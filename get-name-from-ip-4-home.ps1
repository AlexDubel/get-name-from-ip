#$Outfile="C:\temp\ipaddr\ipaddr-2-rez.txt"
#$Outfile="M:\Scripts\Powershell\get-name-from-ip\ipaddr-2-rez.txt"
$Outfile="C:\Users\adm-odubel\Documents\PowerShell\Scripts\get-name-from-ip\ipaddr-2-rez.csv"
Clear-Content $Outfile
$Error.Clear()
#$name = "77.222.159.230", "185.34.224.179", "149.154.161.20" ,"149.154.161.3", "google.com"
$name=Get-Content "C:\Users\adm-odubel\Documents\PowerShell\Scripts\get-name-from-ip\ipaddr-1.txt"
#try {
    $name | ForEach-Object { $dns = Resolve-DnsName $PSItem  -DnsOnly -ErrorAction SilentlyContinue   
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
    else {
    Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"                -value $dns.Namehost}
    $infoObject | Export-Csv -path $OutFile -NoTypeInformation -Encoding UTF8 -Append #Export the results in csv file.
    } 
#} 
<#
#Catch{
    $infoObject = New-Object PSObject
    Add-Member -inputObject $infoObject -memberType NoteProperty -name "Address"				    -value $PSItem
    #Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSType"				    -value $dns.Type
    #Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNSNamehost"                -value $dns.Namehost
    Add-Member -inputObject $infoObject -memberType NoteProperty -name "DNS"                        -value $Error[0].Exception.Message
    $infoObject | Export-Csv -path $OutFile -NoTypeInformation -Encoding UTF8 -Append #Export the results in csv file.
#} 
#>