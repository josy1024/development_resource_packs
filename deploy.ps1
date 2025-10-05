$base = $PSSCRIPTROOT
$destination = "C:\MineCraft\bedrock-server-latest\development_resource_packs"

# Get all directories and files excluding .git folders
$items = Get-ChildItem -Path $base -Recurse -Force | Where-Object {
    -not $_.FullName.Contains(".git")
}

foreach ($item in $items) {
    $targetPath = $item.FullName.Replace($base, $destination)
    Write-RelaxedIT $targetPath
    if ($item.PSIsContainer) {
        # Create directory if it doesn't exist
        if (-not (Test-Path $targetPath)) {
            New-Item -ItemType Directory -Path $targetPath | Out-Null
        }
    } else {
        # Copy file
        Copy-Item -Path $item.FullName -Destination $targetPath -Force
    }
}

explorer.exe $destination