import QtQuick 1.0
import com.nokia.symbian 1.0

Page {
    id: page

    signal openFolderBrowser();

    signal resizeToFitChanged(bool resizeToFit);
    signal showScrollBarChanged(bool scrollBarChanged);
    signal bgColorChanged(string bgColor);

    function selectFolder(folderLocation) {
        folderTextfield.text = folderLocation;
    }

    function setResizeToFit(resizeToFit) {
        generalListModel.setProperty(0, "selected", resizeToFit);
    }

    function setScrollIndicators(scrollBarsEnabled) {
        generalListModel.setProperty(1, "selected", scrollBarsEnabled);
    }

    function setBGColor(bgColor)
    {
        colorSelection.subTitle = bgColor;
    }

    anchors {
        top: parent.top
        bottom: parent.bottom
    }

    Flickable {
        id: flickable

        anchors.fill: parent

        contentHeight: colorSelection.y + colorSelection.height + 50

        clip: true

        Text {
            id: folderTitle

            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right

            text: "Image folder"
            color: "white"
            font.pointSize: 7.5

            TextField {
                id: folderTextfield

                anchors.top: folderTitle.bottom
                anchors.topMargin: 10

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 10
            }

            Button {
                id: folderSelectButton

                anchors.bottom: folderTextfield.top
                anchors.right: folderTextfield.right
                width: 120

                text: "Browse"

                onClicked: openFolderBrowser();
            }
        }

        ListView {
            id: generalListView

            interactive: false

            anchors {
                top: folderTitle.bottom
                topMargin: 60
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            model: generalListModel
            delegate: generalListDelegate

        }

        SelectionListItem {
            id: colorSelection
            title: "Background color"
            subTitle: colorDialog.selectedIndex >= 0
                      ? colorDialog.model.get(colorDialog.selectedIndex).name
                      : "Please select"

            anchors {
                left: parent.left
                right: parent.right
            }

            y: 235

            onClicked: colorDialog.open();

            SelectionDialog {
                id: colorDialog
                titleText: "Select one of the colors"
                selectedIndex: -1
                model: ListModel {
                    ListElement { name: "black" }
                    ListElement { name: "white" }
                    ListElement { name: "blue" }
                    ListElement { name: "darkblue" }
                    ListElement { name: "lightblue" }
                    ListElement { name: "red" }
                    ListElement { name: "pink" }
                    ListElement { name: "darkred" }
                    ListElement { name: "green" }
                    ListElement { name: "darkgreen" }
                    ListElement { name: "red" }
                    ListElement { name: "darkred" }
                    ListElement { name: "pink" }
                    ListElement { name: "gray" }
                    ListElement { name: "lightgray" }
                    ListElement { name: "darkgray" }
                }

                onSelectedIndexChanged: bgColorChanged(colorDialog.model.get(colorDialog.selectedIndex).name)
            }
        }

        ListModel {
            id: generalListModel

            ListElement {
                name: "Resize to fit"
                role: "Title"
                selected: true
            }

            ListElement {
                name: "Show scroll indicators"
                role: "Title"
                selected: false
            }

            function changeSelection(id, value) {
                if (id === 0) resizeToFitChanged(value);
                if (id === 1) showScrollBarChanged(value);
            }

        }
    }
    Component {
        id: generalListDelegate

        ListItem {
            id: generalListItem

            // The texts to display
            Column {
                anchors {
                    left:  generalListItem.paddingItem.left
                    top: generalListItem.paddingItem.top
                    bottom: generalListItem.paddingItem.bottom
                    right: generalCheckbox.left
                }

                ListItemText {
                    mode: generalListItem.mode
                    role: "Title"
                    text: name // Title text is from the 'name' property in the model item (ListElement)
                    width: parent.width
                }
            }

            // The checkbox to display
            CheckBox {
                id: generalCheckbox
                checked: selected  // Checked state is from the 'selected' property in the model item
                anchors { right: generalListItem.paddingItem.right; verticalCenter: generalListItem.verticalCenter }
                onClicked: generalListModel.changeSelection(index, generalCheckbox.checked);
            }
        }
    }
}
