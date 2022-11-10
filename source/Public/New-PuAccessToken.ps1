function New-PuAccessToken {
    param (
        [string]$accessTokenPath = "$env:USERPROFILE\.creds\Pureservice\pureserviceAccessToken.xml"
    )

    $apiKey = Read-Host "Enter API key" -AsSecureString

    #Create parent folders of the access token file
    $accessTokenDir = $accessTokenPath.Substring(0, $accessTokenPath.lastIndexOf('\'))
    if (!(Test-Path $accessTokenDir)) {
        New-Item -ItemType Directory $accessTokenDir | Out-Null
    }

    #Create access token file
    $apiKey | Export-Clixml $accessTokenPath
}