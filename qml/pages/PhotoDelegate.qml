import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: container
    height: parent.height
    width: parent.width
    Rectangle {
        id: photoRect
        anchors {
            fill: parent
        }
        color: "black"
        opacity: .65


        Text {
            // No idea why this is here
            id: imageSource
            visible: false
            text: image
        }

        Item {
            id: photoBox
//            x: Theme.horizontalPageMargin
            x: 0
            height: parent.height
            width: (Screen.orientation === Qt.LandscapeOrientation) ? parent.width - x * 2 : parent.width
            anchors {
                rightMargin: (Screen.orientation === Qt.LandscapeOrientation) ? x : 0
            }

            Image {
                id: containerImage
                width: photoBox.width
//                height: (Screen.orientation === Qt.LandscapeOrientation) ? photoBox.height * 0.85 : photoBox.width / sourceSize.width * sourceSize.height
                height: photoBox.width / sourceSize.width * sourceSize.height
                anchors {
                    top: photoBox.top
                    horizontalCenter: parent.horizontalCenter
                }

                source: image
            }

            Label {
                id: containerTitle
                width: photoBox.width
                y: photoBox.height * 0.15
                anchors {
//                    bottom: (Screen.orientation === Qt.LandscapeOrientation) ? photoBox.bottom : photoBox.bottom - 4 * y
                    bottom: photoBox.bottom
                }

                text: title + " - " + description + " - " + source
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.WordWrap
                truncationMode: TruncationMode.Fade
            }
        }
    }
}
