select count(*)
from momo-develop.ipacking.ipack_temp_new as t, unnest(t.info) as b
where b.boxName is NULL