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
//            height: width / 1.778
            anchors {
//                top: categoryLabel.bottom
//                topMargin: Theme.paddingMedium
                top: parent.top
                topMargin: parent.width / 2
                horizontalCenter: parent.horizontalCenter
            }

            fillMode: Image.PreserveAspectFit
            source: image
        }

        Label {
            id: categoryLabel
            anchors {
//                bottom: containerImage.top
                top: containerImage.bottom
                horizontalCenter: parent.horizontalCenter
            }

            font.pixelSize: Theme.fontSizeMedium / 1.2
            color: Theme.secondaryColor

            text: title
            truncationMode: TruncationMode.Elide
        }
    }

    onClicked: {
        pageStack.push(mainPage)
    }
}
