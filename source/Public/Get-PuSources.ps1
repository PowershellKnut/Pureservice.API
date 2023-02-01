function Get-PuSources {
    param (
        [Parameter(Mandatory)][ValidateSet("Ticket","Change")][string]$Type
    )
    
    $Splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/source/"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
        "Body" = @{
            "filter" = "requestType.Key == `"$Type`""
        }
    }
    $Result = Invoke-RestMethod @Splat
    $Result.sources
}