<#
Creates a clean publication snapshot.
Does not modify working files.
Outputs to /publish_snapshot
#>
Write-Host "Preparing clean publication snapshot..."
$root = Get-Location
$target = Join-Path $root "publish_snapshot"
if (Test-Path $target) {
    Remove-Item $target -Recurse -Force
}
New-Item -ItemType Directory -Path $target | Out-Null
Copy-Item "$root\*" $target -Recurse -Force -Exclude "publish_snapshot"
Write-Host "Publish snapshot created at:"
Write-Host $target
