# See https://github.com/kachick/dotfiles/issues/617 for background of this option
$PSNativeCommandUseErrorActionPreference = $true
$ErrorActionPreference = 'Stop'

# https://pester.dev/docs/commands/New-PesterConfiguration
$config = New-PesterConfiguration
$config.Run.Exit = $true

Invoke-Pester -Configuration $config
