param(
    [string]$ConfigPath = ".\apps-config.json"
)

Write-Host "[Debloat] Starting..." -ForegroundColor Cyan

if (-not (Test-Path $ConfigPath)) {
    Write-Warning "[Debloat] Config file not found. Exiting."
    return
}

$config = (Get-Content $ConfigPath -Raw) | ConvertFrom-Json
$debloat = $config.debloat

# Helper function
function Remove-AppxByPattern {
    param([string]$pattern)

    Write-Host "[Debloat] Removing AppX packages matching '$pattern'..." -ForegroundColor Yellow

    Get-AppxPackage -AllUsers |
        Where-Object { $_.Name -like $pattern } |
        ForEach-Object {
            Write-Host "  Removing $($_.Name)" -ForegroundColor DarkYellow
            Remove-AppxPackage -Package $_.PackageFullName -ErrorAction SilentlyContinue
        }

    Get-AppxProvisionedPackage -Online |
        Where-Object { $_.DisplayName -like $pattern } |
        ForEach-Object {
            Write-Host "  Removing provisioned $($_.DisplayName)" -ForegroundColor DarkYellow
            Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction SilentlyContinue
        }
}

if ($debloat.removeXbox)      { Remove-AppxByPattern "*xbox*" }
if ($debloat.removeBing)      { Remove-AppxByPattern "*bing*" }
if ($debloat.removeClipchamp) { Remove-AppxByPattern "*clipchamp*" }

foreach ($pattern in $debloat.extraAppxPatterns) {
    Remove-AppxByPattern $pattern
}

Write-Host "[Debloat] Done." -ForegroundColor Green
