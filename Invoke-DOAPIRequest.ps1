<#
.SYNOPSIS
    Sends an API request.
.DESCRIPTION
    Sends an API request using the specified parameters.
.EXAMPLE
    $params = @{
        Uri = 'account';
        Method = 'GET';
    }
    Invoke-DOAPIRequest @params -ErrorAction Stop | Select-Object -ExpandProperty account    
.EXAMPLE
    Invoke-DOAPIRequest -Uri 'https://api.digitalocean.com/v2/droplets'
#>
Function Invoke-DOAPIRequest {

    [CmdletBinding(SupportsPaging)]
    Param (
        [Parameter(Position = 0,
            Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $Uri,

        [Parameter(Position = 1,
            Mandatory = $false)]
        [ValidateSet('GET', 'POST', 'PUT', 'PATCH', 'DELETE')]
        [String] $Method = 'GET',

        [Parameter(Position = 2,
            Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Hashtable] $Headers = $Script:CommonHeaders,

        [Parameter(Position = 3,
            Mandatory = $false)]
        [System.Object] $Body
    )

    Try {

        ## Ensure the API token has been set, either globally or via parameters.
        If (-not (Test-DOAPIConnection)) {
            Throw 'Please use Connect-DigitalOcean with a valid API token.'
        }

        ## Fix the uri if a full uri is specified. This gives flexibility to where the uri can either be partial or full.
        If ($Uri -notmatch $Script:BaseAPIUri) {
            $Uri = ("{0}/{1}/{2}" -f $Script:BaseAPIUri, (Get-DOAPIVersion), $Uri)
        }

        ## Parameters used in the API call.
        $params = @{
            Uri = $Uri;
            Method = $Method;
            Headers = $Headers;
        }

        ## Require a body for Methods that require it.
        If ($Method -in @('POST', 'PUT', 'PATCH')) {
            If ($null -eq $Body) {
                Throw ("A Body is required for the {0} method." -f $Method)
            } Else {
                $params.Add('Body', $Body)
            }
        }

        ## Handle pagination if specified with paging parameters.
        If ($PSCmdlet.PagingParameters.First -gt 0 -and $PSCmdlet.PagingParameters.First -lt [UInt64]::MaxValue) {
            If ($params.Uri -match '\?.+$') {
                $params.Uri = ("{0}&per_page={1}" -f $params.Uri, $PSCmdlet.PagingParameters.First)
            } Else {
                $params.Uri = ("{0}?per_page={1}" -f $params.Uri, $PSCmdlet.PagingParameters.First)
            }
        }

        Write-Verbose ("Executing {0} API call to: {1}" -f $Method, $params.Uri)

        ## Execute the API call, writing out the results, if any.
        $results = Invoke-RestMethod @params -ErrorAction Stop

        ## Find the property with data that is returned by the API. By default, this is usually combined with links and meta.
        ## links: Paging information. (next/last)
        ## meta: Metadata. Usually total amount of entries returned.
        $dataPropertyName = $results | Get-Member -MemberType NoteProperty | Where-Object Name -NotIn @('links', 'meta') | Select-Object -ExpandProperty Name
        If ($dataPropertyName) {
            Write-Output $results | Select-Object -ExpandProperty $dataPropertyName
        } Else {
            Write-Output $results
        }

    } Catch {
        Write-Error $_.Exception
        Break    
    }

}