/****************************************************************************
** Meta object code from reading C++ file 'MediakeyCaptureItem.h'
**
** Created: Fri 2. Sep 12:52:14 2011
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../MediakeyCaptureItem.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'MediakeyCaptureItem.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MediakeyCaptureItem[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: signature, parameters, type, tag, flags
      21,   20,   20,   20, 0x05,
      41,   20,   20,   20, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_MediakeyCaptureItem[] = {
    "MediakeyCaptureItem\0\0volumeDownPressed()\0"
    "volumeUpPressed()\0"
};

const QMetaObject MediakeyCaptureItem::staticMetaObject = {
    { &QDeclarativeItem::staticMetaObject, qt_meta_stringdata_MediakeyCaptureItem,
      qt_meta_data_MediakeyCaptureItem, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MediakeyCaptureItem::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MediakeyCaptureItem::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MediakeyCaptureItem::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MediakeyCaptureItem))
        return static_cast<void*>(const_cast< MediakeyCaptureItem*>(this));
    return QDeclarativeItem::qt_metacast(_clname);
}

int MediakeyCaptureItem::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDeclarativeItem::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: volumeDownPressed(); break;
        case 1: volumeUpPressed(); break;
        default: ;
        }
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void MediakeyCaptureItem::volumeDownPressed()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void MediakeyCaptureItem::volumeUpPressed()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}
QT_END_MOC_NAMESPACE
