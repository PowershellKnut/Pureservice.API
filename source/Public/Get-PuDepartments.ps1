function Get-PuDepartments {
    [CmdletBinding()]
    param (
        
    )

    process {
        $Splat = @{
            "Uri" = "$(Get-PuEndpoint)/department"
            "Method" = "GET"
            "Headers" = @{
                "X-Authorization-Key" = Get-PuAccessToken
                "Accept" = "application/vnd.api+json"
            }
        }
        $Result = Invoke-RestMethod @Splat
        $Result.departments
    }
}