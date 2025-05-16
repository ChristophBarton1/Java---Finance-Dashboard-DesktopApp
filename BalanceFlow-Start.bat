@echo off 
echo Starte BalanceFlow... 
set JAVA_OPTS=--add-exports javafx.base/com.sun.javafx.event=ALL-UNNAMED --add-opens javafx.graphics/javafx.scene=ALL-UNNAMED 
java %JAVA_OPTS% -jar "C:\Users\Christoph\CascadeProjects\test projekt java\BalanceFlow\\target\BalanceFlow-app.jar" 
if %ERRORLEVEL% NEQ 0 ( 
   echo Fehler beim Starten der Anwendung! 
   pause 
) 
