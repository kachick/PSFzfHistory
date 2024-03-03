# PSFzfHistory

[![CI - Nix Status](https://github.com/kachick/PSFzfHistory/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/kachick/PSFzfHistory/actions/workflows/ci-nix.yml?query=branch%3Amain+)

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

Now [PowerShell Gallery](https://www.powershellgallery.com/) looks like [not accepting new author or publish](https://github.com/PowerShell/PowerShellGallery/issues/266). So I describe how to load local files here.

Download this module from GitHub and enable from local folder

```pwsh
Invoke-WebRequest 'https://github.com/kachick/PSFzfHistory/archive/refs/heads/main.zip' -OutFile .\PSFzfHistory.zip
Expand-Archive .\PSFzfHistory.zip .\
Remove-Item PSFzfHistory.zip
Import-Module -Name .\PSFzfHistory-main\src\PSFzfHistory.psm1
```

Now you can use the better history experience

```pwsh
Invoke-FzfHistory
```

And enable the keybind if you want

```pwsh
Set-FzfHistoryKeybind -Chord Ctrl+r
```

## Limitations

- Loaded history expect one line: https://github.com/PowerShell/PSReadLine/issues/494#issuecomment-273358367

## Motivation

https://github.com/kelleyma49/PSFzf is helpful, but the loading is much slow for me.

I noticed I just want history finder, and we may realize with tiny PowerShell code and depending only fzf.
