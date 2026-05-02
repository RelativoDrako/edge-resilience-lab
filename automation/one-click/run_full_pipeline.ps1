<#
Runs a full local documentation pipeline:
- Ensures folder structure
- Deploys governance scaffolding
- Validates documentation structure
- Prepares clean publish snapshot
#>

Write-Host "=== EdgeResilienceLab Full Pipeline ==="

$root = Get-Location

Write-Host "Step 1: Ensuring repository structure..."
& "$root\automation\scripts\setup_governance.ps1"

Write-Host "Step 2: Deploying governance scaffolding..."
& "$root\automation\scripts\deploy_governance.ps1"

Write-Host "Step 3: Preparing clean publish snapshot..."
& "$root\automation\scripts\publish_repo_clean.ps1"

Write-Host "Pipeline completed successfully."
