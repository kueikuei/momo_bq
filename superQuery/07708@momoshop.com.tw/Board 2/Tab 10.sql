  SELECT  *
  FROM `momo-develop.embulkUpload.TSTOCK`
  where goods_code in (select goods_code from  `momo-develop.unboxing.dynamic_gift_temp` )