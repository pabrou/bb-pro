/*
 * Destino.hpp
 *
 *  Created on: 09/08/2013
 *      Author: pablo
 */

#ifndef DESTINO_HPP_
#define DESTINO_HPP_

#include <QObject>
#include <QVariant>
#include <QtLocationSubset/QGeoPositionInfo>

using namespace QtMobilitySubset;

class Destino : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double distanciaFaltante READ distanciaFaltante NOTIFY dataChanged)
    Q_PROPERTY(double tiempoFaltante READ tiempoFaltante NOTIFY dataChanged)

    Q_PROPERTY(QString nombre READ nombre WRITE setNombre NOTIFY dataChanged)
    Q_PROPERTY(QString combinacion READ combinacion WRITE setCombinacion NOTIFY dataChanged)

    Q_PROPERTY(double latitud READ latitud NOTIFY dataChanged)
    Q_PROPERTY(double longitud READ longitud NOTIFY dataChanged)

    Q_PROPERTY(QVariant index READ index NOTIFY dataChanged)
public:
	Destino(const QString &nombre, const QString &combinacion, double latitud, double longitud, const QVariant &index);
	virtual ~Destino();

	Q_INVOKABLE bool origenObtenido();

private:
	QString m_nombre;
	QString m_combinacion;

	double m_latitud_destino;
	double m_longitud_destino;

	double m_latitud_origen;
	double m_longitud_origen;

	double m_latitud_actual;
	double m_longitud_actual;

	double m_distancia_faltante;
	double m_tiempo_faltante;

	QVariant m_index;

	bool m_obtuvo_primera_posicion;

	QString nombre() const;
	QString combinacion() const;
	void setNombre(const QString &newNombre);
	void setCombinacion(const QString &newCombinacion);

	double latitud() const;
	double longitud() const;

	QVariant index() const;

	double distanciaFaltante() const;
	double tiempoFaltante() const;
	double calcularDistancia_km(double lat1, double long1, double lat2, double long2);

Q_SIGNALS:
	void dataChanged();

private Q_SLOTS:
	void updateCurrentPosition(const QGeoPositionInfo& pos);
};

#endif /* DESTINO_HPP_ */
