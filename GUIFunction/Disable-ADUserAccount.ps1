function disable-aduseraccount
{
	
	#�����û�������Դ��������textbox2
	$bjdisableusers = $textbox2.Text
	
	$ErrorActionPreference = 'SilentlyContinue'
	$bjdisableusers100 = (Get-ADUser $bjdisableusers).samaccountname
	$disableDate = Get-Date -UFormat "%Y-%m-%d"
	
	#�Ƚ��û�������û������Ƿ���AD�д��ڣ�����������򷵻ش���
	if ($bjdisableusers100 -ne $bjdisableusers)
	{
		
		$global:bjdisableuserserror = "�����˴���ԭ�����û���Ϊ�գ����������˴�����û�����"
		$global:bjdisableuserserror
		
	}
	
	#����û���������ִ��foreach�еĴ���
	elseif ($bjdisableusers100 -eq $bjdisableusers)
	{
		#�ӱ���$bjdisableusers�б����û����ƣ�����ʵ����ֻ��һ���û�����֮���Լ�foreach����Ϊ�˷�����ڸ���Ϊ�������õĽű�
		foreach ($bjdisableuser in $bjdisableusers)
		{
			
			#���û��ƶ����ѽ����˻�OU����ֹͣ3��
			Get-ADUser $bjdisableuser | Move-ADObject -TargetPath "OU=�����ʻ�,DC=contoso,DC=com"
			#Start-Sleep -Seconds 3
			$global:movedisableaduser = "�û�" + "$bjdisableuser" + "�ѱ��ƶ���OU=�����ʻ�,DC=contoso,DC=com" + "`n"
			$global:movedisableaduser
			
			#���û����������޸�һ�£���ֹͣ3��
			Set-ADUser -Identity $bjdisableuser -Description "����ְ $disableDate"
			#Start-Sleep -Seconds 3
			
			$global:modifydisableaduser = "�û�" + "$bjdisableuser" + "�����������ѱ��޸�Ϊ:" + "����ְ " + "$disableDate" + "`n"
			$global:modifydisableaduser
			
			#�����˻�����ֹͣ5��
			Disable-ADAccount -Identity $bjdisableuser
			#Start-Sleep -Seconds 5
			$global:disableadaccount = "�û�" + "$bjdisableuser" + "�ѽ������" + "`n"
			$global:disableadaccount
			
			#�����û�����ӵ�ַ�б�������
			$ErrorActionPreference = "stop"
			
		Trap { "�����⵽���쳣: $($_.Exception.Message)"; Continue }
			Set-Mailbox -HiddenFromAddressListsEnabled $true -Identity $bjdisableuser
			#Start-Sleep -Seconds 3
			$global:disableaduseraddressdisplay = "�û�" + "$bjdisableuser" + "�Ѿ��ӵ�ַ�б����������" + "`n"
			$global:disableaduseraddressdisplay
			
			#��ȡ�û���DN���ƺ��˻����ƣ��ṩ�������LDAPFilterʹ��
			$bjdisableaduser = Get-ADUser -Identity $bjdisableuser
			$bjdisableuserdn = $bjdisableaduser.DistinguishedName
			$bjdisableusername = $bjdisableuser.name
			
			#��ѯ����û����뵽���ض���֯�������ɾ���������־
			if (Get-ADGroup -LDAPFilter "(member=$bjdisableuserdn)")
			{
				
				
				
				$ADgroupname = (Get-ADGroup -LDAPFilter "(member=$bjdisableuserdn)").name
				$log = "$ADgroupname" +"," + "$bjdisableuser" + "`n"
				$log >> "\\fs.contoso.cn\���Ź���\BJDisableUser-GroupLog.txt"
				
				Get-ADGroup -LDAPFilter "(member=$bjdisableuserdn)" | ForEach-Object { Remove-ADGroupMember -Identity $_.Name -Members $bjdisableuserdn -Confirm:$false }
				
				$global:removeadgroupmember = "�û�" + "$bjdisableuser" + "�����������Ѿ����������domain users��" + "`n"
				$global:removeadgroupmember
				
			}
			#��ѯ�û�����������κ��飬�򷵻���Ϣ
			else
			{
				$global:noremoveadgroup = "�û�" + "$bjdisableuser" + "û����Ҫɾ������������Ϣ" + "`n"
				$global:noremoveadgroup
			}
			
			
		}
		
		#����ȫ����ɺ󣬷�����־��Ϣ
		$global:enddisableadaccount = "�����Ѿ�ȫ��ִ����ɣ���־��Ϣ������\\fs.contoso.cn\���Ź���\BJDisableUser-GroupLog.txt" + "`n"
		$global:enddisableadaccount
	}
}
