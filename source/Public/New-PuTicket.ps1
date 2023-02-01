function New-PuTicket {
    param (
        [Parameter(Mandatory)][string]$subject,
        [Parameter(Mandatory)][string]$description,
        [string]$solution,
        [string]$cf_1,
        [string]$cf_2,
        [string]$cf_3,
        [string]$cf_4,
        [string]$cf_5,
        [string]$cf_6,
        [string]$cf_7,
        [string]$cf_8,
        [string]$cf_9,
        [Parameter(Mandatory)][int]$visibility,
        [string]$customerReference,
        [string]$coordinates,
        [bool]$isMarkedForDeletion,
        [Parameter(Mandatory)][int]$user,
        [Parameter(Mandatory)][int]$ticketType,
        [Parameter(Mandatory)][int]$priority,
        [Parameter(Mandatory)][int]$status,
        [Parameter(Mandatory)][int]$source,
        [Parameter(Mandatory)][int]$assignedDepartment,
        [Parameter(Mandatory)][int]$assignedTeam,
        [Parameter(Mandatory)][int]$assignedAgent,
        [int]$form,
        [int]$category1,
        [int]$category2,
        [int]$category3
    )

    process {
        #Set default params
        $Params = $PSBoundParameters + @{
            "requestType" = (Get-PuRequestTypeList).where({$_.name -eq "Ticket"})[0].id
        }

        [array]$LinksParams = @(
            "requestType",
            "user",
            "ticketType",
            "priority",
            "status",
            "source",
            "assignedDepartment",
            "assignedTeam",
            "assignedAgent",
            "form",
            "category1",
            "category2",
            "category3"
        )
    
        $Body = @{
            "links" = @{}
        }
    
        $Params.Keys.ForEach({
            [string]$Key = $_
            $Value = $Params.$key
    
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
            "tickets" = @($Body)
        }
    
        $splat = @{
            "Method" = "POST"
            "Uri" = "$(Get-PuEndpoint)/ticket"
            "Headers" = @{
                "X-Authorization-Key" = Get-PuAccessToken
                "Content-Type" = "application/vnd.api+json"
            }
            "Body" = [System.Text.Encoding]::UTF8.GetBytes(($Body | ConvertTo-Json -Depth 99))
        }
        Invoke-RestMethod @splat
    }
}