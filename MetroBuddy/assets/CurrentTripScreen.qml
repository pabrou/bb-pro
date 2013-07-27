import bb.cascades 1.0

Page {
    Container {
        Label {
            id: myLabel
            text: "Viaje Actual"
        }
    }
    actions: [
        ActionItem {
            title: "Cancelar"
            ActionBar.placement: ActionBarPlacement.InOverflow
            
            onTriggered: {
                myLabel.text = "Cancelar";
            }
        }
    ]
}
