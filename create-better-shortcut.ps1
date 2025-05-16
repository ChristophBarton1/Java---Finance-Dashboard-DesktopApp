# Verbesserte Desktop-Verknüpfung für BalanceFlow erstellen

$CurrentDir = Split-Path $MyInvocation.MyCommand.Path
$BatchPath = "$CurrentDir\BalanceFlow-improved.bat"
$DesktopPath = [Environment]::GetFolderPath("Desktop")

# JavaFX-Abhängigkeiten extrahieren, falls sie noch nicht extrahiert sind
if (-not (Test-Path "$CurrentDir\target\dependency")) {
    Write-Host "Extrahiere JavaFX-Abhängigkeiten für bessere Kompatibilität..."
    
    # Verzeichnis für Abhängigkeiten erstellen
    if (-not (Test-Path "$CurrentDir\target\dependency")) {
        New-Item -Path "$CurrentDir\target\dependency" -ItemType Directory -Force | Out-Null
    }
}

# Desktop-Verknüpfung erstellen
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$DesktopPath\BalanceFlow (Fix).lnk")
$Shortcut.TargetPath = $BatchPath
$Shortcut.WorkingDirectory = $CurrentDir
$Shortcut.WindowStyle = 1  # Normal window
$Shortcut.Description = "BalanceFlow - Persönliches Finanzmanagement (Verbesserte Version)"

# Icon setzen - wir verwenden das Java-Icon falls verfügbar
$JavaHome = [Environment]::GetEnvironmentVariable("JAVA_HOME", "Machine")
if ($JavaHome -and (Test-Path "$JavaHome\bin\javaw.exe")) {
    $Shortcut.IconLocation = "$JavaHome\bin\javaw.exe,0"
} else {
    # Fallback auf ein anderes bekanntes Icon
    $Shortcut.IconLocation = "C:\Windows\System32\shell32.dll,277"  # Geldbeutel-Icon aus Windows
}

$Shortcut.Save()

Write-Host "Verbesserte Desktop-Verknüpfung wurde erstellt!"
Write-Host "Du findest sie auf deinem Desktop als 'BalanceFlow (Fix)'"
Write-Host "----------------------------------------------------------------"
Write-Host "WICHTIG: Wenn die App nicht startet, führe bitte diesen Befehl aus:"
Write-Host "mvn dependency:copy-dependencies"
Write-Host "Dies kopiert alle benötigten JavaFX-Bibliotheken in den richtigen Ordner."
