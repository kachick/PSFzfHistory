$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

Import-Module -Name .\PSFzfHistory\PSFzfHistory.psm1 -Force

# We need Pester to access private functions via InModuleScope for benchmarking
if (-not (Get-Module Pester)) { Import-Module Pester -ErrorAction SilentlyContinue }

# --- Warmup: Setup data outside benchmark ---
$lines = Get-Content -Path ./fixtures/random-guids.txt
$mockHistory = [System.Collections.Generic.List[object]]::new()
for ($i = 0; $i -lt 10; $i++) {
    foreach ($l in $lines) {
        $mockHistory.Add([PSCustomObject]@{ CommandLine = $l })
    }
}

Write-Host "Benchmarking history processing of $($mockHistory.Count) items..." -ForegroundColor Cyan

$time = Measure-Command {
    InModuleScope PSFzfHistory {
        # Process ONLY the logic, discarding output to avoid console overhead
        $null = Get-UniqueReverseHistory $mockHistory
    }
}

Write-Host "  - Elapsed: $($time.TotalMilliseconds) ms" -ForegroundColor Green
