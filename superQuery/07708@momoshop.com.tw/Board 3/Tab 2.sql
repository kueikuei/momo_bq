
select b.boxName, count(b.boxName) as num, CONCAT(count(b.boxName)/8035462*100,'%')
-- select *, b.*
from momo-develop.ipacking.ipack_temp_new as t, unnest(t.info) as b
group by b.boxName
order by num desc
-- where slipNo li