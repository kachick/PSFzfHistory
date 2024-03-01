# https://learn.microsoft.com/en-us/powershell/module/psreadline/set-psreadlinekeyhandler?view=powershell-7.4
Set-PSReadLineKeyHandler -Chord Ctrl+r -ScriptBlock {
    $command = Get-History-Fzf
    if ($command) {
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
    }
}
