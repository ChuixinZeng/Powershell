function Disable-InternetExplorerESC
#�ر�IE ESC����
{
	$computerlist = $Env:COMPUTERNAME
	foreach ($cl in $computerlist)
	{
		$computerversion = Get-WmiObject Win32_OperatingSystem -ComputerName $cl
		
		if ($computerversion.version -eq "6.3.9600")#����ϵͳ�汾Ϊwindows 2012 R2
		{
			$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
			$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
			Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
			Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force
			Stop-Process -Name Explorer
			$disableieesc12R2 = "���Ĳ���ϵͳΪWindows Server 2012 R2,IE ESC�Ѿ�������."
			$disableieesc12R2
		}
		elseif ($computerversion.version -eq "6.1.7601")#����ϵͳ�汾Ϊwindows 2008 R2 sp1
		{
			$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
			$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
			Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
			Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force
			Stop-Process -Name Explorer
			$disableieesc08R2 = "���Ĳ���ϵͳΪWindows Server 2008 R2 sp1,IE ESC�Ѿ�������."
			$disableieesc08R2
		}
		elseif ($computerversion.version -eq "10.0.15063")
		{
			$disableieescwin101703 = "���Ĳ���ϵͳ�汾��windows10 1703�汾����֧�ֹر�IE ESC"
			$disableieescwin101703
		}
		
		elseif ($computerversion.version -eq "10.0.10.0.14393")
		{
			$disableieescwin101603 = "���Ĳ���ϵͳ�汾��windows10 1603�汾����֧�ֹر�IE ESC"
			$disableieescwin101603
		}
		else
		{
			$disableieescother = "��ʱ����֧�ֵĲ���ϵͳ����"
			$disableieescother
		}
	}#foreach�Ľ����ط�
}#function�Ľ����ط�