function Get-PuUsers {
    <#
    .SYNOPSIS
        Gets users from Pureservice using the Pureservice API.
    .PARAMETER filter
        The input $filter is based on predefined properties which you can find by running a get request of users.
        These aren't documented in the Pureservice API docs.
    .EXAMPLE
        Get-PuUsers -filter 'credentials.username=="navnav01"'
    .EXAMPLE
        Get-PuUsers -filter '(fullName == "Navn Navnesen")'
    #>
    param (
        [string]$filter
    )
    
    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/user/"
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