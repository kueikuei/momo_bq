WITH t1 as (
    select orderNo,count(*) from `momo-develop.boxSaver.regularQC_slipInfo_3m`
    where 
        brand_chi LIKE '%理膚寶水%' AND 
        delyType = '乙配' 
    GROUP BY orderNo
),
t2 AS(
    select t2.orderNo,count(*), count(distinct t2.brand_chi) as isSameBrand_chi from `momo-develop.boxSaver.regularQC_slipInfo_3m` as t2
    left join  t1 on t1.orderNo = t2.orderNo 
    GROUP BY t2.orderNo
)
,
t3 AS (
    select * from t2
    where isSameBrand_chi = 1
)

select * from t3


-- where date(orderdate)=DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY) and delytype='乙配'