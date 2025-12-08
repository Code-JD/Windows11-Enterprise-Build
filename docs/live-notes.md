# Live Notes & Troubleshooting Log

This file contains real-time notes taken during build and configuration work.
It demonstrates troubleshooting steps, decision-making, and lessons learned.

---

## [Date] — Windows 11 Fresh Install
- Installed Windows 11 using USB created with Rufus
- Encountered script execution policy block
  - Resolved using: `Set-ExecutionPolicy -Scope Process Bypass`
- Successfully ran `setup.ps1` after correcting GitHub URLs
- Validated that debloat, optimize, and app-install scripts run correctly

---

## [Date] — Chipset Driver Issue
Issue: AMD chipset installer hung at “Checking your PC’s hardware”.

Resolution steps:
1. Rebooted the system
2. Confirmed Windows Update inactivity
3. Cleared previous AMD installer folders
4. Downloaded correct AM4 chipset driver directly from AMD
5. Installer launched successfully and installed:
   - AMD PCI Device Driver
   - AMD PSP Driver
   - AMD SMBus
   - AMD GPIO
   - AMD Ryzen Power Plan
6. Verified installation in Device Manager

Status: **Resolved**

---

*(New entries will be added as work continues)*
