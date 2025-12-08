# Windows 11 Hardening Plan

This document outlines the hardening strategy and corresponding settings that will be implemented as part of the automated script.

## Hardening Objectives
- Reduce attack surface
- Enforce secure defaults
- Disable unnecessary services
- Apply CIS-aligned controls
- Strengthen PowerShell + logging
- Lock down application execution paths

---

## Control Categories

### 1. Windows Defender Enhancements
- Enable tamper protection
- Enable Cloud Protection
- Enable Real-Time Monitoring
- Configure Defender ASR rules (block-mode)

### 2. SmartScreen & Reputation-Based Protection
- SmartScreen for apps and files
- SmartScreen for Microsoft Edge
- Potentially unwanted app blocking

### 3. PowerShell Security
- Constrained Language Mode (optional)
- Script block logging
- Module logging
- Transcription logging

### 4. Telemetry Reduction
- Disable feedback requests
- Disable consumer experiences
- Disable advertising ID
- Disable cross-app tracking

### 5. Service Hardening
- Disable unnecessary or risky services
- Enforce delayed-start for non-essential services

### 6. Firewall Rules
- Enable outbound block policy
- Allow-list essential Windows services
- Allow-list package managers + games
- Optional: block telemetry endpoints

### 7. Credential Hardening
- Enable Credential Guard
- Disable cached credentials
- LSA protection

### 8. User Account Controls
- UAC to "Always Notify"
- Disable insecure autologin
- Enforce password policies

### 9. Additional Enterprise Controls
- Exploit Guard
- Integrity Checks
- Secure Boot validation
- Hardened SMB settings

---

## Implementation Phases
1. **Baseline Setup** – Confirm all apps installed and operational
2. **Defender + SmartScreen Enablement**
3. **ASR Rules (Audit → Block)**
4. **Firewall Hardening**
5. **PowerShell Logging Controls**
6. **Credential Guard & LSA Protection**
7. **Final Lockdown & Validation**

---

## Current Status
- Hardening branch created
- Repo structured
- Documentation initialized
- Scripts under development
