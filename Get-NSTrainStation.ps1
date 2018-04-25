
function Get-NSTrainStation{

    [cmdletbinding()]
        
    Param(
        #Station or part-station name
        [Parameter(Mandatory=$true,Position=0)]
        [string]$StationName,

        #Optional NS Train stations API URI
        [Parameter(Position=1)]
        [string]$Uri = "http://webservices.ns.nl/ns-api-stations"
    )

    $apiUser = Get-NSAPICredential

    $username = $apiUser.Username
    $password = $apiUser.Password
    
    $webClient = New-Object System.Net.WebClient

    $bytes = [System.Text.Encoding]::UTF8.GetBytes($($username + ':' + $password))
    $credentials = [System.Convert]::ToBase64String($bytes)  
    
    $formatcred = 'Basic ' + $credentials

    $webClient.Headers.add('Authorization',$formatcred)
    
    try{
        [xml]$xml = $webClient.DownloadString($Uri)
    }
    catch{
        Throw "Cannot download train info from NS website: $_"        
    }

    $xml.SelectNodes("//station").Where({$_.name -like "*$StationName*"}).ForEach({$_.name})
}




