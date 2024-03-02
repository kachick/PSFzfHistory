# Do not add --height option for fzf, it shows nothing in keybind use
function Invoke-Fzf ([String]$fuzzy) {
    [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems() |
        ForEach-Object { $_.CommandLine.ToString() } |
        Select-String "." |
        Sort-Object |
        Get-Unique |
        Sort-Object LineNumber -Descending |
        fzf --scheme=history --no-sort --no-height --query $fuzzy
}
