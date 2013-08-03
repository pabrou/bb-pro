/*
 * LocationTracker.cpp
 *
 *  Created on: 03/08/2013
 *      Author: pablo
 */

#include "LocationTracker.hpp"
#include <bb/platform/geo/GeoLocation.hpp>


LocationTracker::LocationTracker() {

	//Creo la source para geoposici—n
	QGeoPositionInfoSource *src = QGeoPositionInfoSource::createDefaultSource(this);
	qDebug("creado");

	if (src){
		qDebug("mal");

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

		src->startUpdates();
		qDebug("actualizaciones comenzaron");
	}

}

LocationTracker::~LocationTracker() {
	// TODO Auto-generated destructor stub
}

void LocationTracker::startLocation()
{
	qDebug("startLocation");
	//if (src)
	//	src->startUpdates();

}

void LocationTracker::stopLocation()
{
	qDebug("stopLocation");
	//if (src)
	//	src->stopUpdates();
}

void LocationTracker::positionUpdated(const QGeoPositionInfo& pos)
{
	qDebug("positionUpdated se ejecuto");
	qDebug("latitud %f longitud %f", pos.coordinate().latitude(), pos.coordinate().longitude());
}

void LocationTracker::positionUpdateTimeout()
{
	qDebug("se ejecuto el timeout");
}

