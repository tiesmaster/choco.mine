iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

choco feature enable -n=allowGlobalConfirmation

$installPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

choco source add -n=local -s"$installPath"
$worldFile = Join-Path $installPath "world.config"

choco install $worldFile
