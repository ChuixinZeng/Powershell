function Test_ExService
{
	
	#����ΪExchange�ķ�������һ��function����Ϊ����ɸѡ����״̬��������̫һ����������̫���ӵ��ж��߼�
	
	$ServerListmailservice = (Get-ExchangeServer | Where-Object { $_.AdminDisplayVersion -match "15.0" }).name
	$exserviceDownCount = 0
	foreach ($exmachineName in $ServerListmailservice)
	{
		$ErrorActionPreference = "stop"
		Trap { "�����⵽�� $exmachineName ���쳣: $($_.Exception.Message) ��ȷ���������ܹ��������ӣ���"; Continue }
		$exserviceStatus = get-WmiObject win32_service -ComputerName $exmachineName | where {
			($_.displayName -match "exch*") -and ($_.StartMode -match "Auto") `
			-and ($_.StartMode -match "Manual") -and ($_.state -match "Stopped") }
		
		#ע������ط����ж��Ƿ�˼ά�ģ��������ж���û�д���ֹͣ״̬�ķ�������У�����������û����ִ�к����else
		
		if ($exserviceStatus -ne $null)
		{
			foreach ($exservice in $exserviceStatus)
			{
				$exservicename = $exservice.name
				$exservicestate = $exservice.state
				
				$global:exservicefail = "$exmachineName"+"�ϵ�" + "$exservicename" +"����"+ "$exservicestate"+"״̬"+"`n"
				$global:exservicefail
			
				$exserviceDownCount += 1
			}
		}
		else
		{
			$global:exservicesuccess = "$exmachineName" + "������ʼ���ط�������������."+"`n"
			$global:exservicesuccess
		}
	}
}