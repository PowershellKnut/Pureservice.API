function Get-PuEndpoint {
    param (
        [string]$endpointPath = "$env:USERPROFILE\.creds\Pureservice\PureserviceEndpoint.xml"
    )

    if (!(Test-Path $endpointPath)) {
        New-PuEndpoint
    }

    Import-Clixml $endpointPath
}