$base = "D:\tomcat8-afip"

function Rt8{
Get-Service -Name "Tomcat8"|Stop-Service -Verbose 
Get-Process -Name "notepad"|Stop-Process -Force -Verbose 
sleep(1)

$nname='logs'+(Get-Date).tostring("MMddhhmm")
$log=Get-Item -Path $base'\logs' -ErrorAction SilentlyContinue
$app=Get-ChildItem -LiteralPath "$base\webapps"|where{$_.mode -eq 'd----'}|select -Index 0
if($log){Rename-Item -Path $log.FullName -NewName $nname }
if($app){
$app|Remove-Item -Recurse
Remove-Item -Recurse -LiteralPath "$base`\work\"
}
}

function St8{
Get-Service -Name Tomcat8 |Start-Service -Verbose
}

function Sp8{
Get-Service -Name Tomcat8|Stop-Service -Verbose
}

