$PSNativeCommandUseErrorActionPreference = $true
$ErrorActionPreference = 'Stop'

Write-Host "Benchmarking 100,000 lines of history..." -ForegroundColor Cyan

$time = Measure-Command {
    # All setup inside for scope consistency
    . .\PSFzfHistory\PSFzfHistory.psm1
    $lines = Get-Content -Path ./fixtures/random-guids.txt
    $heavyLines = @($lines) * 10
    
    $result = $heavyLines | Reverse | AsOrderedSet
}

Write-Host "  - Elapsed: $($time.TotalMilliseconds) ms" -ForegroundColor Green
Write-Host "  - Result Count: $($result.Count)"
