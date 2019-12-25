import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {
    id: container
    contentHeight: Theme.itemSizeHuge

    Text {
        id: imageSource
        visible: false
        text: image
    }

    // Put contents in a 'box'
    Item {
        anchors {
            fill: parent
            margins: Theme.paddingMedium
        }

        Image {
            id: icon
            width: parent.width / 4
            height: width
            anchors {
                top: parent.top
                topMargin: Theme.paddingMedium
                horizontalCenter: parent.horizontalCenter
            }

            source: Theme.colorScheme == 0  ? Qt.resolvedUrl("cover-camera.png") : Qt.resolvedUrl("cover-camera.png")
        }

        Label {
            id: categoryLabel
            anchors {
                top: icon.bottom
                horizontalCenter: parent.horizontalCenter
            }

            font.pixelSize: Theme.fontSizeMedium / 1.2
            color: Theme.secondaryColor

            text: title
            truncationMode: TruncationMode.Fade
//            text: { "News Photos" }
        }

        Image {
            id: containerImage
            width: parent.width
            height: width / 1.7
            anchors {
//                centerIn: parent
                top: categoryLabel.bottom
                topMargin: Theme.paddingMedium
                horizontalCenter: parent.horizontalCenter
            }

            source: image
        }
    }

    onClicked: {
        pageStack.push(mainPage)
    }
}
