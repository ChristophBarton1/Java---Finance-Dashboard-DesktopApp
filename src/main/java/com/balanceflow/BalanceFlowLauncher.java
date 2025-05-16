package com.balanceflow;

/**
 * Launcher-Klasse für BalanceFlow
 * 
 * Diese Klasse dient als Einstiegspunkt für die eigenständige JAR-Datei.
 * Sie leitet einfach an die Hauptanwendungsklasse weiter, verhindert aber
 * Probleme bei der Modulerkennung.
 */
public class BalanceFlowLauncher {
    
    /**
     * Hauptmethode zum Starten der Anwendung
     */
    public static void main(String[] args) {
        System.out.println("Starte BalanceFlow...");
        BalanceFlowApp.main(args);
    }
}
