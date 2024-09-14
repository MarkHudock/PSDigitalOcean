#region Module Configurations

## Custom aliases.
New-Alias -Name Connect-DigitalOcean -Value Set-DOAPIToken

## Dot-source all function files.
Get-ChildItem -Path $PSScriptRoot\*.ps1 | ForEach-Object { . $_.FullName }

## Export all commands.
Export-ModuleMember -Alias * –Function @(Get-Command –Module $ExecutionContext.SessionState.Module)

#endregion

#region Variables

$Script:APIVersion = 'v2' # API version used in API calls.
$Script:BaseAPIUri = 'https://api.digitalocean.com' # Base API uri used in API calls.
$Script:APIToken = $null # Initializing null API token for reference.
$Script:CommonHeaders = @{ # Common headers used in API calls.
    'Content-Type' = 'application/json';
    Authorization = "Bearer $($Script:APIToken)";
}

#endregion