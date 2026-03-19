# Install.ps1 - Script de instalación de dotfiles
Write-Host "Instalando dotfiles de Carlos..." -ForegroundColor Cyan

# Oh My Posh
\ = "\C:\Users\Lenovo2006CDMR\Downloads\oh-my-posh-configs"
New-Item -ItemType Directory -Path \ -Force | Out-Null
Copy-Item "\\oh-my-posh\carlos-optimized.omp.json" \

Write-Host "Configuración instalada. Agregue a su $PROFILE:" -ForegroundColor Green
Write-Host "oh-my-posh init pwsh --config "\\carlos-optimized.omp.json" | Invoke-Expression" -ForegroundColor Yellow
