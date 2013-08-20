/*
 * Destino.cpp
 *
 *  Created on: 09/08/2013
 *      Author: pablo
 */
#include <math.h>
#include "Destino.hpp"

#define d2r (M_PI / 180.0)

#define VELOCIDAD_KMH 35

Destino::Destino(const QString &nombre, const QString &combinacion, double latitud, double longitud, const QVariant &index)
	: m_nombre(nombre)
    , m_combinacion(combinacion)
	, m_latitud_destino(latitud)
	, m_longitud_destino(longitud)
	, m_latitud_origen(0)
	, m_longitud_origen(0)
	, m_latitud_actual(0)
	, m_longitud_actual(0)
	, m_distancia_faltante(0)
	, m_tiempo_faltante(0)
	, m_index(index)
	, m_obtuvo_primera_posicion(false)
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

QVariant Destino::index() const
{
    return m_index;
}

double Destino::latitud() const
{
    return m_latitud_destino;
}

double Destino::longitud() const
{
    return m_longitud_destino;
}

double Destino::distanciaFaltante() const
{
    return m_distancia_faltante;
}

double Destino::tiempoFaltante() const
{
    return m_tiempo_faltante;
}


bool Destino::origenObtenido()
{
    return m_obtuvo_primera_posicion;
}



void Destino::updateCurrentPosition(const QGeoPositionInfo& pos){

	m_latitud_actual = pos.coordinate().latitude();
	m_longitud_actual = pos.coordinate().longitude();

	//Si todav’a no hab’a obtenido la primer posicion, guardo esta como de origen
	if (!m_obtuvo_primera_posicion){
		m_latitud_origen = m_latitud_actual;
		m_longitud_origen = m_longitud_actual;

		m_obtuvo_primera_posicion = true;
	}

	m_distancia_faltante = calcularDistancia_km(m_latitud_destino, m_longitud_destino, m_latitud_actual, m_longitud_actual);

	//calculo el tiempo faltante supiendo una velocidad promedio de 35 km/h
	//m_tiempo_faltante = (m_distancia_faltante * 60 / VELOCIDAD_KMH);

	emit dataChanged();
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
