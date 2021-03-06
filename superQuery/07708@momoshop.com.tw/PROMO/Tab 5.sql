WITH gift as --挑選贈品
(

  SELECT DISTINCT PDT.PROMO_NO,PM.PROMO_NAME,PDT.INSERT_ID,
  PDT.INSERT_DATE,PM.PROMO_START_DATE,PM.PROMO_END_DATE,
  PDT.GOODS_CODE,TG.GOODS_NAME

  FROM 
    `momo-develop.oggSync.PROMO_DT` as PDT ,
    `momo-develop.oggSync.PROMO_M` AS PM  ,
    `momo-develop.oggSync.TGOODS` AS TG ,
    `momo-develop.oggSync.TF_GOODS` AS TFG
  where  date(PDT.INSERT_DATE)=CURRENT_DATE() and prefer_type='5' and PM.PROMO_NO =PDT.PROMO_NO and PDT.GOODS_CODE =TG.GOODS_CODE  AND TG.DELY_TYPE='10'
  AND NOT (PM.PROMO_NAME LIKE '%登記%' OR PM.PROMO_NAME LIKE '%紅利金%')
  AND PDT.GOODS_CODE IS NOT NULL
  AND PDT.GOODS_CODE =TFG.GOODS_CODE
  AND TFG.ONLY_OUT_FLAG <> '1'

  ORDER BY INSERT_DATE
),

-- select * from gift
stock as  --計算贈品的庫存
(
  select goods_code,array_agg(wh_code) as stock_whcode,array_agg(stockcount) as stockcount from 
  (
  SELECT  goods_code,wh_code, cast(sum(AQTY)-sum(BQTY)+sum(BALJU_QTY) as  int64) as stockcount
  FROM `momo-develop.embulkUpload.TSTOCK`
  where goods_code in (select goods_code from gift)
  group by goods_code,wh_code
  having stockcount>0
  ORDER BY WH_CODE
  ) 
  group by goods_code
)

  select * from stock