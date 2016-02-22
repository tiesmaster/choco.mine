param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)
{
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else
    {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

Write-host 'Running with full privileges'

iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

choco feature enable -n=allowGlobalConfirmation

$installPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

choco source add -n=local -s"$installPath"
$worldFile = Join-Path $installPath "world.config"

choco install $worldFile
