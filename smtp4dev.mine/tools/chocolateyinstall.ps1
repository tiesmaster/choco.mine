$ErrorActionPreference = 'Stop'

Write-Host "Installing .NET Framework 3.5 (required by Smtp4Dev)"
Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 |Out-Null

$smtp4devRegKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\4A13256439293DF4DBF7FA78E2162E2C"
if(Test-Path $smtp4devRegKey) {
    $smtp4devDir = (Split-Path (Get-ItemProperty $smtp4devRegKey).'F701DA348A1E43B4CB5F2250F518AFBA') 
}
else {
    Write-Host "Falling back to default value"
    $smtp4devDir = "${env:ProgramFiles}\smtp4dev\"
}
Write-Host "Found Smtp4dev install path: $smtp4devDir"

Write-Host "Configuring Smtp4Dev to start in tray, and auto view messages"
$appConfigFilename = Join-Path $smtp4devDir "Smtp4dev.exe.config"
[xml]$appConfig = Get-Content $appConfigFilename

$appConfig.configuration.userSettings.'Rnwood.Smtp4dev.Properties.Settings'.SelectSingleNode("setting[@name = 'StartInTray']").value = "True"
$appConfig.configuration.userSettings.'Rnwood.Smtp4dev.Properties.Settings'.SelectSingleNode("setting[@name = 'AutoViewNewMessages']").value = "True"

$appConfig.Save($appConfigFilename)

Write-Host "Configuring Smtp4dev to start at login"
$smtp4devExecutable = Join-Path $smtp4devDir "Smtp4dev.exe"
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "smtp4dev" -Value $smtp4devExecutable |Out-Null

Write-Host "Starting Smtp4dev again"
Start-Process $smtp4devExecutable
# Configure smtp4dev.exe to start at login
# and start the executable

# TODO: add auto installing firewall rule
