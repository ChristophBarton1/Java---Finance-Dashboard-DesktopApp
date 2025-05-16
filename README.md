# BalanceFlow - Persönliches Finanzmanagement

BalanceFlow ist eine elegante Java-Desktop-Anwendung für persönliches Finanzmanagement mit einem modernen, ästhetischen UI-Design. Die Anwendung bietet eine übersichtliche Darstellung von Einnahmen, Ausgaben und Budgets.

## Features

- **Modernes Glasmorphismus-Design** mit fließenden Animationen und Farbübergängen
- **Finanzübersicht**: Visualisierung von Einnahmen, Ausgaben und Saldo
- **Monatliche Charts**: Grafische Darstellung der finanziellen Entwicklung
- **Budget-Tracking**: Überwachung von Budget-Zielen mit visuellen Fortschrittsbalken
- **Transaktionsverwaltung**: Übersichtliche Liste der letzten Transaktionen

## Technologien

- Java 17
- JavaFX für die Benutzeroberfläche
- MaterialFX für moderne UI-Komponenten
- JFreeChart für Diagramme und Graphen
- AnimateFX für animierte UI-Elemente
- H2 Datenbank für Datenspeicherung

## Ausführen der Anwendung

### Voraussetzungen

- Java 17 JDK
- Maven

### Anwendung starten

1. Wechsle in das Projektverzeichnis:
   ```
   cd "BalanceFlow"
   ```

2. Kompiliere und starte die Anwendung mit Maven:
   ```
   mvn clean javafx:run
   ```

## Projektstruktur

- `src/main/java/com/balanceflow/` - Java-Quellcode
  - `controllers/` - Controller für die UI-Logik
  - `models/` - Datenmodelle
  - `utils/` - Hilfsfunktionen und -klassen
  - `views/` - View-spezifische Klassen
- `src/main/resources/` - Ressourcen
  - `css/` - Stylesheet-Dateien
  - `fxml/` - FXML Layout-Dateien
  - `images/` - Bild-Assets

## Design-Highlights

- **Elegante Farbpalette**: Dunkles Theme mit leuchtenden Akzentfarben
- **Glasmorphismus-Effekte**: Transluzente Karten mit sanften Schatten
- **Intuitive Navigation**: Übersichtliche Sidebar mit klaren, interaktiven Icons
- **Responsive UI**: Ansprechende Benutzeroberfläche mit konsistenter Darstellung
- **Datenkarten**: Attraktive, informative Karten zur Darstellung wichtiger Finanzdaten
