@echo off
setlocal

echo BalanceFlow Debug-Modus
echo =============================================
echo Dieses Fenster bleibt offen, um Fehler anzuzeigen
echo =============================================
echo.

REM Verzeichnis des Scripts ermitteln
set SCRIPT_DIR=%~dp0

REM Pfad zur JAR-Datei
set JAR_PATH=%SCRIPT_DIR%target\BalanceFlow-1.0-SNAPSHOT.jar

echo Starte BalanceFlow-Debug...
echo Anwendungspfad: %JAR_PATH%
echo.

REM Prüfen, ob die JAR-Datei existiert
if not exist "%JAR_PATH%" (
    echo FEHLER: JAR-Datei konnte nicht gefunden werden!
    echo Gesucht wird: %JAR_PATH%
    echo.
    echo Bitte stelle sicher, dass du "mvn clean package" ausgeführt hast.
    goto end
)

echo Extrahiere alle notwendigen Abhängigkeiten...
cd "%SCRIPT_DIR%"
call mvn dependency:copy-dependencies
echo.

echo Versuch 1: Mit explizitem JavaFX-Modulpfad starten...
echo java --module-path "%SCRIPT_DIR%target\dependency" --add-modules javafx.controls,javafx.fxml,javafx.graphics -jar "%JAR_PATH%"
java --module-path "%SCRIPT_DIR%target\dependency" --add-modules javafx.controls,javafx.fxml,javafx.graphics -jar "%JAR_PATH%"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Versuch 1 fehlgeschlagen. Fehlercode: %ERRORLEVEL%
    echo.
    echo Versuch 2: Mit einfacheren JavaFX-Optionen starten...
    echo java --module-path "%SCRIPT_DIR%target\dependency" --add-modules ALL-MODULE-PATH -jar "%JAR_PATH%"
    java --module-path "%SCRIPT_DIR%target\dependency" --add-modules ALL-MODULE-PATH -jar "%JAR_PATH%"
    
    if %ERRORLEVEL% NEQ 0 (
        echo.
        echo Versuch 2 fehlgeschlagen. Fehlercode: %ERRORLEVEL%
        echo.
        echo Versuch 3: Direkter JAR-Aufruf...
        echo java -jar "%JAR_PATH%"
        java -jar "%JAR_PATH%"
        
        if %ERRORLEVEL% NEQ 0 (
            echo.
            echo Alle Versuche fehlgeschlagen. Bitte überprüfe deine Java-Installation!
            echo Java-Version:
            java -version
        )
    )
)

:end
echo.
echo =============================================
echo Debug-Prozess beendet. Bitte oben stehende Fehler überprüfen.
echo =============================================
pause
