module org.example.datap {
    requires javafx.controls;
    requires javafx.fxml;


    opens org.example.datap to javafx.fxml;
    exports org.example.datap;
}