﻿function Send-TwitterLists_MembersDestroyAll {
<#
.SYNOPSIS
    Create and manage lists

.DESCRIPTION
    POST lists/members/destroy_all
    
    Removes multiple members from a list, by specifying a comma-separated list of member ids or screen names. The authenticated user must own the list to be able to remove members from it. Note that lists can't have more than 500 members, and you are limited to removing up to 100 members to a list at a time with this method.
    
    Please note that there can be issues with lists that rapidly remove and add memberships. Take care when using these methods such that you are not too rapidly switching between removals and adds on the same list.

.PARAMETER list_id
    The numerical id of the list.

.PARAMETER slug
    You can identify a list by its slug instead of its numerical id. If you decide to do so, note that you'll also have to specify the list owner using the owner_id or owner_screen_name parameters.

.PARAMETER user_id
    A comma separated list of user IDs, up to 100 are allowed in a single request.

.PARAMETER screen_name
    A comma separated list of screen names, up to 100 are allowed in a single request.

.PARAMETER owner_screen_name
    The screen name of the user who owns the list being requested by a slug .

.PARAMETER owner_id
    The user ID of the user who owns the list being requested by a slug .

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/accounts-and-users/create-manage-lists/api-reference/post-lists-members-destroy_all

#>
    [CmdletBinding()]
    Param(
        [string]$list_id,
        [string]$slug,
        [string]$user_id,
        [string]$screen_name,
        [string]$owner_screen_name,
        [string]$owner_id
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'POST'
        [string]$Resource    = '/lists/members/destroy_all'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/lists/members/destroy_all.json'

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
