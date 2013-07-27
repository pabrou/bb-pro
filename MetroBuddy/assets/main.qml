import bb.cascades 1.0

TabbedPane {
    id: tabPane
    showTabsOnActionBar: false
    
    //Variables para el menu
    property variant menu;
    Menu.definition: menu
    
    Tab {
        id: tab1 
        title: "Estaciónes"
    }
    Tab {
        id: tab2
        title: "Viaje actual"
    }
    Tab {
        id: tab3
        title: "Mapa" 
    }
    Tab {
        id: tab4
        title: "Historial"
    }
    attachedObjects: [
        ComponentDefinition {
            id: page1
            source: "navigationLines.qml"
        },
        ComponentDefinition {
            id: page2
            source: "screenCurrentTrip.qml"
        },
        ComponentDefinition {
            id: page3
            source: "screenMap.qml"
        },
        ComponentDefinition {
            id: page4
            source: "screenMap.qml"
        },
        ComponentDefinition {
            id: metroBuddyMenu
            source: "MetroBuddyMenu.qml"
        }
    ]
    onCreationCompleted: {
        // Creo el menu de la aplicación
        menu = metroBuddyMenu.createObject();
        
        //Instancio y seteo la pantalla para la primer tab
        tab1.content = page1.createObject();
    }
    onActiveTabChanged: {
        if (activeTab == tab2) {
            if (tab2.content == undefined) {
                tab2.content = page2.createObject();
            }
        } else if (activeTab == tab3 ) {
            if (tab3.content == undefined) {
                tab3.content = page3.createObject();
            }
        } else if (activeTab == tab4 ) {
            if (tab4.content == undefined) {
                tab4.content = page4.createObject();
            }
        }
    }
}
