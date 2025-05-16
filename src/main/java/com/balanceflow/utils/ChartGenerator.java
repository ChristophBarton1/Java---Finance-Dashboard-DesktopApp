package com.balanceflow.utils;

import javafx.scene.Node;
import javafx.scene.chart.AreaChart;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.paint.Color;
import javafx.scene.paint.CycleMethod;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;

/**
 * Utility-Klasse zum Erstellen von Charts für die BalanceFlow-App
 */
public class ChartGenerator {
    
    /**
     * Erstellt ein monatliches Einnahmen/Ausgaben-Chart
     * 
     * @return Ein vorbereitetes AreaChart
     */
    public static AreaChart<Number, Number> createMonthlyChart() {
        // X-Achse für Tage des Monats
        NumberAxis xAxis = new NumberAxis(1, 30, 5);
        xAxis.setLabel("Tag des Monats");
        xAxis.setTickLabelFill(Color.WHITE);
        xAxis.setTickMarkVisible(false);
        
        // Y-Achse für Beträge
        NumberAxis yAxis = new NumberAxis(0, 5000, 1000);
        yAxis.setLabel("Betrag (€)");
        yAxis.setTickLabelFill(Color.WHITE);
        yAxis.setTickMarkVisible(false);
        
        // Chart erstellen
        AreaChart<Number, Number> areaChart = new AreaChart<>(xAxis, yAxis);
        areaChart.setLegendVisible(true);
        areaChart.setCreateSymbols(true);
        areaChart.setAnimated(true);
        
        // Einnahmen-Daten
        XYChart.Series<Number, Number> incomeSeries = new XYChart.Series<>();
        incomeSeries.setName("Einkommen");
        incomeSeries.getData().add(new XYChart.Data<>(1, 2800));
        incomeSeries.getData().add(new XYChart.Data<>(5, 2800));
        incomeSeries.getData().add(new XYChart.Data<>(10, 2800));
        incomeSeries.getData().add(new XYChart.Data<>(15, 4250));
        incomeSeries.getData().add(new XYChart.Data<>(20, 4250));
        incomeSeries.getData().add(new XYChart.Data<>(25, 4250));
        incomeSeries.getData().add(new XYChart.Data<>(30, 4250));
        
        // Ausgaben-Daten
        XYChart.Series<Number, Number> expenseSeries = new XYChart.Series<>();
        expenseSeries.setName("Ausgaben");
        expenseSeries.getData().add(new XYChart.Data<>(1, 0));
        expenseSeries.getData().add(new XYChart.Data<>(3, 820));
        expenseSeries.getData().add(new XYChart.Data<>(7, 1150));
        expenseSeries.getData().add(new XYChart.Data<>(12, 1350));
        expenseSeries.getData().add(new XYChart.Data<>(15, 1490));
        expenseSeries.getData().add(new XYChart.Data<>(19, 1950));
        expenseSeries.getData().add(new XYChart.Data<>(24, 2320));
        expenseSeries.getData().add(new XYChart.Data<>(28, 2850));
        
        // Daten dem Chart hinzufügen
        areaChart.getData().add(incomeSeries);
        areaChart.getData().add(expenseSeries);
        
        // Chart-Styling
        areaChart.setCreateSymbols(false);
        areaChart.setLegendVisible(true);
        
        // CSS-Styling anwenden
        areaChart.getStyleClass().add("monthly-chart");
        
        // Benutzerdefiniertes Styling für die Serien
        try {
            for (XYChart.Series<Number, Number> s : areaChart.getData()) {
                if (s.getName() != null && s.getName().equals("Einkommen")) {
                    if (s.getNode() != null) {
                        s.getNode().setStyle("-fx-stroke: #26DE81; -fx-stroke-width: 2;");
                        setAreaFill(s, Color.web("#26DE81", 0.4), Color.web("#26DE81", 0.0));
                    }
                } else if (s.getName() != null && s.getName().equals("Ausgaben")) {
                    if (s.getNode() != null) {
                        s.getNode().setStyle("-fx-stroke: #FC5C65; -fx-stroke-width: 2;");
                        setAreaFill(s, Color.web("#FC5C65", 0.4), Color.web("#FC5C65", 0.0));
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Fehler beim Styling des Charts: " + e.getMessage());
        }
        
        return areaChart;
    }
    
    /**
     * Setzt einen Gradienten-Farbverlauf für die Fläche unter der Linie
     */
    private static void setAreaFill(XYChart.Series<Number, Number> series, Color startColor, Color endColor) {
        try {
            if (series.getNode() != null) {
                Node fillNode = series.getNode().lookup(".chart-series-area-fill");
                if (fillNode != null) {
                    LinearGradient gradient = new LinearGradient(0, 0, 0, 1, true, CycleMethod.NO_CYCLE,
                            new Stop(0, startColor),
                            new Stop(1, endColor));
                    fillNode.setStyle("-fx-fill: " + toRGBA(gradient));
                }
            }
        } catch (Exception e) {
            System.err.println("Fehler beim Setzen des Farbverlaufs: " + e.getMessage());
        }
    }
    
    /**
     * Konvertiert einen Farbgradienten in einen CSS-String
     */
    private static String toRGBA(LinearGradient gradient) {
        StringBuilder sb = new StringBuilder();
        sb.append("linear-gradient(to bottom, ");
        
        for (int i = 0; i < gradient.getStops().size(); i++) {
            Stop stop = gradient.getStops().get(i);
            Color c = stop.getColor();
            
            sb.append(String.format("rgba(%d, %d, %d, %.2f) %.0f%%",
                    (int) (c.getRed() * 255),
                    (int) (c.getGreen() * 255),
                    (int) (c.getBlue() * 255),
                    c.getOpacity(),
                    stop.getOffset() * 100));
            
            if (i < gradient.getStops().size() - 1) {
                sb.append(", ");
            }
        }
        
        sb.append(")");
        return sb.toString();
    }
}
