  SELECT  goods_code,wh_code, cast(sum(AQTY)-sum(BQTY)+sum(BALJU_QTY) as  int64) as stockcount
  FROM `momo-develop.embulkUpload.TSTOCK`
  where goods_code in (select goods_code from  `momo-develop.unboxing.dynamic_gift_temp` )
--   and rpt_date = DATE_SUB(current_Date(), INTERVAL 1 DAY) 
  group by goods_code,wh_code
--   having stockcount>0
--   ORDER BY WH_CODE