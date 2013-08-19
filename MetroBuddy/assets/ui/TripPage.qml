import bb.cascades 1.0

/*
 * _destino.nombre
 * _destino.combinacion
 * _destino.distanciaFaltante
 */


Page {
    id: viajePage
    
    titleBar: TitleBar {
        title: qsTr("Viaje Actual")
    }
   
    Container {
	    background: Color.White
	    topPadding: 30.0
	    leftPadding: 30.0
	    rightPadding: 30.0
	    bottomPadding: 30.0

        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Label {
            id: nombre
            text: "Estacion Pellegrini "
            textStyle.fontSize: FontSize.XLarge
            horizontalAlignment: HorizontalAlignment.Left
        }
        Label {
            id: linea
            text: "Linea A"
            textStyle.fontSize: FontSize.Small
            horizontalAlignment: HorizontalAlignment.Left
        }
        Label {
            id: combinacion
            text: "Combinaciones con linea D y H"
            textStyle.fontSize: FontSize.Small
        }
        Divider {}
        Container {
            topPadding: 30
	        Label {
	            id: progressLabel
	            text: "Progreso del viaje:"
	            textStyle.fontSize: FontSize.Medium
	        }
	        ProgressIndicator {	           
	            id: progressIndicator
	            toValue: 100.0
	            state: ProgressIndicatorState.Progress
	            value: 50.0
	            
                onValueChanged: {
                    if (value == 100) {
                        progressIndicator.state = ProgressIndicatorState.Complete;
                    }
                }
	        }
	    }
        Container {
            topPadding: 50
	        Label {
	            id: distancia
	            text: "Distancia restante: 5 km";
	        }
	        Label {
	            id: eta
	            text: "Tiempo restante: 13 min";
	        }
        } 
    }
    actions: [
        /*
         InvokeActionItem {
         ActionBar.placement: ActionBarPlacement.OnBar
         title: qsTr("Post URL")
         query {
         invokeTargetId: "Facebook"
         invokeActionId: "bb.action.SHARE"
         uri: "http://www.blackberry.com"
         }
         },
         *
         */
                ActionItem {
                    title: "Compartir"
                    ActionBar.placement: ActionBarPlacement.OnBar
                    //enabled: false
                    
                    onTriggered: {
                        var selectedItem = estModel.data(_destino.index);        
                        nombre.text = "Estación "+selectedItem.title;
                        linea.text = "Linea A"
                        combinacion.text = selectedItem.subtitle;
                    }
                },
                DeleteActionItem {
                    title: "Cancelar viaje"
                    ActionBar.placement: ActionBarPlacement.InOverflow
                    //enabled: false
                    
                    onTriggered: {
                        _app.cancelarViaje();
                    }
                }
            ]
            
            attachedObjects: [
                XmlDataModel {
                    id: estModel
                    source: "../model/metro_ba.xml"
                }	
            ]
            
            function actualizarDestino(){
                console.log("Actualizar destino");
                var selectedItem = estModel.data(_destino.index);        
                nombre.text = "Estación "+selectedItem.title;
                linea.text = "Linea A"
                combinacion.text = selectedItem.subtitle;
            }
}

