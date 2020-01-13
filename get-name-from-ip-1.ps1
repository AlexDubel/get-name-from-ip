
$Outfile="C:\temp\ipaddr\ipaddr-2-rez.txt"
Clear-Content $Outfile
try {
    "77.222.159.230", "185.34.224.179", "149.154.161.20" ,"149.154.161.3"|`
    ForEach-Object  {Write-Host -NoNewline $PSItem"`t"; (Resolve-DnsName $PSItem).namehost} | Out-File $Outfile -Append
    Write-host (Get-Content $Outfile)    
}
catch {
    Write-Host -NoNewline $PSItem"`t"; (Resolve-DnsName $PSItem).namehost | Out-File $Outfile -Append
    #Write-host (Get-Content $Outfile)   
}
