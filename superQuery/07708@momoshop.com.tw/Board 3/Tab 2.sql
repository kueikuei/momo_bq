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
  from `oggSync.TGOODS` as t  
)
-- step2 slipFinishInfo 先與 TGOODS 合併
,slipFinishInfoMergeTGOODS as(
    select t1.*, t2.*
    from `boxSaver.slipFinishInfo` as t1
    left join dim as t2 
    on t1.goodsCode = t2.GOODS_CODE
) 

select * from slipFinishInfoMergeTGOODS