CREATE TABLE `momo-develop.ipacking.ipack_temp_byOrderNo`
OPTIONS(
expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 14 DAY)
) AS
WITH t as(
    select t.slipNo, b.*
    from `momo-develop.ipacking.ipack_temp_new`  as t, unnest(t.info) as b
)
select orderNo, array_agg(struct(slipNO, goodsCode, delyQty, WIDTH, LENGTH, HEIGHT, minProjectArea, lagestSide, boxName)) as info
-- select orderNo, array_agg(struct(slipNO), array_agg(struct( goodsCode, delyQty, WIDTH, LENGTH, HEIGHT, minProjectArea, lagestSide, boxName)))
from t
group by orderNo