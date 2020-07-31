WITH t AS(
    select t.slipNo, b.boxName, count(b.boxName) as num
    from momo-develop.ipacking.ipack_temp_new as t, unnest(t.info) as b
    where b.boxName is not null
    group by t.slipNo,b.boxName
    order by num desc
)

select boxName , count(b.boxName) as num , CONCAT(count(b.boxName)/1852957*100,'%') as rate
from t
group by boxName
order by num desc