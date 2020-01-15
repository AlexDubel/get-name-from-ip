#$Outfile="C:\temp\ipaddr\ipaddr-2-rez.txt"
#$Outfile="M:\Scripts\Powershell\get-name-from-ip\ipaddr-2-rez.txt"
$PathToFile="C:\Users\adm-odubel\Documents\PowerShell\Scripts\get-name-from-ip"
$Outfile="$PathToFile\ipaddr-2-rez.csv"
Clear-Content $Outfile
#$Error.Clear()
#$name = "77.222.159.230", "185.34.224.179", "149.154.161.20" ,"149.154.161.3", "google.com"
$name=Get-Content "$PathToFile\ipaddr-1.txt"
#try {
    #Do not use SilentlyContinue because it will suppress all errors
    $name | ForEach-Object { $dns = Resolve-DnsName $PSItem  -DnsOnly -Server 8.8.4.4 -ErrorAction Continue   
        Write-Debug "$PSItem" #-ForegroundColor Yellow
        $infoObject = New-Object PSObject
    Add-Member -inputObject $infoObject -memberType NoteProperty -name "Address"				    -value $PSItem
    #Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSType"				    -value $dns.Type
    if ($dns.Namehost -eq $null) {
        #Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"             -value $Error[1]    
        #Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"              -value "DNS name does not exist"   
        if ($Error[0].Exception.Message -eq $null) 
             { Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"     -value "DNS name does not exist"  }
        else { Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"     -value  $Error[0].Exception.Message }
    }
    else {     Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"     -value $dns.Namehost }
    $infoObject | Export-Csv -path $OutFile -NoTypeInformation -Encoding UTF8 -Append #Export the results in csv file.
    } 