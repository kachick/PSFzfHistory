$command = Get-Content (Get-PSReadlineOption).HistorySavepath | Select-String "." | Sort-Object Line | Get-Unique | Sort-Object LineNumber -Descending | fzf --scheme=history --no-sort
