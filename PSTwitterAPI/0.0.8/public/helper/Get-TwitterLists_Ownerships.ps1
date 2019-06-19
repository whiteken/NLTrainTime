﻿function Get-TwitterLists_Ownerships {
<#
.SYNOPSIS
    Create and manage lists

.DESCRIPTION
    GET lists/ownerships
    
    Returns the lists owned by the specified Twitter user. Private lists will only be shown if the authenticated user is also the owner of the lists.

.PARAMETER user_id
    The ID of the user for whom to return results. Helpful for disambiguating when a valid user ID is also a valid screen name.

.PARAMETER screen_name
    The screen name of the user for whom to return results. Helpful for disambiguating when a valid screen name is also a user ID.

.PARAMETER count
    The amount of results to return per page. Defaults to 20. No more than 1000 results will ever be returned in a single page.

.PARAMETER cursor
    Breaks the results into pages. Provide a value of -1 to begin paging. Provide values as returned in the response body's next_cursor and previous_cursor attributes to page back and forth in the list. It is recommended to always use cursors when the method supports them. See Cursoring for more information.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/accounts-and-users/create-manage-lists/api-reference/get-lists-ownerships

#>
    [CmdletBinding()]
    Param(
        [string]$user_id,
        [string]$screen_name,
        [string]$count,
        [string]$cursor
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/lists/ownerships'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/lists/ownerships.json'

    }
    Process {

        # Find & Replace any ResourceUrl parameters.
        $UrlParameters = [regex]::Matches($ResourceUrl, '(?<!\w):\w+')
        ForEach ($UrlParameter in $UrlParameters) {
            $UrlParameterValue = $Parameters["$($UrlParameter.Value.TrimStart(":"))"]
            $ResourceUrl = $ResourceUrl -Replace $UrlParameter.Value, $UrlParameterValue
        }

        If (-Not $OAuthSettings) { $OAuthSettings = Get-TwitterOAuthSettings -Resource $Resource }
        Invoke-TwitterAPI -Method $Method -ResourceUrl $ResourceUrl -Parameters $Parameters -OAuthSettings $OAuthSettings

    }
    End {

    }
}
