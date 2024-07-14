<#
.SYNOPSIS
    Gets 1-Click Application(s).
.DESCRIPTION
    Gets 1-Click Application(s).

    Type can be specified to narrow down to specific application type.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/oneClicks_list
.EXAMPLE
    Get all 1-Click Applications:
    Get-DOOneClickApplication
.EXAMPLE
    Get all droplet 1-Click Applications:
    Get-DODroplet -Type 'Droplet'
#>
Function Get-DOOneClickApplication {

    [CmdletBinding(SupportsPaging)]
    Param (
        [Parameter(Position = 0,
            Mandatory = $false)]
        [ValidateSet('Droplet', 'Kubernetes')]
        [String] $Type
    )

    Try {

        $params = @{
            Uri = '1-clicks';
            Method = 'GET';
            First = $PSCmdlet.PagingParameters.First;
        }

        ## Add the type parameter, if specified.
        If ($Type) {
            $params.Uri("{0}?type={1}" -f $params.Uri, $Type.ToLower())
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}