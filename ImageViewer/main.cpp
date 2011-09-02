#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "Base.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    Base base;

    //QmlApplicationViewer viewer;
    //viewer.setMainQmlFile(QLatin1String("qml/ImageViewer/main.qml"));
    //viewer.showExpanded();

    return app.exec();
}
