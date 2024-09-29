$PSNativeCommandUseErrorActionPreference = $true
$ErrorActionPreference = 'Stop'

# [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems() cannot be used non tty? as called in CLI
# $lines = [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems()
$lines = Get-Content -Path ./fixtures/random-guids.txt

# Technique        Time            RelativeSpeed Throughput
# ---------        ----            ------------- ----------
# ReverseWithStack 00:00:00.101116 1x            988.96/s
# ReverseWithLinq  00:00:00.273142 2.7x          366.11/s
Measure-Benchmark -Technique @{
    ReverseWithStack = { [System.Collections.Stack]::new($lines) }
    ReverseWithLinq  = { [System.Linq.Enumerable]::Reverse([string[]] $lines) }
}
