function New-PuCommunication {
    param (
        [Parameter(Mandatory)][string]$text,
        [Parameter(Mandatory)][int]$type,
        [Parameter(Mandatory)][int]$direction,
        [Parameter(Mandatory)][int]$ticket
    )
    
    process {
        [array]$LinksParams = @(
            "ticket"
        )
    
        $Body = @{
            "links" = @{}
        }
    
        $PSBoundParameters.Keys.ForEach({
            [string]$Key = $_
            $Value = $PSBoundParameters.$key
    
            if ($LinksParams -contains $Key) {
                $Body.links.$Key += @{
                    "id" = $Value
                }
            } else {
                $Body += @{
                    $Key = $Value
                }
            }
        })
    
        $Body = @{
            "communications" = @($Body)
        }
    
        $splat = @{
            "Method" = "POST"
            "Uri" = "$(Get-PuEndpoint)/communication"
            "Headers" = @{
                "X-Authorization-Key" = Get-PuAccessToken
                "Content-Type" = "application/vnd.api+json"
            }
            "Body" = [System.Text.Encoding]::UTF8.GetBytes(($Body | ConvertTo-Json -Depth 99))
        }
        Invoke-RestMethod @splat
    }
}