import QtQuick 1.0
import com.nokia.symbian 1.0

Page {
    id: page

    signal openFolderBrowser();

    signal resizeToFitChanged(bool value);

    function selectFolder(folderLocation) {
        folderTextfield.text = folderLocation;
    }

    function setResizeToFit(resizeToFit) {
        generalListModel.setProperty(0, "selected", resizeToFit);
    }

    anchors.fill: parent

    Flickable {
        id: flickable

        anchors.fill: parent

        contentHeight: folderSelectButton.y + folderSelectButton.height

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
            anchors {
                top: folderTitle.bottom
                topMargin: 60
                left: parent.left
                right: parent.right
            }


            model: generalListModel
            delegate: generalListDelegate

        }

        ListModel {
            id: generalListModel

            function changeSelection(id, value) {
                if (id === 0) resizeToFitChanged(value);
            }

            ListElement {
                name: "Resize to fit"
                role: "Title"
                selected: true
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
