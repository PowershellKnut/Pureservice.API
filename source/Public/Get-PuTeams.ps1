function Get-PuTeams {
    $Splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/team"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
    }
    $Result = Invoke-RestMethod @Splat
    $Result.teams
}