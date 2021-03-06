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
pair_goods as --贈品的搭配品
(
  select pgoods.promo_no,pgoods.GOODS_CODE,TG.SET_YN 
  from  gift as gift, `momo-develop.oggSync.PROMO_GOODS` as pgoods,`momo-develop.oggSync.TGOODS` AS TG ,`momo-develop.oggSync.TF_GOODS` AS TFG
  WHERE gift.PROMO_NO =pgoods.promo_no 
  and pgoods.GOODS_CODE =TG.GOODS_CODE 
  and pgoods.goods_code=tfg.goods_code
  and TFG.ONLY_OUT_FLAG <> '1'
)

select * from pair_goods