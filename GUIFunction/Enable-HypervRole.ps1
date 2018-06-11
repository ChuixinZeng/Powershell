function Enable-HypervRole
{

		#Ŀǰ��function��֧��Windows10��Windows 2012R2����ϵͳ
		$computername = $env:COMPUTERNAME
		#����ط�֮���Լ�foreach����Ϊ�˷���ؽ���ǰ�ĽŲ�����Ϊ�ܹ�������̨��������Ϊǰ���computername��������������ָ����ǰ����
		foreach ($cn in $computername)
		{
			
			$cnwmi = Get-WmiObject win32_operatingsystem -ComputerName $cn
			
			if (Get-WmiObject win32_operatingsystem -ComputerName $cn | where { $_.Version -like "10.0*" })
			{
				$outputsystemclientversion = "��ǰ$env:COMPUTERNAME �İ汾��Windows10�����ڳ��Կ���Hyper-v��ɫ...." + "`n"
				$outputsystemclientversion
				
				if ((Get-WindowsOptionalFeature -Online | where featurename -Like "Microsoft-Hyper-V-All").state -eq "Disabled")
				{
					Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -All
					$enableclienthypervmessage = "Hyper-v�����ɹ������������ļ�����Ա�������Ч"
					$enableclienthypervmessage
		
				}
				elseif ((Get-WindowsOptionalFeature -Online | where featurename -Like "Microsoft-Hyper-V-All").state -eq "Enabled")
				{
					$enableclienthypervmessage1 = "����ǰ�Ļ����Ѿ�����hyper-v�������ظ�������"
					$enableclienthypervmessage1
				}
				else
				{
					$errorclientenablehypermessage = "Hyper-v״̬δ֪��������������ã�"
					$errorclientenablehypermessage
				}
				
			} #end if
			
			elseif ($cnwmi.version -eq "6.3.9600")
			{
				
				
				if ((Get-WindowsFeature -Name 'Hyper-V').InstallState -eq "Installed")
				{
					$enableserverhypervmessage1 = "����ǰ�Ļ����Ѿ�����hyper-v�������ظ�������"
					$enableserverhypervmessage1
			}
			else
			{
				try
				{
					#����ط���ӵ�warningaction����Ҫ����Ȼ�����޷�����������richtextbox�У�ֱ��дtrap�ǲ��е�
					Install-WindowsFeature -Name Hyper-V -WarningAction Stop -IncludeAllSubFeature -IncludeManagementTools
					
					$enableserverhypervmessage = "Hyper-v�����ɹ������������ļ�����Ա�������Ч"
					$enableserverhypervmessage
					$outputserversystemversion = "��ǰ$env:COMPUTERNAME �İ汾��Windows 2012R2 SP1�����ڳ��Կ���Hyper-v��ɫ...."
					$outputserversystemversion
				}
				catch
				{
					$richtextbox3.Text += "��������ԭ���п�����������������濪��Hyper-v����������ǰ�Ĳ���ϵͳ�����㿪��Hyper-vҪ��
����windows10��windows server2012R2�����ϵͳ�����й���"+"`n"
				}
			}
			
		}#end else
			
			else
			{
				$erroenablehypermesssage = "Ŀǰ��֧�ֿ���Windows10 RTM����CU�汾��Windows 2012 R2 SP1�汾����֪��"
				$erroenablehypermesssage
			}
			
		}#foreach end
	
}#function end