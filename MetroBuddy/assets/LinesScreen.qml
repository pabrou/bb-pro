import bb.cascades 1.0

Page {
    content: 
    Container {
        Label {
            id: myLabel
            text: "Lineas de subte"
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
    onCreationCompleted: {
        console.debug("Ya se creo todo");
    }
}
