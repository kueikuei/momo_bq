select orderNo,count(*) from `momo-develop.boxSaver.slipInfo`
where 
    goodsName LIKE '理膚寶水' AND 
    delyType = '乙配' AND
    date(orderdate) BETWEEN '2020-03-15'  AND '2020-06-15'
GROUP BY orderNo

-- where date(orderdate)=DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY) and delytype='乙配'