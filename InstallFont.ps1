#Requires -RunAsAdministrator

<#
.SYNOPSIS
    Script utilitário de instalação de Nerd Fonts.

.DESCRIPTION
    Script de instalação de Nerd Fonts (https://github.com/ryanoasis/nerd-fonts).

.PARAMETER fontPatch
    Nome do patch/fonte que deve ser instalado. Exemplo: Meslo ou CascadiaCode.

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

Write-Host "🌏 baixando fonte de ""$fontUrl"""

if (Test-Path $tempPath) {
    Write-Host "🧹 Limpando arquivos temporários"
    Remove-Item -Recurse -Force $tempPath
}

New-Item -Path $extractedFontsFolder -ItemType Directory -Force | Out-Null 
Invoke-WebRequest -Uri $fontUrl -OutFile $tempFontsPath

Write-Host "🗂️ extraindo fontes em ""$extractedFontsFolder"""

Expand-Archive -Path $tempFontsPath `
    -DestinationPath $extractedFontsFolder -Force

$fontFiles = Get-ChildItem -Path $extractedFontsFolder -Filter *.ttf

foreach ($fontFile in $fontFiles) {
    Copy-Item -Path $fontFile.FullName -Destination $systemFontsPath

    $fontName = $fontFile.BaseName

    Write-Host "✅ registrando fonte ""$fontName"""

    Set-ItemProperty -Path $regKey -Name $fontName `
        -Value $fontFile.Name
}

Write-Host "🧹 limpando arquivos temporários"
Remove-Item -Recurse -Force $tempPath