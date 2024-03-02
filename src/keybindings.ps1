# https://learn.microsoft.com/en-us/powershell/module/psreadline/set-psreadlinekeyhandler?view=powershell-7.4
Set-PSReadLineKeyHandler -Chord Ctrl+r -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    $matched = Invoke-Fzf-History $line
    if (!$matched) {
        return
    }
    [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($matched)
}
