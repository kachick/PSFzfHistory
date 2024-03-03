# Do not add --height option for fzf, it shows nothing in keybind use
function Invoke-Fzf-History ([String]$fuzzy) {
    $orderedCommands = [ordered]@{}
    $reverse = { [System.Collections.Stack]::new(@($input)) }

    [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems() |
        ForEach-Object {
            if (!$orderedCommands.Contains($_.CommandLine)) {
                $orderedCommands.Add($_.CommandLine, $true) | Out-Null
            }
        }

    $orderedCommands.Keys | & $reverse | fzf --scheme=history --no-sort --no-height --query $fuzzy
}
