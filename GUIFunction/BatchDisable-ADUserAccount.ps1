function batchdisable-aduseraccount
{
	
	#�����û�������Դ��������textbox3
	
	$bjdisableusers = Import-Csv $textbox3.Text -Encoding default
	$ErrorActionPreference = 'SilentlyContinue'
	$disableDate = Get-Date -UFormat "%Y-%m-%d"
	
	foreach ($bjdisableuser in $bjdisableusers)
	{
		
		$batchbjdisableuser = $bjdisableuser.UserName
		
		#���û��ƶ����ѽ����˻�OU����ֹͣ3��
		Get-ADUser $bjdisableuser.UserName | Move-ADObject -TargetPath "OU=�����ʻ�,DC=contoso,DC=com"
		#Start-Sleep -Seconds 3
		$global:batchmovedisableaduser = "�û�" + "$batchbjdisableuser" + "�ѱ��ƶ���OU=�����ʻ�,DC=contoso,DC=com" + "`n"
		$global:batchmovedisableaduser
		
		#���û����������޸�һ�£���ֹͣ3��
		Set-ADUser -Identity $bjdisableuser.UserName  -Description "����ְ $disableDate"
		#Start-Sleep -Seconds 3
		
		$global:batchmodifydisableaduser = "�û�" + "$batchbjdisableuser" + "�����������ѱ��޸�Ϊ:" + "����ְ " + "$disableDate" + "`n"
		$global:batchmodifydisableaduser
		
		#�����˻�����ֹͣ5��
		Disable-ADAccount -Identity $bjdisableuser.UserName
		#Start-Sleep -Seconds 5
		$global:batchdisableadaccount = "�û�" + "$batchbjdisableuser" + "�ѽ������" + "`n"
		$global:batchdisableadaccount
		
		#�����û�����ӵ�ַ�б�������
		Set-Mailbox -HiddenFromAddressListsEnabled $true -Identity $bjdisableuser.UserName
		#Start-Sleep -Seconds 3
		$global:batchdisableaduseraddressdisplay = "�û�" + "$batchbjdisableuser" + "�Ѵӵ�ַ�б����������" + "`n"
		$global:batchdisableaduseraddressdisplay
		
		#��ȡ�û���DN���ƺ��˻����ƣ��ṩ�������LDAPFilterʹ��
		$bjdisableaduser = Get-ADUser -Identity $bjdisableuser.UserName
		$bjdisableuserdn = $bjdisableaduser.DistinguishedName
		$bjdisableusername = $bjdisableuser.name
		
		#��ѯ����û����뵽���ض���֯�������ɾ���������־
		if (Get-ADGroup -LDAPFilter "(member=$bjdisableuserdn)")
		{
			
			$ErrorActionPreference = "stop"
			
			Trap { "�����⵽���쳣: $($_.Exception.Message)"; Continue }
			
			$ADgroupname = (Get-ADGroup -LDAPFilter "(member=$bjdisableuserdn)").name
			$log = "$ADgroupname" + "$batchbjdisableuser" + "`n"
			$log >> "\\fs.contoso.cn\���Ź���\��־�ļ�\BJDisableUser-GroupLog.txt"
			
			Get-ADGroup -LDAPFilter "(member=$bjdisableuserdn)" | ForEach-Object { Remove-ADGroupMember -Identity $_.Name -Members $bjdisableuserdn -Confirm:$false }
			
			$global:batchremoveadgroupmember = "�û�" + "$batchbjdisableuser" + "�����������Ѿ����������domain users��" + "`n"
			$global:batchremoveadgroupmember
			
		}
		#��ѯ�û�����������κ��飬�򷵻���Ϣ
		else
		{
			$global:batchnoremoveadgroup = "�û�" + "$batchbjdisableuser" + "û����Ҫɾ������������Ϣ" + "`n"
			$global:batchnoremoveadgroup
		}
		
		
	}
	
	#����ȫ����ɺ󣬷�����־��Ϣ
	$global:batchenddisableadaccount = "�����Ѿ�ȫ��ִ����ɣ���־��Ϣ������\\fs.contoso.cn\���Ź���\��־�ļ�\BJDisableUser-GroupLog.txt" + "`n"
	$global:batchenddisableadaccount
}