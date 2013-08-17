/*
 * Destino.cpp
 *
 *  Created on: 09/08/2013
 *      Author: pablo
 */
#include <math.h>
#include "Destino.hpp"

#define d2r (M_PI / 180.0)

Destino::Destino(const QString &nombre, const QString &combinacion, double latitud, double longitud)
	: m_nombre(nombre)
    , m_combinacion(combinacion)
	, m_latitud(latitud)
	, m_longitud(longitud)
	, m_distancia_faltante(0)
	, m_tiempo_faltante(0)
{
	// TODO Auto-generated constructor stub


}

Destino::~Destino() {
	// TODO Auto-generated destructor stub
}

QString Destino::nombre() const
{
    return m_nombre;
}

QString Destino::combinacion() const
{
    return m_combinacion;
}

void Destino::setNombre(const QString &newNombre)
{
    if (newNombre != m_nombre) {
    	m_nombre = newNombre;
        emit dataChanged();
    }
}

void Destino::setCombinacion(const QString &newCombinacion)
{
    if (newCombinacion != m_combinacion) {
    	m_combinacion = newCombinacion;
        emit dataChanged();
    }
}

void Destino::updateCurrentPosition(const QGeoPositionInfo& pos){
	qDebug("Se actualizo la posicion %f %f", pos.coordinate().latitude(), pos.coordinate().longitude());

	m_distancia_faltante = calcularDistancia_km(m_latitud, m_longitud, pos.coordinate().latitude(), pos.coordinate().longitude());
	m_tiempo_faltante += 2;

	emit dataChanged();
}

double Destino::latitud() const
{
    return m_latitud;
}

double Destino::longitud() const
{
    return m_longitud;
}

double Destino::distanciaFaltante() const
{
    return m_distancia_faltante;
}

double Destino::tiempoFaltante() const
{
    return m_tiempo_faltante;
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
