<#
Safe reset utility.
Deletes only generated publish_snapshot folder.
Never touches documentation content.
#>
Write-Host "Performing safe reset..."
$target = "publish_snapshot"
if (Test-Path $target) {
    Remove-Item $target -Recurse -Force
    Write-Host "Removed: $target"
}
else {
    Write-Host "No reset required."
}
Write-Host "Safe reset completed."
