<#
.SYNOPSIS
    Utility script for installing and configuring Windows Terminal.

.DESCRIPTION
    Utility script for installing and configuring Windows Terminal.

.EXAMPLE
    .\Install.ps1
#>

$backgroundPath = "$env:UserProfile\Pictures\backgrounds"
$iconsPath = "$env:UserProfile\Pictures\icons"

Write-Host "🚀 installing Windows Terminal"
winget install --id Microsoft.WindowsTerminal --source winget --accept-package-agreements

if (!(Test-Path $backgroundPath)) {
    "🗂️ creating backgrounds directory ($backgroundPath)"
    New-Item -Path $backgroundPath -ItemType Directory -Force | Out-Null
}

Write-Host "🗂️ copying backgrounds"
Copy-Item -Path "$PSScriptRoot\backgrounds\*" -Destination $backgroundPath -Force

if (!(Test-Path $iconsPath)) {
    "🗂️ creating icons directory ($iconsPath)"
    New-Item -Path $iconsPath -ItemType Directory -Force | Out-Null
}

Write-Host "🗂️ copying icons"
Copy-Item -Path "$PSScriptRoot\icons\*" -Destination $iconsPath -Force

Write-Host "🔧 copying my default Windows Terminal configuration"
Copy-Item -Path "$PSScriptRoot\settings.json" -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Force
