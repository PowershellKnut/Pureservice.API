function Get-PuPriorities {
    $Splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/priority"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
    }
    $Result = Invoke-RestMethod @splat
    $Result.priorities
}