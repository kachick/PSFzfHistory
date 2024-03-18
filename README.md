# PSFzfHistory

[![CI - Nix Status](https://github.com/kachick/PSFzfHistory/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/kachick/PSFzfHistory/actions/workflows/ci-nix.yml?query=branch%3Amain+)
[![Release](https://github.com/kachick/PSFzfHistory/actions/workflows/release.yml/badge.svg?branch=main)](https://github.com/kachick/PSFzfHistory/actions/workflows/release.yml?query=branch%3Amain+)
[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSFzfHistory.svg?style=flat&logo=powershell&label=PSGallery%20Version)](https://www.powershellgallery.com/packages/PSFzfHistory)

Tiny [fzf](https://github.com/junegunn/fzf) integration for history substring search in PowerShell

## Installation

### Requirements

Install [fzf](https://github.com/junegunn/fzf) with your favorite method, I prefer [winget](https://github.com/microsoft/winget-pkgs/tree/master/manifests/j/junegunn/fzf) in Windows

```pwsh
winget install --exact --id junegunn.fzf
```

### This Module

via [PowerShell Gallery](https://www.powershellgallery.com/packages/PSFzfHistory)

```pwsh
Install-Module -Name PSFzfHistory
```

via [Local modules](docs/install-from-github.md)

## Usage

```pwsh
Invoke-FzfHistory
```

Enable the keybind if you want

```pwsh
Set-FzfHistoryKeybind -Chord Ctrl+r
```

## Optional - Always Enable keybind

Add these code in your $PROFILE(Profile.ps1)

```pwsh
# Make sure the winget tools in your PATH
# https://github.com/microsoft/winget-cli/issues/2498#issuecomment-1553863082
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Set-FzfHistoryKeybind -Chord Ctrl+r
```

## Limitations

Multiline history may be unuseful behavior in fzf

- https://github.com/PowerShell/PSReadLine/issues/494#issuecomment-273358367
- https://github.com/junegunn/fzf/issues/154#issuecomment-84503814

## Motivation

I really want history substring search in all shells.\
[PSFzf](https://github.com/kelleyma49/PSFzf) is a helpful project, but the module loading speed is much slow for me.\
I noticed I really want integrations only around history, unnecessary for file finders, and we may realize it with tiny PowerShell code.
