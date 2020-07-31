select t.slipNo, b.*
from momo-develop.ipacking.ipack_temp as t, unnest(t.info) as b