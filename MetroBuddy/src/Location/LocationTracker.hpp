/*
 * LocationTracker.hpp
 *
 *  Created on: 03/08/2013
 *      Author: pablo
 */

#ifndef LOCATIONTRACKER_HPP_
#define LOCATIONTRACKER_HPP_

#include <QtCore/QObject>
#include <QtCore/QPointer>

#include <QtLocationSubset/QGeoPositionInfo>
#include <QtLocationSubset/QGeoPositionInfoSource>
#include <QtLocationSubset/QGeoSatelliteInfo>
#include <QtLocationSubset/QGeoSatelliteInfoSource>
#include <QDebug>


using namespace QtMobilitySubset;

class LocationTracker: public QObject {
	Q_OBJECT

    Q_PROPERTY(double latitude READ latitude NOTIFY dataChanged)
    Q_PROPERTY(double longitude READ longitude NOTIFY dataChanged)

	QGeoPositionInfoSource *src;

public:
	LocationTracker();
	virtual ~LocationTracker();

	Q_INVOKABLE void startLocation();
	Q_INVOKABLE void stopLocation();

	// This method is called to trigger an one-time retrieval of location information
	Q_INVOKABLE void requestUpdate();


private:
	double latitude() const;
	double longitude() const;

	double m_latitude;
	double m_longitude;

Q_SIGNALS:
	// The change notification signals of the properties
	void dataChanged(const QGeoPositionInfo & pos);

private Q_SLOTS:
	void positionUpdated(const QGeoPositionInfo & pos);
	void positionUpdateTimeout();
};

#endif /* LOCATIONTRACKER_HPP_ */
