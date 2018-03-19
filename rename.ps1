$fs = Get-ChildItem -Path "D:\LuyiLuImages220"  -Recurse -Filter *.jpg
foreach($o in $fs)
{

$new_name= $o.Name.Split('-')[-1]
if($o.Name.Length -gt 5)
{
###$o|Rename-Item -NewName $new_name
$o | Remove-Item
}
}

