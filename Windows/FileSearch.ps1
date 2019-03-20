param
(
[string]$searchstring,
[string]$searchlocation
)

# ���ò��ҵ�Ŀ¼
Set-Location $searchlocation

# ִ�в��Ҳ������ҵĽ�����浽filename����
$filename = Get-ChildItem *.* -Include *.txt -Recurse | Select-String -Pattern $searchstring | select filename

# ����log�ļ��ĸ�ʽ��·��
$logfile = "reslut_"+(Get-Date).ToString("yyyyMMddhhmmss")+".csv"

# ����ѯ�Ľ�����浽logfile��
$filename | Export-Csv -Path $logfile -Encoding Default