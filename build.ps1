Get-ChildItem -Recurse -Filter "*.nuspec" |ForEach-Object { choco pack $_.fullname}

mkdir output
Get-ChildItem -Filter "*.nupkg" | % {$_ | Copy-Item -Destination output }
Copy-Item .\world.config .\output
Copy-Item .\install.ps1 .\output
