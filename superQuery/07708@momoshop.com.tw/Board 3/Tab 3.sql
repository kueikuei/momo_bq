select t2.orderNo,t1.* from `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anon4ed9dcdea16f2430f50c78588a8abcff03db6267` as t1
left join `boxSaver.slipFinishInfo` as t2
on t1.slipNo = t2.slipNo