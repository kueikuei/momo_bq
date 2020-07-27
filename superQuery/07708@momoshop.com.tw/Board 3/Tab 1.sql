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
-- delyQty 裝箱數量?
-- 以每一個訂單作為一個單位
-- 取得內容物的 goodscode 以及其 delyQty 裝箱數量
-- 為何需要取得裝箱數量
slipNoInfo as (
  select t.slipNo , array_agg(struct(t.goodsCode, t.delyQty)) as info   
  from `boxSaver.slipFinishInfo` as t
  where t.orderDate = '2020-07-14'
  group by t.slipNo 
)

select * from dim

-- select t1.*
-- from slipNoInfo as t1 
-- left join dim as t2
-- on t1.goodsCode = t2.GOODS_CODE