function Get-PuTypes {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][string][ValidateSet("Ticket","Change","Asset")]$TypeCategory,
        [string]$filter
    )

    process {
        $Uri = Get-PuEndpoint
        switch ($TypeCategory) {
            "Ticket"{
                $Uri += "/tickettype"
            }
            "Change"{
                $Uri += "/changetype"
            }
            "Asset" {
                $Uri += "/assettype"
            }
        }

        $ParameterExclusion = @("TypeCategory")
        $Body = $null
        $PSBoundParameters.Keys.ForEach({
            [string]$Key = $_
            $Value = $PSBoundParameters.$key
        
            if ($ParameterExclusion -contains $Key) {
                return
            }
        
            $Body = $Body + @{
                $Key = $Value
            }
        })

        $Splat = @{
            "Uri" = $Uri
            "Method" = "GET"
            "Headers" = @{
                "X-Authorization-Key" = Get-PuAccessToken
                "Accept" = "application/vnd.api+json"
            }
            "Body" = $Body | ConvertTo-Json -Depth 99
        }
        $Result = Invoke-RestMethod @Splat

        switch ($TypeCategory) {
            "Ticket"{
                $Result.tickettypes
            }
            "Change"{
                $Result.changetypes
            }
            "Asset" {
                $Result.assettypes
            }
        }
    }
}