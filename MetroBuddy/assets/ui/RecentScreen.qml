import bb.cascades 1.0


Page {
    Container {
        Label {
            id: myLabel
            text: "Historial"
        }
    }
    actions: [
        ActionItem {
            title: "Buscar"
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: {
                myLabel.text = "Action 1 selected!";
            }
        },        
        ActionItem {
            title: "Action 2"
            ActionBar.placement: ActionBarPlacement.InOverflow
            
            onTriggered: {
                myLabel.text = "Action 2 selected!";
            }
        }  
    ]
}
