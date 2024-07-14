<#
.SYNOPSIS
    Sets the current API version.
.DESCRIPTION
    Sets the current API version.
.EXAMPLE
    Set-DOAPIVersion -Version 'v2'
#>
Function Set-DOAPIVersion {

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0,
            Mandatory = $true)]
        [ValidateSet('v2')]
        [String] $Version
    )

    Try {

        ## Set the new API version.
        $Script:APIVersion = $Version

        Write-Verbose ("API version has been set to $($Script:APIVersion).")

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}