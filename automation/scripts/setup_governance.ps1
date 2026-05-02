<#
Idempotent repository scaffolding.
Creates required folders if missing.
Never deletes existing content.
#>
Write-Host "Ensuring repository folder structure..."
$folders = @(
    "docs\architecture",
    "docs\adrs",
    "docs\governance",
    "docs\operations",
    "docs\testing",
    "automation\scripts",
    "automation\one-click",
    "examples\minimal-edge-node",
    "examples\degraded-mode-demo",
    "diagrams\C4",
    "diagrams\SysML",
    "manual-out-of-system-continuity\guidance",
    "manual-out-of-system-continuity\templates",
    ".github\workflows"
)
foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
        Write-Host "Created: $folder"
    }
    else {
        Write-Host "Exists:  $folder"
    }
}
Write-Host "Structure verification completed."
