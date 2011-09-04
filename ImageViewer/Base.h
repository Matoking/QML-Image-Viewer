#ifndef BASE_H
#define BASE_H

#include <QWidget>
#include <qmlapplicationviewer.h>
#include <QMetaObject>
#include <QSettings>
#include <QCoreApplication>
#include <QtDeclarative>
#include <QDeclarativeItem>
#include <QDir>
#include <QFileInfo>
#include <QFileInfoList>
#include <QStringList>
#include <QFileDialog>
#include <MediakeyCaptureItem.h>

class Base : public QWidget
{
    Q_OBJECT
public:
    explicit Base(QWidget *parent = 0);

    QmlApplicationViewer viewer;

    int imageCount;

    QSettings *settings;

    QString checkedDirectory;

    QMap<int, QString> images;

signals:

public slots:
    void checkSettings();

    void nextImage(QString);
    void previousImage(QString);

    void checkDirectory();
    void changeDirectory(QString);

    void selectFolder();

    void changeFitToScreen(bool);

    void getImageID(QString);
};

#endif // BASE_H
