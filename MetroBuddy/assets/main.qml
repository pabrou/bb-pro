import bb.cascades 1.0
import "ui"

TabbedPane {
    id: tabPane
    showTabsOnActionBar: false
    
    //Variables para el menu
    property variant menu;
    Menu.definition: menu
    
    Tab {
        id: linesTab 
        title: "Nuevo destino"
        LinesScreen{
            id: linesScreen
            
        }
    }
    Tab {
        id: currentTab
        title: "Viaje actual"
        CurrentTripScreen {
            id: currentScreen
        }
    }
    Tab {
        id: mapTab
        title: "Mapa"
        MapScreen {
            id: mapScreen
        } 
    }
    Tab {
        id: recentTab
        title: "Historial"
        RecentScreen {
            id: recentScreen
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: metroBuddyMenu
            source: "ApplicationMenu.qml"
        }
    ]
    onCreationCompleted: {
        // Creo el menu de la aplicación
        menu = metroBuddyMenu.createObject();
        console.log("Voy a crear un locatioDiagnostics");
        //var session = _locationDiagnostics.createLocationSession(true);
        currentScreen.latitud = "-32.12314";
        currentScreen.longitud = "-51.54476";
    }
}
