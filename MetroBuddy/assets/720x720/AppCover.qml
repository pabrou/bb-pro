import bb.cascades 1.0

Container {    
    Container {        
        layout: StackLayout {}
        
        Container {
            minWidth: 310.0
            minHeight: 56.0
            background: Color.create("#64AAD0")
            
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            opacity: 1
            bottomPadding: 7.0
            leftPadding: 7.0
            Label {
                objectName: "Header"
                text: "Est. Pellegrini"
                verticalAlignment: VerticalAlignment.Center
                textStyle.color: Color.White
                textStyle.textAlign: TextAlign.Center
                textStyle.fontStyle: FontStyle.Default
            }
        
        }
        Container {
            background: backgroundPaint.imagePaint
            minWidth: 310.0
            minHeight: 155.0
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            bottomPadding: 7.0
            leftPadding: 7.0
            topPadding: 10
            Label {
                objectName: "Tiempo"
                text: "Faltan: 23 min"
                verticalAlignment: VerticalAlignment.Center
                textStyle.textAlign: TextAlign.Center
                textStyle.fontSize: FontSize.XSmall
                textStyle.color: Color.Black
            }
            Label {
                objectName: "Distancia"
                text: "Distancia: 15.6 km"
                verticalAlignment: VerticalAlignment.Center
                textStyle.textAlign: TextAlign.Center
                textStyle.fontSize: FontSize.XSmall
                textStyle.color: Color.Black
            }
        
        }
    }
    
    
    attachedObjects: [
        ImagePaintDefinition {
            id: backgroundPaint
            imageSource: "asset:///images/fondo_cover_720.png"
            repeatPattern: RepeatPattern.XY
        }
    ]
}