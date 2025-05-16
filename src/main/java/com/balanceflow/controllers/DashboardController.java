package com.balanceflow.controllers;

import animatefx.animation.*;
import com.balanceflow.utils.ChartGenerator;
import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.chart.AreaChart;
import javafx.scene.control.Label;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Region;
import javafx.scene.layout.VBox;
import javafx.animation.FadeTransition;
import javafx.animation.KeyFrame;
import javafx.animation.KeyValue;
import javafx.animation.Timeline;
import javafx.beans.property.IntegerProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.scene.control.ProgressBar;
import javafx.util.Duration;

import java.net.URL;
import java.util.ResourceBundle;

public class DashboardController implements Initializable {

    @FXML
    private VBox chartContainer;
    
    @FXML
    private Region chartPlaceholder;
    
    @FXML
    private HBox summaryCards;
    
    @FXML
    private VBox budgetProgressContainer;
    
    @FXML
    private VBox recentTransactions;
    
    // Fortschrittsbalken
    @FXML
    private ProgressBar foodProgress;
    
    @FXML
    private ProgressBar housingProgress;
    
    @FXML
    private ProgressBar entertainmentProgress;
    
    // Für Geldbetrags-Animation
    @FXML
    private Label incomeAmount;
    
    @FXML
    private Label expenseAmount;
    
    @FXML
    private Label balanceAmount;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        // Dashboard mit Daten und Diagrammen initialisieren
        System.out.println("Dashboard wird initialisiert...");
        
        // Animations-Sequenz verzögern, um UI-Aufbau abzuwarten
        Platform.runLater(this::startAnimationSequence);
    }
    
    /**
     * Startet die Sequenz aller Dashboard-Animationen
     */
    private void startAnimationSequence() {
        // Hauptcontainer mit Fade-In einblenden
        if (summaryCards != null) {
            summaryCards.setOpacity(0);
            new FadeIn(summaryCards).setDelay(Duration.millis(300)).play();
            
            // Animiere die Geldbetrag-Labels
            animateMoneyCounter(incomeAmount, 0, 4250);
            animateMoneyCounter(expenseAmount, 0, 2850.75);
            animateMoneyCounter(balanceAmount, 0, 1399.25);
        }
        
        // Chart mit Verzögerung initialisieren und einblenden
        initChart();
        
        // Budgetbereich mit Verzögerung animieren
        if (budgetProgressContainer != null) {
            budgetProgressContainer.setOpacity(0);
            new FadeInUp(budgetProgressContainer).setDelay(Duration.millis(800)).play();
            
            // Fortschrittsbalken-Animation verzögert starten
            Platform.runLater(() -> {
                animateProgressBar(foodProgress, 0.7, 1500);
                animateProgressBar(housingProgress, 1.0, 1800);
                animateProgressBar(entertainmentProgress, 0.6, 2100);
            });
        }
        
        // Transaktionsbereich mit Pulse-Effekt
        if (recentTransactions != null) {
            recentTransactions.setOpacity(0);
            new FadeInRight(recentTransactions).setDelay(Duration.millis(1200)).play();
            
            // Nacheinander die Transaktionen einblenden
            int delay = 1500;
            for (Node node : recentTransactions.getChildren()) {
                if (node instanceof HBox) {
                    node.setOpacity(0);
                    new Pulse(node).setDelay(Duration.millis(delay)).play();
                    delay += 300;
                }
            }
        }
    }
    
    /**
     * Animiert einen Fortschrittsbalken von 0 zum Zielwert
     */
    private void animateProgressBar(ProgressBar bar, double targetValue, int durationMs) {
        if (bar != null) {
            bar.setProgress(0);
            Timeline timeline = new Timeline(
                new KeyFrame(Duration.ZERO, new KeyValue(bar.progressProperty(), 0)),
                new KeyFrame(Duration.millis(durationMs), new KeyValue(bar.progressProperty(), targetValue))
            );
            timeline.play();
        }
    }
    
    /**
     * Animiert ein Geldbetrags-Label mit Zählereffekt
     */
    private void animateMoneyCounter(Label label, double from, double to) {
        if (label == null) return;
        
        // Property für die Animation
        IntegerProperty count = new SimpleIntegerProperty((int)(from * 100));
        int target = (int)(to * 100);
        
        // Bei Änderung aktualisieren
        count.addListener((observable, oldValue, newValue) -> {
            double value = newValue.doubleValue() / 100.0;
            label.setText(String.format("%,.2f", value).replace('.', ',') + " €");
        });
        
        // Animation erstellen
        Timeline timeline = new Timeline(
            new KeyFrame(Duration.ZERO, new KeyValue(count, (int)(from * 100))),
            new KeyFrame(Duration.millis(2000), new KeyValue(count, target))
        );
        timeline.play();
    }
    
    /**
     * Initialisiert und zeigt das monatliche Chart an
     */
    private void initChart() {
        if (chartContainer != null && chartPlaceholder != null) {
            // Chart-Container erst mit Animation einblenden
            chartContainer.setOpacity(0);
            new FadeInUp(chartContainer).setDelay(Duration.millis(600)).play();
            
            // Chart generieren
            AreaChart<Number, Number> monthlyChart = ChartGenerator.createMonthlyChart();
            monthlyChart.setPrefHeight(200);
            monthlyChart.setMaxHeight(Double.MAX_VALUE);
            monthlyChart.setAnimated(true);
            
            // Chart mit Animation einblenden
            monthlyChart.setOpacity(0);
            
            // Platzhalter entfernen und Chart hinzufügen
            chartContainer.getChildren().remove(chartPlaceholder);
            chartContainer.getChildren().add(monthlyChart);
            
            // Fade-in Animation mit Verzögerung
            FadeTransition fadeIn = new FadeTransition(Duration.seconds(1.5), monthlyChart);
            fadeIn.setFromValue(0);
            fadeIn.setToValue(1);
            fadeIn.setDelay(Duration.millis(800));
            fadeIn.play();
        }
    }
    
    @FXML
    private void handleExit() {
        Platform.exit();
    }
    
    @FXML
    private void showDashboard() {
        System.out.println("Dashboard anzeigen");
        // Speichern des aktiven Buttons
        animateButtonClick(0);
    }
    
    @FXML
    private void showTransactions() {
        System.out.println("Transaktionen anzeigen");
        // Speichern des aktiven Buttons
        animateButtonClick(1);
    }
    
    @FXML
    private void showBudgets() {
        System.out.println("Budgets anzeigen");
        // Speichern des aktiven Buttons
        animateButtonClick(2);
    }
    
    @FXML
    private void showSettings() {
        System.out.println("Einstellungen anzeigen");
        // Speichern des aktiven Buttons
        animateButtonClick(3);
    }
    
    /**
     * Animiert den Klick eines Navigationsbuttons
     */
    private void animateButtonClick(int buttonIndex) {
        // In einer vollständigen Implementierung würden wir hier die Menüs wechseln
        // und den aktiven Button visuell hervorheben
        // Für diese Demo nur Animation hinzufügen
        new Pulse(summaryCards).play();
    }
}
