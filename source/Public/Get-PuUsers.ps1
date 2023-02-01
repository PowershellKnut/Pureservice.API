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
        [string]$filter,
        [int]$limit,
        [string]$sort,
        [string]$include
    )

    process{
        $Uri = "$(Get-PuEndpoint)/user"
        #Parameters to exclude in Uri build
        $ParameterExclusion = @()
        #Build request Uri
        $PSBoundParameters.Keys.ForEach({
            [string]$Key = $_
            $Value = $PSBoundParameters.$key
        
            #Check if parameter is excluded
            if ($ParameterExclusion -contains $Key) {
                return
            }
        
            if ($Value.GetType().BaseType.Name -eq "Array") {
                $Value = $Value -join ","
            }
        
            #Check for "?" in Uri and set delimiter
            if (!($Uri -replace "[^?]+")) {
                $Delimiter = "?"
            } else {
                $Delimiter = "&"
            }
        
            $Uri = "$Uri$Delimiter$Key=$Value"
        })     

        $splat = @{
            "Method" = "GET"
            "Uri" = $Uri
            "Headers" = @{
                "X-Authorization-Key" = Get-PuAccessToken
                "Accept" = "application/vnd.api+json"
            }
        }
        $Result = Invoke-RestMethod @splat
        $Result.users
    }
}