import bb.cascades 1.0

Page {
    property string linea
    content: Container {
        id: rootEstacion
        
        function cambiarLabel(texto){
            lblTitulo.text = texto;
        }
        
        Label {
            id: lblTitulo
            text: "Linea "+linea
        }
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
                        title: ListItemData.title
                    }
                }
            ]
            onTriggered: {
                //var selectedItem = dataModel.data(indexPath);
            }
        }
    }
    actions: [
        ActionItem {
            title: "Buscar"
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: {
                rootEstacion.cambiarLabel("otro texto");
            }
        }
    ]
}
