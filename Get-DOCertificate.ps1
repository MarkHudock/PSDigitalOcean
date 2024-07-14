<#
.SYNOPSIS
    Gets certificate(s) for the current account.
.DESCRIPTION
    Gets certificate(s) for the current account.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/certificates_list
.EXAMPLE
    Get all certificates:
    Get-DOCertificate
.EXAMPLE
    Get a certificate by name:
    Get-DOCertificate -Name 'web-cert-01'
#>
Function Get-DOCertificate {

    [CmdletBinding(SupportsPaging)]
    Param (
        [Parameter(Position = 0,
            Mandatory = $false)]
        [String] $Name
    )

    Try {

        $params = @{
            Uri = 'certificates';
            Method = 'GET';
            First = $PSCmdlet.PagingParameters.First;
        }

        ## Add name to the uri, if specified.
        If ($Name) {
            $params.Uri = ("{0}?Name={1}" -f $params.Uri, $Name)
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}