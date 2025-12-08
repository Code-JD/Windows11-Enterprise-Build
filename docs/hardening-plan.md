# Windows 11 Hardening Plan
**Version:** 1.0
**Author:** Jonathan H. (Code-JD)

This document outlines the design and reasoning behind the security hardening phases included in the `hardening.ps1` script.
The goal is to simulate real-world endpoint hardening practices used by enterprise IT and cybersecurity teams.

---

# 🎯 Objectives

- Increase security and reduce modern attack surface
- Maintain **full compatibility** with gaming (Star Citizen, Steam, Epic)
- Maintain **compatibility with development tools** (VS Code, Git, PowerShell)
- Enable **deep visibility** for incident response and SOC-style log analysis
- Create a **repeatable, script-driven baseline**

---

# ⚙️ Phase Overview

| Phase | Focus Area | Status |
|-------|------------|--------|
| **Phase 1** | Core Defender + Privacy Configuration | ✔ Complete |
| **Phase 2** | Attack Surface Reduction (Balanced Profile) | ✔ Complete |
| **Phase 3** | PowerShell Logging + Advanced Audit Policy | ✔ Complete |
| **Phase 4** | Firewall Hardening | ⏳ Pending |
| **Phase 5** | Credential Guard + LSA Protection | ⏳ Pending |
| **Phase 6** | Service + Scheduled Task Review | ⏳ Pending |
| **Phase 7** | Exportable Enterprise Baseline (GPO/DSC) | ⏳ Pending |

---

# 🛡️ Phase 1 — Core Defender & Privacy Configuration

**Purpose:** Establish strong baseline protections that do not interfere with daily use.

### Controls Applied
- Enable cloud-delivered protection
- Enable automatic sample submission
- Enable PUA (Potentially Unwanted Application) protection
- Ensure:
  - Real-time protection
  - Behavior monitoring
  - Script scanning
- Enable SmartScreen for apps & Microsoft Edge
- Enable Network Protection (Block Mode)
- Disable consumer features:
  - Advertising ID
  - Suggested content
  - Windows tips
- Reduce telemetry

### Why These Controls Matter
These settings protect against malware, unsafe downloads, phishing attempts, and malicious behavior while ensuring the operating system behaves more like an enterprise-managed device.

---

# 🛡️ Phase 2 — Attack Surface Reduction (Balanced Mode)

**Purpose:** Block high-risk behaviors without breaking gaming or development workflows.

### ASR Rules Enabled (Block Mode)
- Block executable content from email and web
- Block Office from creating child processes
- Block Office from injecting into other processes
- Block untrusted/unsigned processes from USB
- Block LSASS credential theft attempts
- Block process creation from suspicious script files
- Block executable content launched from OneNote

### ASR Rules *Not* Enabled (on purpose)
Some ASR rules break:

- Game anti-cheat systems
- Application installers
- Development tools
- Debuggers
- Steam, Epic, and non-Microsoft launchers

Only rules that preserve full compatibility are enabled.

### Why This Matters
Balanced ASR offers excellent protection from real-world malware (macros, phishing documents, USB attacks) while avoiding false positives in gaming and software development environments.

---

# 🛡️ Phase 3 — PowerShell Logging & Advanced Audit Policy

**Purpose:** Provide SOC-grade visibility into system activity without affecting performance.

### PowerShell Logging Enabled
- Script Block Logging
- Module Logging
- Transcription Logging
  - Stored in `C:\PowerShell-Transcripts`
- Invocation headers enabled

### Audit Policies Enabled
- Logon/logoff
- Account management
- Privilege use
- Audit policy changes
- Authentication changes
- Process creation/termination
- File system auditing
- Registry auditing
- System integrity

### Why This Matters
These logs provide the data needed for:

- Detection engineering
- Incident response practice
- Blue-team investigation
- Threat hunting
- SIEM correlation in future HomeLab projects

This makes *your local Windows PC* behave like a monitored corporate endpoint.

---

# 🧱 Future Phases

## Phase 4 — Firewall Hardening
Create an outbound allowlist and enforce application-scoped rules.

## Phase 5 — Credential Guard + LSA Protection
Help mitigate credential theft attacks such as Mimikatz.

## Phase 6 — Service & Scheduled Task Hardenings
Disable unnecessary tasks and reduce system noise.

## Phase 7 — Exportable Enterprise Baseline
Push the entire configuration into:

- Group Policy Objects (GPO)
- Desired State Configuration (DSC)
- Intune-ready JSON

---

# 📌 Summary

This hardening plan provides:

- Strong security
- High compatibility
- Repeatability
- Real-world skills that transfer directly to IT/cybersecurity roles

This document will continue evolving as new phases are implemented.
