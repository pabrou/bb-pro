
#include "Destination.hpp"

Destination::Destination()
{
}

Destination::Destination(const QGeoPositionInfo & estacion_destino)
{
	m_estacion_destino = estacion_destino;
}

QString Destination::customerID() const
{
    return m_id;
}

QString Destination::firstName() const
{
    return m_firstName;
}

QString Destination::lastName() const
{
    return m_lastName;
}
