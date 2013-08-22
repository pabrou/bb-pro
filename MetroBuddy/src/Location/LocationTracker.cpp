/*
 * LocationTracker.cpp
 *
 *  Created on: 03/08/2013
 *      Author: pablo
 */

#include "LocationTracker.hpp"
#include <bb/platform/geo/GeoLocation.hpp>

#include <QtCore/QVariant>


LocationTracker::LocationTracker()
	: m_latitude(0)
	, m_longitude(0)
{

	//Creo la source para geoposición
	src = QGeoPositionInfoSource::createDefaultSource(this);

	if (src){
		src->setPreferredPositioningMethods(QGeoPositionInfoSource::AllPositioningMethods);
		src->setUpdateInterval(15000); //15 segundos de update

		// Connect the positionUpdated() signal to a
		// slot that handles position updates.
		connect(src,
				SIGNAL(positionUpdated(const QGeoPositionInfo &)),
				this,
				SLOT(positionUpdated(const QGeoPositionInfo &)));

		connect(src,
				SIGNAL(updateTimeout()),
				this,
				SLOT(positionUpdateTimeout()));
	}
}

LocationTracker::~LocationTracker()
{
	// TODO Auto-generated destructor stub
}

void LocationTracker::startLocation()
{
	qDebug("Starting location tracking...");
	if (src)
		src->startUpdates();

}

void LocationTracker::stopLocation()
{
	qDebug("Stopping location tracking...");
	if (src)
		src->stopUpdates();
}

void LocationTracker::requestUpdate()
{
    if (src) {
    	src->requestUpdate(12000);
    }
}

void LocationTracker::positionUpdated(const QGeoPositionInfo& pos)
{
	qDebug("Se actualizo la posicion, Latitud: %f Longitud: %f", pos.coordinate().latitude(), pos.coordinate().longitude());

	m_latitude = pos.coordinate().latitude();
	m_longitude = pos.coordinate().longitude();

	emit dataChanged(pos);
}

void LocationTracker::positionUpdateTimeout()
{
	qDebug("Timeout tratando de obtener posicion");
}


double LocationTracker::latitude() const
{
    return m_latitude;
}

double LocationTracker::longitude() const
{
    return m_longitude;
}
