function Get-PuEndpoint {
    param (
        [string]$endpointPath = "$env:USERPROFILE\.creds\Pureservice\pureserviceEndpoint.xml"
    )

    if (!(Test-Path $endpointPath)) {
        New-PuEndpoint
    }

    Import-Clixml $endpointPath
}