  SELECT  *
  FROM `momo-develop.embulkUpload.TSTOCK`
--   where goods_code in (select goods_code from  `momo-develop.unboxing.dynamic_gift_temp` )
  where goods_code = '7835937' OR goods_code = '7832918' OR goods_code = '7814454' OR goods_code = '7848122' 
  
  
-- select goods_code from  `momo-develop.unboxing.dynamic_gift_temp`b