WITH Q_unboxing as(
    SELECT
        slipNo,
        count(slipNo) as num
    from `momo-develop.ipacking.ipack_data` 
    group by slipNo
     having num > 1
)
select t1.slipNo, t2.newSlipNo
from Q_unboxing as t1
left join `boxSaver.addBoxInfo` as t2
on t1.slipNo = t2.orgSlipNo
WHERE t2.newSlipNo is not null