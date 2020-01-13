#$computer = 'W12R2DSC3'
Clear-Host
Write-Host "=================" -ForegroundColor Green
$name = "77.222.159.230", "185.34.224.179", "149.154.161.20" ,"149.154.161.3", "google.com"
try {
$name | ForEach-Object {$name1=$PSItem; Resolve-DnsName $PSItem -ErrorAction Stop }
}
catch {
  Write-Warning -Message "Record not found for $name1"
}