/****************************************************************************
** Meta object code from reading C++ file 'Base.h'
**
** Created: Fri 2. Sep 12:52:16 2011
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../Base.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Base.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Base[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
       6,    5,    5,    5, 0x0a,
      22,    5,    5,    5, 0x0a,
      41,    5,    5,    5, 0x0a,
      64,    5,    5,    5, 0x0a,
      81,    5,    5,    5, 0x0a,
     106,    5,    5,    5, 0x0a,
     121,    5,    5,    5, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_Base[] = {
    "Base\0\0checkSettings()\0nextImage(QString)\0"
    "previousImage(QString)\0checkDirectory()\0"
    "changeDirectory(QString)\0selectFolder()\0"
    "changeFitToScreen(bool)\0"
};

const QMetaObject Base::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_Base,
      qt_meta_data_Base, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Base::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Base::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Base::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Base))
        return static_cast<void*>(const_cast< Base*>(this));
    return QWidget::qt_metacast(_clname);
}

int Base::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: checkSettings(); break;
        case 1: nextImage((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: previousImage((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: checkDirectory(); break;
        case 4: changeDirectory((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: selectFolder(); break;
        case 6: changeFitToScreen((*reinterpret_cast< bool(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 7;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
