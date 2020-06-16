WITH t1 as (
    select orderNo,count(*) from `momo-develop.boxSaver.regularQC_slipInfo_3m`
    where 
        brand_chi LIKE '%理膚寶水%' AND 
        delyType = '乙配' 
    GROUP BY orderNo
),
t2 AS(
    select t2.orderNo,count(*), count(distinct t2.brand_chi) from `momo-develop.boxSaver.regularQC_slipInfo_3m` as t2
    left join  t1 on t1.orderNo = t2.orderNo 
    GROUP BY t2.orderNo
)
,
t3 AS (
    select * from t2
    where orderNo = '20200613232966' OR orderNo =  '20200613434446' OR orderNo = '20200613174177' OR orderNo = '20200613377247'
)

select * from t2


-- where date(orderdate)=DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY) and delytype='乙配'