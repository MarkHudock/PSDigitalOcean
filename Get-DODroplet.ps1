<#
.SYNOPSIS
    Gets droplet(s) for the current account.
.DESCRIPTION
    Gets droplet(s) for the current account.

    This cmdlet can get droplets by Id, Name, or Tag. By default, it will return all droplets.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/droplets_list
.EXAMPLE
    Get all droplets:
    Get-DODroplet
.EXAMPLE
    Get a droplet by Id:
    Get-DODroplet -Id 2878487
.EXAMPLE
    Get a droplet by name:
    Get-DODroplet -Name 'web-cert-01'
.EXAMPLE
    Get a droplet by tag:
    Get-DODroplet -Tag 'infrastructure'
#>
Function Get-DODroplet {

    [CmdletBinding(SupportsPaging)]
    Param (
        [Parameter(Position = 0,
            Mandatory = $false)]
        [Alias('droplet_id')]
        [String] $Id,

        [Parameter(Position = 1,
            Mandatory = $false)]
        [String] $Name,

        [Parameter(ParameterSetName = 'Tag',
            Position = 2,
            Mandatory = $false)]
        [String] $Tag
    )

    Try {

        $params = @{
            Uri = 'droplets';
            Method = 'GET';
            First = $PSCmdlet.PagingParameters.First;
        }

        ## Set the uri according to the parameters.
        If ($Id) {
            $params.Uri = ("{0}/{1}" -f $params.Uri, $Id)
        } ElseIf ($Name) {
            $params.Uri = ("{0}?name={1}" -f $params.Uri, $Name)
        } ElseIf ($Tag) {
            $params.Uri = ("{0}?tag_name={1}" -f $params.Uri, $Tag)
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}