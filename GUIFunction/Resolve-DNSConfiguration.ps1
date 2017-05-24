#����һ���ٷ��Ľű����ҽ������޸ģ��ʺ���Powershell GUI��ʹ��

Function Resolve-DNSConfiguration
{
    <#
    .SYNOPSIS
    Resolve-DNSConfiguration is used to find the IP address for a given DNS name or vice-versa 
    .DESCRIPTION
    used to find the IP address for a given DNS name or vice-versa
    using .NET Classes DNS and ActiveDirectorySite, this tool can replace NSLOOKUP.exe utility
    .PARAMETER  ComputerName
    The name or IP of the computer to query.
    .EXAMPLE
    Resolve-DNSConfiguration -ComputerName WHATEVER
    This will query information from the computer WHAREVER
    .EXAMPLE
    Resolve-DNSConfiguration -ComputerName WHATEVER | Format-Table *
    This will dispaly the information in a table.
    .EXAMPLE
    Resolve-DNSConfiguration -ComputerName 127.0.0.1
    This will dispaly the using IP
    .EXAMPLE
    'LocalHost','127.0.0.1' | Resolve-DNSConfiguration
    Acepting pipeline input
    .LINK
    https://msdn.microsoft.com/en-us/library/system.net.dns(v=vs.110).aspx
    https://msdn.microsoft.com/en-us/library/system.directoryservices.activedirectory.activedirectorysite(v=vs.110).aspx
    #>
	[CmdLetBinding()]
	PARAM (
		[Parameter(Mandatory = $True,
				   ValuefromPipeLine = $True,
				   ParameterSetName = "ComputerName",
				   HelpMessage = "Computer Name to be resolved",
				   ValueFromPipeLineByPropertyName = $True)]
		[String[]]$ComputerName,
		
		[Switch]$ShowProgress
		
		#[String]$ErrorLogFilePath = $RCErrorPath
	)
	BEGIN
	{
		$Counter = 0
	}
	PROCESS
	{
		foreach ($Comp in $ComputerName)
		{
			try
			{
				
				$Computer = [System.Net.Dns]::GetHostEntry("$Comp")
				$server = [System.DirectoryServices.ActiveDirectory.ActiveDirectorySite]::GetComputerSite().servers
				[PSCustomObject]$successnslookup = @{
					'ComputerFQDN' = $Computer.HostName;
					'ComputerIP' = $Computer.AddressList.IPAddressToString;
				}
				
				$global:successnslookupresult = "����������ǣ�" + $successnslookup.ComputerFQDN + "`n" + "IP��ַ�ǣ�" + $successnslookup.ComputerIP + "`n"
				return $global:successnslookupresult
			}
			catch
			{
				$global:singlenslookuperror = "������ļ�������ƣ�" + "$Comp" + " �޷����������Ľ�������ȷ��������ȷ����" + "`n"
				return $global:singlenslookuperror
				
				#��־����ȱ�ע�͵��ˣ�����Ҫ�����־
				#$Comp | Out-File -FilePath $ErrorLogFilePath -Append
			}
			if ($ShowProgress)
			{
				$Counter++
				$Parameters = @{
					Activity = "Processing -->";
					Status = "$counter of $($ComputerName.Count) of Computers";
					CurrentOperation = $Comp;
					PercentComplete = (($Count/$ComputerName.Count) * 100)
				}
				Write-Progress @Parameters
			}
		}
	}
	END { }
}