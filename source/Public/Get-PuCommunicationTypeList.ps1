function Get-PuCommunicationTypeList {
    [CmdletBinding()]
    param (
        
    )

    process {
        @(
            [PSCustomObject]@{
                id = 1
                name = "Note"
            },
            [PSCustomObject]@{
                id = 2
                name = "Message"
            },
            [PSCustomObject]@{
                id = 3
                name = "Sms"
            },
            [PSCustomObject]@{
                id = 4
                name = "Solution"
            }
            [PSCustomObject]@{
                id = 5
                name = "PreviousSolution"
            },
            [PSCustomObject]@{
                id = 6
                name = "History"
            },
            [PSCustomObject]@{
                id = 7
                name = "InitialMessage"
            },
            [PSCustomObject]@{
                id = 8
                name = "TaskHistory"
            },
            [PSCustomObject]@{
                id = 9
                name = "Timeloghistory"
            },
            [PSCustomObject]@{
                id = 10
                name = "ServicetargetHistory"
            },
            [PSCustomObject]@{
                id = 11
                name = "AttachmentHistory"
            },
            [PSCustomObject]@{
                id = 12
                name = "RiskHistory"
            },
            [PSCustomObject]@{
                id = 13
                name = "RollbackPlanHistory"
            }
        )
    }
}