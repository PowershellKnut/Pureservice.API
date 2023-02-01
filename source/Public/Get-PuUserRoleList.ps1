function Get-PuUserRoleList {
    [CmdletBinding()]
    param (
        
    )

    process {
        @(
            [PSCustomObject]@{
                "id" = 0
                "name" = "None"
            },
            [PSCustomObject]@{
                "id" = 1
                "name" = "PendingActivate"
            },
            [PSCustomObject]@{
                "id" = 2
                "name" = "LocationPendingActivate"
            },
            [PSCustomObject]@{
                "id" = 10
                "name" = "Enduser"
            },
            [PSCustomObject]@{
                "id" = 20
                "name" = "Agent"
            },
            [PSCustomObject]@{
                "id" = 25
                "name" = "ZoneAdmin"
            },
            [PSCustomObject]@{
                "id" = 30
                "name" = "Administrator"
            },
            [PSCustomObject]@{
                "id" = 50
                "name" = "System"
            }
        )
    }
}