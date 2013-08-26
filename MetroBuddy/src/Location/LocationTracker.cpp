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

	//Creo la source para geoposici—n
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
	if (src)
		src->startUpdates();

}

void LocationTracker::stopLocation()
{
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

	m_latitude = pos.coordinate().latitude();
	m_longitude = pos.coordinate().longitude();

	emit dataChanged(pos);
}

void LocationTracker::positionUpdateTimeout()
{
}


double LocationTracker::latitude() const
{
    return m_latitude;
}

double LocationTracker::longitude() const
{
    return m_longitude;
}
