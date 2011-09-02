import QtQuick 1.0
import com.nokia.symbian 1.0

Page {
    id: page

    anchors.fill: parent

    property double currentWidth;
    property double currentHeight;

    property double originalWidth;
    property double originalHeight;

    property bool imageHandled: false;
    property bool imageFlicked: false;

    property bool resizeToFit;

    //property list<string> images;

    property int listID;
    property int currentID;

    signal back();

    signal goForward(string source);
    signal goBack(string source);

    Flickable {
        id: flickable

        anchors.fill: parent

        contentWidth: currentImage.width * currentImage.scale
        contentHeight: currentImage.height * currentImage.scale

        onFlickStarted: flicked();

        onHeightChanged: adjustImage();
        onWidthChanged: adjustImage();

        Image {
            id: currentImage

            transformOrigin: Item.TopLeft

            asynchronous: true

            sourceSize.height: 1500
            sourceSize.width: 1500

            onStatusChanged: checkStatus();

            smooth: true
            scale: 1
        }

        MouseArea {
            id: areaGrid
            x:0+flickable.contentX
            y:0+flickable.contentY
            width: 80
            height: 80
            onClicked: returnToGrid();
            Image {
                id: backToGrid
                opacity: 0.5
                source: "gfx/back_to_grid.png"
                anchors.centerIn: parent
                visible: false
            }
        }

        MouseArea {
            id: areaZoomDown
            x: 0 + flickable.contentX
            y: page.height - 80 + flickable.contentY
            width: 80
            height: 80
            onClicked: zoomDown();
            Image {
                id: zoomDownIcon
                opacity: 0.5
                source: "gfx/zoom_down.png"
                anchors.centerIn: parent
                visible: false
            }
        }

        MouseArea {
            id: areaZoomUp
            x: page.width - 80 + flickable.contentX
            y: page.height - 80 + flickable.contentY
            width: 80
            height: 80
            onClicked: zoomUp();
            Image {
                id: zoomUpIcon
                opacity: 0.5
                source: "gfx/zoom_up.png"
                anchors.centerIn: parent
                visible: false
            }
        }

        MouseArea {
            id: areaLeft
            x: 0 + flickable.contentX
            y: page.height / 2 + flickable.contentY - height / 2
            width: 80
            height: 80
            onClicked: previousImage(currentImage.source);
            Image {
                id: arrowLeft
                opacity: 0.5
                source: "gfx/arrow_left.png"
                anchors.centerIn: parent
                visible: false
            }
        }

        MouseArea {
            id: areaRight
            x: page.width - 80 + flickable.contentX
            y: page.height / 2 + flickable.contentY - height / 2
            width: 80
            height: 80
            onClicked: nextImage(currentImage.source);
            Image {
                id: arrowRight
                opacity: 0.5
                source: "gfx/arrow_right.png"
                anchors.centerIn: parent
                visible: false
            }
        }

        MouseArea {
            x: flickable.contentX + 80
            y: flickable.contentY
            width: flickable.width - 160
            height: flickable.height

            onClicked: showIcons();
            onDoubleClicked: doubleClick();

            BusyIndicator {
                id: busyIndicator
                visible: false
                anchors.centerIn: parent

                height: 100
                width: 100
            }
            Text {
                id: errorText
                visible: false
                color: "white"

                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }

                text: ""
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

            }
        }

        Timer {
            id: timer
            interval: 2000
            running: false
            repeat: false
            onTriggered: hideIcons();
        }
    }

    function flicked() {
        imageHandled = true;
        imageFlicked = true;
    }

    function adjustImage() {
        if (imageHandled == false && resizeToFit == true) fitToScreen();
    }

    function doubleClick() {
        if (currentImage.scale == 1.0)
        {
            fitToScreen();
            resize();
            centerInResized();
            return;
        }
        else {
            currentImage.scale = 1.0;
            resize();
            centerIn();
        }
    }

    function zoomUp() {
        imageHandled = true;
        showIcons();
        var flickX = flickable.contentX;
        var flickY = flickable.contentY;
        currentImage.scale += 0.1;
        if (currentImage.scale >= 1.5) currentImage.scale = 1.5;
        if (currentImage.scale != 1.5 && imageFlicked === true) {
            flickable.contentX = 1.1 * flickX;
            flickable.contentY = 1.1 * flickY;
        }
        else if (imageFlicked == false) {
            if (currentImage.width > page.width || currentImage.height > page.height) {
                if (currentImage.width > page.width) flickable.contentX = (originalWidth * currentImage.scale) / 2 - page.width / 2;
                if (currentImage.height > page.height) flickable.contentY = (originalHeight * currentImage.scale) / 2 - page.height / 2;
            }
        }
        if (currentImage.width <= page.width) flickable.contentX = 0;
        if (currentImage.height <= page.height) flickable.contentY = 0;

        resize();
    }

    function zoomDown() {
        imageHandled = true;
        showIcons();
        var flickX = flickable.contentX;
        var flickY = flickable.contentY;
        currentImage.scale -= 0.1;
        if (currentImage.scale <= 0.1) currentImage.scale = 0.1;
        if (currentImage.scale != 0.1 && imageFlicked == true) {
            flickable.contentX = 0.9 * flickX;
            flickable.contentY = 0.9 * flickY;
        }
        else if (imageFlicked == false) {
            if ((originalWidth * currentImage.scale) > page.width || (originalHeight * currentImage.scale) > page.height) {
                if ((originalWidth * currentImage.scale) > page.width) flickable.contentX = (originalWidth * currentImage.scale) / 2 - page.width / 2;
                if ((originalHeight * currentImage.scale) > page.height) flickable.contentY = (originalHeight * currentImage.scale) / 2 - page.height / 2;
            }
        }
        if (originalWidth * currentImage.scale <= page.width) flickable.contentX = 0;
        if (originalHeight * currentImage.scale <= page.height) flickable.contentY = 0;

        resize();
    }

    function centerOnZoom() {
        var contentX = flickable.contentX;
        var contentY = flickable.contentY;
        if (currentImage.scale > 1.0) {
            if (currentImage.width > flickable.width) flickable.contentX = contentX + (originalWidth - originalWidth * currentImage.scale) / 2;
            if (currentImage.height > flickable.height) flickable.contentY = contentY + (originalHeight - originalHeight * currentImage.scale) / 2;
        }
        else if (currentImage.scale < 1.0) {
            if (currentImage.width > flickable.width) flickable.contentX = contentX - (originalWidth - originalWidth * currentImage.scale) / 2;
            if (currentImage.height > flickable.height) flickable.contentY = contentY - (originalHeight - originalHeight * currentImage.scale) / 2;
        }
    }

    function showImage(string, id) {
        imageHandled = false;
        imageFlicked = false;
        currentID = id;
        currentImage.scale = 1;
        currentImage.source = string;
        resize();
    }

    function checkStatus() {
        busyIndicator.visible = false;
        errorText.text = "";
        errorText.visible = false;
        if (currentImage.status == Image.Loading) {
            busyIndicator.visible = true;
            busyIndicator.running = true;
            return;
        }
        if (currentImage.status == Image.Ready) {
            busyIndicator.visible = false;
            busyIndicator.running = false;
            originalHeight = currentImage.height;
            originalWidth = currentImage.width;
            if (resizeToFit == false) {
                centerIn();
                resize();
            }
            if (resizeToFit == true) fitToScreen();
            return;
        }
        if (currentImage.status == Image.Error) {
            busyIndicator.visible = false;
            errorText.text = "Failed to load " + currentImage.source;
            errorText.visible = true;
            return;
        }

    }

    function fitToScreen() {
        var resizeScale;

        currentImage.scale = Math.min( page.width/currentImage.width, page.height/currentImage.height);
        resize();
        centerInResized();
    }

    function centerInResized() {
        flickable.contentX = 0;
        flickable.contentY = 0;
    }

    function centerIn() {
        if (currentImage.width >= flickable.width) {
            flickable.contentX = currentImage.width / 2 - flickable.width / 2;
        }
        if (currentImage.height >= flickable.height) {
            flickable.contentY = currentImage.height / 2 - flickable.height / 2;
        }
    }

    function resize() {
        if (currentImage.status == Image.Ready) {
            currentImage.x = 0;
            currentImage.y = 0;

            currentWidth = currentImage.width * currentImage.scale;
            currentHeight = currentImage.height * currentImage.scale;

            if (scale != 1) return;

            if (currentWidth < page.width) {
                currentImage.x = page.x + page.width - (page.width / 2) - currentWidth / 2;
            }
            if (currentHeight < page.height) {
                currentImage.y = page.y + page.height - (page.height / 2) - currentHeight / 2;
            }
        }
        else {
            return;
        }
    }

    function returnToGrid() {
        currentImage.source = "";
        back();
    }

    function addListItem(imageFileName) {
        listID++;
        console.log("Added " + imageFileName);

        //images[listID] = imageFileName;
    }

    function showIcons() {
        arrowRight.visible = true;
        arrowLeft.visible = true;
        zoomDownIcon.visible = true;
        zoomUpIcon.visible = true;
        backToGrid.visible = true;
        timer.restart();
    }

    function hideIcons() {
        arrowRight.visible = false;
        arrowLeft.visible = false;
        zoomDownIcon.visible = false;
        zoomUpIcon.visible = false;
        backToGrid.visible = false;
    }

    function nextImage(sourceImage) {
        showIcons();
        goForward(sourceImage);
    }

    function previousImage(sourceImage) {
        showIcons();
        goBack(sourceImage);
    }
}
