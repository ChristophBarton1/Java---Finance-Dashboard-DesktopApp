@echo off
echo Starte BalanceFlow...
java --add-exports javafx.base/com.sun.javafx.event=ALL-UNNAMED --add-opens javafx.graphics/javafx.scene=ALL-UNNAMED -jar "C:\Users\Christoph\CascadeProjects\test projekt java\BalanceFlow\target\BalanceFlow-app.jar"
if %ERRORLEVEL% NEQ 0 (
   echo Fehler beim Starten! Bitte drücke eine Taste zum Beenden.
   pause
)
