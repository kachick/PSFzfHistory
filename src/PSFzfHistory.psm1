# Do not add --height option for fzf, it shows nothing in keybind use
function Invoke-FzfHistory ([String]$fuzzy) {
    [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems() |
        Select-Object -ExpandProperty CommandLine |
        Reverse |
        AsOrderedSet |
        fzf --scheme=history --no-sort --no-height --query $fuzzy
}

# Avoid System.Collections.Generic.SortedSet from following points
# - the sort order is "index", not the character dictionary order
# - No creation intermediate objects and just used in pipe
function AsOrderedSet {
    $set = New-Object System.Collections.Generic.HashSet[string];
    $input | Where-Object { $set.Add($_) }
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
