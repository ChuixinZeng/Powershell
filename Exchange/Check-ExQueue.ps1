Add-pssnapin Microsoft.Exchange.Management.PowerShell.E2010
function Queue {
$servername=get-transportserver |sort -Property name
foreach ($server in $servername)
{$queuecount =($server|Get-Queue |?{$_.DeliveryType -ne "ShadowRedundancy"}  | measure messagecount -sum |select sum).sum
$output1 =$server.name+"�ʼ����й�"+ $queuecount
if ($queuecount -gt -1)
{$output1 =$output1+"��ѻ��ʼ�"}
$output1
}}
$date1 = Get-Date -UFormat "%Y-%m-%d_%H��%M��%S��"
$date2 = Get-Date -UFormat "%Y/%m/%d %H:%M:%S"
Queue > "D:\scripts\Exchange������и澯��Ϣ$date1.txt"


$filename = "D:\scripts\Exchange������и澯��Ϣ$date1.txt"
$smtpServer = ��10.205.91.22��
$msg = new-object Net.Mail.MailMessage
$att = new-object Net.Mail.Attachment($filename)
$smtp = new-object Net.Mail.SmtpClient($smtpServer)
$msg.From = ��scomadmin@contoso.com��
$msg.To.Add("zengchuixin@contoso.com")
$msg.To.Add("qideyu@contoso.com")
$msg.To.Add("linxiaorui@contoso.com")
$msg.To.Add("zhangwj@contoso.com")
$msg.To.Add("gaoxu@contoso.com")
$msg.Subject = ��$date2 �ʼ����б��������
$msg.Body = ����򿪸����鿴��ϸ��Exchange������������о�����Ϣ!�����ʼ��ѻ�����100��ķ���������Ҫ�ر��ע!��
$msg.Attachments.Add($att)
$smtp.Send($msg)