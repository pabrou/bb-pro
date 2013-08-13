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

public:
	Destino();
	virtual ~Destino();

private:

Q_SIGNALS:

private Q_SLOTS:
	void updateCurrentPosition(const QGeoPositionInfo& pos);
};

#endif /* DESTINO_HPP_ */
