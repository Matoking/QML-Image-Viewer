# Add more folders to ship with the application, here
folder_01.source = qml/ImageViewer
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian{
    TARGET.UID3 = 0xE6A3EA2D
    INCLUDEPATH += MW_LAYER_SYSTEMINCLUDE // Not sure if this is needed...
    LIBS += -L\epoc32\release\armv5\lib -lremconcoreapi
    LIBS += -L\epoc32\release\armv5\lib -lremconinterfacebase
}

ICON = ImageViewer.svg
TARGET = ImageViewer
VERSION = 0.90

CONFIG += qt-components

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
symbian:DEPLOYMENT.installer_header = 0xA000D7CE

# Allow network access on Symbian
symbian {
    TARGET.CAPABILITY += NetworkServices
    #INCLUDEPATH += MW_LAYER_SYSTEMINCLUDE // Not sure if this is needed...
    LIBS += -L\epoc32\release\armv5\lib -lremconcoreapi
    LIBS += -L\epoc32\release\armv5\lib -lremconinterfacebase
}

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    Base.cpp \
    MediakeyCaptureItem.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

HEADERS += \
    Base.h \
    MediakeyCaptureItem.h


