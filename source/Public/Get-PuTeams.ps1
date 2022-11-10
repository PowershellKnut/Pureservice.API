function Get-PuTeams {
    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/team"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
    }
    Invoke-RestMethod @splat
}