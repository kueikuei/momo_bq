select count(t.*) from ipacking.ipack_res_final4 as t
left join ipacking.ipack_temp_data2 as t2
on t.gs = t2.gs