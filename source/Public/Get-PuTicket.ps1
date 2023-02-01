function Get-PuTicket {
    [CmdletBinding(DefaultParameterSetName="List tickets")]
    param (
        [Parameter(Mandatory,ParameterSetName="Get ticket by id")][int]$ticketId,
        [Parameter(Mandatory,ParameterSetName="Get ticket by requestnumber")][int]$requestNumber,
        [string]$filter,
        [Parameter(ParameterSetName="List tickets")][switch]$ListTickets
    )

    $Uri = "$(Get-PuEndpoint)/ticket"

    switch ($PsCmdlet.ParameterSetName) {
        "Get ticket by id" {
            $Uri += "/$ticketId"
        }
        "Get ticket by requestnumber" {
            $Uri += "/$requestNumber/requestNumber/"
        }
    }

    $splat = @{
        "Method" = "GET"
        "Uri" = $Uri
        "Headers" = @{
            "X-Authorization-Key" = Get-PuAccessToken
            "Accept" = "application/vnd.api+json"
        }
        "Body" = @{
            "filter" = $filter
        } | ConvertTo-Json -Depth 99
    }
    $Result = Invoke-RestMethod @splat
    $Result.tickets
}