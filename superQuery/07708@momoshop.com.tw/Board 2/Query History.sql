WITH t as(
SELECT 
RANK() OVER (ORDER BY order_3m_Sum DESC) AS Order_3m_Row_Sum_Rank,
-- RANK() OVER (ORDER BY Order_1y_Sum DESC) AS Order_1y_Row_SumRank,
*
FROM `momo-develop._scriptb0c309b28d8dab4961b6dd2b0a8a9de50e51b162.Example2`
)
, t2 as(
    SELECT 
    case when Order_3m_Row_Sum_Rank<(select count(*) from t  ) * 0.2 then 1 
    when Order_3m_Row_Sum_Rank>(select count(*) from t  ) * 0.8 then -1 
    else 0 end as Order_3m_Row_Sum_Rank_ResRate,
    -- case when Order_1y_Row_SumRank<(select count(*) from t  ) * 0.2 then 1 
    -- when Order_1y_Row_SumRank>(select count(*) from t  ) * 0.8 then -1 
    -- else 0 end as Order_1y_Row_SumRank_ResRate,
    t.* 
    from t
)

select * from t2