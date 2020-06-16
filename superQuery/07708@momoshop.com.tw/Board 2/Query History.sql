-- SELECT * FROM `momo-develop.unboxing.combine_brandname_0615` LIMIT 1000

CREATE TEMP FUNCTION brandname(g STRING,g2 STRING)
RETURNS BOOLEAN
LANGUAGE js AS """
  var returnString = "";
  if (g===g2) {return true;}
  else{return false;}
  
""";
with data as 
(
  select  *,brandname(g,g2) as combine_self 
  FROM `momo-develop.unboxing.combine_brandname_0615`  as t
)

select g,group_count,group_percent from data
where combine_self != false AND g = '理膚寶水'
order by group_percent desc
-- limit 100