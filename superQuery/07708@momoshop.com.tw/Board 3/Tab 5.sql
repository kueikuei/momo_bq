-- step1 先取2020 1~5月3 樓所有資料
-- 取得每一個商品的長寬高、最小投影面積、最長邊
with dim as
(
  select 
    distinct t.GOODS_CODE,t.WIDTH ,t.LENGTH ,t.HEIGHT , 
    -- 計算最小投影面積
    LEAST(WIDTH*LENGTH, LENGTH*HEIGHT, WIDTH*HEIGHT) as minProjectArea,
    -- 取得最長邊      
    GREATEST(t.WIDTH ,t.LENGTH ,t.HEIGHT) as lagestSide
  from `oggSync.FUBON_TGOODS`  as t  
),
-- step2 先進行 left join
 
-- delyQty 裝箱數量?
-- 以每一個訂單作為一個單位
-- 取得內容物的 goodscode 以及其 delyQty 裝箱數量
-- 為何需要取得裝箱數量
slipNoInfo as (
  select  t.slipNo , array_agg(struct(t.goodsCode, t.delyQty)) as info   
  from `boxSaver.slipFinishInfo` as t
  where t.orderDate = '2020-07-14'
  group by t.slipNo 
)
,ttt as(
  select t2.orderNO , t.*
  from slipNoInfo as t
  left join `boxSaver.slipFinishInfo` as t2
  on t.slipNo = t2.slipNo
)

select distinct * from slipNoInfo