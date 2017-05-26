function Enable-TelnetClientRole
{
	#Ŀǰ��function��֧��Windows10��Windows 2012R2����ϵͳ
	$computername = $env:COMPUTERNAME
	#����ط�֮���Լ�foreach����Ϊ�˷���ؽ���ǰ�ĽŲ�����Ϊ�ܹ�������̨��������Ϊǰ���computername��������������ָ����ǰ����
	foreach ($cn in $computername)
	{
		
		$cnwmi = Get-WmiObject win32_operatingsystem -ComputerName $cn
		
		if (Get-WmiObject win32_operatingsystem -ComputerName $cn | where { $_.Version -like "10.0*" })
		{
			$outputsystemclientversion = "��ǰ$env:COMPUTERNAME �İ汾��Windows10 1703�����ڳ��Կ���Telnet�ͻ��˽�ɫ...."+"`n"
			$outputsystemclientversion
			
			if ((Get-WindowsOptionalFeature -Online | where featurename -Like "*Telnet*").state -eq "Disabled")
			{
				Enable-WindowsOptionalFeature -Online -FeatureName TelnetClient -All
				$enableclienthypervmessage = "Telnet�ͻ��˿����ɹ������������ļ�����Ա�������Ч"
				$enableclienthypervmessage
				$ErrorActionPreference = "stop"
				Trap { "����Telnet Clientʧ��: $($_.Exception.Message)"; }
			}
			elseif ((Get-WindowsOptionalFeature -Online | where featurename -Like "*Telnet*").state -eq "Enabled")
			{
				$enableclienthypervmessage1 = "����ǰ�Ļ����Ѿ�����Telnet�ͻ��ˣ������ظ�������"+"`n"
				$enableclienthypervmessage1
			}
			else
			{
				$errorclientenablehypermessage = "Telnet�ͻ���״̬δ֪��������������ã�"+"`n"
				$errorclientenablehypermessage
			}
			
		} #end if
		
		elseif ($cnwmi.version -eq "6.3.9600")
		{
			$outputserversystemversion = "��ǰ$env:COMPUTERNAME �İ汾��Windows 2012R2 SP1�����ڳ��Կ���Telnet�ͻ��˽�ɫ...."+"`n"
			$outputserversystemversion
			
			if ((Get-WindowsFeature "telnet-client").InstallState -eq "Available")
			{
				Install-WindowsFeature -Name Telnet-Client
				$enableserverhypervmessage = "Telnet�ͻ��˿����ɹ������������ļ�����Ա�������Ч"+"`n"
				$enableserverhypervmessage
				$ErrorActionPreference = "stop"
				Trap { "����Telnet�ͻ���ʧ��: $($_.Exception.Message)"; }
			}
			elseif ((Get-WindowsFeature "telnet-client").InstallState -eq "Installed")
			{
				$enableserverhypervmessage1 = "����ǰ�Ļ����Ѿ�����Telnet�ͻ��ˣ������ظ�������"+"`n"
				$enableserverhypervmessage1
			}
			
			else
			{
				$errorserverenablehypermessage = "Telnet�ͻ���״̬δ֪��������������ã�"+"`n"
				$errorserverenablehypermessage
			}
		}#end elseif
		
		else
		{
			$erroenablehypermesssage = "Ŀǰ��֧�ֿ���Windows10 RTM����CU�汾��Windows 2012 R2 SP1�汾����֪��"+"`n"
			$erroenablehypermesssage
		}
		
	}#foreach end
}#function end