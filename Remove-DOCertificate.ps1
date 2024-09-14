<#
.SYNOPSIS
    Deletes the specified certificate from the current account.
.DESCRIPTION
    Deletes the specified certificate from the current account.
.PARAMETER Id
    A unique identifier for a certificate.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/certificates_delete
.EXAMPLE
    Remove a certificate:
    Remove-DOCertificate -Id '4de7ac8b-495b-4884-9a69-1050c6793cd6'
#>
Function Remove-DOCertificate {

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    Param (
        [Parameter(Position = 0,
            Mandatory = $true)]
        [Alias('certificate_id')]
        [ValidateNotNullOrEmpty()]
        [String] $Id
    )

    Try {

        If ($PSCmdlet.ShouldProcess("$Id")) {
            $params = @{
                Uri = ('certificates/{0}' -f $Id);
                Method = 'DELETE';
            }
            Invoke-DOAPIRequest @params -ErrorAction Stop
        }

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}