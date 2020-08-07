WITH t1 as(
  select t.orderNo, b.*
  from `momo-develop.ipacking.ipack_temp_byOrderNo` as t, unnest(info) as b  
  -- where slipNo = '10000265366378'
)


select count(boxName) from t1
where boxName is null