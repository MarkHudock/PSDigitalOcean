<#
.SYNOPSIS
    Gets the balances on a customer's account.
.DESCRIPTION
    Gets the balances on a customer's account.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/balance_get
.EXAMPLE
    Get-DOCustomerBalance
#>
Function Get-DOCustomerBalance {

    [CmdletBinding()]
    Param ( )

    Try {

        $params = @{
            Uri = 'customers/my/balance';
            Method = 'GET';
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}