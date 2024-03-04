# PSFzfHistory

[![CI - Nix Status](https://github.com/kachick/PSFzfHistory/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/kachick/PSFzfHistory/actions/workflows/ci-nix.yml?query=branch%3Amain+)

[fzf](https://github.com/junegunn/fzf) integration for PowerShell with small code

## Usage

### Requirements

Install fzf with your favorite method, I prefer winget in Windows as follows

```pwsh
winget install --exact --id junegunn.fzf
```

### Features

Try this after [whole installation steps](#installation)

```pwsh
Invoke-FzfHistory
```

And enable the keybind if you want

```pwsh
Set-FzfHistoryKeybind -Chord Ctrl+r
```

### Enable in your Profile.ps1

In your $PROFILE

```pwsh
# Make sure the winget tools in your PATH
# https://github.com/microsoft/winget-cli/issues/2498#issuecomment-1553863082
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Add this section if you want the keybind
if (Get-Module -Name PSFzfHistory) {
    Set-FzfHistoryKeybind -Chord Ctrl+r
}
```

### Installation

Unfortunately, now [PowerShell Gallery](https://www.powershellgallery.com/) looks like [not accepting new author or publish](https://github.com/PowerShell/PowerShellGallery/issues/266). So I describe how to install local modules.

Download this module from GitHub

```pwsh
Invoke-WebRequest 'https://github.com/kachick/PSFzfHistory/archive/refs/heads/main.zip' -OutFile .\PSFzfHistory.zip
Expand-Archive .\PSFzfHistory.zip .\
Remove-Item PSFzfHistory.zip
Move-Item .\PSFzfHistory-main\ .\PSFzfHistory\
```

Create local repository if you don't have it yet

```pwsh
# https://stackoverflow.com/questions/49987884/how-to-install-update-a-powershell-module-from-a-local-folder-set-up-an-intern
$local_modules_path = Join-Path -Path (Split-Path -Parent $PROFILE) -ChildPath "MyModules"
New-Item -Force -ItemType "Directory" -Path $local_modules_path
Register-PSRepository -Name "MyRepository" -InstallationPolicy Trusted -SourceLocation $local_modules_path
```

Install from your local repository

```pwsh
# https://github.com/PowerShell/PowerShellGetv2/issues/606
$env:DOTNET_CLI_UI_LANGUAGE="en_US"
$env:DOTNET_CLI_LANGUAGE="en_US"
$env:NUGET_CLI_LANGUAGE="en_US"
Publish-Module -Path .\PSFzfHistory -Repository MyRepository
Remove-Item .\PSFzfHistory
Install-Module -Name PSFzfHistory -Repository MyRepository
```

Make sure you are really installed the module

```pwsh
> Get-InstalledModule

Version              Name                                Repository           Description
-------              ----                                ----------           -----------
5.5.0                Pester                              PSGallery            Pester provides a framework for running …
0.0.1                PSFzfHistory                        MyRepository         fzf history integration with small code
```

## Limitations

Multiline history may be unuseful behavior in fzf

- https://github.com/PowerShell/PSReadLine/issues/494#issuecomment-273358367
- https://github.com/junegunn/fzf/issues/154#issuecomment-84503814

## Motivation

I really want history substring search in all shells.\
[PSFzf](https://github.com/kelleyma49/PSFzf) is a helpful project, but the module loading speed is much slow for me.\
I noticed I really want integrations only around history, unnecessary for file finders, and we may realize it with tiny PowerShell code.
