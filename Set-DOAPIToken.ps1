<#
.SYNOPSIS
    Sets the API token to use in cmdlets.
.DESCRIPTION
    Sets the API token to use in cmdlets.
.EXAMPLE
    Set-DOAPIToken -APIToken 'myapitoken'
#>
Function Set-DOAPIToken {

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0,
            Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $APIToken
    )

    Try {

        ## Set the API token module variable.
        $Script:APIToken = $APIToken

        ## Set the token in the CommonHeaders module variable.
        $Script:CommonHeaders.Authorization = "Bearer $Script:APIToken"

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}