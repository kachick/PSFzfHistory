# https://learn.microsoft.com/en-us/powershell/module/psreadline/set-psreadlinekeyhandler?view=powershell-7.4
Set-PSReadLineKeyHandler -Chord Ctrl+r -ScriptBlock {
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    $command = Get-History-Fzf $line
    if (!$command) {
      return
    }
    [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
}
