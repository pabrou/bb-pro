import bb.cascades 1.0
import bb.system 1.0

Page {
    id: destinationPage

	property variant estacion
	property variant indice

	// Custom signal for notifying that this page needs to be closed
    signal done ()
    signal close ()
    
    titleBar: TitleBar {
        title: qsTr("Destino")
        dismissAction: ActionItem {
            title: qsTr("Cerrar")
            onTriggered: {
                // Emit the custom signal here to indicate that this page needs to be closed
                // The signal would be handled by the page which invoked it
                destinationPage.close();
            }
        }
    }
    
    Container {
        id: root
        layout: AbsoluteLayout{
        }
        /*
        MapView {
            id: topMap
            
            altitudeMode: AltitudeMode.RelativeToGround
            latitude: estacion.latitud
            longitude: estacion.longitud
            preferredHeight: 300
            visible: true
            altitude: 2000.0
            
            onLatitudeChanged: {
                _app.addMarker(topMap, estacion.latitud, estacion.longitud, "Estación "+estacion.title);
            }
        }
        */
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            topPadding: 30.0
            leftPadding: 30.0
            rightPadding: 30.0
            
            Label {
	            horizontalAlignment: HorizontalAlignment.Center

				text: qsTr("Estación ")+estacion.title
	            textStyle.fontFamily: ""
	            textStyle.fontSize: FontSize.Large
	        }
            Divider {}
            Label {
                horizontalAlignment: HorizontalAlignment.Left
                text: nombreDeLinea()
                textStyle.fontFamily: ""
                textStyle.fontSize: FontSize.Small
            }
            Label {
                horizontalAlignment: HorizontalAlignment.Left
                text: estacion.subtitle
                textStyle.fontFamily: ""
                textStyle.fontSize: FontSize.Small
            }
	        Button {
	            horizontalAlignment: HorizontalAlignment.Center
	
	        	text: qsTr("Establecer como destino")
	        	
	        	onClicked: {
                    if (_app.isViajeEnProceso()){
                        viajeEnProceso.show();
                    }else{
                    	_app.iniciarViaje(estacion.title, estacion.subtitle, estacion.latitud, estacion.longitud, indice);
                        destinationSetToast.show();
                    	destinationPage.done();
                    }
	            }
                topMargin: 40.0
            }
            Divider {}
            Label {
                text: "Información adicional"
                textStyle.fontSize: FontSize.Small
                horizontalAlignment: HorizontalAlignment.Left
            }
            TextArea {
            	editable: false 
                text: estacion.story
                textStyle.fontSize: FontSize.XSmall
            }

        }

    }
    
    function nombreDeLinea(){
        var selectedLinea = (estModel.data([indice[0]]));
        
        return selectedLinea.title;
    }
    
	attachedObjects: [
	    /*
        SystemDialog {
            id: viajeEnProceso
            title: qsTr("Viaje en progreso")
            dismissAutomatically: true
            body: qsTr("Actualmente hay un viaje en proceso. Para establecer un nuevo destino cancele el viaje actual")
            cancelButton.label: undefined
        },
        SystemToast {
            id: destinationSetToast            
            body: qsTr("La estación ")+estacion.title+qsTr(" se ha establecido como destino")
        },
*/
        XmlDataModel {
            id: estModel
            source: "../model/metro_ba.xml"
        }
	]
}
