function Get-PuSources {
    param (
        [Parameter(Mandatory)][ValidateSet("ticket","change")][string]$type
    )
    
    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/source/"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
        "Body" = @{
            "filter" = "requestType.Key == `"$type`""
        }
    }
    Invoke-RestMethod @splat
}