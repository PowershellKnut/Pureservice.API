function Get-PuPriorities {
    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/priority"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
    }
    Invoke-RestMethod @splat
}