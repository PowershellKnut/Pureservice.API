#Region '.\Private\Get-PuAccessToken.ps1' 0
function Get-PuAccessToken {
    param (
        [string]$accessTokenPath = "$env:USERPROFILE\.creds\Pureservice\pureserviceAccessToken.xml"
    )

    if (!(Test-Path $accessTokenPath)) {
        New-PuAccessToken
    }

    Import-Clixml $accessTokenPath | ConvertFrom-SecureString -AsPlainText
}
#EndRegion '.\Private\Get-PuAccessToken.ps1' 11
#Region '.\Private\Get-PuEndpoint.ps1' 0
function Get-PuEndpoint {
    param (
        [string]$endpointPath = "$env:USERPROFILE\.creds\Pureservice\pureserviceEndpoint.xml"
    )

    if (!(Test-Path $endpointPath)) {
        New-PuEndpoint
    }

    Import-Clixml $endpointPath
}
#EndRegion '.\Private\Get-PuEndpoint.ps1' 11
#Region '.\Private\New-PuAccessToken.ps1' 0
function New-PuAccessToken {
    param (
        [string]$accessTokenPath = "$env:USERPROFILE\.creds\Pureservice\pureserviceAccessToken.xml"
    )

    $apiKey = Read-Host "Enter API key" -AsSecureString

    #Create parent folders of the access token file
    $accessTokenDir = $accessTokenPath.Substring(0, $accessTokenPath.lastIndexOf('\'))
    if (!(Test-Path $accessTokenDir)) {
        New-Item -ItemType Directory $accessTokenDir | Out-Null
    }

    #Create access token file
    $apiKey | Export-Clixml $accessTokenPath
}
#EndRegion '.\Private\New-PuAccessToken.ps1' 16
#Region '.\Private\New-PuEndpoint.ps1' 0
function New-PuEndpoint {
    param (
        [string]$endpointPath = "$env:USERPROFILE\.creds\Pureservice\pureserviceEndpoint.xml"
    )

    $pureserviceUrl = Read-Host "Enter pureservice url"
    $endpoint = "$pureserviceUrl/agent/api"

    #Create parent folders of the access token file 
    $endpointDir = $endpointPath.Substring(0, $endpointPath.lastIndexOf('\'))
    if (!(Test-Path $endpointDir)) {
        New-Item -ItemType Directory $endpointDir | Out-Null
    }

    #Create access token file
    $endpoint | Export-Clixml $endpointPath
}
#EndRegion '.\Private\New-PuEndpoint.ps1' 17
#Region '.\Public\Get-PuPriorities.ps1' 0
function Get-PuPriorities {
    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/priority"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
    }
    Invoke-RestMethod @splat
}
#EndRegion '.\Public\Get-PuPriorities.ps1' 11
#Region '.\Public\Get-PuSources.ps1' 0
function Get-PuSources {
    param (
        [Parameter(Mandatory)][ValidateSet("ticket","change")][string]$type
    )
    
    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/source/"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
        "Body" = @{
            "filter" = "requestType.Key == `"$type`""
        }
    }
    Invoke-RestMethod @splat
}
#EndRegion '.\Public\Get-PuSources.ps1' 18
#Region '.\Public\Get-PuStatuses.ps1' 0
function Get-PuStatuses {
    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/status"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
    }
    Invoke-RestMethod @splat
}
#EndRegion '.\Public\Get-PuStatuses.ps1' 11
#Region '.\Public\Get-PuTeams.ps1' 0
function Get-PuTeams {
    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/team"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
    }
    Invoke-RestMethod @splat
}
#EndRegion '.\Public\Get-PuTeams.ps1' 11
#Region '.\Public\Get-PuTicket.ps1' 0
function Get-PuTicket {
    param (
        [int]$requestNumber,
        [string]$filter
    )

    if ($requestNumber) {
        $endpointSuffix = "/ticket/$requestNumber/requestNumber/"
    } else {
        $endpointSuffix = "/ticket"
    }

    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)$endpointSuffix"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
        "Body" = @{
            "filter" = $filter
        }
    }
    Invoke-RestMethod @splat
}
#EndRegion '.\Public\Get-PuTicket.ps1' 25
#Region '.\Public\Get-PuUsers.ps1' 0
function Get-PuUsers {
    <#
    .SYNOPSIS
        Gets users from Pureservice using the Pureservice API.
    .PARAMETER filter
        The input $filter is based on predefined properties which you can find by running a get request of users.
        These aren't documented in the Pureservice API docs.
    .EXAMPLE
        Get-PuUsers -filter 'credentials.username=="navnav01"'
    .EXAMPLE
        Get-PuUsers -filter '(fullName == "Navn Navnesen")'
    #>
    param (
        [string]$filter
    )
    
    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-PuEndpoint)/user/"
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
        "Body" = @{
            "filter" = $filter
        }
    }
    Invoke-RestMethod @splat
}
#EndRegion '.\Public\Get-PuUsers.ps1' 29
#Region '.\Public\New-PuInternalNote.ps1' 0
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
#EndRegion '.\Public\New-PuInternalNote.ps1' 28
#Region '.\Public\New-PuTicket.ps1' 0
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
#EndRegion '.\Public\New-PuTicket.ps1' 64
