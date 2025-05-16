module com.balanceflow {
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.graphics;
    
    requires java.sql;
    requires java.desktop;
    
    // Öffne Pakete für die FXML-Reflexion
    opens com.balanceflow to javafx.fxml;
    opens com.balanceflow.controllers to javafx.fxml;
    opens com.balanceflow.models to javafx.fxml;
    
    // Exportiere Pakete
    exports com.balanceflow;
    exports com.balanceflow.controllers;
    exports com.balanceflow.models;
    exports com.balanceflow.utils;
    
    // Verwende automatische Module für nicht-modularisierte Abhängigkeiten
    requires org.jfree.jfreechart;
    requires static AnimateFX;
    requires static MaterialFX;
}
