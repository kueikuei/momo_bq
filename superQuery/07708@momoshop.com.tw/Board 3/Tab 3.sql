select *
from `oggSync.FUBON_TGOODS`
where WIDTH is NULL OR HEIGHT is NULL OR LENGTH is NULL
limit 100