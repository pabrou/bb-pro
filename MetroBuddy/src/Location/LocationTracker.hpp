/*
 * LocationTracker.hpp
 *
 *  Created on: 03/08/2013
 *      Author: pablo
 */

#ifndef LOCATIONTRACKER_HPP_
#define LOCATIONTRACKER_HPP_

#include <QDebug>
#include <QtLocationSubset/QGeoPositionInfo>
#include <QtLocationSubset/QGeoPositionInfoSource>
#include <QtLocationSubset/QGeoSatelliteInfo>
#include <QtLocationSubset/QGeoSatelliteInfoSource>

#include <QtCore/QObject>
#include <QtCore/QPointer>

using namespace QtMobilitySubset;

class LocationTracker: public QObject {
	Q_OBJECT

public:
	LocationTracker();
	virtual ~LocationTracker();

	Q_INVOKABLE void startLocation();
	Q_INVOKABLE void stopLocation();

private Q_SLOTS:
	void positionUpdated(const QGeoPositionInfo & pos);
	void positionUpdateTimeout();
};

#endif /* LOCATIONTRACKER_HPP_ */
