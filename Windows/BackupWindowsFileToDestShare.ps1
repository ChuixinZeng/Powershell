$date = Get-Date -format yyyy-MM-dd
$SourceDir = "D:\TEST"  
$DestinationDir = "E:\$date"

$AddDays = -1 #���ӵ�����,�����ɸ�
#$AddHours = -1  #���ӵ�Сʱ,�����ɸ�
#$SourceFileArray = Get-ChildItem -Path $SourceDir -Recurse | Where-Object -FilterScript {($_.LastWriteTime -gt (Get-Date).AddDays($AddDays).AddHours($AddHours))} | Select-Object -ExpandProperty Name  
$SourceFileArray = Get-ChildItem -Path $SourceDir -Recurse | Where-Object -FilterScript {($_.LastWriteTime -gt (Get-Date).AddDays($AddDays))} | Select-Object -ExpandProperty Name  
$SourceFileArray
  
$date = Get-Date  
Write-Host "$date ������ʼ����"   

if (!(Test-Path -path $DestinationDir) ){
New-Item -path $DestinationDir -type Directory | out-null
}
  
foreach ( $file in $SourceFileArray ){  
$SourcePath = $SourceDir + "\" +$file 
$SourcePath 

Copy-Item -Path $SourcePath -Destination $DestinationDir -Recurse -Force
}
Write-Host "$date ��ɣ�" + $SourcePath 

Write-Host "$date ������ɣ�" 