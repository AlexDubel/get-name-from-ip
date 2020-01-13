$Outfile="C:\temp\ipaddr\ipaddr-2-rez.txt"
Clear-Content $Outfile
$name = "77.222.159.230", "185.34.224.179", "149.154.161.20" ,"149.154.161.3", "google.com"

try {
    $name | ForEach-Object { $dns = Resolve-DnsName $PSItem  -DnsOnly #-ErrorAction Stop
        $name1=$PSItem
        $IPhash = @{}
        <#
        $xxx=$IPAddr.Count
        if ($xxx -gt 1) {
        While ($xxx -ge 1) {
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "IPAddr_$xxx"	-Value $IPAddr[$xxx-1]
    #>
    Write-host "dns.Name="$dns.Name "dns.Type="$DNs.Type "DNS.NameHost="$DNS.NameHost -ForegroundColor green
    Write-Host "1234" -ForegroundColor Yellow
    ForEach-Object                                  {    
    $IPhash.Add($dns.name,$dns.Type,$dns.Namehost)  | Out-File $Outfile -Append }
        #$outvar = $dns  |
        #Where-Object Section -eq Additional | 
        #ForEach-Object {
        #    $IPhash.Add($PSItem.name, $PSItem.Type,$PSItem.Namehost)
        #} | Out-File $Outfile -Append 
        #$outvar | Out-File $Outfile -Append 
    $outvar = $dns  | 
        Where-Object Section -eq Answer | 
        Sort-Object NameHost |
        Select-Object Name, NameHost,
            @{N='IP';     E={$IPhash[$_.NameHost]}},
            @{N='Status'; E={'Resolved'}} 
            $outvar | Out-File $Outfile -Append 
    } 
} 
Catch{
        [pscustomobject]@{
        Name = $name1
        NameHost = ''
        IP = ''
        Status = $Error[0].Exception.Message 
    }  | Out-File $Outfile -Append
} 