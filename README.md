<p align="center">
  <img src="https://img.shields.io/badge/Windows-11-0078D6?logo=windows11&logoColor=white" />
  <img src="https://img.shields.io/badge/PowerShell-Automation-5391FE?logo=powershell&logoColor=white" />
  <img src="https://img.shields.io/badge/Microsoft%20Defender-Hardening-2E8B57?logo=microsoftdefender&logoColor=white" />
  <img src="https://img.shields.io/badge/ASR-Rules%20Enabled-orange" />
  <img src="https://img.shields.io/badge/Logging-Full%20Visibility-8A2BE2" />
  <img src="https://img.shields.io/badge/Status-Active%20Development-success" />
</p>

# Windows 11 Hardening & Bootstrap Automation

A HomeLab project to rebuild and harden a Windows 11 workstation using **PowerShell**, **Microsoft Defender**, and **enterprise-style logging** — while keeping it fully usable for **gaming, productivity, and development**.

## 📚 Table of Contents

- [Windows 11 Hardening \& Bootstrap Automation](#windows-11-hardening--bootstrap-automation)
  - [📚 Table of Contents](#-table-of-contents)
  - [🔍 Overview](#-overview)
  - [🛠️ Tech Stack](#️-tech-stack)
  - [📂 Repository Structure](#-repository-structure)
- [**SECTION 5 — Current Features (Phase 1)**](#section-5--current-features-phase-1)
  - [✅ Current Features](#-current-features)
    - [**Phase 1 — Core Defender \& Privacy Hardening**](#phase-1--core-defender--privacy-hardening)
    - [**Phase 2 — Attack Surface Reduction (Balanced Mode)**](#phase-2--attack-surface-reduction-balanced-mode)
    - [**Phase 3 — PowerShell Logging \& Security Auditing (Full Visibility)**](#phase-3--powershell-logging--security-auditing-full-visibility)
  - [▶️ How to Run](#️-how-to-run)
- [**SECTION 9 — Validation \& Logs**](#section-9--validation--logs)
  - [🔎 Validation \& Logging Locations](#-validation--logging-locations)
    - [**Defender UI**](#defender-ui)
    - [**PowerShell Transcripts**](#powershell-transcripts)
    - [**Event Viewer Locations**](#event-viewer-locations)
  - [🎯 Learning Outcomes](#-learning-outcomes)
  - [�️ Roadmap](#️-roadmap)
  - [📣 Feedback](#-feedback)
  - [🧑‍💼 For Hiring Managers](#-for-hiring-managers)
  - [📫 Contact](#-contact)


> **Goal:** Build real, transferable skills for IT, sysadmin, cybersecurity, and cloud roles by treating a personal Windows 11 machine like a managed enterprise endpoint.

## 🔍 Overview

This repository contains scripts and documentation for:

- Automating portions of a fresh Windows 11 installation
- Applying **balanced but strong security hardening**
- Enabling **full PowerShell and security auditing**
- Creating a **repeatable baseline** for clean rebuilds
- Practicing **Git/GitHub workflows**
- Documenting troubleshooting and system configuration like a real IT engineer

This project is part of my longer-term HomeLab initiative to build hands-on experience for transitioning into a technical role.

## 🛠️ Tech Stack

- **Windows 11**
- **PowerShell 7**
- **Microsoft Defender**
- **Attack Surface Reduction (ASR)**
- **Windows Audit Policy (`auditpol.exe`)**
- **winget** package manager
- **VS Code** (PowerShell extension, Git integration)
- **Git & GitHub**

## 📂 Repository Structure

```text
Windows11-Enterprise-Build/
│
├─ README.md                 # Main documentation
├─ apps-config.json          # App provisioning config (WIP)
├─ setup.ps1                 # Bootstrap script for fresh installs
│
├─ scripts/
│   ├─ hardening.ps1         # Phases 1–3 hardening and logging
│   └─ future/               # Placeholder for later phases (firewall, etc.)
│
└─ docs/
    ├─ overview.md           # High-level project summary
    ├─ live-notes.md         # Active troubleshooting log
    ├─ hardening-plan.md     # Breakdown of security phases & controls
    └─ changelog.md          # Version history


---

# **SECTION 5 — Current Features (Phase 1)**

```markdown
## ✅ Current Features

### **Phase 1 — Core Defender & Privacy Hardening**

Enterprise-security baseline:

- Enables **PUA protection**
- Enables **cloud-delivered protection**
- Ensures:
  - Real-time protection
  - Behavior monitoring
  - Script scanning
- Enables **Network Protection (Block Mode)**
- Enables **SmartScreen** for apps and Microsoft Edge
- Disables:
  - Advertising ID
  - Consumer experience content
  - Windows tips
- Reduces telemetry levels
- Ensures consistent Defender configuration across rebuilds

### **Phase 2 — Attack Surface Reduction (Balanced Mode)**

A safe-for-gaming, safe-for-development ASR profile:

**ASR rules enabled (Block mode):**
- Block executable content from email and web
- Block Office from creating child processes
- Block Office from injecting code into other processes
- Block untrusted/unsigned processes from **USB**
- Block credential theft attempts from **LSASS**
- Block process creation from suspicious script files
- Block executable content launched from OneNote

**ASR rules intentionally NOT enabled (to avoid breaking):**
- Development tools
- Steam / Epic / RSI Launcher
- Installers and game anti-cheat systems
- VS Code debugging

This profile is strong but compatible with daily use.

### **Phase 3 — PowerShell Logging & Security Auditing (Full Visibility)**

Enterprise-grade visibility normally used by SOC analysts and blue-team environments.

**PowerShell Logging Enabled:**
- Script Block Logging
- Module Logging
- Transcription Logging (saved to `C:\PowerShell-Transcripts`)
- Invocation headers for attribution

**Advanced Audit Policy Configuration:**
- Logon / Logoff
- Account & security group management
- Sensitive privilege use
- Audit policy changes
- Authentication policy changes
- **Process creation** (critical for detection)
- Process termination
- File system access auditing
- Registry auditing
- System integrity events
- Security state changes

Combined, this produces deep telemetry for:
- Threat hunting
- Incident response
- SIEM ingestion (future)
- Detection engineering

## ▶️ How to Run

> ⚠️ **Warning:** Hardening scripts modify security configuration.
> Always test in a homelab or fresh install first.

Clone the repo:

```powershell
git clone https://github.com/Code-JD/Windows11-Enterprise-Build.git
cd Windows11-Enterprise-Build\scripts

powershell.exe -ExecutionPolicy Bypass -File .\hardening.ps1


---

# **SECTION 9 — Validation & Logs**

```markdown
## 🔎 Validation & Logging Locations

### **Defender UI**
- SmartScreen → **On**
- PUA Protection → **On**
- Network Protection → **On (Block Mode)**

### **PowerShell Transcripts**


### **Event Viewer Locations**
- **Windows Logs → Security**
- **Applications and Services Logs → Windows PowerShell**
- **Microsoft → Windows → PowerShell → Operational**

## 🎯 Learning Outcomes

This project provides hands-on experience in:

- Windows administration
- PowerShell scripting
- Security hardening with Defender + ASR
- Enterprise-level logging and visibility
- Auditing and incident analysis preparation
- Git version control workflows
- Documenting troubleshooting and change history
- Designing and executing repeatable system baselines

The goal is to demonstrate practical capability to future employers.


## 🗺️ Roadmap

- [ ] **Phase 4 — Firewall Hardening (balanced outbound allowlist)**
- [ ] **Phase 5 — Credential Guard & LSA Protection**
- [ ] **Phase 6 — Service Hardening & Scheduled Task Review**
- [ ] **Phase 7 — Exportable GPO/Intune/DSC Baseline**
- [ ] Expand setup.ps1 into a full bootstrap engine
- [ ] Build an example “incident” using collected logs
- [ ] Create detection rules for SIEM integration

## 📣 Feedback

I’m actively learning and improving.
If you work in IT, cybersecurity, or cloud engineering, I’d love feedback or suggestions for additional controls or documentation improvements.

## 🧑‍💼 For Hiring Managers

This project demonstrates my ability to:

- Automate Windows configuration using PowerShell
- Apply practical, real-world security hardening
- Configure enterprise-grade logging and audit policies
- Troubleshoot drivers, packages, and system issues
- Use Git/GitHub for version control and documentation
- Write clear, maintainable scripts and technical docs

This repository intentionally mirrors real IT + cybersecurity workflows:
- Working in branches
- Committing with meaningful messages
- Documenting issues in `live-notes.md`
- Maintaining a stable, repeatable baseline
- Designing phased deployments

If you'd like to discuss this project or my learning journey, feel free to reach out.

## 📫 Contact

If you’d like to connect or provide feedback:

- **LinkedIn:**https://www.linkedin.com/posts/jonathan-herring-code_i-just-completed-a-full-homelab-project-where-activity-7403858278130311168-p6WC/?rcm=ACoAAC3_5gsBUR9cBNarPSf3OHdO9cYIF4kDSe0
- **Medium:**https://medium.com/@jonathan.d.herring/turning-my-gaming-pc-into-an-enterprise-hardened-windows-11-workstation-homelab-project-523f52fe5054
- **GitHub:** https://github.com/Code-JD

Feedback from IT, cybersecurity, and cloud professionals is always appreciated.

Repository:
**https://github.com/Code-JD/Windows11-Enterprise-Build**
