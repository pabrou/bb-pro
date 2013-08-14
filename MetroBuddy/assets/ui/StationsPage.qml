import bb.cascades 1.0

Page {
    id: stationsPage
    
    property NavigationPane linesNav
    property string linea
    
    titleBar: TitleBar {
        title: qsTr("Linea A")
    }
    
    content: Container {
        id: rootEstacion
        
        // Create a ListView that uses an XML data model
        ListView {
            id: estacionesView
            rootIndexPath: [1]
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
            onTriggered: {
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
