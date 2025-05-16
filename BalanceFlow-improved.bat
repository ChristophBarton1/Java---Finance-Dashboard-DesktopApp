@echo off
setlocal

REM Verzeichnis des Scripts ermitteln
set SCRIPT_DIR=%~dp0

REM Pfad zur JAR-Datei
set JAR_PATH=%SCRIPT_DIR%target\BalanceFlow-1.0-SNAPSHOT.jar

echo Starte BalanceFlow...
echo Anwendungspfad: %JAR_PATH%

REM Prüfen, ob die JAR-Datei existiert
if not exist "%JAR_PATH%" (
    echo FEHLER: JAR-Datei konnte nicht gefunden werden!
    echo Gesucht wird: %JAR_PATH%
    echo.
    echo Bitte stelle sicher, dass du "mvn clean package" ausgeführt hast.
    pause
    exit /b 1
)

REM Mit javaw starten (ohne Konsolenfenster)
start "" javaw ^
  --module-path "%SCRIPT_DIR%target\dependency" ^
  --add-modules javafx.controls,javafx.fxml ^
  --add-exports javafx.base/com.sun.javafx.event=ALL-UNNAMED ^
  --add-opens javafx.graphics/javafx.scene=ALL-UNNAMED ^
  -jar "%JAR_PATH%"

if %ERRORLEVEL% NEQ 0 (
    echo FEHLER: Die Anwendung konnte nicht gestartet werden.
    echo Versuche alternativen Startbefehl...
    
    REM Zweiter Versuch mit einfacherem Befehl
    start "" java -jar "%JAR_PATH%"
    
    if %ERRORLEVEL% NEQ 0 (
        echo FEHLER: Auch der alternative Startbefehl ist fehlgeschlagen.
        echo Bitte überprüfe deine Java-Installation!
        pause
    )
)

endlocal
