-- CREATE TEMP TABLE GrayGoods
-- as 
-- 去掉永久終止、甲配商品
-- 確保萬一也拿掉 tgoods 的乙配
-- inner join 去掉永久終止的 tgoods
-- 終止欄位SALE_GB，故這邊先排除
-- 得到完整的TGOODSDT
-- 已經是乙配
WITH slipInfo3m as(
    SELECT CONCAT(goodsCode,goodsdtCode) as Full_Goodscode , count(goodsCode) as order3mNum 
    FROM `momo-develop.boxSaver.regularQC_slipInfo_3m` 
    -- where delyType  = '乙配' AND
    where date(orderDate) >= date_sub(current_date, interval 3 month)
    group by goodsCode,goodsdtCode
),
-- 取出所有商品近一年銷量(乙配)
slipInfo1y as(
    SELECT CONCAT(goodsCode,goodsdtCode) as Full_Goodscode , count(goodsCode) as order1yNum
    FROM `momo-develop.boxSaver.regularQC_slipInfo_1y` 
    -- where delyType  = '乙配' AND
    where date(orderDate) >= date_sub(current_date, interval 1 year)
    group by goodsCode,goodsdtCode
),
-- 商品與銷量合併
goodsSlipHistoryList as (
    select IFNULL(b.order3mNum,0) as Order_3m_Sum,a.* 
    -- from tgoodsdt as a
    from `momo-develop.inventoryPlanning.IP_goodsinfo_temp`  as a
    LEFT JOIN slipInfo3m as b ON
    a.Full_Goodscode = b.Full_Goodscode
    -- Where order3mNum > 0
),
goodsSlipHistoryList2 as (
    select 
        IFNULL(b.order1yNum,0) as Order_1y_Sum,
        a.* 
    from goodsSlipHistoryList as a
    LEFT JOIN slipInfo1y as b ON
    a.Full_Goodscode = b.Full_Goodscode
)
,grayGoods_pre as
(
select 
    Full_Goodscode,
    Order_3m_Sum,
    RANK() OVER (ORDER BY order_3m_Sum DESC) AS Order_3m_Row_Sum_Rank,
    Order_1y_Sum,
    RANK() OVER (ORDER BY Order_1y_Sum DESC) AS Order_1y_Row_Sum_Rank,
    INSERT_DATE,
    IF(date(INSERT_DATE)  >= date_sub(current_date, interval 1 month),true,false) as New_Goods_Or_Not
-- from hotAndLongtailGoods
from goodsSlipHistoryList2
)
,grayGoods as 
(
SELECT 
    *,
    IF(Order_3m_Row_Sum_Rank<((select count(*) from grayGoods_pre)-(select count(*) from grayGoods_pre where order_3m_Sum = 0)) * 0.2, true, false) as Order_3m_Row_Sum_Rank_Rate,
    IF(Order_1y_Row_Sum_Rank<((select count(*) from grayGoods_pre)-(select count(*) from grayGoods_pre where Order_1y_Sum = 0)) * 0.2, true, false) as Order_1y_Row_Sum_Rank_Rate,
    IF(Order_1y_Sum=0, true, false) as Order_1y_Never_BeSold_Good,
    IF(Order_3m_Sum=0, true, false) as Order_3m_Never_BeSold_Good
FROM grayGoods_pre
)
, category1 as(
SELECT
CASE
    -- 是新品、近三個月熱銷、近一年也是熱銷 -> 超級熱銷品，賣的量直衝整年熱銷量，一上架就大賣特賣 (ex PS4悠遊卡)，大概佔了 0.015 %
    WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Row_Sum_Rank_Rate = true ) THEN '1' 
    -- 是新品、近三個月熱銷、近一年非熱銷 -> 熱銷品，一上架就大賣特賣，但可能賣的時間還不夠長，大概佔了 0.0118 %
    WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Row_Sum_Rank_Rate = false ) THEN '2'
    -- 是新品、近三個月非熱銷、近一年非熱銷 -> 新上架商品，上架時間不夠長導致長尾，大概佔了 2.32 %
    WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = false AND Order_1y_Row_Sum_Rank_Rate = false ) THEN '3'
    -- 非新品、近三個月非熱銷、近一年非熱銷 -> 長尾商品，大概佔了 91.69 %
    WHEN (New_Goods_Or_Not = false AND Order_3m_Row_Sum_Rank_Rate = false AND Order_1y_Row_Sum_Rank_Rate = false ) THEN '4'
    -- 非新品、近三個月熱銷、近一年非熱銷 -> 近三個月成為熱銷品，可能受突發性市場機制影響(ex 疫情造成口罩大銷售)，大概佔了 0.3 %
    WHEN (New_Goods_Or_Not = false AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Row_Sum_Rank_Rate = false ) THEN '5'
    -- 非新品、近三個月非熱銷、近一年熱銷 -> 近三個月非熱銷、近一年曾經熱銷，可能活動過了或是真的不流行了，大概佔了 2.6 %
    WHEN (New_Goods_Or_Not = false AND Order_3m_Row_Sum_Rank_Rate = false AND Order_1y_Row_Sum_Rank_Rate = true ) THEN '6'
    -- 是新品、近三個月非熱銷、近一年熱銷 -> 邏輯有誤，理論上不該有這選項的量
    WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = false AND Order_1y_Row_Sum_Rank_Rate = true ) THEN '7'
    -- 非新品、近三個月熱銷、近一年也熱銷 -> 長期熱銷品，可能是活動長期 support 等狀況，大概佔了 3 %
    WHEN (New_Goods_Or_Not = false AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Row_Sum_Rank_Rate = true ) THEN '8'
    ELSE '0'  
    END
AS category_pre,
*
from grayGoods
)
SELECT 
CASE
    -- _1：近3個月銷量為0、近一年銷量為0
    -- _2：近3個月銷量為0、近一年銷量不為0
    -- _3：近3個月銷量不為0、近一年銷量為0
    -- _4：近3個月銷量不為0、近一年銷量不為0
    WHEN (category_pre = '1' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '1_1'
    WHEN (category_pre = '1' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '1_2'
    WHEN (category_pre = '1' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '1_3'
    WHEN (category_pre = '1' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '1_4'
    WHEN (category_pre = '2' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '2_1'
    WHEN (category_pre = '2' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '2_2'
    WHEN (category_pre = '2' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '2_3'
    WHEN (category_pre = '2' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '2_4'
    WHEN (category_pre = '3' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '3_1'
    WHEN (category_pre = '3' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '3_2'
    WHEN (category_pre = '3' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '3_3'
    WHEN (category_pre = '3' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '3_4'
    WHEN (category_pre = '4' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '4_1'
    WHEN (category_pre = '4' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '4_2'
    WHEN (category_pre = '4' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '4_3'
    WHEN (category_pre = '4' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '4_4'
    WHEN (category_pre = '5' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '5_1'
    WHEN (category_pre = '5' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '5_2'
    WHEN (category_pre = '5' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '5_3'
    WHEN (category_pre = '5' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '5_4'
    WHEN (category_pre = '6' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '6_1'
    WHEN (category_pre = '6' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '6_2'
    WHEN (category_pre = '6' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '6_3'
    WHEN (category_pre = '6' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '6_4'
    WHEN (category_pre = '8' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '8_1'
    WHEN (category_pre = '8' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '8_2'
    WHEN (category_pre = '8' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '8_3'
    WHEN (category_pre = '8' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '8_4'
    ELSE '0'
    END
AS category,
*
FROM category1





