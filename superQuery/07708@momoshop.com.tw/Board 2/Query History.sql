SELECT 
    IF(Order_3m_Row_Sum_Rank<(select count(*) from `momo-develop._scripte54f6fb8d4fa08f21a73a943578694cd92ee7544.GrayGoods`) * 0.2, 'true', 'false') as Order_3m_Row_Sum_Rank_Rate,
    IF(Order_1y_Row_SumRank<(select count(*) from `momo-develop._scripte54f6fb8d4fa08f21a73a943578694cd92ee7544.GrayGoods`) * 0.2, 'true', 'false') as Order_1y_Row_SumRank_Rate,
    IF(Order_1y_Sum=0, 'true', 'false') as Order_1y_Never_BeSold_Good,
    IF(Order_3m_Sum=0, 'true', 'false') as Order_3m_Never_BeSold_Good,
    * 
FROM `momo-develop._scripte54f6fb8d4fa08f21a73a943578694cd92ee7544.GrayGoods`  as t
limit 1000

-- SELECT t.*, 
-- case when rank<(select count(*) from momo-develop._script790dc6b1551f5eb0fd39117aeb08d41eed4d9beb.Example2  ) * 0.2 then 1 
-- when rank>(select count(*) from momo-develop._script790dc6b1551f5eb0fd39117aeb08d41eed4d9beb.Example2  ) * 0.8 then -1 
-- else 0 end as t 
-- FROM momo-develop._script790dc6b1551f5eb0fd39117aeb08d41eed4d9beb.Example2 as t