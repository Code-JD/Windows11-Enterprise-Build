<# 
  setup.ps1
  Main bootstrap script for fresh Win11 installs.
  - Reads apps-config.json
  - Ensures winget is available
  - Optionally installs PowerShell 7
  - Downloads debloat/app-install/optimize scripts from GitHub
  - Runs them in sequence
#>

param(
    [string]$ConfigPath = ".\apps-config.json"
)

Write-Host "=== Windows 11 Bootstrap Setup ===" -ForegroundColor Cyan

# --- 1. Check for Admin ---
$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run this script as Administrator (right-click → Run with PowerShell, as Admin)."
    Read-Host "Press Enter to exit"
    exit 1
}

# --- 2. Execution Policy (temporary) ---
Write-Host "Setting execution policy for this session..." -ForegroundColor Yellow
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# --- 3. Verify config file ---
if (-not (Test-Path $ConfigPath)) {
    Write-Error "Config file '$ConfigPath' not found. Make sure apps-config.json is in the same folder as setup.ps1."
    exit 1
}

Write-Host "Loading configuration from $ConfigPath..." -ForegroundColor Yellow
$configJson = Get-Content $ConfigPath -Raw
$config = $configJson | ConvertFrom-Json

# --- 4. Check winget ---
Write-Host "Checking for winget..." -ForegroundColor Yellow
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Warning "winget is not available. On a fully updated Windows 11, it should come with App Installer."
    Write-Warning "Open Microsoft Store, install 'App Installer', then re-run this script."
    Read-Host "Press Enter to exit"
    exit 1
}

# --- 5. Optionally install PowerShell 7 ---
if ($config.options.InstallPowerShell7 -eq $true) {
    Write-Host "Ensuring PowerShell 7 is installed via winget..." -ForegroundColor Yellow
    try {
        winget install --id Microsoft.PowerShell --silent --accept-package-agreements --accept-source-agreements
    } catch {
        Write-Warning "Failed to install PowerShell 7 via winget. Continuing with Windows PowerShell."
    }
}

# --- 6. GitHub raw URLs for scripts ---
# IMPORTANT: change YOUR-GITHUB-USERNAME and repo/branch to match your setup.
$baseUrl = "https://raw.githubusercontent.com/Code-JD/Windows11-Enterprise-Build/main/scripts"

$scripts = @{
    "debloat.ps1"     = "$baseUrl/debloat.ps1"
    "app-install.ps1" = "$baseUrl/app-install.ps1"
    "optimize.ps1"    = "$baseUrl/optimize.ps1"
}

# --- 7. Download scripts locally ---
$scriptFolder = ".\scripts"
if (-not (Test-Path $scriptFolder)) {
    New-Item -ItemType Directory -Path $scriptFolder | Out-Null
}

foreach ($name in $scripts.Keys) {
    $url  = $scripts[$name]
    $dest = Join-Path $scriptFolder $name

    Write-Host "Downloading $name using curl..." -ForegroundColor Yellow

    $cmd = "curl.exe -L `"$url`" -o `"$dest`""
    Invoke-Expression $cmd

    if (-not (Test-Path $dest) -or (Get-Item $dest).Length -eq 0) {
        Write-Warning "$name failed to download (file missing or empty)."
    } else {
        Write-Host "$name downloaded successfully." -ForegroundColor Green
    }
}

# --- 8. Run debloat (if enabled) ---
$debloatScript = Join-Path $scriptFolder "debloat.ps1"
if ($config.options.RunDebloat -and (Test-Path $debloatScript)) {
    Write-Host "Running debloat script..." -ForegroundColor Cyan
    & $debloatScript -ConfigPath $ConfigPath
} else {
    Write-Host "Skipping debloat (either disabled or script missing)." -ForegroundColor DarkYellow
}

# --- 9. Run app install ---
$appInstallScript = Join-Path $scriptFolder "app-install.ps1"
if (Test-Path $appInstallScript) {
    Write-Host "Running app installation script..." -ForegroundColor Cyan
    & $appInstallScript -ConfigPath $ConfigPath
} else {
    Write-Warning "app-install.ps1 not found. Skipping app installs."
}

# --- 10. Run optimization (if enabled) ---
$optimizeScript = Join-Path $scriptFolder "optimize.ps1"
if ($config.options.RunOptimize -and (Test-Path $optimizeScript)) {
    Write-Host "Running optimization script..." -ForegroundColor Cyan
    & $optimizeScript -ConfigPath $ConfigPath
} else {
    Write-Host "Skipping optimization (either disabled or script missing)." -ForegroundColor DarkYellow
}

Write-Host "=== Bootstrap complete. You may need to reboot. ===" -ForegroundColor Green
