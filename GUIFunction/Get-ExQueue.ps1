#��ȡ��ǰ�������ʼ�ϵͳ�Ķ����������Ҫ��ǰ����exchange�Ĺ���ģ�飬ʹ������add-pssnapin *exchange*

function Get-ExQueue
{
	
	$exservicename = Get-TransportService | sort -Property name
	foreach ($exservice in $exservicename)
	{
		$queuecount = ($exservice | Get-Queue | ?{ $_.DeliveryType -ne "ShadowRedundancy" } | measure messagecount -sum | select sum).sum
		$exqueueoutput = $exservice.name + "�ʼ����й�" + $queuecount
		if ($queuecount -gt 0)
		{
			
			$Global:exqueuecount = $exqueueoutput + "��ѻ��ʼ�."+"`n"
			$Global:exqueuecount
			
		}
		else
		{
			
			$global:exqueuesuccess = "$exservice" + "����û�жѻ�."+"`n"
			$global:exqueuesuccess
			
		}
	}
	
}