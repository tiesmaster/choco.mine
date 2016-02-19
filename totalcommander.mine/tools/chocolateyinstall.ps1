$ErrorActionPreference = 'Stop'

$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$licenceFile = Join-Path $scriptPath "wincmd.key"

$totalcmdPath = 'c:\totalcmd'

Copy-Item $licenceFile "$totalcmdPath" -Force
