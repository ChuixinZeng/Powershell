
#����һ��ping�ű����������޸ģ��ʺ���powershell GUI�е���
function Ping_Test
{
	PROCESS
	{
		#$ws = New-Object -ComObject WScript.Shell
		$ping = $false
		$results = Get-WmiObject -query "SELECT * FROM Win32_PingStatus WHERE Address = '$_'"
		$RT = $results.ResponseTime
		$TTL = $results.ResponseTimeToLive
		#start-sleep 5 #�ȴ�ʱ��Ϊ5��
		foreach ($result in $results)
		{
			if ($results.StatusCode -eq 0)
			{
				if ($RT -ge 250) #����ӳٸ���250
				{
					$global:pingwaring =  "$_ " + "RTime=$RT ms," + " RTime is dangerous"+"`n" #�Ի�ɫ��������ӳ���Ϣ
					return $global:pingwaring
					#echo ((get-date).ToString("HH:mm:ss") + " DA " + "$_ Response Time=$RT ms, ")>> ((get-date).ToString("MMdd") + ".txt")
				} #����Ϣ��������ǰ���ڵ��ļ����£�����עʱ�䣬��DAΪ��ʶ��
				else
				{
					$global:pingsuccess = "$_ " + "RTime=$RT ms," + "  RTime is OK"+"`n"  #����ӳٲ�����250������ɫ���������
					return $global:pingsuccess
					#echo ((get-date).ToString("HH:mm:ss") + " OK " + "$_ Response Time=$RT ms, ")>> ((get-date).ToString("MMdd") + ".txt")
				}#����Ϣ��������ǰ���ڵ��ļ����£�����עʱ�䣬��OKΪ��ʶ��
			}
			else
			{
				$global:pingerror = "$_ " + "Ping failed!"+"`n" #����ֲ��Ǹ���250��Ҳ���ǵ���250��������·�ж��˰���
				return $global:pingerror
				#$ws.popup("`n$_ �����ж���", 3, " �����ж�", 64) #�����жϵ�������
				#echo ((get-date).ToString("HH:mm:ss") + " FA " + "`n$_ Ping failed! ")>> ((get-date).ToString("MMdd") + ".txt") #��¼��Ϣ����FAΪ��ʶ
			}
		}
	}
}