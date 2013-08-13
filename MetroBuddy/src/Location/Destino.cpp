/*
 * Destino.cpp
 *
 *  Created on: 09/08/2013
 *      Author: pablo
 */

#include "Destino.hpp"

Destino::Destino() {
	// TODO Auto-generated constructor stub

}

Destino::~Destino() {
	// TODO Auto-generated destructor stub
}

void Destino::updateCurrentPosition(const QGeoPositionInfo& pos){
	qDebug("Se actualizo la posicion %f %f", pos.coordinate().latitude(), pos.coordinate().longitude());
}
