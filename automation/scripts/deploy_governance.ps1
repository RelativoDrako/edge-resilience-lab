<#
Deploys governance marker files if missing.
Does not overwrite existing files.
#>
Write-Host "Deploying governance scaffolding..."
$files = @(
    "docs\governance\risk-register.md",
    "docs\governance\threat-model.md",
    "docs\governance\compliance-matrix.md",
    "docs\governance\audit-readiness.md"
)
foreach ($file in $files) {
    if (-not (Test-Path $file)) {
        "# Placeholder governance document" | Out-File $file -Encoding UTF8
        Write-Host "Created: $file"
    }
    else {
        Write-Host "Exists:  $file"
    }
}
Write-Host "Governance scaffolding deployed."
