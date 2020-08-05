with t as(
    select t.slipNo, b.*
    from momo-develop.ipacking.ipack_temp as t, unnest(t.info) as b
)

select orderNo,slipNO 
from t
GROUP BY orderNo,slipNO