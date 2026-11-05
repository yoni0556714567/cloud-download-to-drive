# Downloads a link / magnet and moves the result to Google Drive, then cleans up locally.
param([string]$Link)

$Remote = "mydrive:Downloads"   # rclone remote name : folder in Drive
$Temp = Join-Path $env:USERPROFILE "dl_temp"

if (-not $Link) { $Link = Read-Host "Paste link or magnet" }
if (-not $Link) { Write-Host "No link given."; exit 1 }

foreach ($tool in @("aria2c", "rclone")) {
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) {
        Write-Host "$tool not found. Run setup.ps1 first (and reopen the terminal)."
        exit 1
    }
}

New-Item -ItemType Directory -Force -Path $Temp | Out-Null

Write-Host "Downloading..."
aria2c -x 16 -s 16 -k 1M --seed-time=0 --file-allocation=none -d $Temp $Link
if ($LASTEXITCODE -ne 0) { Write-Host "Download failed."; exit 1 }

Write-Host "Uploading to Google Drive..."
rclone move $Temp $Remote --progress --delete-empty-src-dirs
if ($LASTEXITCODE -ne 0) { Write-Host "Upload failed. Files remain in $Temp"; exit 1 }

Write-Host "Done. Files are in Drive folder: $Remote"
