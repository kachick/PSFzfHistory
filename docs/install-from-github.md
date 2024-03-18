### Installation from GitHub

When [PowerShell Gallery](https://www.powershellgallery.com/) is [down](https://github.com/PowerShell/PowerShellGallery/blob/master/psgallery_status.md), refer this document as an example to use local modules.

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
0.0.6                PSFzfHistory                        MyRepository         Tiny fzf integration for history substr …
```
