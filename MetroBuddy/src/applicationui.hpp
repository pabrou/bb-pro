#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <QVariant>
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

private slots:
    void onSystemLanguageChanged();

private:
    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;

    QPoint worldToPixel(QObject* mapObject, double latitude, double longitude) const;
};

#endif /* ApplicationUI_HPP_ */
