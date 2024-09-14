<#
.SYNOPSIS
    Creates a domain under the current account.
.DESCRIPTION
    Creates a domain under the current account.
.PARAMETER Name
    The name of the domain itself. This should follow the standard domain format of domain.TLD. For instance, example.com is a valid domain name.
.PARAMETER IPAddress
    This optional attribute may contain an IP address. When provided, an A record will be automatically created pointing to the apex domain.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/domains_create
.EXAMPLE
    Create a domain:
    New-DODomain -Name 'example.com'
.EXAMPLE
    Create a domain with an ip address (A record):
    New-DODomain -Name 'example.com' -IPAddress 1.1.1.1
#>
Function New-DODomain {

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0,
            Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $Name,

        [Parameter(Position = 1,
            Mandatory = $false)]
        [String] $IPAddress
    )

    Try {

        $body = @{
            name = $Name;
        }
        If ($IPAddress) {
            $body.Add('ip_address', $IPAddress)
        }

        $params = @{
            Uri = 'domains';
            Method = 'POST';
            Body = ($body | ConvertTo-Json -ErrorAction Stop);
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}