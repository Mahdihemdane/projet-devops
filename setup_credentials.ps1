$AccessKey = Read-Host "Entrez aws_access_key_id"
$SecretKey = Read-Host "Entrez aws_secret_access_key"
$SessionToken = Read-Host "Entrez aws_session_token (Laissez vide si aucun)"

[System.Environment]::SetEnvironmentVariable('AWS_ACCESS_KEY_ID', $AccessKey, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('AWS_SECRET_ACCESS_KEY', $SecretKey, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('AWS_DEFAULT_REGION', 'us-east-1', [System.EnvironmentVariableTarget]::User)

if ($SessionToken -ne "") {
    [System.Environment]::SetEnvironmentVariable('AWS_SESSION_TOKEN', $SessionToken, [System.EnvironmentVariableTarget]::User)
    Write-Host "✅ Session Token configuré." -ForegroundColor Green
}

Write-Host "✅ Identifiants sauvegardés ! Redémarrez votre terminal (Fermez et rouvrez VS Code) pour qu'ils soient pris en compte." -ForegroundColor Green
Write-Host "Ensuite, lancez : cd terraform; ..\bin\terraform.exe init; ..\bin\terraform.exe plan" -ForegroundColor Cyan
