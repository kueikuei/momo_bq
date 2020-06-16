WITH t1 as (
    select orderNo,count(*) from `momo-develop.boxSaver.regularQC_slipInfo_3m`
    where 
        brand_chi LIKE '%理膚寶水%' AND 
        delyType = '乙配' AND
        date(orderdate) BETWEEN '2020-03-15'  AND '2020-06-15'
    GROUP BY orderNo
)

select * from t1


-- where date(orderdate)=DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY) and delytype='乙配'