<#
.SYNOPSIS
    Gets CPU metrics for a given droplet.
.DESCRIPTION
    Gets CPU metrics for a given droplet during the specified timeframe.
.LINK
    https://docs.digitalocean.com/reference/api/api-reference/#operation/monitoring_get_DropletCpuMetrics
.EXAMPLE
    Get-DOCPUMetrics
#>
Function Get-DOCPUMetrics {

    [CmdletBinding(SupportsPaging)]
    Param (
        [Parameter(Position = 0,
            Mandatory = $true)]
        [ValidateRange([Int64]::MinValue, [Int64]::MaxValue)]
        [Alias('host_id')]
        [Int64] $DropletId,

        [Parameter(Position = 1,
            Mandatory = $false)]
        [DateTime] $StartDate = (Get-Date -Hour 0 -Minute 0 -Second 0 -Millisecond 0),

        [Parameter(Position = 2,
            Mandatory = $false)]
        [ValidateScript({ $_ -gt $StartDate })]
        [DateTime] $EndDate = (Get-Date)
    )

    Try {

        ## Convert start and end dates to Unix time.
        $startDateUnixTime = ([DateTimeOffset]$StartDate).ToUnixTimeSeconds()
        $endDateUnixTime = ([DateTimeOffset]$EndDate).ToUnixTimeSeconds()

        $params = @{
            Uri = ("monitoring/metrics/droplet/cpu?host_id={0}&start={1}&end={2}" -f $DropletId, $startDateUnixTime, $endDateUnixTime);
            Method = 'GET';
            First = $PSCmdlet.PagingParameters.First;
        }
        Invoke-DOAPIRequest @params -ErrorAction Stop

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}