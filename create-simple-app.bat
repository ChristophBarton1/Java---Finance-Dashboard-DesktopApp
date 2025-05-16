@echo off
echo ===================================================
echo BalanceFlow - Erstelle einfache Anwendung
echo ===================================================
echo.

set PROJECT_DIR=%~dp0
cd "%PROJECT_DIR%"

echo 1. Kompiliere und paketiere die Anwendung...
call mvn clean package
if %ERRORLEVEL% NEQ 0 (
    echo Fehler beim Kompilieren des Projekts!
    goto error
)

echo.
echo 2. Erstelle Startskript...

echo @echo off > "%PROJECT_DIR%\BalanceFlow-Start.bat"
echo echo Starte BalanceFlow... >> "%PROJECT_DIR%\BalanceFlow-Start.bat"
echo set JAVA_OPTS=--add-exports javafx.base/com.sun.javafx.event=ALL-UNNAMED --add-opens javafx.graphics/javafx.scene=ALL-UNNAMED >> "%PROJECT_DIR%\BalanceFlow-Start.bat"
echo java %%JAVA_OPTS%% -jar "%PROJECT_DIR%\target\BalanceFlow-app.jar" >> "%PROJECT_DIR%\BalanceFlow-Start.bat"
echo if %%ERRORLEVEL%% NEQ 0 ( >> "%PROJECT_DIR%\BalanceFlow-Start.bat"
echo    echo Fehler beim Starten der Anwendung! >> "%PROJECT_DIR%\BalanceFlow-Start.bat"
echo    pause >> "%PROJECT_DIR%\BalanceFlow-Start.bat"
echo ) >> "%PROJECT_DIR%\BalanceFlow-Start.bat"

echo.
echo 3. Erstelle Desktop-Verknüpfung...

powershell -Command ^
  "$WshShell = New-Object -ComObject WScript.Shell; ^
   $Shortcut = $WshShell.CreateShortcut([Environment]::GetFolderPath('Desktop') + '\BalanceFlow.lnk'); ^
   $Shortcut.TargetPath = '%PROJECT_DIR%\BalanceFlow-Start.bat'; ^
   $Shortcut.WorkingDirectory = '%PROJECT_DIR%'; ^
   $Shortcut.Description = 'BalanceFlow - Finanzmanagement'; ^
   $Shortcut.IconLocation = 'shell32.dll,277'; ^
   $Shortcut.Save()"

echo.
echo ===================================================
echo Fertig! BalanceFlow wurde erstellt.
echo.
echo Du kannst die Anwendung jetzt starten durch:
echo 1. Desktop-Verknüpfung "BalanceFlow"
echo 2. Doppelklick auf "BalanceFlow-Start.bat" im Projektordner
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
