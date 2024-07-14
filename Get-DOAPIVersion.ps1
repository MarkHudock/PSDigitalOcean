<#
.SYNOPSIS
    Gets the current API version.
.DESCRIPTION
    Gets the current API version.
.EXAMPLE
    Get-DOAPIVersion
#>
Function Get-DOAPIVersion {

    [CmdletBinding()]
    Param ( )

    Try {

        Write-Output $Script:APIVersion

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}