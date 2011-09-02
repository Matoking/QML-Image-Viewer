#include "Base.h"

Base::Base(QWidget *parent) :
    QWidget(parent)
{
    imageCount = 0;

    QCoreApplication::setApplicationName("ImageViewer");
    QCoreApplication::setOrganizationName("Matoking");
    //viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    qmlRegisterType<MediakeyCaptureItem>("Mediakey", 1, 0, "MediakeyCapture");
    viewer.setMainQmlFile(QLatin1String("qml/ImageViewer/main.qml"));
    viewer.showExpanded();
    viewer.rootContext()->setContextProperty("base", this);

    checkedDirectory = "";

    settings = new QSettings(this);
    checkSettings();
}

void Base::checkSettings()
{
    if (settings->contains("main/imageFolder") == false)
    {
        settings->setValue("main/imageFolder", QString("nothing"));
        settings->setValue("main/resizeToFit", true);

        settings->sync();
    }
    else {
        QString folderString = QString("file:///%1").arg(settings->value("main/imageFolder").toString());
        QMetaObject::invokeMethod(viewer.rootObject(), "selectFolder", Q_ARG(QVariant, folderString));
        QMetaObject::invokeMethod(viewer.rootObject(), "selectSettingsFolder", Q_ARG(QVariant, settings->value("main/imageFolder").toString()));
        QMetaObject::invokeMethod(viewer.rootObject(), "selectResizeToFit", Q_ARG(QVariant, settings->value("main/resizeToFit").toBool()));
        checkDirectory();
    }
    return;
}

void Base::changeDirectory(QString folderName)
{
    settings->setValue("main/imageFolder", folderName);
    settings->sync();
    checkSettings();
}

void Base::selectFolder()
{
    QString folder = QFileDialog::getExistingDirectory(this,
                                                       QString("Open File"), settings->value("main/imageFolder").toString());
    if (folder.isNull()) folder = "C:/";
    folder.remove(folder.length() - 1, 1);
    settings->setValue("main/imageFolder", folder);
    settings->sync();
    qDebug("Set folder to " + folder.toAscii());
    checkSettings();
}

void Base::changeFitToScreen(bool fitToScreen)
{
    settings->setValue("main/resizeToFit", fitToScreen);
    settings->sync();
    checkSettings();
}

void Base::nextImage(QString imageName)
{
    int count = 1;
    int index;

    while(true)
    {
        if (images[count].isNull()) break;
        if (images[count] == imageName)
        {
            index = count;
            break;
        }
        else {
            count++;
        }
    }

    QString fileName = images[count+1];
    int nextIndex = index + 1;

    if (fileName.isEmpty()) return;

    QMetaObject::invokeMethod(viewer.rootObject(), "showImage", Q_ARG(QVariant, fileName), Q_ARG(QVariant, nextIndex));
}

void Base::previousImage(QString imageName)
{
    int count = 1;
    int index;

    while(true)
    {
        if (images[count].isNull()) break;
        if (images[count] == imageName)
        {
            index = count;
            break;
        }
        else {
            count++;
        }
    }

    QString fileName = images[count-1];
    int nextIndex = index - 1;

    if (fileName.isEmpty()) return;

    QMetaObject::invokeMethod(viewer.rootObject(), "showImage", Q_ARG(QVariant, fileName), Q_ARG(QVariant, nextIndex));
}

void Base::checkDirectory()
{
    if (checkedDirectory == settings->value("main/imageFolder").toString()) return;
    qDebug("Checking directory " + settings->value("main/imageFolder").toString().toAscii());
    QDir dir;
    QString path = settings->value("main/imageFolder").toString();
    QStringList fileFilters;
    fileFilters << "*.png" << "*.jpg" << "*.gif"  << "*.jpeg";

    images.clear();

    dir.setPath(path);
    dir.setFilter(QDir::Files);
    dir.setSorting(QDir::Name);
    dir.setNameFilters(fileFilters);

    QFileInfoList list = dir.entryInfoList();

    int count = 1;

    for (int i = 0; i < list.size(); ++i) {
        QFileInfo fileInfo = list.at(i);

        images[count] = QString("file:///%1").arg(fileInfo.absoluteFilePath());
        count++;

        qDebug("ADDED " + fileInfo.absoluteFilePath().toAscii());
    }

    checkedDirectory = settings->value("main/imageFolder").toString();
}
