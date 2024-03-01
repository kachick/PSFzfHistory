function Get-History-Fzf([String]$line) {
  [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems() | ForEach-Object {$_.CommandLine.ToString()} | Select-String "." | Sort-Object | Get-Unique | Sort-Object LineNumber -Descending | fzf --scheme=history --no-sort --query=$line
}



