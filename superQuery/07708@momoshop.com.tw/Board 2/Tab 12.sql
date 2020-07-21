SELECT category, CONCAT((count(category) / (select count(*) from `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anon783b9d8d_e867_48f2_83c6_d4b78c47fe6b`)) * 100,'%') as rate
FROM `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anon783b9d8d_e867_48f2_83c6_d4b78c47fe6b`
GROUP BY category