$ErrorActionPreference = 'Stop'

$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$configFile = Join-Path $scriptPath "ConEmu.xml"
$destinationPath = "$env:APPDATA"

Write-Host 'Copying licence file to Total Commander path'
Copy-Item $configFile $destinationPath -Force
