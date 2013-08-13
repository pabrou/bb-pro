/*
#ifndef DESTINATION_HPP
#define DESTINATION_HPP

#include <QtCore/QObject>
#include <QtCore/QPointer>

#include <QtLocationSubset/QGeoPositionInfo>
#include <QtLocationSubset/QGeoPositionInfoSource>
#include <QtLocationSubset/QGeoSatelliteInfo>
#include <QtLocationSubset/QGeoSatelliteInfoSource>
#include <QDebug>

using namespace QtMobilitySubset;

class Destination: public QObject
{
    Q_OBJECT

    // These are the properties that will be accessible by the datamodel in the view.
    //Q_PROPERTY(QGeoPositionInfo* estacionDestino READ estacionDestino WRITE setEstacionDestino NOTIFY estacionDestinoChanged FINAL)
    //Q_PROPERTY(QString firstName READ firstName WRITE setFirstName NOTIFY firstNameChanged FINAL)
    //Q_PROPERTY(QString lastName READ lastName WRITE setLastName NOTIFY lastNameChanged FINAL)

public:
    Destination();
    virtual ~Destination();
    //Destination(const QGeoPositionInfo &estacion_destino);

    //QGeoPositionInfo* estacionDestino() const;
    //void setEstacionDestino(const QGeoPositionInfo* newDest);

Q_SIGNALS:
    //void estacionDestinoChanged(const QGeoPositionInfo* estacion_destino);
    //void posicionOriginalChanged(const QGeoPositionInfo &posicion_original);
    //void posicionActualChanged(const QGeoPositionInfo &posicion_actual);
private:
    QGeoPositionInfo* m_estacion_destino;
    QGeoPositionInfo* m_posicion_original;
    QGeoPositionInfo* m_posicion_actual;
};

#endif
*/
