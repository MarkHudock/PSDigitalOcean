<#
.SYNOPSIS
    Gets a list of all billing history entries.
.DESCRIPTION
    Gets a list of all billing history entries.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/billingHistory_list
.EXAMPLE
    Get-DOBillingHistory
#>
Function Get-DOBillingHistory {

    [CmdletBinding()]
    Param ( )

    Try {

        $params = @{
            Uri = 'customers/my/billing_history';
            Method = 'GET';
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}