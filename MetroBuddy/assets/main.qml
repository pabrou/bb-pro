import bb.cascades 1.0
import bb.system 1.0
import "ui"


TabbedPane {
    id: tabPane
    showTabsOnActionBar: true
    
    /* Note: 
     * To push a NavigationPane Page from the ApplicationMenu, we will need  
     * to keep track which NavigationPane to push it to (that is, which is the active NavigationPane)
     * Tab cannot be added to NavigationPane (but the other way around is possible)
     */ 
    property NavigationPane currentNavigationPane: linesTab.navHandle
    
    Tab {
        id: linesTab 
        title: qsTr("Destino")
        imageSource: "asset:///images/map_pin.png"
        property alias navHandle: linesNav
        NavigationPane {
            id: linesNav
            
            onPopTransitionEnded: {
                Application.menuEnabled = true;
                OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All; 
            }
	        LinesPage{
	            id: linesPage
                linesNav: linesNav
	        }
	    }
    }
    Tab {
        id: tripTab
        title: qsTr("Viaje")     
        imageSource: "asset:///images/nav_to.png"
        property alias navHandle: tripNav
        NavigationPane {
            id: tripNav
            
            onPopTransitionEnded: {
                Application.menuEnabled = true;
                OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.All;
            }
            
            ViajePage {
                id: viajePage
            }
	    }
    }
    
    // Creo el menu de la aplicación
    Menu.definition: 
    MenuDefinition {
        settingsAction: SettingsActionItem {
            title: qsTr("Configuración")
            onTriggered: {
                // For Settings, we will use NavigationPane
                var settingsPageObj = settingsPage.createObject();
                Application.menuEnabled = false;
                currentNavigationPane.push(settingsPageObj);
            }
        }
        helpAction: HelpActionItem {
            title: qsTr("Ayuda")
            onTriggered: {
                // For InfoPage, we will use Sheet
                helpSheet.open();
            }
        }
    }
    
    // Update the NavigationPane handle when the Tab is changed
    onActiveTabChanged: {
        currentNavigationPane = activeTab.navHandle
        
        if (activeTab == tripTab){
            if (_app.isViajeEnProceso())
            	viajePage.conViaje()
            else 
            	viajePage.sinViaje()
        }
    }
    
    attachedObjects: [
        ComponentDefinition {
            id: settingsPage
            source: "ui/SettingsPage.qml"
        },
        Sheet {
            id: helpSheet
            // The following page refers to the InfoPage.qml
            HelpPage {
                id: helpPage
                // Handle the custom signal from InfoPage.qml
                onDone : {
                    helpSheet.close();
                }
            }
        }
    ]
}
