function New-PuTicket {
    param (
        [Parameter(Mandatory)][int]$userId,
        [Parameter(Mandatory)][int]$assignedDepartmentId,
        [Parameter(Mandatory)][int]$assignedTeamId,
        [Parameter(Mandatory)][int]$assignedAgentId,
        [Parameter(Mandatory)][string]$subject,
        [Parameter(Mandatory)][string]$description,
        [int]$priorityId = 4,
        [int]$ticketTypeId = 1,
        [int]$statusId = 1,
        [int]$requestTypeId = 1,
        [int]$sourceId = 1,
        [int]$visibility = 1
    )

    $splat = @{
        "Method" = "POST"
        "Uri" = "$(Get-PuEndpoint)/ticket"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Content-Type" = "application/vnd.api+json"
        }
        "Body" = @{
            "tickets" = @(
                @{
                    "links" = @{
                        "priority" = @{
                            "id" = $priorityId
                        }
                        "ticketType" = @{
                            "id" = $ticketTypeId
                        }
                        "user" = @{
                            "id" = $userId
                        }
                        "assignedDepartment" = @{
                            "id" = $assignedDepartmentId
                        }
                        "assignedTeam" = @{
                            "id" = $assignedTeamId
                        }
                        "assignedAgent" = @{
                            "id" = $assignedAgentId
                        }
                        "status" = @{
                            "id" = $statusId
                        }
                        "requestType" = @{
                            "id" = $requestTypeId
                        }
                        "source" = @{
                            "id" = $sourceId
                        }
                    }
                    "subject" = $subject
                    "description" = $description
                    "visibility" = $visibility
                }
            )
        } | ConvertTo-Json -Depth 4
    }
    Invoke-RestMethod @splat
}