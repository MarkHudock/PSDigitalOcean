<#
.SYNOPSIS
    Gets account information.
.DESCRIPTION
    Gets account information for the current account.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#section/Introduction
.EXAMPLE
    Get-DOAccount
#>
Function Get-DOAccount {

    [CmdletBinding()]
    Param ( )

    Try {

        $params = @{
            Uri = 'account';
            Method = 'GET';
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}