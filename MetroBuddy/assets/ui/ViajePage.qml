import bb.cascades 1.0
import bb.system 1.0
import bb.platform 1.0
import QtQuick 1.0

Page {
    id: viajePage
    
    property bool notificacionLanzada
    property string tiempoRestante
    property string distanciaRestante
      
    titleBar: TitleBar {
        title: qsTr("Viaje Actual")
    }
   
   	Container {
        
	    Container {
	        id: conViajeContainer
	        visible: false 
	        
		    //background: Color.White
		    topPadding: 30.0
		    leftPadding: 30.0
		    rightPadding: 30.0
		    bottomPadding: 30.0
	
	        layout: StackLayout {
	            orientation: LayoutOrientation.TopToBottom
	        }
	        Label {
	            id: nombre
	            text: "Estación"
	            textStyle.fontSize: FontSize.XLarge
	            horizontalAlignment: HorizontalAlignment.Left
	        }
	        Label {
	            id: linea
	            text: "Linea"
	            textStyle.fontSize: FontSize.Small
	            horizontalAlignment: HorizontalAlignment.Left
	        }
	        Label {
	            id: combinacion
	            text: "Combinaciones"
	            textStyle.fontSize: FontSize.Small
	        }
	        Divider {}
	        Container {
	            topPadding: 30
		        Label {
		            id: progressLabel
		            text: qsTr("Progreso del viaje:")
		            textStyle.fontSize: FontSize.Medium
		        }
		        ProgressIndicator {
		            id: progressIndicator
		            toValue: 1
		            state: ProgressIndicatorState.Indeterminate
                    value: 0
		        }
		    }
	        Container {
	            topPadding: 50
		        Label {
		            id: distancia
                    text: qsTr("Distancia restante: Calculando");
                    
		        }
		        Label {
		            id: eta
                    text: qsTr("Tiempo restante: Calculando");
		        }
	        } 
	    }
        
        Container {
            id: sinViajeContainer
            visible: true
            
            //background: Color.White
            topPadding: 10.0
            leftPadding: 30.0
            rightPadding: 30.0
            //bottomPadding: 30.0
            
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Container {
                topPadding: 10
                Label {
                    id: sinDestino
                    text: qsTr("Sin Viaje")
                    textStyle.fontSize: FontSize.XXLarge
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Top
                }
                
                Divider {}
            }
            ImageView {
                imageSource: "asset:///images/fondo_nav_hd.png"
                opacity: 0.5
                horizontalAlignment: HorizontalAlignment.Center
            }
            TextArea {
                text: qsTr("No se ha indicado aún una estación de destino. Por favor seleccione la estación que disparará las alarmas desde la solapa Destino")
                textStyle.fontSize: FontSize.XSmall
                editable: false
                scrollMode: TextAreaScrollMode.Stiff
                textStyle.textAlign: TextAlign.Justify
            }
        }
	}
   	
    actions: [
        InvokeActionItem {
            id: compartirAction
            title: qsTr("Compartir")
            query.mimeType: "text/plain"
            query.invokeActionId: "bb.action.SHARE"
            ActionBar.placement: ActionBarPlacement.OnBar
            query.data: qsTr("Viajando a: ")+nombre.text+ "\n" + distancia.text + "\n" + eta.text + "\n\n" + qsTr("Estoy usando MetroBuddy");
        },
        DeleteActionItem {
            id: cancelarViajeAction
            enabled: false 
            title: qsTr("Cancelar viaje")
            ActionBar.placement: ActionBarPlacement.InOverflow
            onTriggered: {
                cancelDialog.show()
            }
        }
    ]
    
    attachedObjects: [
        XmlDataModel {
            id: estModel
            source: "../model/metro_ba.xml"
        },
        SystemDialog {
            id: cancelDialog
            title: qsTr("Terminar viaje")
            
            body: qsTr("¿Esta seguro que desea terminar el viaje que esta realizando actualmente?")
            onFinished: {
                if (cancelDialog.result == SystemUiResult.ConfirmButtonSelection){
                    _app.cancelarViaje();
                    sinViaje();
                } 
            }
        },
        Connections {
            id: connect
            target: _destino
            onDataChanged: actualizarDatosEstacion()
        },
        NotificationDialog {
            id: alertdialog
            title: nombre.text
            body: qsTr("Se esta acercando a su destino. Por favor asegúrese que es la estación correcta.")
            repeat: true
            buttons: [
                SystemUiButton {
                    label: qsTr("Desactivar Alarma")
                }
            ]
        }
    ]
    
    function conViaje(){
        sinViajeContainer.visible = false
        conViajeContainer.visible = true 
        
        compartirAction.enabled = true 
        cancelarViajeAction.enabled = true 
        
        tiempoRestante = qsTr("Faltan: Calculando")
        distanciaRestante = qsTr("Distancia: Calculando")
        
        actualizarDatosEstacion()
    }
    
    function sinViaje(){
        conViajeContainer.visible = false  
        sinViajeContainer.visible = true 
        
        compartirAction.enabled = false
        cancelarViajeAction.enabled = false 
        
        tiempoRestante = ""
        distanciaRestante = ""
        
        notificacionLanzada = false
    }
    
    function actualizarDatosEstacion(){
        console.log("actualizar datos fue llamado");
            
        //Obtengo los datos del destino
        var selectedEstacion = estModel.data(_destino.index);
        var selectedLinea = estModel.data([_destino.index[0]]);
        
        //Actualizo los labels con el nombre de la estacion y de la linea
        nombre.text = qsTr("Est. ")+selectedEstacion.title;
        linea.text = selectedLinea.title;
        combinacion.text = selectedEstacion.subtitle;
        
        //Si la posición es valida muestro el progreso y distancia y tiempo restante
        if (!_destino.origenObtenido()){
            console.log("origenObtenido");
            progressIndicator.value = 0;
            progressIndicator.state = ProgressIndicatorState.Indeterminate;
            distancia.text = qsTr("Distancia restante: Calculando");
            eta.text = qsTr("Tiempo restante: Calculando");
            
            tiempoRestante = qsTr("Faltan: Calculando");
            distanciaRestante = qsTr("Distancia: Calculando");
            
            notificacionLanzada = false
        }else{
            console.log("NO origenObtenido");
            //si llego a un 97% del recorrido para el trackeo y muestro que llego al destino
            if (_destino.porcentajeRecorrido >= 0.97){
                console.log("progressIndicator.value >= 0.97");
                progressIndicator.value = 1;
            	progressIndicator.state = ProgressIndicatorState.Complete;
            	
                distancia.text = qsTr("Distancia restante: Destino alcanzado");
                eta.text = qsTr("Tiempo restante: Destino alcanzado");
                
                tiempoRestante = "Destino alcanzado";
                distanciaRestante = "";
                activeFrame.update(nombre.text, tiempoRestante, distanciaRestante);
                
            	//solo detener el trackeo, no cancelo el viaje, asi no elimina el destino
                _app.detenerTracking();
            }else{
                console.log("NO progressIndicator.value >= 0.97");
                
                distancia.text = qsTr("Distancia restante: ")+ (Math.round(_destino.distanciaFaltante * 10) / 10) +qsTr(" km");
                eta.text = qsTr("Tiempo restante: ")+  (Math.round(_destino.tiempoFaltante * 1) / 1) +qsTr(" min");
                progressIndicator.state = ProgressIndicatorState.Progress;
                progressIndicator.value = _destino.porcentajeRecorrido;                     
                
                tiempoRestante = "Faltan: "+(Math.round(_destino.tiempoFaltante * 1) / 1)+" min";
                distanciaRestante = "Distancia: "+(Math.round(_destino.distanciaFaltante * 10) / 10)+" km";     
            }
            
            console.log("notificacionLanzada:"+notificacionLanzada);
	        //Si todavía no lanzé la notificación
	        if (notificacionLanzada == false){
	            //Leo de la configuración la distancia para lanzar la alarma
	            var confDistancia = _app.getValueFor("alarm_distance", "1.0");
	
				//Si la distancia restante es menor o igual a la configuracion para la alarma, disparo la notificación
	            if (_destino.distanciaFaltante <= confDistancia){
	                
	                //si tengo que emitir la notificacion
                    if (_app.getValueFor("send_notification", "true") == "true"){
	                   alertdialog.show();
                    }
	                
		            notificacionLanzada = true;
	            }
	        }
        }
        
        compartirAction.query.data = qsTr("Viajando a: ")+nombre.text+ "\n" + distancia.text + "\n" + eta.text + "\n\n" + qsTr("Estoy usando MetroBuddy");
        compartirAction.query.updateQuery();
        
        onThumbnail();
    }
    
    onCreationCompleted: {
        console.log("Se creo ViajePage");
        Application.thumbnail.connect(onThumbnail); 
    }
    
    function onThumbnail() {
        console.log("Se ejecuto onThumbnail");
        if (_app.isViajeEnProceso()){
            console.log("isViajeEnProceso");
            activeFrame.update(nombre.text, tiempoRestante, distanciaRestante);
        }else{ 
            console.log("NO isViajeEnProceso");
            activeFrame.update("Sin Viaje", "", "");
        }
    
    
    }
}

