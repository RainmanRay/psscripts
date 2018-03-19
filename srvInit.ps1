New-SmbShare -Name "logshr" -ReadAccess 'everyone' -Path "D:\nuctech\apache\logs" -ErrorVariable ex
Set-ExecutionPolicy Bypass -Force
Enable-PSRemoting -Force -SkipNetworkProfileCheck