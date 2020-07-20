WITH T AS(
    select CONCAT(GOODS_CODE,GOODSDT_CODE) AS TTT,* from `momo-develop.oggSync.TGOODSDT` as t
-- where  = '7826949001'
)
SELECT * FROM T
WHERE TTT = '7831053001'