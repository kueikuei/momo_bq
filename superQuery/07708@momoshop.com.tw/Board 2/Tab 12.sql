SELECT COUNT(*)
FROM `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anon561eeca6_369c_4d51_9d2f_b23e7f437906`
WHERE category = '1' 
GROUP BY category
-- AND Order_3m_Never_BeSold_Good != true AND Order_1y_Never_BeSold_Good != true