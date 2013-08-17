import bb.cascades 1.0
import bb.cascades.maps 1.0

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
          
        MapView {
            id: topMap
            
            altitudeMode: AltitudeMode.RelativeToGround
            latitude: estacion.latitud
            longitude: estacion.longitud
            preferredHeight: 300
            visible: true
            altitude: 2000.0
            
            onRequestRender: {
                //pinContainer.updateMarkers();
            }
            
            onCreationCompleted: {
                //setRenderEngine("RenderEngine3D");
                //pinContainer.addPin(estacion.latitud, estacion.longitud);
            }
        }

		/*		
		Container {
		    id: pinContainer
		    horizontalAlignment: HorizontalAlignment.Fill
            topPadding: 100
            leftPadding: 768/2
		
			ImageView {
			    imageSource: "asset:///images/on_map_pin.png"
            }
		}

		Container {
		    id: pinContainer
		    // Must match the mapview width and height and position
		    preferredHeight: topMap.preferredHeight
		    preferredWidth: topMap.preferredWidth
		    //touchPropagationMode: TouchPropagationMode.PassThrough
		    overlapTouchPolicy: OverlapTouchPolicy.Allow
		    property variant currentBubble
		    property variant me
		    layout: AbsoluteLayout {
		    }
		    
		    function addPin(lat, lon) {
		        var marker = pin.createObject();
		        marker.lat = lat;
		        marker.lon = lon;
		        var xy = _app.worldToPixelInvokable(topMap, marker.lat, marker.lon);
		        marker.x = xy[0];
		        marker.y = xy[1];
		        pinContainer.add(marker);
		        marker.animDrop.play();
		    }
		    function updateMarkers() {
		        _app.updateMarkers(topMap, pinContainer);
		    }
		} 
		*/

        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            topPadding: 330.0
            leftPadding: 30.0
            rightPadding: 30.0
            
            Label {
	            horizontalAlignment: HorizontalAlignment.Center

				text: "Estación "+estacion.title
	            textStyle.fontFamily: ""
	            textStyle.fontSize: FontSize.Large
	        }
            /*
            Divider {
            
            }
            Label {
                text: "Distancia: 2.4 km"
                textStyle.fontFamily: ""
            }
            Label {
                text: "ETA: 23 min"
                textStyle.fontFamily: ""
            }
            Label {
                text: estacion.subtitle
                textStyle.fontFamily: ""
            }
            */
            Divider {}
	        Button {
	            horizontalAlignment: HorizontalAlignment.Center
	
	        	text: qsTr("Establecer como destino")
	        	
	        	onClicked: {
                    _app.iniciarViaje(1, estacion.title, estacion.subtitle, estacion.latitud, estacion.longitud, indice);
                    destinationPage.done();
	            }
                topMargin: 40.0
            }
        }

    }
    
    
	attachedObjects: [
		ComponentDefinition {
			id: pin
			source: "pin.qml"
		}
	]
}
