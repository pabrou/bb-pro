import bb.cascades 1.0
import bb.system 1.0
import "ui"


TabbedPane {
    id: tabPane
    showTabsOnActionBar: false
    
    /* Note: 
     * To push a NavigationPane Page from the ApplicationMenu, we will need  
     * to keep track which NavigationPane to push it to (that is, which is the active NavigationPane)
     * Tab cannot be added to NavigationPane (but the other way around is possible)
     */ 
    property NavigationPane currentNavigationPane: tripTab.navHandle
    
    Tab {
        id: linesTab 
        title: "Nuevo destino"
        property alias navHandle: navLines
        NavigationPane {
            id: navLines
            
            onPopTransitionEnded: {
                Application.menuEnabled = true;
            }
	        LinesScreen{
	            id: linesScreen
	            navLines: navLines
	        }
	    }
    }
    Tab {
        id: tripTab
        title: "Viaje actual"        
        property alias navHandle: navTrip
        NavigationPane {
            id: navTrip
            
            onPopTransitionEnded: {
                Application.menuEnabled = true;
            }
            
	        CurrentTripScreen {
	            id: currentScreen
	        }
	    }
    }
    Tab {
        id: mapTab
        title: "Mapa"
        property alias navHandle: navMap
        NavigationPane {
            id: navMap
            
            onPopTransitionEnded: {
                Application.menuEnabled = true;
            }
	        MapScreen {
	            id: mapScreen
	        } 
	    }
    }
    Tab {
        id: recentTab
        title: "Historial"
        property alias navHandle: navRecent
        NavigationPane {
            id: navRecent
            
            onPopTransitionEnded: {
                Application.menuEnabled = true;
            }
	        RecentScreen {
	            id: recentScreen
	        }
	    }
    }
    
    // Creo el menu de la aplicación
    Menu.definition: 
    MenuDefinition {
        settingsAction: SettingsActionItem {
            onTriggered: {
                // For Settings, we will use NavigationPane
                var settingsPageObj = settingsPage.createObject();
                Application.menuEnabled = false;
                currentNavigationPane.push(settingsPageObj);
            }
        }
        helpAction: HelpActionItem {
            onTriggered: {
               
            }
        }
    }
    
    // Update the NavigationPane handle when the Tab is changed
    onActiveTabChanged: {
        currentNavigationPane = activeTab.navHandle
    }
    
    onCreationCompleted: {
        console.log("Ya se creo todo el QML");
        currentScreen.tracker = _locationTracker;
    }
    
    attachedObjects: [
        ComponentDefinition {
            id: settingsPage
            source: "ui/SettingsPage.qml"
        }
    ]
}
