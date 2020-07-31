select count(slipNo)  as num
from `momo-develop.ipacking.ipack_data` 
group by slipNo
having num > 1