  SELECT  distinct t.xwhat ,t.xwhen ,t.xwho,t.xcontext.item_id 
  FROM  `momo-logistics-pro.momodataset.CUSTOMER_LOG_PROCESSED_1d`  as t
  where xwhat='view_item' and t.xcontext.item_id is not null