-- step1 先取2020 1~5月3 樓所有資料
-- 取得每一個商品的長寬高、最小投影面積、最長邊
-- with dim as
-- (
--   select 
--     distinct t.GOODS_CODE,t.WIDTH ,t.LENGTH ,t.HEIGHT , 
--     -- 計算最小投影面積
--     LEAST(WIDTH*LENGTH, LENGTH*HEIGHT, WIDTH*HEIGHT) as minProjectArea,
--     -- 取得最長邊      
--     GREATEST(t.WIDTH ,t.LENGTH ,t.HEIGHT) as lagestSide
--   from `oggSync.TGOODS` as t  
-- )
-- -- step2 slipFinishInfo 先與 TGOODS 合併
-- ,slipFinishInfoMergeTGOODS as(
--     select t1.*, t2.*
--     from `boxSaver.slipFinishInfo` as t1
--     left join dim as t2 
--     on t1.goodsCode = t2.GOODS_CODEmomo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anon05c0a3b26f28da7166f58c5060ef378e2df4d256
-- ) 
-- ,slipNoInfo as (
WITH slipNoInfo as (
  select  t.slipNo , array_agg(struct(t.orderNo, t.goodsCode, t.delyQty, t.WIDTH ,t.LENGTH ,t.HEIGHT, t.minProjectArea, t.lagestSide, t.boxName)) as info   
--   from `boxSaver.slipFinishInfo` as t
  from `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anonev__U2D83CoqTRV2vbGDC_dNd3c0TnpjqgBVLTtYiuWypo` as t
--   where t.orderDate = '2020-07-14'
  where t.slipNo in (select * from `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anon4ed9dcdea16f2430f50c78588a8abcff03db6267`)
  group by t.slipNo 
)
-- ,ttt as(
--   select t2.orderNO , t.*
--   from slipNoInfo as t
--   left join `boxSaver.slipFinishInfo` as t2
--   on t.slipNo = t2.slipNo
-- )

select * from slipNoInfo