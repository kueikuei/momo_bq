WITH t as(
    select * from `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anone14e1434_abf1_4555_b466_e6d1c0176ef8`
)

,a as(
SELECT
    Full_Goodscode,
    CASE
        -- 近三個月為熱銷品且為新品 -> 活動或廣告造成 (ex 贈品) || 當季流行物 (ex. iphone 剛出)
        WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Never_BeSold_Good = false AND Order_3m_Never_BeSold_Good = false) THEN '1' 
        -- 近三個月為熱銷品且不為新品 -> 因應時事流行品(ex 疫情造成)
        WHEN (New_Goods_Or_Not = false AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Never_BeSold_Good = false AND Order_3m_Never_BeSold_Good = false) THEN '2'
        -- 近一年為熱銷品且不為新品 -> 穩定熱銷品 || 長期活動贈品 (ex 理膚寶水)
        WHEN (New_Goods_Or_Not = false AND Order_1y_Row_Sum_Rank_Rate = true AND Order_1y_Never_BeSold_Good = false) THEN '3'
        -- 近三個月為長尾商品(Sum>0)且為新品 -> 可能賣的時間不夠長
        WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = false AND Order_1y_Never_BeSold_Good = false AND Order_3m_Never_BeSold_Good = false) THEN '4'
        -- 近一年為長尾商品(扣掉三個月的量Sum>0)且不為新品 -> 真的很不暢銷的商品
        WHEN (New_Goods_Or_Not = false AND Order_3m_Row_Sum_Rank_Rate = false AND Order_1y_Row_Sum_Rank_Rate = false AND Order_1y_Never_BeSold_Good = false AND Order_3m_Never_BeSold_Good = false) THEN '5'
        -- 近一年銷量為0且不為新品 -> 超級冷門貨
        WHEN (New_Goods_Or_Not = false AND Order_3m_Row_Sum_Rank_Rate = false AND Order_1y_Row_Sum_Rank_Rate = false AND Order_1y_Never_BeSold_Good = true AND Order_3m_Never_BeSold_Good = true) THEN '6'
        --其他灰色商品，暫時分類不出來
        ELSE '0'  
        END
    AS category
from t
)

select category,count(category) from a
group by category