select orderNo,DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY),count(*) from `momo-develop.boxSaver.slipInfo`
where 
    brand_chi = '理膚寶水' AND 
    delyType = '乙配' AND
    date(orderdate)=DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY)
GROUP BY orderNo

-- where date(orderdate)=DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY) and delytype='乙配'