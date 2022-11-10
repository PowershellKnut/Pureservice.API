function Get-PuTicket {
    param (
        [int]$requestNumber,
        [string]$filter
    )

    if ($requestNumber) {
        $endpointSuffix = "/ticket/$requestNumber/requestNumber/"
    } else {
        $endpointSuffix = "/ticket"
    }

    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)$endpointSuffix"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
        "Body" = @{
            "filter" = $filter
        }
    }
    Invoke-RestMethod @splat
}