#include "applicationui.hpp"
#include "LocationTracker.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>

using namespace bb::cascades;

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

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);


    LocationTracker* locationTracker = new LocationTracker();

    locationTracker->startLocation();

    qDebug("Agrego al contexto la location");
    qml->setContextProperty("app", this);

    /*
    //Pasos para obtener posici—n
    QGeoPositionInfoSource *src = QGeoPositionInfoSource::createDefaultSource(this);
    if (src){
    	src->setPreferredPositioningMethods(QGeoPositionInfoSource::AllPositioningMethods);
    	src->setUpdateInterval(15000); //15 segundos de update

    	// Connect the positionUpdated() signal to a
    	// slot that handles position updates.
    	bool positionUpdatedConnected = connect(src,
    			SIGNAL(positionUpdated(const QGeoPositionInfo &)),
    			this,
    			SLOT(positionUpdated(const QGeoPositionInfo &)));

    	bool updateTimeoutConnected = connect(src,
    			SIGNAL(updateTimeout()),
    			this,
    			SLOT(positionUpdateTimeout()));

    	if (positionUpdatedConnected && updateTimeoutConnected) {
    		src->startUpdates();
    	}
    }
    */

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

void ApplicationUI::positionUpdated(const QGeoPositionInfo& pos)
{
	qDebug("positionUpdated se ejecuto");
	qDebug("latitud %f longitud %f", pos.coordinate().latitude(), pos.coordinate().longitude());
}

void ApplicationUI::positionUpdateTimeout()
{
	qDebug("se ejecuto el timeout");
}
