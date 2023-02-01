function Get-PuCommunicationDirectionList {
    [CmdletBinding()]
    param (
        
    )

    process {
        @(
            [PSCustomObject]@{
                id = 1
                name = "Inbound"
            },
            [PSCustomObject]@{
                id = 2
                name = "Outbound"
            },
            [PSCustomObject]@{
                id = 3
                name = "None"
            }
        )
    }
}