function Get-PuTicket {
    [CmdletBinding(DefaultParameterSetName="Get ticket by requestnumber")]
    param (
        [Parameter(Mandatory, ParameterSetName="Get ticket by id")]
        [int]$ticketId,
        [Parameter(Mandatory, ParameterSetName="Get ticket by requestnumber")]
        [Alias("INC","Incident","Saksnummer")]
        [string]$requestNumber,
        [Parameter(ParameterSetName="List tickets")]
        [switch]$ListTickets,
        [string]$filter,
        [int]$Limit = 500  # Default limit per page for listing tickets
    )

    # Define headers
    $headers = @{
        "X-Authorization-Key" = Get-PuAccessToken
        "Accept" = "application/vnd.api+json"
        "Content-Type" = "application/vnd.api+json"
    }
    $Uri = "$(Get-PuEndpoint)/ticket"

    # Case 1: List tickets (with paging)
    if ($PsCmdlet.ParameterSetName -eq "List tickets") {
        $tickets = @()
        $Start = 0

        do {
            # Construct the URI with paging parameters
            $PagedUri = "$Uri/?start=$Start&limit=$Limit"

            # Prepare the splatting parameters for the Invoke-RestMethod call
            $splat = @{
                "Method" = "GET"
                "Uri" = $PagedUri
                "Headers" = $headers
                "Body" = @{
                    "filter" = $filter
                } | ConvertTo-Json -Depth 99
            }

            # Make the API request
            $Result = Invoke-RestMethod @splat -ResponseHeadersVariable headervar

            # Add the tickets from this page to the cumulative result
            $tickets += $Result.tickets

            # Update the start value for the next page
            $Start += $Limit
        } while ($Result.tickets.Count -eq $Limit)  # Continue until fewer tickets than limit are returned

        # Return all retrieved tickets
        return $tickets
    }

    # Case 2: Get single ticket by ID or Request Number
    else {

        switch ($PsCmdlet.ParameterSetName) {
            "Get ticket by id" {
                $Uri += "/$ticketId"
            }
            "Get ticket by requestnumber" {
                $Uri += "/$([int]$requestNumber.trimstart("INC").trim())/requestNumber/"
            }
        }

        # Prepare the splatting parameters for the Invoke-RestMethod call
        $splat = @{
            "Method" = "GET"
            "Uri" = $Uri
            "Headers" = $headers
        }

        # Fetch the single ticket
        $Result = Invoke-RestMethod @splat

        # Return the single ticket
        return $Result.tickets
    }
}
