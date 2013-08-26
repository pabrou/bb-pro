#include "ActiveFrameQML.hpp"

#include <bb/cascades/SceneCover>
#include <bb/cascades/Container>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>

using namespace bb::cascades;

ActiveFrameQML::ActiveFrameQML(QObject *parent)
    : SceneCover(parent)
{
    QmlDocument *qml = QmlDocument::create("asset:///AppCover.qml").parent(parent);
    Container *mainContainer = qml->createRootObject<Container>();
    setContent(mainContainer);

    m_coverTitle = mainContainer->findChild<Label*>("Header");
    m_coverTitle->setParent(mainContainer);

    m_coverTiempo = mainContainer->findChild<Label*>("Tiempo");
    m_coverTiempo->setParent(mainContainer);

    m_coverDistancia = mainContainer->findChild<Label*>("Distancia");
    m_coverDistancia->setParent(mainContainer);
}

void ActiveFrameQML::update(QString title, QString tiempo, QString distancia) {

	m_coverTitle->setText(title);

	m_coverTiempo->setText(tiempo);

	m_coverDistancia->setText(distancia);
}
