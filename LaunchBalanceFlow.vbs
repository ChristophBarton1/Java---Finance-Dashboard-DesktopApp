Option Explicit

' VBScript zum versteckten Starten der BalanceFlow-App ohne Terminalfenster
Dim WshShell, ProjectDir, Command

' Projektverzeichnis ermitteln
ProjectDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)

' Befehl zusammenbauen - JavaW statt Java für unsichtbaren Start
Command = "javaw --add-exports javafx.base/com.sun.javafx.event=ALL-UNNAMED --add-opens javafx.graphics/javafx.scene=ALL-UNNAMED -jar """ & ProjectDir & "\target\BalanceFlow-app.jar"""

' WshShell-Objekt erstellen
Set WshShell = CreateObject("WScript.Shell")

' Arbeitsverzeichnis setzen
WshShell.CurrentDirectory = ProjectDir

' Anwendung ohne sichtbares Fenster starten (0 = versteckt)
WshShell.Run Command, 0, False

Set WshShell = Nothing
