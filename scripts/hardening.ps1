# ==========================================
# Windows 11 Hardening Script (Phase 1)
# Author: Code-JD
# Purpose: Enterprise-grade security hardening
# ==========================================

Write-Host "Starting Windows 11 Hardening (Phase 1)..." -ForegroundColor Cyan

# --- Function to require admin ---
function Require-Admin {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
                [Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Warning "You must run this script as Administrator."
        exit
    }
}
Require-Admin

# --- Enable PUA (Potentially Unwanted App) Protection ---
Write-Host "Enabling PUA Protection..." -ForegroundColor Yellow
Set-MpPreference -PUAProtection Enabled

# --- Enable Cloud-Delivered Protection ---
Write-Host "Enabling Cloud-Delivered Protection..." -ForegroundColor Yellow
Set-MpPreference -MAPSReporting Advanced
Set-MpPreference -SubmitSamplesConsent SendAllSamples

# --- Realtime Monitoring ---
Write-Host "Ensuring Real-Time Protection is enabled..." -ForegroundColor Yellow
Set-MpPreference -DisableRealtimeMonitoring $false

# --- Behavior Monitoring ---
Write-Host "Enabling Behavior Monitoring..." -ForegroundColor Yellow
Set-MpPreference -DisableBehaviorMonitoring $false

# --- Script Scanning ---
Write-Host "Enabling Script Scanning..." -ForegroundColor Yellow
Set-MpPreference -DisableScriptScanning $false

# --- Network Protection ---
Write-Host "Enabling Network Protection (Block Mode)..." -ForegroundColor Yellow
Set-MpPreference -EnableNetworkProtection Enabled

# --- SmartScreen Enablement ---
Write-Host "Enabling SmartScreen for Apps and Files..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name SmartScreenEnabled -Value "RequireAdmin"

# --- SmartScreen for Microsoft Edge ---
Write-Host "Enabling SmartScreen for Edge..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Edge\SmartScreenEnabled" -Name SmartScreenEnabled -Value 1 -Force

# --- Disable Advertising ID ---
Write-Host "Disabling Advertising ID..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name Enabled -Value 0 -Force

# --- Disable Consumer Experiences Safely ---
Write-Host "Disabling Consumer Experience Content..." -ForegroundColor Yellow

$cloudContentPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
if (-not (Test-Path $cloudContentPath)) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "CloudContent" -Force | Out-Null
}

Set-ItemProperty -Path $cloudContentPath -Name DisableConsumerFeatures -Value 1 -Force

# --- Disable Tips and Suggestions ---
Write-Host "Disabling Windows Tips..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" `
    -Name "SoftLandingEnabled" -Value 0 -Force

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" `
    -Name "SubscribedContent-310093Enabled" -Value 0 -Force

# --- Disable Telemetry (Safe Baseline) ---
Write-Host "Setting Telemetry to Basic..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" `
    -Name AllowTelemetry -Value 1 -Force

# --- Confirm Completion ---
Write-Host "Phase 1 Hardening Complete." -ForegroundColor Green
Write-Host "Reboot recommended before continuing to Phase 2." -ForegroundColor Cyan

# ==========================================
# Phase 2: Attack Surface Reduction (Balanced Mode)
# ==========================================

Write-Host "Applying Attack Surface Reduction (ASR) rules..." -ForegroundColor Cyan

function Enable-ASRRule {
    param (
        [string]$RuleId,
        [string]$Mode
    )
    Write-Host "Enabling ASR Rule: $RuleId ($Mode)" -ForegroundColor Yellow
    Add-MpPreference -AttackSurfaceReductionRules_Ids $RuleId -AttackSurfaceReductionRules_Actions $Mode
}

# --- Balanced ASR Rules ---
# 1. Block executable content from email/web
Enable-ASRRule -RuleId "D4F940AB-401B-4EFC-AADC-AD5F3C50688A" -Mode "1"  # Block

# 2. Block Office from injecting code into other processes
Enable-ASRRule -RuleId "75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84" -Mode "1"

# 3. Block Office from creating child processes
Enable-ASRRule -RuleId "D4F940AB-401B-4EFC-AADC-AD5F3C50688B" -Mode "1"

# 4. Block untrusted and unsigned processes from USB
Enable-ASRRule -RuleId "B2B3F03D-6A65-4F7B-A9C7-1C7EFE8C28D4" -Mode "1"

# 5. Block credential stealing from LSASS
Enable-ASRRule -RuleId "9E6F0A0B-CE3B-4BFE-8F22-7ED507D96E6B" -Mode "1"

# 6. Block process creation from suspicious script files
Enable-ASRRule -RuleId "5BEB7EFE-FD9A-4556-801D-275E5FFC04CC" -Mode "1"

# 7. Block executable content from OneNote (modern attack vector)
Enable-ASRRule -RuleId "BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550" -Mode "1"

# --- RULES WE AVOID (these break VS Code, Steam, gaming, installers) ---
# Block Win32 API calls from Office (breaks macros)
# Block child processes from scripts (breaks installers)
# Block all Office macros (annoying for non-Office users)
# Block remote Office files (breaks SharePoint users)
# Block LSASS credential dump is already enabled above

Write-Host "ASR Balanced Profile Applied." -ForegroundColor Green
