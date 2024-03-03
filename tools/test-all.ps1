# https://pester.dev/docs/commands/New-PesterConfiguration
$config = New-PesterConfiguration
$config.Run.Exit = $true

Invoke-Pester -Configuration $config
