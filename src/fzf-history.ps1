# Do not add --height option for fzf, it shows nothing in keybind use
function Invoke-Fzf-History ([String]$fuzzy) {
    $reversedCommandSet = [ordered]@{}
    $reverse = { [System.Collections.Stack]::new(@($input)) }

    [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems() |
        & $reverse |
        ForEach-Object {
            if (!$reversedCommandSet.Contains($_.CommandLine)) {
                $reversedCommandSet.Add($_.CommandLine, $true) | Out-Null
            }
        }

    $reversedCommandSet.Keys | fzf --scheme=history --no-sort --no-height --query $fuzzy
}
