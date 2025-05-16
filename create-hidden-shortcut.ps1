$WshShell = New-Object -ComObject WScript.Shell
$ProjectDir = Split-Path $MyInvocation.MyCommand.Path
$DesktopPath = [Environment]::GetFolderPath("Desktop")

# Desktop-Verknüpfung erstellen, die direkt auf die VBScript zeigt
$ShortcutPath = "$DesktopPath\BalanceFlow (ohne Terminal).lnk"
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "$ProjectDir\LaunchBalanceFlow.vbs"
$Shortcut.WorkingDirectory = $ProjectDir
$Shortcut.Description = "BalanceFlow - Persönliches Finanzmanagement (ohne Terminalfenster)"

# Setze ein schönes Icon (Standard-Windows-Geld-Icon)
$Shortcut.IconLocation = "Shell32.dll,277"
$Shortcut.Save()

Write-Host "Desktop-Verknüpfung ohne Terminal wurde erfolgreich erstellt!"
Write-Host "Du findest sie auf deinem Desktop als 'BalanceFlow (ohne Terminal)'"
Write-Host "Wenn du auf dieses Symbol klickst, startet die App ohne zusätzliches Terminalfenster."
