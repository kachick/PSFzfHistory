﻿$PSNativeCommandUseErrorActionPreference = $true
$ErrorActionPreference = 'Stop'

# nix --version - Excluded for Windows, nix targets onle Unix-like OS
nil --version
task --version
dprint --version
typos --version
pwsh --version
pwsh --Command 'Get-InstalledModule'
grep --version
wc --version
