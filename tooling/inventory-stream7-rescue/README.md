# inventory-stream7-rescue

Cross-platform **inventory, rescue triage, install-path assessment, and evidence-first reporting** for constrained hardware.

This repository is organized around **two layers**:

1. a **cross-platform inventory and rescue baseline** for Linux and Windows;
2. a **specialized Stream 7 continuation path** for unusually constrained hardware.

The general lane comes first.  
The Stream 7 lane is a focused continuation, not the definition of the whole repository.

It is designed to help answer these questions before invasive changes:

- What hardware and software do I actually have?
- Is this device better kept on its current OS or migrated?
- What is the best role for this machine under real constraints?
- What optimizations offer the highest return with the lowest risk?
- What evidence should be preserved before making changes?

## Repository value

This repository demonstrates:

- cross-platform diagnostic discipline
- architecture-aware rescue and install-path evaluation
- evidence-first reporting before disruptive action
- constrained technical judgment under low-resource conditions

## Supported lanes

### 1. Multiplatform general lanes
Reusable general-purpose audit and assessment flows for:
- Linux (x86 32-bit, x86_64, armhf, arm64)
- Windows PowerShell 5+
- Windows PowerShell 4 legacy lane (`PS4` here means **PowerShell 4**, not PlayStation 4)

### 2. Stream 7 specialized lane
A focused lane for HP Stream 7-class devices where storage, memory, firmware, driver, and usability constraints require more careful sequencing.

## Typical use cases

- triaging an unknown low-resource Linux or Windows device before reinstalling
- documenting a legacy machine before role reassignment
- deciding whether to preserve, optimize, repurpose, or retire constrained hardware
- generating structured evidence before invasive rescue or migration decisions

## Repository structure

```text
docs/                                   Public documentation and operating notes
docs/professional-image/                Notes to align F1-F3 and this repository
shared/                                 Shared templates
shared/ip/                              Minimal IP-protection artifacts
stream7/stream7-linux-specialized/      Specialized Stream 7 Linux lane
multiplatform/linux-general/            General Linux lane
multiplatform/windows-ps5-general/      General Windows PowerShell 5+ lane
legacy/windows-ps4-general/             Legacy Windows PowerShell 4 lane
assets/                                 Publication assets
deploy.ps1                              Repository publication helper
.gitignore                              Repository hygiene rules
```

## Core methodology

1. **Inventory / Probe**
2. **Assessment**
3. **Recommendation framing**
4. **Controlled action**
5. **Reporting**
6. **Optional optimization review**

## Professional boundary

This repository is a **secondary public proof** of:
- constrained technical judgment
- rescue workflow discipline
- cross-platform inventory and reporting thinking
- install-path evaluation under limited conditions

It is **not**:
- an enterprise fleet-management system
- an official OEM recovery program
- a licensing bypass workflow
- a universal recovery guarantee
- a replacement for device-specific validation

## Reading order

1. `docs/executive-summary.md`
2. `docs/hardware-baseline.md`
3. `docs/install-path-matrix.md`
4. `docs/methodology.md`
5. `docs/AGNOSTIC_PLATFORM_STRATEGY.md`
6. platform-specific guides
7. `docs/IP_MINIMUM_PROTECTION_GUIDE.md`

## Recommended publication positioning

Use this repository as a **secondary public proof** behind the flagship architecture and seismic prototype surfaces.

---

Public technical reference maintained by Daniel Franco.
