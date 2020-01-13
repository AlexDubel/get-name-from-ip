#$Outfile="C:\temp\ipaddr\ipaddr-2-rez.txt"
$Outfile="M:\Scripts\Powershell\get-name-from-ip\ipaddr-2-rez.txt"
Clear-Content $Outfile
#$name = "77.222.159.230", "185.34.224.179", "149.154.161.20" ,"149.154.161.3", "google.com"
$name=Get-Content "M:\Scripts\Powershell\get-name-from-ip\ipaddr-1.txt"
try {
    $name | ForEach-Object { $dns = Resolve-DnsName $PSItem  -DnsOnly -ErrorAction SilentlyContinue   
        #$name1=$PSItem
        #$IPhash = @{}
        <#
        $xxx=$IPAddr.Count
        if ($xxx -gt 1) {
        While ($xxx -ge 1) {
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "IPAddr_$xxx"	-Value $IPAddr[$xxx-1]
    #>
    #$dns | 
    #ForEach-Object {Write-host "dns.Name="$PSItem.Name "dns.Type="$PSItem.Type "DNS.NameHost="$PSItem.NameHost -ForegroundColor green}
    Write-Host "1234" -ForegroundColor Yellow
    #ForEach-Object {
    #$IPhash.Add($dns.name, $dns.Type, $dns.Namehost) | Out-File $Outfile -Append }
    $infoObject = New-Object PSObject
    Add-Member -inputObject $infoObject -memberType NoteProperty -name "Address"				    -value $PSItem
    #Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSType"				    -value $dns.Type
    if ($dns.Namehost -eq $null) {
        #Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"             -value $Error[1]    
        #Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"              -value "DNS name does not exist"   
        Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"              -value  $Error[0].Exception.Message  
    }
    else {
    Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"                -value $dns.Namehost}
    $Error[1]
    #Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNS"                -value $dns
    $infoObject | Out-File $Outfile -Append
    #ForEach-Object {
    #    $IPhash.Add(($DNS).name, ($dns).Namehost) | Out-File $Outfile -Append }
    #$dns | ForEach-Object                                  {    
    #$IPhash.Add($PSItem.name, $PSItem.Type, $PSItem.Namehost) | Out-File $Outfile -Append }
        #$outvar = $dns  |
        #Where-Object Section -eq Additional | 
        #ForEach-Object {
        #    $IPhash.Add($PSItem.name, $PSItem.Type,$PSItem.Namehost)
        #} | Out-File $Outfile -Append 
        #$outvar | Out-File $Outfile -Append 
    
    <#
        $outvar = $dns  | 
        Where-Object Section -eq Answer | 
        Sort-Object NameHost |
        Select-Object Name, NameHost,
            @{N='IP';     E={$IPhash[$_.NameHost]}},
            @{N='Status'; E={'Resolved'}} 
            $outvar | Out-File $Outfile -Append 
            #>
    } 
} 
Catch{
      <#  [pscustomobject]@{
        Name = $name1
        NameHost = ''
        IP = ''
        Status = $Error[0].Exception.Message 
    }  | Out-File $Outfile -Append
    #>
    $infoObject = New-Object PSObject
    Add-Member -inputObject $infoObject -memberType NoteProperty -name "Address"				    -value $PSItem
    #Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSType"				    -value $dns.Type
    #Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"                -value $dns.Namehost
    Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNS"                        -value $Error[0].Exception.Message
    $infoObject | Out-File $Outfile -Append
} 