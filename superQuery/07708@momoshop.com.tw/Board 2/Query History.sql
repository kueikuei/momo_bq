-- SELECT * FROM `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anon69bc28a0_344e_4e78_b3de_a91ef8718384` LIMIT 1000
WITH t as(
    select * from `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anon69bc28a0_344e_4e78_b3de_a91ef8718384`
)

,a as(
SELECT
    Full_Goodscode,
CASE
    WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Row_Sum_Rank_Rate = true ) THEN '1' 
    WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Row_Sum_Rank_Rate = false ) THEN '2'
    WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = false AND Order_1y_Row_Sum_Rank_Rate = false ) THEN '3'
    WHEN (New_Goods_Or_Not = false AND Order_3m_Row_Sum_Rank_Rate = false AND Order_1y_Row_Sum_Rank_Rate = false ) THEN '4'
    WHEN (New_Goods_Or_Not = false AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Row_Sum_Rank_Rate = false ) THEN '5'
    WHEN (New_Goods_Or_Not = false AND Order_3m_Row_Sum_Rank_Rate = false AND Order_1y_Row_Sum_Rank_Rate = true ) THEN '6'
    WHEN (New_Goods_Or_Not = true AND Order_3m_Row_Sum_Rank_Rate = false AND Order_1y_Row_Sum_Rank_Rate = true ) THEN '7'
    WHEN (New_Goods_Or_Not = false AND Order_3m_Row_Sum_Rank_Rate = true AND Order_1y_Row_Sum_Rank_Rate = true ) THEN '8'
    ELSE '0'  
    END
AS category
from t
)

select category,CONCAT(CAST(count(category)/(select count(*) from a)*100 AS STRING),'%') as rate from a
group by category
order by category