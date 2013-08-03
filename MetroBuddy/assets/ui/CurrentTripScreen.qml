import bb.cascades 1.0

Page {
    
    property string latitud
    property string longitud
    
    Container {
        Label {
            id: latitud
            text: "Latitud:"+latitud
        }
        Label {
            id: longitud
            text: "Longitud:"+longitud
        }
    }
    actions: [
        ActionItem {
            title: "Ubicar"
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: {
                
                
            }
        },
        ActionItem {
            title: "Cancelar"
            ActionBar.placement: ActionBarPlacement.InOverflow
            
            onTriggered: {
                myLabel.text = "Cancelar";
            }
        }
    ]
}
