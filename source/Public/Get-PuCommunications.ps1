function Get-PuCommunications {
    [CmdletBinding()]
    param (
        [string]$filter,
        [string]$sort,
        [int]$limit,
        [array]$include
    )

    process {
        $Uri = "$(Get-PuEndpoint)/communication"
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

        $Splat = @{
            "Uri" = $Uri
            "Method" = "GET"
            "Headers" = @{
                "X-Authorization-Key" = Get-PuAccessToken
                "Accept" = "application/vnd.api+json"
            }
        }
        Invoke-RestMethod @Splat
    }
}