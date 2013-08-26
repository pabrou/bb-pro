/*
 * ActiveFrame.h
 *
 *  Created on: Apr 2, 2013
 *      Author: wbarichak
 */

#ifndef ACTIVEFRAMEQML_H_
#define ACTIVEFRAMEQML_H_

#include <QObject>
#include <bb/cascades/Label>
#include <bb/cascades/SceneCover>

using namespace ::bb::cascades;

class ActiveFrameQML: public SceneCover {
    Q_OBJECT

public:
    ActiveFrameQML(QObject *parent=0);

public slots:
    Q_INVOKABLE void update(QString title, QString tiempo, QString distancia);

private:
    bb::cascades::Label *m_coverTitle;
    bb::cascades::Label *m_coverTiempo;
    bb::cascades::Label *m_coverDistancia;
};

#endif /* ACTIVEFRAMEQML_H_ */
