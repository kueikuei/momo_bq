WITH t as(
    select t.slipNo, b.*
    from `momo-develop.ipacking.ipack_temp_new`  as t, unnest(t.info) as b
)

select orderNo, array_agg(slipNO, goodsCode, delyQty, WIDTH, LENGTH, HEIGHT, minProjectArea, lagestSide, boxName)
from t
group by orderNo