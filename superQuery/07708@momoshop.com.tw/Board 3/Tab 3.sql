WITH Q_unboxing as(
    SELECT
        slipNo,
        count(slipNo) as num
    from `momo-develop.ipacking.ipack_data` 
    group by slipNo
     having num > 1
)
select sum(num) from Q_unboxing