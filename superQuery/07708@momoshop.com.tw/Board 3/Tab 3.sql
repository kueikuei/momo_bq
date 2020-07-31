WITH Q_unboxing as(
    SELECT
        slipNo,
        count(slipNo) as num
    from `momo-develop.ipacking.ipack_data` 
    group by slipNo
     having num > 1
)
select t1.slipNo, t2.newSlipNo
left join `boxSaver.addBoxInfo` as t2
on t1.slipNo = t2.orgSlipNo