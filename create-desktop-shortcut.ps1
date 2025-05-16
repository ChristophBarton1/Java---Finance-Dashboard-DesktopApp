$CurrentDir = Split-Path $MyInvocation.MyCommand.Path

# 1. Icon aus dem Jar-Symbol extrahieren oder Standard-Java-Icon verwenden
$IconPath = "$CurrentDir\BalanceFlow-icon.ico"
if (-Not (Test-Path $IconPath)) {
    # Da wir kein echtes Icon haben, verwenden wir das Java-Icon (falls vorhanden)
    $JavaHome = [Environment]::GetEnvironmentVariable("JAVA_HOME", "Machine")
    if ($JavaHome -and (Test-Path "$JavaHome\bin\java.exe")) {
        # Java-Icon extrahieren
        Write-Host "Java-Installation gefunden, nutze Java-Icon..."
        # Icon vom Java-Executable wird verwendet
        $JavaExe = "$JavaHome\bin\java.exe"
    } else {
        # Fallback auf Standard-Icon (kann angepasst werden)
        $JavaExe = "C:\Windows\System32\mstsc.exe"
        Write-Host "Kein Java-Icon gefunden, verwende Standard-Icon..."
    }
    # Icon-Pfad setzen
    $IconPath = $JavaExe
}

# 2. Batch-Datei erstellen
$BatchPath = "$CurrentDir\BalanceFlow.bat"
$BatchContent = @"
@echo off
echo Starte BalanceFlow...
start javaw -jar "$CurrentDir\target\BalanceFlow-1.0-SNAPSHOT.jar"
"@
Set-Content -Path $BatchPath -Value $BatchContent -Encoding ASCII

# 3. Desktop-Verknüpfung erstellen
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\BalanceFlow.lnk")
$Shortcut.TargetPath = $BatchPath
$Shortcut.WorkingDirectory = $CurrentDir
$Shortcut.IconLocation = "$IconPath,0"
$Shortcut.Description = "BalanceFlow - Persönliches Finanzmanagement mit Dark Mode"
$Shortcut.Save()

Write-Host "Desktop-Verknüpfung für BalanceFlow wurde erstellt!"
Write-Host "Du findest sie auf deinem Desktop als 'BalanceFlow'"
