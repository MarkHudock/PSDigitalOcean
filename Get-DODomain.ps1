<#
.SYNOPSIS
    Gets domain(s) for the current account.
.DESCRIPTION
    Gets domain(s) for the current account. Domains can be retrieved by Name, if specified.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/domains_list
.EXAMPLE
    Get all domains:
    Get-DODomain
.EXAMPLE
    Get a domain by name:
    Get-DODomain -Name 'example.com'
#>
Function Get-DODomain {

    [CmdletBinding(SupportsPaging)]
    Param (
        [Parameter(Position = 0,
            Mandatory = $false)]
        [Alias('domain_name')]
        [String] $Name
    )

    Try {

        $params = @{
            Uri = 'domains';
            Method = 'GET';
            First = $PSCmdlet.PagingParameters.First;
        }

        If ($Name) {
            $params.Uri = ('{0}/{1}' -f $params.Uri, $Name)
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}