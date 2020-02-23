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
            id: containerImage
            width: parent.width
            anchors {
                top: parent.top
                topMargin: parent.width / 2
                horizontalCenter: parent.horizontalCenter
            }

            fillMode: Image.PreserveAspectFit
            source: image
        }

        Label {
            id: categoryLabel
//            width: parent.width
            height: parent.height / 3
            anchors {
                top: containerImage.bottom
                horizontalCenter: parent.horizontalCenter
            }

            font.pixelSize: Theme.fontSizeMedium / 1.2
            color: Theme.secondaryColor

            text: title
            wrapMode: Text.WordWrap
            truncationMode: TruncationMode.Fade
        }
    }

    onClicked: {
        pageStack.push(mainPage)
    }
}
