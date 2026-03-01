$PSNativeCommandUseErrorActionPreference = $true
$ErrorActionPreference = 'Stop'

Import-Module -Name .\PSFzfHistory\PSFzfHistory.psm1 -Force

# We need Pester to access private functions via InModuleScope for benchmarking
if (-not (Get-Module Pester)) { Import-Module Pester -ErrorAction SilentlyContinue }

Write-Host "Benchmarking history processing (using InModuleScope)..." -ForegroundColor Cyan

$sw = [System.Diagnostics.Stopwatch]::StartNew()
$result = InModuleScope PSFzfHistory {
    $lines = Get-Content -Path ./fixtures/random-guids.txt
    $mock = [System.Collections.Generic.List[object]]::new()
    for ($i = 0; $i -lt 10; $i++) {
        foreach ($l in $lines) {
            $mock.Add([PSCustomObject]@{ CommandLine = $l })
        }
    }
    Get-UniqueReverseHistory $mock
}
$sw.Stop()

Write-Host "  - Elapsed: $($sw.Elapsed.TotalMilliseconds) ms" -ForegroundColor Green
Write-Host "  - Result Count: $($result.Count)"
