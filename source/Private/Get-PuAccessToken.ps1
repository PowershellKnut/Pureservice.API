function Get-PuAccessToken {
    param (
        [string]$accessTokenPath = "$env:USERPROFILE\.creds\Pureservice\pureserviceAccessToken.xml"
    )

    if (!(Test-Path $accessTokenPath)) {
        New-PuAccessToken
    }

    Import-Clixml $accessTokenPath | ConvertFrom-SecureString -AsPlainText
}