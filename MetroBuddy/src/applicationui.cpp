#include "applicationui.hpp"
#include "LocationTracker.hpp"
#include "Destino.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/Container>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/cascades/maps/MapView>
#include <bb/platform/geo/Point.hpp>

#include <QPoint>
#include <QSettings>

using namespace bb::cascades;
using namespace bb::cascades::maps;
using namespace bb::platform::geo;

QmlDocument *qml_link;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
        QObject(app)
{
    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);
    if(!QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()))) {
        // This is an abnormal situation! Something went wrong!
        // Add own code to recover here
        qWarning() << "Recovering from a failed connect()";
    }
    // initial load
    onSystemLanguageChanged();

    qmlRegisterType<bb::cascades::maps::MapView>("bb.cascades.maps", 1, 0, "MapView");

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    qml_link = qml;

    //Arranco a trackear posiciones
    locationTracker = new LocationTracker();

    qml->setContextProperty("_locationTracker", locationTracker);
    qml->setContextProperty("_app", this);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    app->setScene(root);
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("MetroBuddy_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}

/********************************************************************
 * Funciones para interactuar con QML
 *********************************************************************/

void ApplicationUI::iniciarViaje(int id_estacion, QString nombre, QString combinaciones, double latitude, double longitude, QVariant indice)
{
	qDebug("iniciando viaje");

	qDebug("valores recibidos %s %f %f", nombre.toStdString().c_str(), latitude, longitude);

	if (destino != NULL){
		qDebug("Voy a cancelar el viaje anterior porque ya hab’a uno corriendo");
		cancelarViaje();
	}
	if (destino == NULL){
		qDebug("Se creo un destino nuevo porque era null");
		destino = new Destino(nombre, combinaciones, latitude, longitude, indice);


		qml_link->setContextProperty("_destino", destino);

		connect(locationTracker, SIGNAL(dataChanged(const QGeoPositionInfo &)),
		    	destino, SLOT(updateCurrentPosition(const QGeoPositionInfo &)));

		//iniciando el trackeo de la posici—n
		locationTracker->startLocation();
	}
}

void ApplicationUI::cancelarViaje()
{
	qDebug("cancelando viaje");

	locationTracker->stopLocation();

	if (destino != NULL){
		disconnect(locationTracker, SIGNAL(dataChanged(const QGeoPositionInfo &)),
		    	destino, SLOT(updateCurrentPosition(const QGeoPositionInfo &)));

		delete destino;
		destino = NULL;
	}
}

/********************************************************************
 * Funciones para Guardar y Leer los valores de la configuraci—n
 *********************************************************************/

QString ApplicationUI::getValueFor(const QString &objectName, const QString &defaultValue)
{
    QSettings settings;

    // If no value has been saved, return the default value.
    if (settings.value(objectName).isNull()) {
        return defaultValue;
    }

    // Otherwise, return the value stored in the settings object.
    return settings.value(objectName).toString();
}

void ApplicationUI::saveValueFor(const QString &objectName, const QString &inputValue)
{
    // A new value is saved to the application settings object.
    QSettings settings;
    settings.setValue(objectName, QVariant(inputValue));
}

/*********************************************************************
 * Funciones para manejo de Pins en mapas
 ********************************************************************/

QVariantList ApplicationUI::worldToPixelInvokable(QObject* mapObject, double latitude, double longitude) const
{
    MapView* mapview = qobject_cast<MapView*>(mapObject);
    const Point worldCoordinates = Point(latitude, longitude);
    const QPoint pixels = mapview->worldToWindow(worldCoordinates);

    return QVariantList() << pixels.x() << pixels.y();
}

void ApplicationUI::updateMarkers(QObject* mapObject, QObject* containerObject) const
{
    MapView* mapview = qobject_cast<MapView*>(mapObject);
    Container* container = qobject_cast<Container*>(containerObject);

    for (int i = 0; i < container->count(); i++) {
        const QPoint xy = worldToPixel(mapview,
                                       container->at(i)->property("lat").value<double>(),
                                       container->at(i)->property("lon").value<double>());
        container->at(i)->setProperty("x", xy.x());
        container->at(i)->setProperty("y", xy.y());
    }
}

QPoint ApplicationUI::worldToPixel(QObject* mapObject, double latitude, double longitude) const
{
    MapView* mapview = qobject_cast<MapView*>(mapObject);
    const Point worldCoordinates = Point(latitude, longitude);

    return mapview->worldToWindow(worldCoordinates);
}


