CREATE TEMP FUNCTION brandname(brand_chi STRING,brand_eng STRING,goodsName STRING,entpName STRING)
RETURNS STRING
LANGUAGE js AS """
  var returnString = "";
  if ((brand_chi !== "其他" && brand_chi !== ""  && brand_chi !== null) ) 
  {
    returnString = brand_chi;
  }
  else if( brand_eng !== "" && brand_eng !==  null )
  {
    returnString = brand_eng;
  }  
  else {
     returnString = entpName;
  }
      return returnString;
"""; 
select * from 
(
select orderno,array_agg(brandname) as agg_brand from 
(
select  t.orderNo,brandname(brand_chi,brand_eng,goodsName,entpName) as brandname 
FROM boxSaver.regularQC_slipInfo_3m  as t
)
group by orderno
having array_length(agg_brand)=1
) as t , unnest(t.agg_brand) as t1
where t1='理膚寶水'