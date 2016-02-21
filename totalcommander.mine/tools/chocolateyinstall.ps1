$ErrorActionPreference = 'Stop'

$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$licenceFile = Join-Path $scriptPath "wincmd.key"

$totalcmdPath = (Get-ItemProperty -path "HKLM:\SOFTWARE\Ghisler\Total Commander" -name InstallDir).InstallDir
Write-Host "Found Total Commander install path: $totalcmdPath"

Write-Host 'Copying licence file to Total Commander path'
Copy-Item $licenceFile "$totalcmdPath" -Force

Write-Host 'Configuring Total Commander Quick Search to use "Letter Only"'
Add-Content "$env:APPDATA\GHISLER\wincmd.ini" "AltSearch=2"

# Locate GVIM install dir
$regPathWow6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Vim'
$regPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Vim'

if (Test-Path $regPath) {
    $regPathFound = $regPath
}

if (Test-Path $regPathWow6432) {
    $regPathFound = $regPathWow6432
}

if ($regPathFound) {
    $gvimInstallDir = Split-Path -Parent (
        Get-ItemProperty $regPathFound 'UninstallString'
    ).UninstallString

    $gvimPath = Join-Path $gvimInstallDir "gvim.exe"
    Write-Host 'Setting Editor to GVIM'
    Add-Content "$env:APPDATA\GHISLER\wincmd.ini" "Editor=$gvimPath"
}
