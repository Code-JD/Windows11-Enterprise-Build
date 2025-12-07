param(
    [string]$ConfigPath = ".\apps-config.json"
)

Write-Host "[AppInstall] Starting..." -ForegroundColor Cyan

if (-not (Test-Path $ConfigPath)) {
    Write-Warning "[AppInstall] Config file not found. Exiting."
    return
}

$config = (Get-Content $ConfigPath -Raw) | ConvertFrom-Json

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Warning "[AppInstall] winget not found. Cannot install apps."
    return
}

foreach ($app in $config.apps) {
    if ($app.enabled -eq $false) {
        Write-Host "[AppInstall] Skipping disabled app: $($app.name)" -ForegroundColor DarkGray
        continue
    }

    Write-Host "[AppInstall] Installing: $($app.name) ($($app.id))" -ForegroundColor Yellow
    try {
        winget install --id $app.id --silent --accept-package-agreements --accept-source-agreements
    } catch {
        Write-Warning "[AppInstall] Failed to install $($app.name): $_"
    }
}

Write-Host "[AppInstall] Done." -ForegroundColor Green
