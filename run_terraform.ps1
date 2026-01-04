# AWS Credentials should be set as environment variables or via setup_credentials.ps1
# Avoid hardcoding them here for security.

Write-Host "Lancement de Terraform..." -ForegroundColor Green
Set-Location terraform
..\bin\terraform.exe init
..\bin\terraform.exe apply -auto-approve | Tee-Object -FilePath "terraform_log.txt"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur détectée !" -ForegroundColor Red
    Read-Host "Appuyez sur Entrée pour quitter..."
}
