import bb.cascades 1.0

Page {
    titleBar: TitleBar {
        title: qsTr("Configuración")
    }
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        
        background: Color.White
        topPadding: 30.0
        leftPadding: 30.0
        rightPadding: 30.0
        bottomPadding: 30.0
        
        Label {
            text: qsTr("Distancia para Activar Alarma")
        }
        Container {
            clipContentToBounds: false
            
            layout: DockLayout {
            }

            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Top

            topPadding: 30.0
            Slider {
                id: distanceSlider
                objectName: "alarm_distance"
                value: _app.getValueFor(objectName, "1.0")
                fromValue: 0.1
                toValue: 4.0
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top

                onImmediateValueChanged: {
                    // If the value changes, we update the animation speed
                    if (tooltipcontainer.posValue != immediateValue) {
                        tooltipcontainer.opacity = 1.0;
                        tooltipcontainer.posValue = immediateValue;
                    }
                }
                
                onValueChanged: {
                    // Remove the tooltip and store the value of the Slider.
                    tooltipcontainer.opacity = 0.0;
                    _app.saveValueFor(distanceSlider.objectName, value);
                }
            }
            
            // This Container has the tooltip and text
            Container {
                bottomPadding: -40
                id: tooltipcontainer
                property real posValue: 0.0
                clipContentToBounds: false
                translationX: -115 + 645 * (posValue/4)
                translationY: -100
                
                layout: DockLayout {
                }
                
                ImageView {
                    id: tooltipImage
                    imageSource: "asset:///images/_Tooltip.png"
                }
                
                Container {
                    bottomPadding: 25
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Fill
                    
                    layout: DockLayout {
                    }
                    
                    Label {
                        id: tooltipTip
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        
                        textStyle {
                            base: SystemDefaults.TextStyles.BodyText
                            color: Color.create("#ff262626")
                            textAlign: TextAlign.Center
                        }
                        
                        text: distanceSlider.immediateValue.toFixed(1)+" km";                        
                    }
                } // Container
                
                attachedObjects: [
                    ImplicitAnimationController {
                        id: tooltipController
                        propertyName: "translationX"
                    }
                ]
                
                onCreationCompleted: {
                    tooltipController.enabled = false;
                }
            } // tooltip Container
        }
        Container {
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Fill
            
            layout: DockLayout {}
            topMargin: 0.0
            leftPadding: 30.0
            rightPadding: 30.0
            bottomPadding: 20.0
            Label {
                id: distanceLabel
                text: qsTr("Cuando se encuentro a una distancia igual o menor a "+distanceSlider.value.toFixed(1)+" km, la aplicación le informará.")
                verticalAlignment: VerticalAlignment.Bottom
                multiline: true
                textStyle.fontSize: FontSize.Small
            }
        }
        Divider {
        }
        Label {
            text: qsTr("Acciones al Llegar al Destino")
        }
        Container {
            layout: DockLayout {}
            bottomPadding: 5.0
            topPadding: 20.0
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                text: qsTr("Emitir alarma audible")
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Left
            }
            ToggleButton {
                id: soundToggle
                objectName: "play_sound"
                checked: _app.getValueFor(objectName, "true") == "true" ? true : false;
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
                
                onCheckedChanged: {
                    _app.saveValueFor(soundToggle.objectName, checked);
                }
            }
        }
        Container {
            layout: DockLayout {}
            bottomPadding: 5.0
            topPadding: 5.0
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                text: qsTr("Vibrar teléfono")
                horizontalAlignment: HorizontalAlignment.Left
                verticalAlignment: VerticalAlignment.Center
            }
            ToggleButton {
                id: vibrateToggle
                objectName: "vibrate_phone"
                checked: _app.getValueFor(objectName, "true") == "true" ? true : false;
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
                
                onCheckedChanged: {
                    _app.saveValueFor(vibrateToggle.objectName, checked);
                }
            }
        }
        Container {
            
            layout: DockLayout {}
            bottomPadding: 5.0
            topPadding: 10.0
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                id: labelNotificacion
                text: qsTr("Enviar notificación")
                verticalAlignment: VerticalAlignment.Center
            }
            ToggleButton {
                id: notificationToggle
                objectName: "send_notification"
                checked: _app.getValueFor(objectName, "true") == "true" ? true : false;
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Right
                
                onCheckedChanged: {
                    _app.saveValueFor(notificationToggle.objectName, checked);
                }
            }
        }
    }
    
    onCreationCompleted: {
        OrientationSupport.supportedDisplayOrientation = SupportedDisplayOrientation.DisplayPortrait;
    }
    
}
