CREATE TEMP TABLE Example2
as 
-- 去掉永久終止、甲配商品
WITH tgoods as(
    SELECT GOODS_CODE
    FROM `momo-develop.oggSync.TGOODS` as a
    WHERE DELY_TYPE='10'
),
-- 確保萬一也拿掉 tgoods 的乙配
-- inner join 去掉永久終止的 tgoods
-- 終止欄位SALE_GB，故這邊先排除
-- 得到完整的TGOODSDT
tgoodsdt as(
    SELECT CONCAT(a.GOODS_CODE,a.GOODSDT_CODE) as fullgoodscode,a.*
    FROM `momo-develop.oggSync.TGOODSDT` as a
    LEFT JOIN tgoods AS b ON a.GOODS_CODE = b.GOODS_CODE
    WHERE a.SALE_GB !='19' AND b.GOODS_CODE IS NOT NULL
),
-- 取出近三個月銷量(乙配)
slipInfo3m as(
    SELECT CONCAT(goodsCode,goodsdtCode) as fullgoodscode , count(goodsCode) as order3mNum 
    FROM `momo-develop.boxSaver.regularQC_slipInfo_3m` 
    where delyType  = '乙配' AND
    date(orderDate) >= date_sub(current_date, interval 3 month)
    group by goodsCode,goodsdtCode
),
-- 取出所有商品近一年銷量(乙配)
slipInfo1y as(
    SELECT CONCAT(goodsCode,goodsdtCode) as fullgoodscode , count(goodsCode) as order1yNum
    FROM `momo-develop.boxSaver.regularQC_slipInfo_1y` 
    where delyType  = '乙配' AND
    date(orderDate) >= date_sub(current_date, interval 1 year)
    group by goodsCode,goodsdtCode
),
-- 商品與銷量合併
goodsSlipHistoryList as (
    select IFNULL(b.order3mNum,0) as order_3m_Sum,a.* 
    from tgoodsdt as a
    LEFT JOIN slipInfo3m as b ON
    a.fullgoodscode = b.fullgoodscode
    -- Where order3mNum > 0
),
goodsSlipHistoryList2 as (
    select 
        IFNULL(b.order1yNum,0) as Order_1y_Sum,
        a.* 
    from goodsSlipHistoryList as a
    LEFT JOIN slipInfo1y as b ON
    a.fullgoodscode = b.fullgoodscode
    -- Where order1yNum > 0
)
,hotAndLongtailGoods as(
    select 
        -- ROW_NUMBER() OVER (ORDER BY Order_1y_Sum DESC) AS Order_1y_Row_Num,
        -- ROW_NUMBER() OVER (ORDER BY order_3m_Sum DESC) AS Order_3m_Row_Num,
        *
    from goodsSlipHistoryList2
)select 
    RANK() OVER (ORDER BY order_3m_Sum DESC) AS Order_3m_Row_Sum_Rank,
    RANK() OVER (ORDER BY Order_1y_Sum DESC) AS Order_1y_Row_SumRank,
    *
    from hotAndLongtailGoods;

SELECT 
case when Order_3m_Row_Sum_Rank<(select count(*) from Example2  ) * 0.2 then 1 
when Order_3m_Row_Sum_Rank>(select count(*) from Example2  ) * 0.8 then -1 
else 0 end as Order_3m_Row_Sum_Rank_ResRate,
case when Order_1y_Row_SumRank<(select count(*) from Example2  ) * 0.2 then 1 
when Order_1y_Row_SumRank>(select count(*) from Example2  ) * 0.8 then -1 
else 0 end as Order_1y_Row_SumRank_ResRate,
t.* 
from Example2
 
-- FROM Example2 as t
-- ,t as (
--     select count(*)*0.8 as tot from hotAndLongtailGoods
-- )

-- select
--     IF(Order_1y_Row_Num >= (select tot from t),'true','false') as nowDate2,
--     *
    -- count(*)*0.8,
    --  IF( order_3m_Sum=MAX(Order_1y_Row_Num), 'true', 'false') as result
    -- IF(date(INSERT_DATE) >= date_sub(current_date, interval 1 month),'true','false') as nowDate,
    
    -- *
-- from hotAndLongtailGoods

-- GROUP BY fullgoodscode

-- select COUNT(*) from goodsSlipHistoryList2
-- select IF( Order_1y_Num=0, 'true', 'false') as Order_Or_Not_1y,
--         * 
-- from goodsSlipHistoryList2

-- where setGoodFlag = '贈品' OR setGoodFlag = '贈品[抽獎]'


