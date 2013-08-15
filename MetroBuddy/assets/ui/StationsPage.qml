import bb.cascades 1.0

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
                    actions: [
                        ActionItem {
                            title: qsTr("Establecer destino")
                            imageSource: "asset:///images/track.png"
                            
                            onTriggered: {
                            }
                        },
                        ActionItem {
                            title: qsTr("Ver en mapa")
                            imageSource: "asset:///images/url.png"
                        },
                        ActionItem {
                            title: qsTr("Información")
                            imageSource: "asset:///images/info.png"
                        }
                    ]
                } // end of ActionSet   
            ] // end of contextActions list
            
            onTriggered: {
                var selectedItem = dataModel.data(indexPath);
                
                setDestinationPage.estacion = selectedItem;
                
                //Muestro un sheet con los detalles de la estación y la posibilidad de setearlo como destino
                destinationSheet.open();
                //var selectedItem = dataModel.data(indexPath);
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
        }
    ]
}
