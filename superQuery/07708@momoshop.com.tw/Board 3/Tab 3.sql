SELECT
    slipNo,
    count(slipNo) as num
from `momo-develop.ipacking.ipack_data` 
where num > 1
group by slipNo