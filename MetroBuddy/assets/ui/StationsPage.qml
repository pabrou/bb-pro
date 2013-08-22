import bb.cascades 1.0
import bb.system 1.0
import bb.platform 1.0

Page {
    id: stationsPage
    
    property NavigationPane linesNav
    property string lineaTitle
    
    property alias rootIndex: estacionesView.rootIndexPath
    
    
    titleBar: TitleBar {
        title: qsTr(lineaTitle)
    }
    
    content: Container {
        id: rootEstacion
        
        // Create a ListView that uses an XML data model
        ListView {
            id: estacionesView
            //rootIndexPath: index
            dataModel: XmlDataModel {
                id: estModel
                source: "../model/metro_ba.xml"
            }
            
            listItemComponents: [
                ListItemComponent {
                    id: estacionView
                    type: "estacion"
                    StandardListItem {
                        imageSource: ListItemData.imagen
                        title: ListItemData.title
                        description: ListItemData.subtitle
                        status: ListItemData.status
                    }
                }
            ]
            
            contextActions: [
                ActionSet {
                    title: qsTr("Opciones de Estación")
                    actions: [
                        ActionItem {
                            title: qsTr("Ver detalles")
                            imageSource: "asset:///images/info.png"
                            onTriggered: {
                                var selectedItem = estModel.data(estacionesView.selected());
                                setDestinationPage.estacion = selectedItem;
                                setDestinationPage.indice = estacionesView.selected();
                                
                                //Muestro un sheet con los detalles de la estación y la posibilidad de setearlo como destino
                                destinationSheet.open();
                            }
                        },
                        ActionItem {
                            title: qsTr("Establecer como destino")
                            imageSource: "asset:///images/track.png"
                            
                            onTriggered: {
                                if (_app.isViajeEnProceso()){
                                    viajeEnProceso.show();
                                }else{
	                                var selectedItem = estModel.data(estacionesView.selected());
	                                destinationSetToast.estacionTitle = selectedItem.title;
	                                
	                                _app.iniciarViaje(selectedItem.title, selectedItem.subtitle, selectedItem.latitud, selectedItem.longitud, estacionesView.selected());
	                                
	                                destinationSetToast.show();
                                    linesNav.pop();
                                }
                            }
                        },
                        ActionItem {
                            id: invokeMap
                            title: qsTr("Ver en mapa")
                            imageSource: "asset:///images/url.png"
                            onTriggered: {
                                var selectedItem = estModel.data(estacionesView.selected());
                                
                                locationInvokerID.locationName = qsTr("Estación ")+selectedItem.title
                                locationInvokerID.locationLatitude = selectedItem.latitud;
                                locationInvokerID.locationLongitude = selectedItem.longitud;
                                locationInvokerID.setCenterLatitude(selectedItem.latitud);
                                locationInvokerID.setCenterLongitude(selectedItem.longitud);
                                locationInvokerID.go();
                            }
                        }
                    ]
                } // end of ActionSet   
            ] // end of contextActions list
            
            onTriggered: {
                var selectedItem = dataModel.data(indexPath);
                setDestinationPage.estacion = selectedItem;
                setDestinationPage.indice = indexPath;
                
                //Muestro un sheet con los detalles de la estación y la posibilidad de setearlo como destino
                destinationSheet.open();
            }
        }
    }
    
    attachedObjects: [
        Sheet {
            id: destinationSheet

            SetDestinationPage {
                id: setDestinationPage
                
                onDone : {
                    destinationSheet.close();
                    linesNav.pop();
                }
                
                onClose:{
                    destinationSheet.close();
                }
            }
        },
        
        SystemToast {
            property string estacionTitle

			id: destinationSetToast            
            body: qsTr("La estación ")+estacionTitle+qsTr(" se ha establecido como destino")
        },
        SystemDialog {
            id: viajeEnProceso
            title: qsTr("Viaje en progreso")
            dismissAutomatically: true
            body: qsTr("Actualmente hay un viaje en proceso. Para establecer un nuevo destino cancele el viaje actual")
            cancelButton.label: undefined
        },
        LocationMapInvoker {
            id: locationInvokerID
            
            centerLatitude :  -34.587061    // Ottawa's latitude
            centerLongitude : -58.455269        // Ottawa's longitude
            altitude : 1200
            
            // Request for a given POI (point of interest) to be shown 
            // on the map also.
            locationLatitude : -34.587061
            locationLongitude : -58.455269
            locationName : "Estación Callao"

        }
    ]
}
