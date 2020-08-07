
with t1 as(
select t.slipNo,b.*
from `momo-develop.ipacking.ipack_temp_new` as t, UNNEST(info) as b
),
t2 as(
select slipNo,boxName
from t1
where boxName is not null
group by slipNo,boxName
)

select boxName, count(boxName)/(select count(boxName) from t2)*100 as rate, count(boxName) as num
from t2
group by boxName
order by rate desc