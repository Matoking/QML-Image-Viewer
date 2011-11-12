import QtQuick 1.0
import com.nokia.symbian 1.0
import Mediakey 1.0

Window {
    id: window

    property bool imageOpen: false
    property bool settingsOpen: false

    property bool changeOfWidth: false
    property bool changeOfHeight: false
    property bool newOrientation:  false

    property int index: 1

    onWidthChanged: {changeOfWidth = true; newOrientation = (changeOfWidth && changeOfHeight)}
    onHeightChanged: {changeOfHeight = true; newOrientation  = (changeOfWidth && changeOfHeight)}

    onNewOrientationChanged: {
        if (newOrientation) {
            changeOfWidth = false;
            changeOfHeight = false;

            if (width > height) {
                // landscape
                gridList.toolBarHeight = toolBar.height;
                if (imageOpen == true) imageView.resize();
            } else {
                // portrait
                gridList.toolBarHeight = toolBar.height;
                if (imageOpen == true) imageView.resize();
            }
        }
    }

    StatusBar {
        id: statusBar
        anchors.top: window.top
    }

    PageStack {
        id: pageStack

        anchors {
            top: statusBar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        ImageView {
            id: imageView

            anchors.fill: parent

            onBack: showGrid();
            onGoForward: base.nextImage(source);
            onGoBack: base.previousImage(source);
        }

        GridList {
            id: gridList

            anchors.fill: parent

            onOpenFile: showImage(source, index);
        }

        Settings {
            id: settings

            anchors.fill: parent

            onOpenFolderBrowser: base.selectFolder();
            onResizeToFitChanged: base.changeFitToScreen(resizeToFit);
            onShowScrollBarChanged: base.changeScrollIndicators(scrollBarChanged);
            onBgColorChanged: base.changeBGColor(bgColor);
        }

    }

    ToolBar {
        id: toolBar
        anchors.bottom: window.bottom
        tools: ToolBarLayout {
            id: toolBarLayout
            ToolButton {
                flat: true
                iconSource: "toolbar-back"
                onClicked: back();
            }
            ToolButton {
                iconSource: "toolbar-menu"
                onClicked: openSettings();
            }
        }
    }
    Component.onCompleted: showGrid();

    function showImage(source, id) {
        imageView.totalImages = gridList.getTotal();
        toolBar.visible = false;
        statusBar.visible = false;
        statusBar.enabled = false;
        pageStack.anchors.top = window.top;
        imageView.showImage(source, id);
        base.getImageID(source);
        pageStack.push(imageView);
        imageOpen = true;
    }

    function setCurrentID(id) {
        gridList.setIndex(id-1);
        imageView.currentID = id;
    }

    function selectFolder(folderName) {
        gridList.setFolder(folderName);
        imageView.totalImages = gridList.getTotal();
    }

    function selectSettingsFolder(folderName) {
        settings.selectFolder(folderName);
    }

    function selectResizeToFit(resizeToFit) {
        imageView.resizeToFit = resizeToFit;
        settings.setResizeToFit(resizeToFit);
    }

    function showScrollIndicators(scrollBarsEnabled) {
        imageView.showScrollIndicators(scrollBarsEnabled);
        settings.setScrollIndicators(scrollBarsEnabled);
    }

    function setBGColor(newColor)
    {
        settings.setBGColor(newColor);
        imageView.setBGColor(newColor);
    }

    function showGrid() {
        toolBar.visible = true;
        toolBar.opacity = 0.5;
        gridList.toolBarHeight = toolBar.height;
        statusBar.visible = true;
        statusBar.enabled = true;
        pageStack.anchors.top = statusBar.bottom;
        pageStack.push(gridList);
        imageOpen = false;
    }

    function goForward() {
        gridList.increaseIndex(1);
        showImage(gridList.getSource(), gridList.getIndex());
    }

    function openSettings() {
        toolBar.visible = true;
        toolBar.opacity = 1;
        statusBar.visible = true;
        statusBar.enabled = true;
        pageStack.anchors.top = statusBar.bottom;
        pageStack.push(settings);
        imageOpen = false;
        settingsOpen = true;
    }

    function back() {
        if (settingsOpen == false) {
            base.quitApplication ();
            return;
        }
        else {
            settingsOpen = false;
            toolBar.visible = true;
            toolBar.opacity = 0.5;
            statusBar.visible = true;
            statusBar.enabled = true;
            pageStack.anchors.top = statusBar.bottom;
            pageStack.push(gridList);
        }
    }

    MediakeyCapture{
        onVolumeDownPressed: imageView.zoomDown();
        onVolumeUpPressed: imageView.zoomUp();
    }
}

