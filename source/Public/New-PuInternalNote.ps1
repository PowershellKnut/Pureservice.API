#NB: This uses ticketId and not requestId
function New-PuInternalNote {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int]$ticketId, 
        [Parameter(Mandatory)][string]$text
    )
    
    $splat = @{
        "Method" = "POST"
        "Uri" = "$(Get-PuEndpoint)/communication"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Content-Type" = "application/vnd.api+json"
        }
        "Body" = @{
            "communications" = @(
                @{
                    "text" = $text
                    "type" = 1
                    "direction" = 3
                    "ticketId" = $ticketId
                }
            )
        } | ConvertTo-Json
    }
    Invoke-RestMethod @splat
}