# Do not add --height option for fzf, it shows nothing in keybind use
function Invoke-FzfHistory ([String]$fuzzy) {
    $reversedCommandSet = [ordered]@{}

    [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems() |
        & Reverse |
        ForEach-Object {
            if (!$reversedCommandSet.Contains($_.CommandLine)) {
                $reversedCommandSet.Add($_.CommandLine, $true) | Out-Null
            }
        }

    $reversedCommandSet.Keys | fzf --scheme=history --no-sort --no-height --query $fuzzy
}

function Reverse {
    [System.Collections.Stack]::new(@($input))
}

function Set-FzfHistoryKeybind {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Chord
    )

    # https://learn.microsoft.com/en-us/powershell/module/psreadline/set-psreadlinekeyhandler?view=powershell-7.4
    Set-PSReadLineKeyHandler -Chord $Chord -ScriptBlock {
        param($key, $arg)

        $line = $null
        $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
        $matched = Invoke-FzfHistory $line
        if (!$matched) {
            return
        }
        [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($matched)
    }
}

Export-ModuleMember -Function ('Invoke-FzfHistory', 'Set-FzfHistoryKeybind')
