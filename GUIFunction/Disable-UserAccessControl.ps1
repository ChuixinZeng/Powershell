function Disable-UserAccessControl
{
	
	
	Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000
	$useraccesscontrolturnoff = "�û����ʿ���UAC�ѹرգ���������ǰ�ļ����ȷ����Ч��"
	$useraccesscontrolturnoff
	
}