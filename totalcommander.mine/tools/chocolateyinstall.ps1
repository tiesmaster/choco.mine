$ErrorActionPreference = 'Stop'

$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$licenceFile = Join-Path $scriptPath "wincmd.key"

$totalcmdPath = (gp -path "HKLM:\SOFTWARE\Ghisler\Total Commander" -name InstallDir).InstallDir

Copy-Item $licenceFile "$totalcmdPath" -Force
