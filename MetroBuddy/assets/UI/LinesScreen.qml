import bb.cascades 1.0

NavigationPane {
    id: navigationPane
	Page {
	    Container {
	        Label {
	            id: myLabel
	            text: "Lineas de subte"
	        }
	    }
        actions: [
            ActionItem {
                title: "Estaciones"
                ActionBar.placement: ActionBarPlacement.OnBar
                
                onTriggered: {
                    var newPage = stationsScreen.createObject();
                    navigationPane.push(newPage);
                }
            }
        ]
	}
    attachedObjects: [
        ComponentDefinition {
            id: stationsScreen
            source: "StationsScreen.qml"
        }
    ]
}
