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
            width: parent.width / 2
            height: width / 2
            anchors {
                top: parent.top
                topMargin: Theme.paddingMedium
                horizontalCenter: parent.horizontalCenter
            }

            source: Theme.colorScheme == 0  ? Qt.resolvedUrl("../images/icons/light/icon-cover-camera.png") : Qt.resolvedUrl("../../images/icons/dark/icon-cover-camera.png")
        }

        Label {
            id: categoryLabel
            anchors {
                top: icon.bottom
                horizontalCenter: parent.horizontalCenter
            }

            font.pixelSize: Theme.fontSizeMedium / 1.2
            color: Theme.secondaryColor
//            color: Theme.highlightColor

            text: { "News Photos" }
        }

        Image {
            id: containerImage
            width: parent.width
            height: width / 1.7
            anchors {
                top: categoryLabel.bottom
                topMargin: Theme.paddingMedium
                horizontalCenter: parent.horizontalCenter
            }

            source: image
        }

//        Label {
//            id: containerTitle
//            width: parent.width
//            anchors {
//                top: containerImage.bottom
//                horizontalCenter: parent.horizontalCenter
//            }

//            text: title

//            font.pixelSize: Theme.fontSizeExtraSmall / 1.1
//            wrapMode: Text.WordWrap
//            truncationMode: TruncationMode.Fade
//        }
    }

    onClicked: {
        pageStack.push(mainPage)
    }
}
