select t.slipNo 
from boxSaver.slipInfo as t
where t.slipNo in (
	select t.newSlipNo 
	from boxSaver.addBoxInfo as t
	where t.orgSlipNo ='10000255227448'
)
group by t.slipNo