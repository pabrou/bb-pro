import bb.cascades 1.0

Page {
    property string nombre
    Container {
        Label {
            id: estacion
            text: "Estación "+nombre

        }
    }
    
    function setNombre(nombre){
        estacion.setText(nombre);
    }
}
