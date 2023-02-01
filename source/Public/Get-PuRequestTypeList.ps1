function Get-PuRequestTypeList {
    [CmdletBinding()]
    param (
        
    )

    process {
        @(
            [PSCustomObject]@{
                "id" = 1
                "name" = "Ticket"
            },
            [PSCustomObject]@{
                "id" = 2
                "name" = "Change"
            }
        )
    }
}