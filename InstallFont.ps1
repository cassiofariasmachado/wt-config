#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Utility script for installing Nerd Fonts.

.DESCRIPTION
    Script to install Nerd Fonts (https://github.com/ryanoasis/nerd-fonts).

.PARAMETER fontPatch
    Name of the patch/font to be installed. Example: Meslo or CascadiaCode.

.EXAMPLE
    .\InstallFont.ps1 -fontPatch Meslo
    .\InstallFont.ps1 -fontPatch CascadiaCode
#>

param (
    [string]$fontPatch
)

$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$fontPatch.zip"
$regKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

$tempPath = "${env:Temp}/font-install-script"
$extractedFontsFolder = "$tempPath/$fontPatch"
$tempFontsPath = "$tempPath/$fontPatch.zip"

$systemFontsPath = "${env:SystemRoot}\Fonts"

Write-Host "🌏 downloading font from ""$fontUrl"""

if (Test-Path $tempPath) {
    Write-Host "🧹 cleaning up temporary files"
    Remove-Item -Recurse -Force $tempPath
}

New-Item -Path $extractedFontsFolder -ItemType Directory -Force | Out-Null 
Invoke-WebRequest -Uri $fontUrl -OutFile $tempFontsPath

Write-Host "🗂️ extracting fonts to ""$extractedFontsFolder"""

Expand-Archive -Path $tempFontsPath `
    -DestinationPath $extractedFontsFolder -Force

$fontFiles = Get-ChildItem -Path $extractedFontsFolder -Filter *.ttf

foreach ($fontFile in $fontFiles) {
    Copy-Item -Path $fontFile.FullName -Destination $systemFontsPath

    $fontName = $fontFile.BaseName

    Write-Host "✅ registering font ""$fontName"""

    Set-ItemProperty -Path $regKey -Name $fontName `
        -Value $fontFile.Name
}

Write-Host "🧹 cleaning up temporary files"
Remove-Item -Recurse -Force $tempPath