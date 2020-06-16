WITH t1 as (
    select orderNo,count(*) as t1ct from `momo-develop.boxSaver.regularQC_slipInfo_3m`
    where 
        brand_chi LIKE '%理膚寶水%' AND 
        delyType = '乙配' 
    GROUP BY orderNo
),
t2 AS(
    select t2.orderNo,count(*) as ct, count(distinct t2.brand_chi) as isSameBrand_chi from `momo-develop.boxSaver.regularQC_slipInfo_3m` as t2
    GROUP BY t2.orderNo
)
,
t4 as (
    select t1.* ,t2.ct, t2.isSameBrand_chi
    from t1 as t1
    left join t2 on t1.orderNo = t2.orderNo
)


select *,(t1ct-ct) as num from t4
where isSameBrand_chi = 1


-- SELECT 
--  ttt.*,Table_R.Value
-- FROM Table_L as ttt
-- left join Table_R  on ttt.Row = Table_R.Row

-- where date(orderdate)=DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY) and delytype='乙配'