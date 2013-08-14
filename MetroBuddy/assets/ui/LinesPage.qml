import bb.cascades 1.0

Page {
    property NavigationPane linesNav
    
    titleBar: TitleBar {
        title: qsTr("Lineas de Subte")
    }
    
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
                    id: listitem
                    type: "linea"
                    StandardListItem {
                        imageSource: ListItemData.imagen
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
                var stationsPageObj = stationsPage.createObject();
                stationsPageObj.linesNav = linesNav;
                linesNav.push(stationsPageObj);
                
            }
        }
    }
    
    attachedObjects: [
        ComponentDefinition {
            id: stationsPage
            source: "StationsPage.qml"
        }
    ]
}


