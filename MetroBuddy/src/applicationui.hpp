#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include "Destino.hpp"
#include "LocationTracker.hpp"

#include <QObject>
#include <QVariant>
#include <bb/cascades/QmlDocument>
#include <QtLocationSubset/QGeoPositionInfo>
#include <QtLocationSubset/QGeoPositionInfoSource>
#include <QtLocationSubset/QGeoSatelliteInfo>
#include <QtLocationSubset/QGeoSatelliteInfoSource>


namespace bb
{
    namespace cascades
    {
        class Application;
        class LocaleHandler;
        class QmlDocument;
    }
}

using namespace QtMobilitySubset;

class QTranslator;
class QPoint;


/*!
 * @brief Application object
 *
 *
 */

class ApplicationUI : public QObject
{
    Q_OBJECT

    //bb::cascades::QmlDocument *qml;
    LocationTracker* locationTracker;
    Destino *destino;
public:
    ApplicationUI(bb::cascades::Application *app);
    virtual ~ApplicationUI() { }

    /**
	 * Funciones para guardar y leer valores de settings
	 */
	Q_INVOKABLE QString getValueFor(const QString &objectName, const QString &defaultValue);
	Q_INVOKABLE void saveValueFor(const QString &objectName, const QString &inputValue);

	/**
	* Funciones poner pins en mapas
	*/
    Q_INVOKABLE QVariantList worldToPixelInvokable(QObject* mapObject, double latitude, double longitude) const;
    Q_INVOKABLE void updateMarkers(QObject* mapObject, QObject* containerObject) const;

    Q_INVOKABLE void iniciarViaje(int id_estacion, QString nombre, QString combinaciones, double latitude, double longitude);
    Q_INVOKABLE void cancelarViaje();

private slots:
    void onSystemLanguageChanged();

private:
    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;

    QPoint worldToPixel(QObject* mapObject, double latitude, double longitude) const;
};

#endif /* ApplicationUI_HPP_ */
