function Get-History-Fzf {
  [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems() | ForEach-Object {$_.CommandLine.ToString()} | Select-String "." | Sort-Object ToString | Get-Unique | Sort-Object LineNumber -Descending | fzf --scheme=history --no-sort
}
