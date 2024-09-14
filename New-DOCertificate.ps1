<#
.SYNOPSIS
    Creates a certificate under the current account.
.DESCRIPTION
    Creates a certificate under the current account. The two types of certificates that can be created are Custom and Lets_Encrypt, based on parameter sets.
.PARAMETER Name
    A unique human-readable name referring to a certificate.
.PARAMETER PrivateKey
    The contents of a PEM-formatted private-key corresponding to the SSL certificate. This is only for Custom certificate requests.
.PARAMETER LeafCertificate
    The contents of a PEM-formatted public SSL certificate. This is only for Custom certificate requests.
.PARAMETER CertificateChain
    The full PEM-formatted trust chain between the certificate authority's certificate and your domain's SSL certificate. This is only for Custom certificate requests.
.PARAMETER DNSNames
    An array of fully qualified domain names (FQDNs) for which the certificate was issued. A certificate covering all subdomains can be issued using a wildcard (e.g. *.example.com).
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/certificates_create
.EXAMPLE
    Create a custom certificate:
    New-DOCertificate -Name 'example.com' -PrivateKey (Get-Content -Path 'example.com_private.pem') -LeafCertificate (Get-Content -Path 'example.com_public.crt')
.EXAMPLE
    Create a let's encrypt certificate:
    New-DOCertificate -Name 'example.com' -DNSNames *.example.com
#>
Function New-DOCertificate {

    [CmdletBinding(DefaultParameterSetName = 'Custom')]
    Param (
        [Parameter(Position = 0,
            Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $Name,

        [Parameter(ParameterSetName = 'Custom',
            Position = 1,
            Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('private_key')]
        [String] $PrivateKey,

        [Parameter(ParameterSetName = 'Custom',
            Position = 2,
            Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('leaf_certificate')]
        [String] $LeafCertificate,

        [Parameter(ParameterSetName = 'Custom',
            Position = 3,
            Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Alias('certificate_chain')]
        [String] $CertificateChain,

        [Parameter(ParameterSetName = 'Lets_Encrypt',
            Position = 1,
            Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('dns_names')]
        [String[]] $DNSNames
    )

    Try {

        $body = @{
            name = $Name;
            type = ($PSCmdlet.ParameterSetName.ToLower());
        }

        ## Adjust the body according to certificate request type.
        Switch ($PSCmdlet.ParameterSetName) {
            'Custom' {
                $body.Add('private_key', $PrivateKey)
                $body.Add('leaf_certificate', $LeafCertificate)
                If ($CertificateChain) {
                    $body.Add('certificate_chain', $CertificateChain)
                }
            }
            'Lets_Encrypt' {
                $body.Add('dns_names', $DNSNames)
            }
            Default { throw "Unknown parameter set: $($PSCmdlet.ParameterSetName)" }
        }

        Write-Verbose ('Creating a {0} certificate with the name: {1}.' -f $PSCmdlet.ParameterSetName, $Name)

        $params = @{
            Uri = 'certificates';
            Method = 'POST';
            Body = ($body | ConvertTo-Json -ErrorAction Stop);
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}