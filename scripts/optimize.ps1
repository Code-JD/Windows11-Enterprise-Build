param(
    [string]$ConfigPath = ".\apps-config.json"
)

Write-Host "[Optimize] Starting basic optimizations..." -ForegroundColor Cyan

# Faster UI feel
Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name MenuShowDelay -Value 20 -ErrorAction SilentlyContinue

# High performance power plan if available
try {
    $highPerf = powercfg -L | Select-String "High performance"
    if ($highPerf) {
        $guid = ($highPerf -split '\s+')[3]
        powercfg -setactive $guid
        Write-Host "[Optimize] High performance power plan enabled." -ForegroundColor Yellow
    }
} catch {
    Write-Warning "[Optimize] Could not set power plan: $_"
}

# Clean recycle bin (no prompt)
try {
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
} catch {}

Write-Host "[Optimize] Done." -ForegroundColor Green
