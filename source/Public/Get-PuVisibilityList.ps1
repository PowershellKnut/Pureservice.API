function Get-PuVisibilityList {
    [CmdletBinding()]
    param (
        
    )

    process {
        @(
            [PSCustomObject]@{
                "id" = 0
                "name" = "Visible"
            },
            [PSCustomObject]@{
                "id" = 1
                "name" = "VisibleSilent"
            },
            [PSCustomObject]@{
                "id" = 2
                "name" = "NotVisible"
            }
        )
    }
}