
with t1 as(
select t.slipNo,b.*
from `momo-develop.ipacking.ipack_temp_new` as t, UNNEST(info) as b
)
select slipNo as sn, (seelct * from t1 where slipNo = sn group by boxName)
from t1
group by slipNo
-- group by boxName
-- order by rate desc