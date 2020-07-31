找出在Q台拆箱 box，並且取得新的 slipNo
WITH ipack_up_1 as(
    SELECT
        slipNo,
        count(slipNo) as num
    from `momo-develop.ipacking.ipack_data` 
    group by slipNo
    having num > 1
)
,
ipack_equal_1 as(
    SELECT
        slipNo
    from `momo-develop.ipacking.ipack_data` 
    group by slipNo
    having num  = 1
)
, newSlipNO as(
    select t2.newSlipNo as slipNo
    from ipack_1up as t1
    left join `boxSaver.addBoxInfo` as t2
    on t1.slipNo = t2.orgSlipNo
    WHERE t2.newSlipNo is not null
)
select count(*) from newSlipNO