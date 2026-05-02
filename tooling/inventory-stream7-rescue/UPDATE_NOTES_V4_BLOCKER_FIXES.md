# Update Notes V4 — Blocker Fixes

## Corrected blockers

1. **Menu exit fixed**
   - `0) Exit` now leaves the interactive loop correctly in both Windows launchers.
   - Root cause: `break` inside `switch` did not reliably terminate the surrounding `while` menu loop.

2. **PS5 probe completion fixed**
   - Reworked battery section generation in `multiplatform/windows-ps5-general/scripts/10_probe.ps1`.
   - Root cause: inline `if` embedded inside a concatenation expression is invalid PowerShell syntax.

## Additional hardening applied

- Added `Get-CimSafe` and `Get-SectionText` helpers to reduce probe fragility when a WMI/CIM class is unavailable.
- Hardened `report` so it can still render a bounded output even if `assess` has not yet been run.
- Added assessment status visibility in the PS5 operational flow/report path.
- Added a small PS4 report note so operators do not over-trust outputs without assessment.

## Remaining items recommended for fine-tuning in the next iteration

- Validate menu behavior and `Pause` interaction directly on the target Windows host.
- Review whether `Get-WindowsOptionalFeature -Online` should stay optional/non-admin or be downgraded to a safer query path.
- Decide whether `report` should auto-trigger `assess` or remain strictly non-mutating and dependency-explicit.
- Review probe scope/performance on slower devices because `Win32_PnPSignedDriver` and large app inventories can be expensive.
