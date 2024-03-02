# Do NOT use 'Invoke-ScriptAnalyzer -Recurse -Path .' It includes dotfiles as .direnv
# https://github.com/PowerShell/PSScriptAnalyzer/issues/561
Get-ChildItem -Recurse -Path . -Include "*.ps1" |
    ForEach-Object {
        echo $_.FullName
        Invoke-ScriptAnalyzer -Recurse -ReportSummary -EnableExit -Settings CodeFormatting -Fix -Path $_.FullName
    }
