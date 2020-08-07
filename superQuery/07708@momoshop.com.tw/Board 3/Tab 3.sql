with t1 as(
select t.slipNo,b.*
from `momo-develop.ipacking.ipack_temp_new` as t, UNNEST(info) as b
)
select slipNo,boxName
from t1
group by slipNo,boxName