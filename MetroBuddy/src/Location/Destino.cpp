/*
 * Destino.cpp
 *
 *  Created on: 09/08/2013
 *      Author: pablo
 */
#include <math.h>
#include "Destino.hpp"

#define d2r (M_PI / 180.0)

Destino::Destino() {
	// TODO Auto-generated constructor stub

	distancia_faltante = 0;
	tiempo_faltante = 0;

}

Destino::~Destino() {
	// TODO Auto-generated destructor stub
}

void Destino::updateCurrentPosition(const QGeoPositionInfo& pos){
	qDebug("Se actualizo la posicion %f %f", pos.coordinate().latitude(), pos.coordinate().longitude());

	distancia_faltante = calcularDistancia_km(-34.65202, -58.4777, pos.coordinate().latitude(), pos.coordinate().longitude());
	tiempo_faltante += 2;

	emit dataChanged();
}

double Destino::distanciaFaltante() const
{
    return distancia_faltante;
}

double Destino::tiempoFaltante() const
{
    return tiempo_faltante;
}

double Destino::calcularDistancia_km(double lat1, double long1, double lat2, double long2)
{
    double dlong = (long2 - long1) * d2r;
    double dlat = (lat2 - lat1) * d2r;
    double a = pow(sin(dlat/2.0), 2) + cos(lat1*d2r) * cos(lat2*d2r) * pow(sin(dlong/2.0), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double d = 6367 * c;

    //Para calcular en millas en vez de km
    //double d = 3956 * c;

    return d;
}
