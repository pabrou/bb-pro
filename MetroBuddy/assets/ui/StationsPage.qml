import bb.cascades 1.0
import bb.system 1.0

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
                            title: qsTr("Ver estación")
                            imageSource: "asset:///images/info.png"
                            onTriggered: {
                                var selectedItem = estModel.data(estacionesView.selected());
                                setDestinationPage.estacion = selectedItem;
                                
                                //Muestro un sheet con los detalles de la estación y la posibilidad de setearlo como destino
                                destinationSheet.open();
                            }
                        },
                        ActionItem {
                            title: qsTr("Establecer como destino")
                            imageSource: "asset:///images/track.png"
                            
                            onTriggered: {
                                var selectedItem = estModel.data(estacionesView.selected());
                                destinationSetToast.estacionTitle = selectedItem.title;
                                
                                _app.iniciarViaje(1, selectedItem.title, selectedItem.subtitle, selectedItem.latitud, selectedItem.longitud, estacionesView.selected());
                                
                                destinationSetToast.show();
                            }
                        },
                        InvokeActionItem {
                            id: invokeMap
                            //ActionBar.placement: ActionBarPlacement.OnBar
                            title: qsTr("Navegar a la estación")
                            query {
                                mimeType: "application/vnd.rim.map.action-v1"
                                invokeActionId: "bb.action.OPEN"
                                //invokeTargetId: "application/vnd.rim.map.action-v1"
                            }
                            onTriggered: {
                                var selectedItem = estModel.data(estacionesView.selected());
                                destinationSetToast.estacionTitle = selectedItem.title;
                                
                                invokeMap.setData(JSON.stringify({
                                            "view_mode" :"nav", 
                                            "center" : { "latitude" : selectedItem.latitud, "longitude" : selectedItem.longitud, "heading" : 180, "zoom" : 4 }, 
                                            "nav_start" : { 
                                                "properties" : { 
                                                    "name" : "Ubicacion actual"
                                                }, 
                                                "latitude" : -34.587061, 
                                                "longitude" : -58.455269 
                                            }, 
                                            "nav_end" : { 
                                                "properties" : { 
                                                    "name" : "Estacion "+selectedItem.title
                                                }, 
                                                "latitude" : selectedItem.latitud, 
                                                "longitude" : selectedItem.longitud
                                            }, 
                                            "nav_options" : { 
                                                "nav_mode" : "fastest", 
                                                "avoid_highways" : false, 
                                                "avoid_tolls" : false, 
                                                "transport_mode" : "foot"
                                            }}))
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
        }
    ]
}
