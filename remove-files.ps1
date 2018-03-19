$i = 1
do{
Write-Host -ForegroundColor Yellow -Object "开始第$i`次删除"
sleep(8)
$fl = Get-ChildItem -Recurse -Path "D:\venu img" -Filter *1.png

write-host -ForegroundColor Yellow "删除文件： $fl"
$fl | Remove-Item -Confirm

}while($i++)