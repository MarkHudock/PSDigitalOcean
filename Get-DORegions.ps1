<#
.SYNOPSIS
    Gets all data center regions that are available.
.DESCRIPTION
    Gets all data center regions that are available.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/regions_list
.EXAMPLE
    Get-DORegions
#>
Function Get-DORegions {

    [CmdletBinding(SupportsPaging)]
    Param ( )

    Try {

        $params = @{
            Uri = 'regions';
            Method = 'GET';
            First = $PSCmdlet.PagingParameters.First;
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}