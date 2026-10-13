<div align="center">

# BalanceFlow

**A personal finance desktop dashboard built with JavaFX: income, expenses, balance and budgets at a glance.**

[![Java](https://img.shields.io/badge/Java-17-ED8B00?style=flat-square&logo=openjdk&logoColor=white)](https://openjdk.org)
[![JavaFX](https://img.shields.io/badge/JavaFX-17-007396?style=flat-square&logo=java&logoColor=white)](https://openjfx.io)
[![Maven](https://img.shields.io/badge/Maven-C71A36?style=flat-square&logo=apachemaven&logoColor=white)](https://maven.apache.org)
[![FXML + CSS](https://img.shields.io/badge/FXML_%2B_CSS-1572B6?style=flat-square&logo=css3&logoColor=white)](src/main/resources)
[![Windows](https://img.shields.io/badge/Windows-launchers-0078D6?style=flat-square&logo=windows&logoColor=white)](#-getting-started)

</div>

## About

BalanceFlow is a Java desktop application for personal finance management with a strong focus on
visual design. It presents income, expenses and balance as animated summary cards, a monthly area
chart, budget progress bars and a recent-transactions list, all inside a frameless, draggable,
dark-themed window. The current version is a **UI prototype driven by sample data**; it showcases
JavaFX layout, styling and animation work rather than a finished bookkeeping backend.

## ✨ Features

- **Summary cards**: income, expenses and balance with an animated count-up effect and month-over-month indicators.
- **Monthly overview chart**: a JavaFX `AreaChart` with gradient fills comparing income and expenses across the month.
- **Budget tracking**: per-category progress bars (groceries, housing, entertainment) that animate to their fill level.
- **Recent transactions**: a styled list of the latest income and expense entries with staggered entry animations.
- **Polished window chrome**: frameless, transparent `Stage` with custom drag handling, sidebar navigation and a custom close button.
- **Motion design**: staged fade, slide and pulse animations via AnimateFX plus JavaFX `Timeline` transitions.
- **Windows convenience scripts**: batch/PowerShell helpers to build a fat JAR, run the app and create desktop shortcuts.

> The UI labels are currently in German (e.g. *Einkommen*, *Ausgaben*, *Saldo*).

## 🧱 Tech stack

| Area | Choice |
| --- | --- |
| Language | Java 17 (JPMS module `com.balanceflow`) |
| UI | JavaFX 17 (controls, FXML, charts), custom CSS theme |
| Animation | AnimateFX, JavaFX `Timeline` / `FadeTransition` |
| Build | Maven, `javafx-maven-plugin`, `maven-assembly-plugin` (jar-with-dependencies) |
| Declared for upcoming work | H2 (local persistence), MaterialFX, JFreeChart |

## 🏗️ How it works

The app follows a simple **FXML + controller** structure:

- `BalanceFlowApp` loads `fxml/Dashboard.fxml`, sets up a transparent, draggable stage and shows a friendly error dialog if startup fails.
- `BalanceFlowLauncher` is a plain `main` entry point so the app can run from a fat JAR without JavaFX module-path issues.
- `DashboardController` wires the FXML nodes and runs the animation sequence (cards → chart → budgets → transactions).
- `ChartGenerator` builds and styles the monthly income/expense `AreaChart`.
- `Transaction` is the domain model for future data-driven views.

## 🚀 Getting started

**Prerequisites:** JDK 17+ and Maven.

```bash
# Run in development mode
mvn clean javafx:run

# Build a standalone fat JAR (target/BalanceFlow-app.jar)
mvn clean package
java -jar target/BalanceFlow-app.jar
```

On Windows, `build-standalone-app.bat` and the `create-*-shortcut.ps1` scripts automate building and
creating a desktop shortcut. Some of the launcher `.bat` files contain machine-specific paths and may
need adjusting before use.

## 📁 Project structure

```
src/main/java/
  module-info.java
  com/balanceflow/
    BalanceFlowApp.java        JavaFX Application (stage, scene, error handling)
    BalanceFlowLauncher.java   fat-JAR entry point
    controllers/               DashboardController (animations, navigation)
    models/                    Transaction
    utils/                     ChartGenerator
src/main/resources/
  fxml/Dashboard.fxml          dashboard layout
  css/style.css                dark theme, cards, gradients
  images/app-icon.ico          application icon
*.bat, *.ps1, *.vbs            Windows build/launch/shortcut helpers
```

## 🗺️ Roadmap

- Persist transactions and budgets locally with H2.
- Make the Transactions, Budgets and Settings views functional (navigation currently stays on the dashboard).
- Add data entry, categories and CSV import.
- English localisation of the UI.

---

<div align="center">

Built by [Christoph Barton](https://christophbarton.com)

</div>
