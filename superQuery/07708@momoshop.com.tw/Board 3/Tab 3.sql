select count(GOODS_CODE) 
from `oggSync.FUBON_TGOODS`
order by GOODS_CODE
where WIDTH is NULL OR HEIGHT is NULL OR LENGTH is NULL