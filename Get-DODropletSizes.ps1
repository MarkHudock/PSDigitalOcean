<#
.SYNOPSIS
    Gets all available droplets sizes.
.DESCRIPTION
    Gets all available droplets sizes.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/sizes_list
.EXAMPLE
    Get-DODropletSizes
.EXAMPLE
    Get-DODropletSizes -First 50
#>
Function Get-DODropletSizes {

    [CmdletBinding(SupportsPaging)]
    Param ( )

    Try {

        $params = @{
            Uri = 'sizes';
            Method = 'GET';
            First = $PSCmdlet.PagingParameters.First;
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}