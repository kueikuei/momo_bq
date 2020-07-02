  SELECT  *, cast(sum(AQTY)-sum(BQTY)+sum(BALJU_QTY) as  int64) as stockcount
  FROM `momo-develop.embulkUpload.TSTOCK`
  where goods_code in (select goods_code from  `momo-develop.unboxing.dynamic_gift_temp` )