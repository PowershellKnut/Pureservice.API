function Get-PuStatuses {
    $Splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/status"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
    }
    $Result = Invoke-RestMethod @Splat
    $Result.statuses
}