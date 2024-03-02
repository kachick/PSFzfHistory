# pwsh-fzf-history

[![CI - Nix Status](https://github.com/kachick/pwsh-fzf-history/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/kachick/pwsh-fzf-history/actions/workflows/ci-nix.yml?query=branch%3Amain+)

fzf integration for pwsh(PowerShell) to realize history substring search with tiny code

## Usage

As a preparation step, install and add the path for fzf with your favorite method

```pwsh
# Install fzf
winget install --exact --id junegunn.fzf

# Make sure the winget tools in your PATH
# https://github.com/microsoft/winget-cli/issues/2498#issuecomment-1553863082
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
```

And this

```pwsh
# Do not add --height option for fzf, it shows nothing in keybind use
function Invoke-Fzf ([String]$fuzzy) {
    [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems() |
        ForEach-Object { $_.CommandLine.ToString() } |
        Select-String "." |
        Sort-Object |
        Get-Unique |
        Sort-Object LineNumber -Descending |
        fzf --scheme=history --no-sort --no-height --query $fuzzy
}

Set-PSReadLineKeyHandler -Chord Ctrl+r -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    $matched = Invoke-Fzf $line
    if (!$matched) {
        return
    }
    [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($matched)
}
```

## Limitations

- Loaded history expect one line: https://github.com/PowerShell/PSReadLine/issues/494#issuecomment-273358367

## TODO

- (Optional) Provide easy install way

## Motivation

https://github.com/kelleyma49/PSFzf is helpful, but the loading is much slow for me.

I noticed I just want history finder, and we may realize with tiny PowerShell code and depending only fzf.
