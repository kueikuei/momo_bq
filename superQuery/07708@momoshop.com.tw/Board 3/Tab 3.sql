select *
from `oggSync.TGOODS`
where WIDTH is NULL OR HEIGHT is NULL OR LENGTH is NULL
limit 100