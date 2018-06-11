#����һ��powershell����վ�����ʾ���ű����������޸ģ��ʺ���GUI�е���

function Test-Port
{
	Param ([string]$ComputerName, $port, $timeout)
	try
	{
		$tcpclient = New-Object -TypeName system.Net.Sockets.TcpClient
		$iar = $tcpclient.BeginConnect($ComputerName, $port, $null, $null)
		$wait = $iar.AsyncWaitHandle.WaitOne($timeout, $false)
		if (!$wait)
		{
			$tcpclient.Close()
			#return Write-Host "$ComputerName �˿�ʧ�ܣ�"
			$global:porterror = $ComputerName + "�ϵ�Ŀ��˿ڲ���ʧ�ܣ�" + "`n"
			return $global:porterror
			
		}
		else
		{
			# Close the connection and report the error if there is one
			#$outputmessage = Write-Host "$ComputerName �˿�������"
			$global:portsuccess = $ComputerName + "�ϵ�Ŀ��˿ڲ���������" + "`n"
			$null = $tcpclient.EndConnect($iar)
			$tcpclient.Close()
			return $global:portsuccess
		}
	}
	catch
	{
		"������Ŀ��˿�"
	}
}