$name = 'google.com'
#$name = '149.154.161.20'

try{
    
    $dns = Resolve-DnsName -Name $name -Type NS -DnsOnly -ErrorAction Stop
    $IPhash = @{}
        $dns |
        Where-Object Section -eq Additional | 
        #"77.222.159.230", "185.34.224.179", "149.154.161.20" ,"149.154.161.3", "google.com" |`
        ForEach-Object {
             $IPhash.Add($_.name, $_.IP4Address)
        }

    $dns | 
        Where-Object Section -eq Answer | 
        Sort-Object NameHost |
        Select-Object Name, NameHost,
            @{N='IP';     E={$IPhash[$_.NameHost]}},
            @{N='Status'; E={'Resolved'}}
} Catch{
    [pscustomobject]@{
        Name = $name
        NameHost = ''
        IP = ''
        Status = $Error[0].Exception.Message
    }
}