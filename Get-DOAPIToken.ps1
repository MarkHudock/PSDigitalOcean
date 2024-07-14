<#
.SYNOPSIS
    Gets the current API token.
.DESCRIPTION
    Gets the current API token.
.EXAMPLE
    Get-DOAPIToken
#>
Function Get-DOAPIToken {

    [CmdletBinding()]
    Param ( )

    Try {

        Write-Output $Script:APIToken

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}