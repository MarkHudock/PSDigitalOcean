<#
.SYNOPSIS
    Gets action(s) for the current account.
.DESCRIPTION
    Gets action(s) for the current account. Actions can be retrieved by Id, if specified.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/actions_list
.EXAMPLE
    Get all actions:
    Get-DOAction
.EXAMPLE
    Get an action by Id:
    Get-DOAction -Id 28478921
#>
Function Get-DOAction {

    [CmdletBinding(SupportsPaging)]
    Param (
        [Parameter(Position = 0,
            Mandatory = $false)]
        [Alias('action_id')]
        [String] $Id
    )

    Try {

        $params = @{
            Uri = 'actions';
            Method = 'GET';
            First = $PSCmdlet.PagingParameters.First;
        }

        If ($Id) {
            $params.Uri = ("{0}/{1}" -f $params.Uri, $Id)
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}