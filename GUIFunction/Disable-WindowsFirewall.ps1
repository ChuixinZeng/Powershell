function Disable-WindowsFirewall

#��function�ʺ��ڲ��Ի���������������������رշ���ǽ
{
	
	#������ǽ״̬
	$firewallstatus = (Get-NetFirewallProfile -Name Domain, Public, Private).Enabled
	#�������ǽ���ڿ���״̬�����޸����з���ǽ����Ϊ�ر�
	if ($firewallstatus -contains "True")
	{
		
		Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled false
		$writefirewallmessagesuccess = "��������ǽ�Ѿ��ɹ��رգ�"
		$writefirewallmessagesuccess
		
	}
	
	#�������ǽ�Ѿ����ڹر�״̬���򷵻�message
	else
	{
		
		$writefirewallmessage = "��ķ���ǽ���ڹر�״̬���������ã�"
		$writefirewallmessage
		
	}
	
}