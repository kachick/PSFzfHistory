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
