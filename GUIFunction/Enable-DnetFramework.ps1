function Enable-DnetFramework
{
	#Ŀǰ��function��֧��Windows10��Windows 2012R2����ϵͳ
	$computername = $env:COMPUTERNAME
	#����ط�֮���Լ�foreach����Ϊ�˷���ؽ���ǰ�ĽŲ�����Ϊ�ܹ�������̨��������Ϊǰ���computername��������������ָ����ǰ����
	foreach ($cn in $computername)
	{
		
		$cnwmi = Get-WmiObject win32_operatingsystem -ComputerName $cn
		
		if (Get-WmiObject win32_operatingsystem -ComputerName $cn | where { $_.Version -like "10.0*" })
		{
			$outputsystemclientversion = "��ǰ$env:COMPUTERNAME �İ汾��Windows10�����ڳ��Կ���.NetFrameWork 3.5.1�ͻ��˹���...." + "`n"
			$outputsystemclientversion
			
			if ((Get-WindowsOptionalFeature -Online | where featurename -like "*NetFX3*").state -eq "DisabledWithPayloadRemoved")
			{
				
				$ErrorActionPreference = "stop"
				Trap { "����.NetFrameWork 3.5.1ʧ��: $($_.Exception.Message)"; }
				Dism.exe /online /enable-feature /featurename:NetFX3 /Source:\\fs.contos.com\���Ź���\NetFramework3.5.1\sxswindows10 | Out-Null
				$enableclienthypervmessage = ".NetFrameWork 3.5.1�����ɹ������������ļ�����Ա�������Ч" + "`n"
				$enableclienthypervmessage
				
				
			}
			elseif ((Get-WindowsOptionalFeature -Online | where featurename -like "*NetFX3*").state -eq "Enabled")
			{
				$enableclienthypervmessage1 = "����ǰ�Ļ����Ѿ�����.NetFrameWork 3.5.1�������ظ�������" + "`n"
				$enableclienthypervmessage1
			}
			else
			{
				$errorclientenablehypermessage = ".NetFrameWork 3.5.1״̬δ֪��������������ã�" + "`n"
				$errorclientenablehypermessage
			}
			
		} #end if
		
		elseif ($cnwmi.version -eq "6.3.9600")
		{
			$outputserversystemversion = "��ǰ$env:COMPUTERNAME �İ汾��Windows 2012R2 SP1�����ڳ��Կ���.NetFrameWork 3.5.1����...." + "`n"
			$outputserversystemversion
			
			if ((Get-WindowsFeature Net-Framework-Core).InstallState -eq "Available")
			{
				Install-WindowsFeature Net-Framework-Core -source \\fs.contos.com\���Ź���\NetFramework3.5.1\sxswindow2012r2\source\sxs
				$enableserverhypervmessage = ".NetFrameWork 3.5.1�����ɹ������������ļ�����Ա�������Ч" + "`n"
				$enableserverhypervmessage
				$ErrorActionPreference = "stop"
				Trap { "����T.NetFrameWork 3.5.1ʧ��: $($_.Exception.Message)"; }
			}
			elseif ((Get-WindowsFeature Net-Framework-Core).InstallState -eq "Installed")
			{
				$enableserverhypervmessage1 = "����ǰ�Ļ����Ѿ�����.NetFrameWork 3.5.1�������ظ�������" + "`n"
				$enableserverhypervmessage1
			}
			
			else
			{
				$errorserverenablehypermessage = ".NetFrameWork 3.5.1״̬δ֪��������������ã�" + "`n"
				$errorserverenablehypermessage
			}
		}#end elseif
		
		else
		{
			$erroenablehypermesssage = "Ŀǰ��֧�ֿ���Windows10 RTM����CU�汾��Windows 2012 R2 SP1�汾����֪��" + "`n"
			$erroenablehypermesssage
		}
		
	}#foreach end
}#function end