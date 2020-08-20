-- ======= 目標 ======= --
# 情境一：無腦結果進行計算
# 最大訂單量比率 - 公式
# 最佳填充率比率 - 公式
# 最小運費 - 公式
-- ======= 目標 ======= --

-- select count(*) from ipacking.ipack_res_final4 

-- 取得原來訂單數量
CREATE TABLE `momo-develop.ipacking.ipack_res_final4_orderC`
OPTIONS(
expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 14 DAY)
) AS
select t2.orderCount as orderCount,t.gs from ipacking.ipack_res_final4 as t
left join ipacking.ipack_temp_data2 as t2
on t.gs = t2.gs