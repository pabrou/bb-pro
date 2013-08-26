/* Copyright (c) 2013 Research In Motion Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import bb.cascades 1.0


Page {
    id: infoPage
    
    // Custom signal for notifying that this page needs to be closed
    signal done ()
    
    titleBar: TitleBar {
        title: qsTr("Ayuda")
        dismissAction: ActionItem {
            title: qsTr("Cerrar")
            onTriggered: {
                // Emit the custom signal here to indicate that this page needs to be closed
                // The signal would be handled by the page which invoked it
                infoPage.done();
            }
        }
    }
    
    Container {
        layout: StackLayout {}
        //background: Color.White
        topPadding: 30.0
        leftPadding: 30.0
        rightPadding: 30.0
        bottomPadding: 30.0

		Label {
      		text: "Metro Alarm"
            textStyle.fontSize: FontSize.Large
            horizontalAlignment: HorizontalAlignment.Center

        }
        Label {
            topMargin: 0
            text: "versión 1.0"
            textStyle.fontSize: FontSize.XSmall
            opacity: 0.8
            horizontalAlignment: HorizontalAlignment.Center
        }
        TextArea {
            text: "Metro Alarm es su compañero al momento de viajar en subte, para que nunca pierda su estación o se quede dormido.\n\n"+
            	"El funcionamiento es muy simple.\n\n"+
            	"Desde la solapa Destino puede indicar a que estación se esta dirigiendo.\n"+
            	"En la solapa Viaje puede ir monitoreando el avance de su viaje. Tanto en distancia, como tiempo restante.\n\n"+
            	"Desde la pantalla de configuración puede indicar si desea recibir una notificación al encontrarse a una distancia igual o menor a la indicada."
            
            editable: false
            scrollMode: TextAreaScrollMode.Stiff
            textStyle.fontSize: FontSize.XSmall
            textStyle.textAlign: TextAlign.Justify
        }      
        Container {
            topPadding: 60
            horizontalAlignment: HorizontalAlignment.Center
            Label {
	            text: "Puede contactarme por twitter en  @pabrou"
	            
	            multiline: true
	            textStyle.fontSize: FontSize.XSmall
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Center
                textStyle.color: Color.Blue
            }       
        }   
    } // Container DockLayout

} // Page