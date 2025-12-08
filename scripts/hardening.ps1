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

# --- Disable Consumer Experiences ---
Write-Host "Disabling Consumer Experience Content..." -ForegroundColor Yellow
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name DisableConsumerFeatures -Value 1 -Force

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
