<#
.SYNOPSIS
    Gets app(s) for the current account.
.DESCRIPTION
    Gets apps(s) for the current account.

    This cmdlet can get apps by Id or Name. By default, it will return all apps.

    WithProjects can be specified to include the project_id of listed apps in the output.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/apps_list
.EXAMPLE
    Get all apps:
    Get-DOApp
.EXAMPLE
    Get an app by Id:
    Get-DOApp -Id 2878487
.EXAMPLE
    Get an app by name:
    Get-DOApp -Name 'myApp'
#>
Function Get-DOApp {

    [CmdletBinding(SupportsPaging)]
    Param (
        [Parameter(Position = 0,
            Mandatory = $false)]
        [String] $Id,

        [Parameter(Position = 1,
            Mandatory = $false)]
        [String] $Name,

        [Parameter(Position = 2,
            Mandatory = $false,
            HelpMessage = 'Whether the project_id of listed apps should be fetched and included.')]
        [Switch] $WithProjects
    )

    Try {

        $params = @{
            Uri = 'apps';
            Method = 'GET';
            First = $PSCmdlet.PagingParameters.First;
        }

        ## Set the uri according to the parameters.
        If ($Id) {
            $params.Uri = ("{0}/{1}" -f $params.Uri, $Id)
        } ElseIf ($Name) {
            $params.Uri = ("{0}?name={1}" -f $params.Uri, $Name)
        }

        ## Include the with_projects parameter, if specified.
        If ($WithProjects) {
            $params.Uri = ("{0}{1}with_projects=true" -f $params.Uri, $(If ($params.Uri -match '\?.+$') { '&' } Else { '?' }))
        }

        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}