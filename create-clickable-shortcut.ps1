$WshShell = New-Object -ComObject WScript.Shell
$ProjectDir = Split-Path $MyInvocation.MyCommand.Path
$DesktopPath = [Environment]::GetFolderPath("Desktop")

# Erstelle ein Startskript für die App
$startBatPath = "$ProjectDir\Start-BalanceFlow.bat"
$startBatContent = @"
@echo off
echo Starte BalanceFlow...
java --add-exports javafx.base/com.sun.javafx.event=ALL-UNNAMED --add-opens javafx.graphics/javafx.scene=ALL-UNNAMED -jar "$ProjectDir\target\BalanceFlow-app.jar"
if %ERRORLEVEL% NEQ 0 (
   echo Fehler beim Starten! Bitte drücke eine Taste zum Beenden.
   pause
)
"@
Set-Content -Path $startBatPath -Value $startBatContent -Force

# Erstelle die Desktop-Verknüpfung
$ShortcutPath = "$DesktopPath\BalanceFlow.lnk"
$Shortcut = $WshShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $startBatPath
$Shortcut.WorkingDirectory = $ProjectDir
$Shortcut.Description = "BalanceFlow - Persönliches Finanzmanagement"

# Setze ein schönes Icon (Standard-Windows-Geld-Icon)
$Shortcut.IconLocation = "Shell32.dll,277"
$Shortcut.Save()

Write-Host "Desktop-Verknüpfung wurde erfolgreich erstellt!"
Write-Host "Du findest sie auf deinem Desktop als 'BalanceFlow'"
