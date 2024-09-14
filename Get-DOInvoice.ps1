<#
.SYNOPSIS
    Gets invoice(s) for the current account.
.DESCRIPTION
    Gets invoice(s) for the current account. Use the OutputType parameter for different output formats. (CSV, PDF, Summary)
.NOTES
    OutputType is only applicable when retrieving invoices by id/uuid.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/invoices_list
.EXAMPLE
    Get-DOInvoice
.EXAMPLE
    Get-DOInvoice -Id '22737513-0ea7-4206-8ceb-98a575af7681'
.EXAMPLE
    Get-DOInvoice -Id '22737513-0ea7-4206-8ceb-98a575af7681' -OutputType 'CSV'
#>
Function Get-DOInvoice {

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0,
            Mandatory = $false)]
        [Alias('invoice_uuid')]
        [Guid] $Id,

        [Parameter(Position = 1,
            Mandatory = $false)]
        [ValidateSet('CSV', 'PDF', 'Summary')]
        [String] $OutputType = 'Summary'
    )

    Try {

        $params = @{
            Uri = 'customers/my/invoices';
            Method = 'GET';
        }
        If ($Id) {
            $params.Uri = ('{0}/{1}/{2}' -f $params.Uri, $Id, $OutputType)
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}