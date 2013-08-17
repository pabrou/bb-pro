import bb.cascades 1.0


Page {
    
    function distance(lat1, lon1, lat2, lon2){
        var R = 6371; // km
        var dLat = toRad(lat2-lat1);
        var dLon = toRad(lon2-lon1);
        var lat1 = toRad(lat1);
        var lat2 = toRad(lat2);
        
        var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
        var d = R * c;
        
        return d;
    }

	function toRad(Value) {
	    /** Converts numeric degrees to radians */
	   return Value * Math.PI / 180;
	}

    Container {
        Label {
            id: nombre
            text: "Estacion:"+_destino.nombre
        }
        Label {
        	id: combinacion
        	text: "Combinaciones:"+_destino.combinacion
        }
        Label {
            id: latitud
            text: "distanciaFaltante:"+_destino.distanciaFaltante
        }
        Label {
            id: longitud
            text: "tiempoFaltante:"+_destino.tiempoFaltante
        }
        Label {
            id: distancia
            text: "Distancia a casa:"+distance(-34.652026566066446, -58.4777569770813, _locationTracker.latitude, _locationTracker.longitude)+" km";
            
        }
    }
    actions: [
        ActionItem {
            title: "Ubicar"
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: {
            }
        },
        ActionItem {
            title: "Cancelar"
            ActionBar.placement: ActionBarPlacement.InOverflow
            
            onTriggered: {
                _app.cancelarViaje();
            }
        }
    ]
}

