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
function Get-History-Fzf {
  Get-Content (Get-PSReadlineOption).HistorySavepath | Select-String "." | Sort-Object Line | Get-Unique | Sort-Object LineNumber -Descending | fzf --scheme=history --no-sort
}

Set-PSReadLineKeyHandler -Chord Ctrl+r -ScriptBlock {
    $command = Get-History-Fzf
    if ($command) {
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
    }
}
```

## TODO

- Functionize
- Keybinding
- (Optional) Provide easy install way

Chores

- Formatter - https://github.com/PowerShell/PSScriptAnalyzer

## Motivation

https://github.com/kelleyma49/PSFzf is helpful, but the loading is much slow for me.

I noticed I just want history finder, and we can realize with tiny PowerShell code and depending only fzf.
