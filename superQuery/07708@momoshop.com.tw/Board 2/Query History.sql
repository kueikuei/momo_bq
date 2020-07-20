WITH t as(
    select * from `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anone14e1434_abf1_4555_b466_e6d1c0176ef8`
)

SELECT
    Full_Goodscode,
    CASE
        WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Row_Sum_Rank_Rate = true AND Order_1y_Never_BeSold_Good = true AND Order_3m_Never_BeSold_Good = true) THEN '1'
        WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Row_Sum_Rank_Rate = true AND Order_1y_Never_BeSold_Good = true AND Order_3m_Never_BeSold_Good = false) THEN '2'
        ELSE '0'
        END
    AS category
from t