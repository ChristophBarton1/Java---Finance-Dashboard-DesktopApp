@echo off
echo ===================================================
echo BalanceFlow - Erstelle eigenständige Anwendung
echo ===================================================
echo.

set PROJECT_DIR=%~dp0
cd "%PROJECT_DIR%"

echo 1. Kompiliere das Projekt...
call mvn clean package
if %ERRORLEVEL% NEQ 0 (
    echo Fehler beim Kompilieren des Projekts!
    goto error
)

echo.
echo 2. Erstelle eigenständige Anwendung mit jlink...
call mvn javafx:jlink
if %ERRORLEVEL% NEQ 0 (
    echo Fehler beim Erstellen der eigenständigen Anwendung!
    goto error
)

echo.
echo 3. Erstelle Desktop-Verknüpfung zur eigenständigen Anwendung...

powershell -Command ^
  "$WshShell = New-Object -ComObject WScript.Shell; ^
   $Shortcut = $WshShell.CreateShortcut([Environment]::GetFolderPath('Desktop') + '\BalanceFlow Standalone.lnk'); ^
   $Shortcut.TargetPath = '%PROJECT_DIR%target\balanceflow-app\bin\balanceflow.bat'; ^
   $Shortcut.WorkingDirectory = '%PROJECT_DIR%target\balanceflow-app\bin'; ^
   $Shortcut.Description = 'BalanceFlow - Finanzmanagement-App'; ^
   $Shortcut.IconLocation = '%SystemRoot%\System32\shell32.dll,277'; ^
   $Shortcut.Save()"

echo.
echo 4. Kopiere zusätzlichen Starter...
copy /Y "%PROJECT_DIR%target\balanceflow-app\bin\balanceflow.bat" "%PROJECT_DIR%target\balanceflow-app\BalanceFlow.bat"

echo @echo off > "%PROJECT_DIR%target\BalanceFlow-Starter.bat"
echo start "" "%PROJECT_DIR%target\balanceflow-app\bin\balanceflow.bat" >> "%PROJECT_DIR%target\BalanceFlow-Starter.bat"

echo.
echo ===================================================
echo Fertig! Eigenständige Anwendung wurde erstellt.
echo.
echo Du kannst die Anwendung jetzt starten durch:
echo 1. Desktop-Verknüpfung "BalanceFlow Standalone"
echo 2. Doppelklick auf "%PROJECT_DIR%target\BalanceFlow-Starter.bat"
echo ===================================================

goto end

:error
echo.
echo ===================================================
echo FEHLER: Die Anwendung konnte nicht erstellt werden!
echo Bitte überprüfe deine Java-Installation und Maven-Konfiguration.
echo ===================================================

:end
pause
