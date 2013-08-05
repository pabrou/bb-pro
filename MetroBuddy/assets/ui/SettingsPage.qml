import bb.cascades 1.0

Page {
    titleBar: TitleBar {
        title: "Settings"
    }
    
    Container {
        layout: DockLayout {
        }
        background: Color.Black
        Container {
            layout: StackLayout {
            }
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            
            Label {
                text: "Demonstrating this Settings Page from application Menu, using NavigationPane.\n More NavigationPane Page objects can be pushed on top of this Page to allow more drill down navigation."
                multiline: true
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.fontSize: FontSize.Medium
                textStyle.color: Color.White
                textStyle.fontStyle: FontStyle.Italic
            }
        
        } // Container StackLyaout
    } // Container DockLayout
}
