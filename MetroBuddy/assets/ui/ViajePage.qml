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
        
	    Container {
	        id: conViajeContainer
	        visible: false 
	        
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
	            text: "Estación"
	            textStyle.fontSize: FontSize.XLarge
	            horizontalAlignment: HorizontalAlignment.Left
	        }
	        Label {
	            id: linea
	            text: "Linea"
	            textStyle.fontSize: FontSize.Small
	            horizontalAlignment: HorizontalAlignment.Left
	        }
	        Label {
	            id: combinacion
	            text: "Combinaciones"
	            textStyle.fontSize: FontSize.Small
	        }
	        Divider {}
	        Container {
	            topPadding: 30
		        Label {
		            id: progressLabel
		            text: qsTr("Progreso del viaje:")
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
		            text: qsTr("Distancia restante: 5 km");
		        }
		        Label {
		            id: eta
		            text: qsTr("Tiempo restante: 13 min");
		        }
	        } 
	    }
	    
        Container {
            id: sinViajeContainer
            visible: true
            
            background: Color.White
            topPadding: 30.0
            leftPadding: 30.0
            rightPadding: 30.0
            bottomPadding: 30.0
            
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Container {
                topPadding: 40
                Label {
                    id: sinDestino
                    text: qsTr("Sin Viaje")
                    textStyle.fontSize: FontSize.XXLarge
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Top
                }
                
                Divider {}
            }
            ImageView {
                imageSource: "asset:///images/fondo_nav_hd.png"
                opacity: 0.5
                horizontalAlignment: HorizontalAlignment.Center
            }
            Label {
                text: qsTr("No se ha indicado aún una estación de destino. Por favor seleccione la estación que disparará las alarmas desde la solapa Destino")
                multiline: true
                textStyle.fontSize: FontSize.XSmall
            }
        }
	}
   	
    actions: [
        ActionItem {
            id: compartirAction
            enabled: false 
            title: qsTr("Compartir")
            ActionBar.placement: ActionBarPlacement.OnBar
            //enabled: false
            
            onTriggered: {
                
            }
        },
        DeleteActionItem {
            id: cancelarViajeAction
            enabled: false 
            title: qsTr("Cancelar viaje")
            ActionBar.placement: ActionBarPlacement.InOverflow
            //enabled: false
            
            onTriggered: {
                _app.cancelarViaje();
                
                sinViaje()
            }
        }
    ]
    
    attachedObjects: [
        XmlDataModel {
            id: estModel
            source: "../model/metro_ba.xml"
        }	
    ]
    
    function conViaje(){
        sinViajeContainer.visible = false
        conViajeContainer.visible = true 
        
        compartirAction.enabled = true 
        cancelarViajeAction.enabled = true 
        
        actualizarDatosEstacion()
    }
    
    function sinViaje(){
        conViajeContainer.visible = false  
        sinViajeContainer.visible = true 
        
        compartirAction.enabled = false
        cancelarViajeAction.enabled = false 
    }
    
    function actualizarDatosEstacion(){
        var selectedEstacion = estModel.data(_destino.index);        
        var selectedLinea = estModel.data([_destino.index[0]]);       
        
        nombre.text = qsTr("Estación ")+selectedEstacion.title;
        linea.text = selectedLinea.title
        combinacion.text = selectedEstacion.subtitle;
    }
}

