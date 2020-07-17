SELECT t.*, 
case when rank<(select count() from momo-develop._script790dc6b1551f5eb0fd39117aeb08d41eed4d9beb.Example2  ) 0.2 then 1 
when rank>(select count(*) from momo-develop._script790dc6b1551f5eb0fd39117aeb08d41eed4d9beb.Example2  ) * 0.8 then -1 
else 0 end as t 
FROM momo-develop._script790dc6b1551f5eb0fd39117aeb08d41eed4d9beb.Example2 as t