# Copyright (C) 2024 Kenichi Kamiya

# Do not add --height option for fzf, it shows nothing in keybind use
function Invoke-FzfHistory ([String]$fuzzy) {
    $history = [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems()
    $uniqueCommands = Get-UniqueReverseHistory $history
    # Join with NUL character to support multiline items in fzf
    $matched = $uniqueCommands -join "`0" | fzf --read0 --no-sort --no-height --scheme=history --query=$fuzzy
    
    # fzf output is captured as a string array if it contains newlines.
    # Join them back with the current system newline.
    if ($matched) {
        return $matched -join [System.Environment]::NewLine
    }
}

# Internal helper to process history items: reverse and unique
function Get-UniqueReverseHistory ([Object[]]$historyItems) {
    $set = [System.Collections.Generic.HashSet[string]]::new()
    $unique = for ($i = $historyItems.Count - 1; $i -ge 0; $i--) {
        $cmd = $historyItems[$i].CommandLine
        if ($set.Add($cmd)) {
            $cmd
        }
    }
    return $unique
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
