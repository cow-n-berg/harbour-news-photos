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
                id: photoContainer
                width: photoBox.width
                height: photoBox.width / sourceSize.width * sourceSize.height
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }

                source: image
            }

//            Rectangle {
//                id: titleRect
//                height: photoTitle.height // parent.height / 5
//                anchors {
//                    bottom: parent.bottom
//                }
//                color: "black"
//                opacity: 1.0
//            }

            Label {
                id: photoTitle
                width: parent.width - hideButton.width
                anchors {
//                        top: (Screen.primaryOrientation === Qt.PortraitOrientation) ? photoContainer.bottom : undefined
//                        bottom: (Screen.primaryOrientation === Qt.LandscapeOrientation) ? photoContainer.bottom : undefined
                    bottom: parent.bottom
                }

                function plain( htmlText ) {
                    return unescape(htmlText);
                }

                text: plain(title + " - " + description + " - " + source)
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.lightSecondaryColor
                wrapMode: Text.WordWrap
                truncationMode: TruncationMode.Fade
//                        visible: true
            }

            IconButton {
                id: hideButton
                icon.source: Qt.resolvedUrl("icon-x.png")
                anchors {
                    bottom: parent.bottom
                    right: parent.right
                }

                onPressed: {
//                    titleRect.visible = !titleRect.visible
                    hideButton.visible = !hideButton.visible
                    photoTitle.visible = !photoTitle.visible
                }
            }
        }
    }
}
