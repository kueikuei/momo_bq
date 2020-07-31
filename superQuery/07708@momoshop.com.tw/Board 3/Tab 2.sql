select t.slipNo, b.boxName
from momo-develop.ipacking.ipack_temp_new as t, unnest(t.info) as b
group by t.slipNo,b.boxName