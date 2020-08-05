with t as(
    select t.slipNo, b.*
    from momo-develop.ipacking.ipack_temp_new as t, unnest(t.info) as b
)
-- 20200217625793
select orderNo,slipNO , array_agg(struct(goodsCode, delyQty, WIDTH, LENGTH, HEIGHT, minProjectArea, lagestSide, boxName)) as info
from t
GROUP BY orderNo,slipNO