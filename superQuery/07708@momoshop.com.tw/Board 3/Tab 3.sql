WITH t1 as(
  select t.orderNo, b.*
  from `momo-develop.ipacking.ipack_temp_byOrderNo` as t, unnest(info) as b  
  -- where slipNo = '10000265366378'
)


-- select * from t1
-- where boxName is null


select boxName, count(boxName) as num
from t1
group by boxName
order by num desc