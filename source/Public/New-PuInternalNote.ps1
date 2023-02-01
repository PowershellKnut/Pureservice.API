#NB: This uses ticketId and not requestId
function New-PuInternalNote {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$ticketId, 
        [Parameter(Mandatory)][string]$text
    )

    process {
        $splat = @{
            "text" = $text
            "type" = (Get-PuCommunicationTypeList).where({$_.name -eq "Note"}).id
            "direction" = (Get-PuCommunicationDirectionList).where({$_.name -eq "None"}).id
            "ticket" = $ticketId
        }
        New-PuCommunication @splat
    }
}