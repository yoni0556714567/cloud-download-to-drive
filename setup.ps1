# One-time setup: installs aria2 (downloader) and rclone (Google Drive uploader)
Write-Host "Installing aria2..."
winget install -e --id aria2.aria2 --accept-source-agreements --accept-package-agreements

Write-Host "Installing rclone..."
winget install -e --id Rclone.Rclone --accept-source-agreements --accept-package-agreements

Write-Host ""
Write-Host "Done. Now CLOSE this window, open a new PowerShell, and run:  rclone config"
Write-Host "Create a new remote named:  mydrive   (type: drive)"
Write-Host "See README.md for the exact steps."
