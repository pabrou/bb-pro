/****************************************************************************
** Meta object code from reading C++ file 'applicationui.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/applicationui.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'applicationui.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ApplicationUI[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      15,   14,   14,   14, 0x08,

 // methods: signature, parameters, type, tag, flags
      73,   49,   41,   14, 0x02,
     124,  102,   14,   14, 0x02,
     196,  167,  154,   14, 0x02,
     268,  242,   14,   14, 0x02,
     348,  301,   14,   14, 0x02,
     401,   14,   14,   14, 0x02,
     417,   14,   14,   14, 0x02,
     440,   14,  435,   14, 0x02,
     484,  459,   14,   14, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_ApplicationUI[] = {
    "ApplicationUI\0\0onSystemLanguageChanged()\0"
    "QString\0objectName,defaultValue\0"
    "getValueFor(QString,QString)\0"
    "objectName,inputValue\0"
    "saveValueFor(QString,QString)\0"
    "QVariantList\0mapObject,latitude,longitude\0"
    "worldToPixelInvokable(QObject*,double,double)\0"
    "mapObject,containerObject\0"
    "updateMarkers(QObject*,QObject*)\0"
    "nombre,combinaciones,latitude,longitude,indice\0"
    "iniciarViaje(QString,QString,double,double,QVariant)\0"
    "cancelarViaje()\0detenerTracking()\0"
    "bool\0isViajeEnProceso()\0"
    "mapObject,lat,lon,nombre\0"
    "addMarker(QObject*,double,double,QString)\0"
};

void ApplicationUI::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ApplicationUI *_t = static_cast<ApplicationUI *>(_o);
        switch (_id) {
        case 0: _t->onSystemLanguageChanged(); break;
        case 1: { QString _r = _t->getValueFor((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 2: _t->saveValueFor((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 3: { QVariantList _r = _t->worldToPixelInvokable((*reinterpret_cast< QObject*(*)>(_a[1])),(*reinterpret_cast< double(*)>(_a[2])),(*reinterpret_cast< double(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = _r; }  break;
        case 4: _t->updateMarkers((*reinterpret_cast< QObject*(*)>(_a[1])),(*reinterpret_cast< QObject*(*)>(_a[2]))); break;
        case 5: _t->iniciarViaje((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< double(*)>(_a[3])),(*reinterpret_cast< double(*)>(_a[4])),(*reinterpret_cast< QVariant(*)>(_a[5]))); break;
        case 6: _t->cancelarViaje(); break;
        case 7: _t->detenerTracking(); break;
        case 8: { bool _r = _t->isViajeEnProceso();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 9: _t->addMarker((*reinterpret_cast< QObject*(*)>(_a[1])),(*reinterpret_cast< double(*)>(_a[2])),(*reinterpret_cast< double(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ApplicationUI::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ApplicationUI::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ApplicationUI,
      qt_meta_data_ApplicationUI, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ApplicationUI::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ApplicationUI::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ApplicationUI::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ApplicationUI))
        return static_cast<void*>(const_cast< ApplicationUI*>(this));
    return QObject::qt_metacast(_clname);
}

int ApplicationUI::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
