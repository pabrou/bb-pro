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
    actions: [
        ActionItem {
            title: qsTr("Compartir")
            ActionBar.placement: ActionBarPlacement.OnBar
            enabled: false
            onTriggered: {
            
            }
        },
        DeleteActionItem {
            title: qsTr("Cancelar viaje")
            ActionBar.placement: ActionBarPlacement.InOverflow
            enabled: false
            onTriggered: {
            }
        }
    ]
}

