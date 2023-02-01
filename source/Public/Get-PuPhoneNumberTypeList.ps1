function Get-PuPhonenNumberTypeList {
    [CmdletBinding()]
    param (
        
    )

    process {
        @(
            [PSCustomObject]@{
                "id" = 0
                "name" = "Home"
            },
            [PSCustomObject]@{
                "id" = 1
                "name" = "Cellphone"
            }
        )
    }
}