﻿$PSNativeCommandUseErrorActionPreference = $true
$ErrorActionPreference = 'Stop'

if (-not (Get-InstalledModule -ErrorAction SilentlyContinue PSScriptAnalyzer )) {
    # https://github.com/PowerShell/PSScriptAnalyzer
    Install-Module -Name PSScriptAnalyzer -Force
}

if (-not (Get-InstalledModule -ErrorAction SilentlyContinue Pester)) {
    # https://github.com/pester/pester
    Install-Module -Name Pester -Force
}

if (-not (Get-InstalledModule -ErrorAction SilentlyContinue Benchpress)) {
    # https://github.com/StartAutomating/Benchpress
    Install-Module Benchpress -Scope CurrentUser -Force
}
