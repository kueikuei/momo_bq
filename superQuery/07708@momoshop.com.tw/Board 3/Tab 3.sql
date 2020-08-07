with t1 as(
select t.slipNo,b.*
from `momo-develop.ipacking.ipack_temp_new` as t, UNNEST(info)
)
select boxName, count(boxName)/(select count(boxName) from t1 where boxName is not null)*100 as rate
from t1
where boxName is not null
group by boxName
order by rate desc