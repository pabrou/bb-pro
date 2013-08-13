/*
 * Destino.hpp
 *
 *  Created on: 09/08/2013
 *      Author: pablo
 */

#ifndef DESTINO_HPP_
#define DESTINO_HPP_

#include <QtCore/QObject>
#include <QtLocationSubset/QGeoPositionInfo>

using namespace QtMobilitySubset;

class Destino : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double distanciaFaltante READ distanciaFaltante NOTIFY dataChanged)
    Q_PROPERTY(double tiempoFaltante READ tiempoFaltante NOTIFY dataChanged)

public:
	Destino();
	virtual ~Destino();

private:
	double distanciaFaltante() const;
	double tiempoFaltante() const;
	double calcularDistancia_km(double lat1, double long1, double lat2, double long2);

	double distancia_faltante;
	double tiempo_faltante;

Q_SIGNALS:
	void dataChanged();

private Q_SLOTS:
	void updateCurrentPosition(const QGeoPositionInfo& pos);
};

#endif /* DESTINO_HPP_ */
