Add-PSSnapin *exchange*
$info=Import-Csv -Path D:\scripts\room.csv -Encoding Default
#$password=ConvertTo-SecureString -AsPlainText -String "@!m02222017" -Force
foreach ($info1 in $info)

{
#��������������

New-Mailbox -Name $info1.alias -Database "BJDB01114" -Room `
 -DisplayName $info1.displayname -Office $info1.ln -Alias $info1.alias `
 -PrimarySmtpAddress $info1.mailname -OrganizationalUnit "OU=������,OU=������Դ,DC=contoso,DC=com"
 }

 Start-Sleep -Seconds 180 -Verbose

 foreach ($info2 in $info)

 {

#��Ĭ�ϵĵ����ʼ���ַ����

Get-Mailbox -Identity $info2.mailname | Set-Mailbox -EmailAddressPolicyEnabled:$true 

#���û�����������ޣ�30�죩

Get-Mailbox -Identity $info2.mailname | Set-CalendarProcessing `
-MaximumDurationInMinutes 1800 -BookingWindowInDays 180 -AutomateProcessing AutoAccept

#ɾ������������
#Remove-Mailbox -Identity "$info1.roomname
}


#���û�����Ȩ�������ˣ����е����������ң�

Get-Mailbox -Identity "VIP-room-Meeting@contoso.com" | Set-CalendarProcessing `
-AllBookInPolicy $false -AllRequestInPolicy $true -ResourceDelegates "test@contoso.com"

Get-Mailbox -Identity "World-of-Warcraft-Meeting@contoso.com" | Set-CalendarProcessing `
-AllBookInPolicy $false -AllRequestInPolicy $true -ResourceDelegates "test@contoso.com"
Get-Mailbox -Identity "Call-of-Duty-Meeting@contoso.com" | Set-CalendarProcessing `
-AllBookInPolicy $false -AllRequestInPolicy $true -ResourceDelegates "test@contoso.com"

<#
�����͹������������: Exchange Online Help  
https://technet.microsoft.com/zh-cn/library/jj215781(v=exchg.150).aspx

#>