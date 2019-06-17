﻿function Get-TwitterFriendships_Incoming {
<#
.SYNOPSIS
    Follow, search, and get users

.DESCRIPTION
    GET friendships/incoming
    
    Returns a collection of numeric IDs for every user who has a pending request to follow the authenticating user.

.PARAMETER cursor
    Causes the list of connections to be broken into pages of no more than 5000 IDs at a time. The number of IDs returned is not guaranteed to be 5000 as suspended users are filtered out after connections are queried. If no cursor is provided, a value of -1 will be assumed, which is the first "page."
The response from the API will include a previous_cursor and next_cursor to allow paging back and forth.

.PARAMETER stringify_ids
    Many programming environments will not consume our Tweet ids due to their size. Provide this option to have ids returned as strings instead.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/accounts-and-users/follow-search-get-users/api-reference/get-friendships-incoming

#>
    [CmdletBinding()]
    Param(
        [string]$cursor,
        [string]$stringify_ids
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/friendships/incoming'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/friendships/incoming.json'

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
