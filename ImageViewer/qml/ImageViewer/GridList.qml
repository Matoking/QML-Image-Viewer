import QtQuick 1.0
import com.nokia.symbian 1.0
import Qt.labs.folderlistmodel 1.0

Page {
    id: page

    signal openFile(string source, int index);

    property int fileId: 0
    property int toolBarHeight: 0

    anchors {
        fill: parent
    }

    GridView {
        id: gridView
        anchors.fill: parent

        clip: true

        cellHeight: 80
        cellWidth: 90

        footer: gridFooter

        cacheBuffer: 12

        highlightFollowsCurrentItem: true

        ScrollDecorator {
            id: scrollDecorator
            flickableItem: gridView
        }

        FolderListModel {
            id: folderModel
            nameFilters: ["*.jpg", "*.png", "*.gif", "*.jpeg"]
            sortField: FolderListModel.Name

            showDirs: false

            folder: ""
        }

        Component {
            id: gridFooter

            Rectangle {
                width: 1
                height: toolBarHeight
                visible: false
            }
        }

        Component {
            id: fileDelegate

            Column {
                Image {
                    id: image
                    width: 90
                    height: 80
                    fillMode: Image.PreserveAspectFit
                    source: folderModel.folder + "/" + fileName

                    asynchronous: true

                    sourceSize.height: 80; sourceSize.width: 90

                    MouseArea {
                        anchors.fill: parent
                        onClicked: openFile(parent.source, gridView.currentIndex);
                    }
                }
            }
        }

        model: folderModel
        delegate: fileDelegate
    }

    function setFolder(folderName) {
        folderModel.folder = folderName;
    }
    function setIndex(value) {
        gridView.currentIndex = value;
    }

    function getTotal() {
        return gridView.count;
    }

    function getSource() {
        return gridView.currentItem.image.source;
    }

    function getIndex() {
        return gridView.currentIndex;
    }
}
