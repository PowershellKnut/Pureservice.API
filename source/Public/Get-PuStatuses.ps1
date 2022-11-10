function Get-PuStatuses {
    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/status"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
    }
    Invoke-RestMethod @splat
}