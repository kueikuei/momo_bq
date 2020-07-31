select b.boxName, count(b.boxName) as num
-- select *, b.*
from momo-develop.ipacking.ipack_temp_new as t, unnest(t.info) as b
group by b.boxName
order by num desc