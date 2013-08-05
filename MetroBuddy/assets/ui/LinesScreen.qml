import bb.cascades 1.0

	Page {
        property NavigationPane navLines
        
        content: Container {
            // Create a ListView that uses an XML data model
            ListView {
                id: lineasView
                dataModel: XmlDataModel {
                    id: metroModel
                    source: "../model/metro_ba.xml"
                }
                
                listItemComponents: [
                    ListItemComponent {
                        type: "linea"
                        StandardListItem {
                            title: ListItemData.title
                            description: ListItemData.subtitle
                        }
                    },
                    //Oculto los items estacion, ya que esos los muestro en otra pantalla
                    ListItemComponent {
                        type: "estacion"
                        Container {}
                    }
                ]
                
                onTriggered: {
                    var selectedItem = dataModel.data(indexPath);
                    var estacionSel = stationsScreen.createObject();
                    //estacionSel.linea = indexPath;
                    navLines.push(estacionSel);
                }
            }
        }
        
        actions: [
            ActionItem {
                title: "Buscar"
                ActionBar.placement: ActionBarPlacement.OnBar
                
                onTriggered: {
                    var newPage = stationsScreen.createObject();
                    navLines.push(newPage);
                }
            }
        ]
        
        attachedObjects: [
            ComponentDefinition {
                id: stationsScreen
                source: "StationsScreen.qml"
            }
        ]
	}


