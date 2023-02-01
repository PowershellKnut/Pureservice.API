function New-PuEndpoint {
    param (
        [string]$endpointPath = "$env:USERPROFILE\.creds\Pureservice\PureserviceEndpoint.xml"
    )

    $pureserviceUrl = Read-Host "Enter Pureservice url"
    $endpoint = "$pureserviceUrl/agent/api"

    #Create parent folders of the access token file 
    $endpointDir = $endpointPath.Substring(0, $endpointPath.lastIndexOf('\'))
    if (!(Test-Path $endpointDir)) {
        New-Item -ItemType Directory $endpointDir | Out-Null
    }

    #Create access token file
    $endpoint | Export-Clixml $endpointPath
}