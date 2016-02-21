$ErrorActionPreference = 'Stop'; # stop on all errors

if(Test-Path "HKLM:\SOFTWARE\Classes\Everything.FileList\shell\open\command") {
    $everythingDir = (Split-Path (Get-ItemProperty "HKLM:\SOFTWARE\Classes\Everything.FileList\shell\open\command").'(default)'.Trim('`"').Trim(" `"%1`"")) 
}
else {
    $everythingDir = "${env:ProgramFiles}\Everything\"
}
Write-Host "Found Everything install path: $everythingDir"

Write-Host "Stopping Everything"
Stop-Process -processname Everything

$everythingExecutable = Join-Path $everythingDir "Everything.exe"

Write-Host "Installing Everything as service"
Start-Process $everythingExecutable -Wait -ArgumentList "-install-service"

Write-Host "Disabling running as admin"
Start-Process $everythingExecutable -Wait -ArgumentList "-disable-run-as-admin"

Write-Host "Importing config"
$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$configFilename = Join-Path $scriptPath "Everything.ini"
Start-Process $everythingExecutable -Wait -ArgumentList "-install-config $configFilename"

Write-Host "Starting Everything again"
Start-Process $everythingExecutable
