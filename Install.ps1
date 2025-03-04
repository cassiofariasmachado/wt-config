<#
.SYNOPSIS
    Script utilitário de instalação e configuração do Windows Terminal.

.DESCRIPTION
    Script utilitário de instalação e configuração do Windows Terminal.

.EXAMPLE
    .\Install.ps1
#>

$backgroundPath = "$env:UserProfile\Pictures\backgrounds"

Write-Host "🚀 instalando Windows Terminal"
winget install --id Microsoft.WindowsTerminal --source winget --accept-package-agreements

if (!(Test-Path $backgroundPath)) {
    "🗂️ criando diretório de backgrounds ($backgroundPath)"
    New-Item -Path $backgroundPath -ItemType Directory -Force | Out-Null
}

Write-Host "🗂️ copiando backgrounds"
Copy-Item -Path "$PSScriptRoot\backgrounds\*" -Destination $backgroundPath -Force

Write-Host "🔧 copiando minha configuração padrão do Windows Terminal"
Copy-Item -Path "$PSScriptRoot\settings.json" -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Force

