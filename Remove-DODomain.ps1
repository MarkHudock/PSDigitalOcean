<#
.SYNOPSIS
    Deletes the specified domain from the current account.
.DESCRIPTION
    Deletes the specified domain from the current account.
.PARAMETER Name
    The name of the domain itself.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/domains_delete
.EXAMPLE
    Remove a domain:
    Remove-DODomain -Name 'example.com'
#>
Function Remove-DODomain {

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param (
        [Parameter(Position = 0,
            Mandatory = $true)]
        [Alias('domain_name')]
        [ValidateNotNullOrEmpty()]
        [String] $Name
    )

    Try {

        If ($PSCmdlet.ShouldProcess("$Name")) {
            $params = @{
                Uri = ('domains/{0}' -f $Name);
                Method = 'DELETE';
            }
            Invoke-DOAPIRequest @params -ErrorAction Stop
        }

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}