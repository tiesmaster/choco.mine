$ErrorActionPreference = 'Stop'

$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$licenceFile = Join-Path $scriptPath "wincmd.key"

$totalcmdPath = (gp -path "HKLM:\SOFTWARE\Ghisler\Total Commander" -name InstallDir).InstallDir

Copy-Item $licenceFile "$totalcmdPath" -Force

Add-Content "$env:APPDATA\GHISLER\wincmd.ini" "AltSearch=2"
Add-Content "$env:APPDATA\GHISLER\wincmd.ini" "Editor=C:\Program Files (x86)\vim\vim74\gvim.exe"
