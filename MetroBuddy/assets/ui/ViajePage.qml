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
            id: cancelarViajeAction
            enabled: false 
            title: "Cancelar viaje"
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
    }
    
    function sinViaje(){
        conViajeContainer.visible = false  
        sinViajeContainer.visible = true 
        
        compartirAction.enabled = false
        cancelarViajeAction.enabled = false 
    }
}

