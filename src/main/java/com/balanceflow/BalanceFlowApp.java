package com.balanceflow;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

import java.io.IOException;
import java.net.URL;

public class BalanceFlowApp extends Application {

    private double xOffset = 0;
    private double yOffset = 0;

    @Override
    public void start(Stage primaryStage) {
        try {
            // FXML-Ressource korrekt laden
            URL fxmlUrl = getClass().getResource("/fxml/Dashboard.fxml");
            if (fxmlUrl == null) {
                throw new IOException("FXML-Datei konnte nicht gefunden werden: /fxml/Dashboard.fxml");
            }
            
            FXMLLoader loader = new FXMLLoader(fxmlUrl);
            Parent root = loader.load();
            
            // Für Drag-Funktion des Fensters
            root.setOnMousePressed(event -> {
                xOffset = event.getSceneX();
                yOffset = event.getSceneY();
            });
            
            root.setOnMouseDragged(event -> {
                primaryStage.setX(event.getScreenX() - xOffset);
                primaryStage.setY(event.getScreenY() - yOffset);
            });

            Scene scene = new Scene(root);
            scene.setFill(Color.TRANSPARENT);
            
            primaryStage.setTitle("BalanceFlow");
            primaryStage.setScene(scene);
            primaryStage.initStyle(StageStyle.TRANSPARENT);
            primaryStage.show();
            
            System.out.println("BalanceFlow wurde erfolgreich gestartet.");
        } catch (Exception e) {
            showErrorAndExit("Anwendungsfehler", "Die Anwendung konnte nicht gestartet werden.", e);
        }
    }
    
    /**
     * Zeigt eine Fehlermeldung an und beendet die Anwendung
     */
    private void showErrorAndExit(String title, String message, Exception e) {
        System.err.println(message + " Fehler: " + e.getMessage());
        e.printStackTrace();
        
        Platform.runLater(() -> {
            Alert alert = new Alert(AlertType.ERROR);
            alert.setTitle(title);
            alert.setHeaderText(null);
            alert.setContentText(message + "\n\nFehler: " + e.getMessage());
            alert.showAndWait();
            Platform.exit();
        });
    }

    public static void main(String[] args) {
        launch(args);
    }
}
