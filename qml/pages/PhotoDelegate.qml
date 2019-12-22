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
            margins: Theme.paddingLarge
        }

        Image {
            id: containerImage
            width: parent.height
            height: parent.height / sourceSize.width * sourceSize.height
            anchors {
                top: parent.top
                left: parent.center
            }

            source: image
        }

        Label {
            id: containerTitle
            width: parent.width
            anchors {
//                top: containerImage.bottom
//                leftMargin: Theme.paddingLarge
            }

            text: title
            font.pixelSize: Theme.Normal
            wrapMode: Text.WordWrap
            truncationMode: TruncationMode.Fade
        }

        Label {
            id: containerDescription
            width: parent.width
            anchors {
                top: containerTitle.bottom
            }

            text: title
            font.pixelSize: Theme.fontSizeSmall
            wrapMode: Text.WordWrap
            truncationMode: TruncationMode.Fade
        }

        Label {
            id: containerSource
            width: parent.width
            anchors {
                top: containerDescription.bottom
                leftMargin: Theme.paddingLarge
            }

            text: title
            font.pixelSize: Theme.fontSizeExtraSmall
            wrapMode: Text.WordWrap
            truncationMode: TruncationMode.Fade
        }
    }

//    onClicked: {
//    }
}
