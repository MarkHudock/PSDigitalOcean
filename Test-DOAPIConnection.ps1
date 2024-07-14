<#
.SYNOPSIS
    Tests the connection to the API.
.DESCRIPTION
    Tests the connection to the API. This cmdlet will return true or false, depending on the result.
.EXAMPLE
    Test-DOAPIConnection
#>
Function Test-DOAPIConnection {

    [CmdletBinding()]
    Param ( )

    Try {

        If (Get-DOAPIToken) {
            Write-Output $true
        } Else {
            Write-Output $false
        }

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}