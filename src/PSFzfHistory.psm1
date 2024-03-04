# Do not add --height option for fzf, it shows nothing in keybind use
function Invoke-FzfHistory ([String]$fuzzy) {
    [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems() |
        Select-Object -ExpandProperty CommandLine |
        Reverse |
        AsOrderedSet |
        fzf --no-sort --no-height --scheme=history --query=$fuzzy
}

# Avoid System.Collections.Generic.SortedSet from following points
# - required order is "index", character dictionary based order is needless
# - Avoid to create intermediate objects as possible
function AsOrderedSet {
    $set = New-Object System.Collections.Generic.HashSet[string];
    $input | Where-Object { $set.Add($_) }
}

function Reverse {
    # Prefer Stack rather than Enumerable::Reverse from the performance
    # See tools/benchmark.ps1 for detail
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
