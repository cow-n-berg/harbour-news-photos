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
            anchors {
                fill: parent
            }

            Image {
                id: photoContainer
                anchors {
                    fill: parent
                    centerIn: parent
                }
                fillMode: Image.PreserveAspectFit
                source: image
            }

            Label {
                id: photoTitle
                width: parent.width - hideButton.width
                anchors {
                    bottom: parent.bottom
//                    top: photoContainer.bottom - (Screen.primaryOrientation === Qt.LandscapeOrientation) ? height : 0
                    left: parent.left
                }

                function plain( htmlText ) {
                    return unescape(htmlText);
                }

                text: plain(title + " - " + description + " - " + site + " - " + source)
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.lightSecondaryColor
                wrapMode: Text.WordWrap
//                visible: (Screen.primaryOrientation === Qt.LandscapeOrientation) ? generic.showTextOnPhoto : true
                visible: generic.showTextOnPhoto
            }

            IconButton {
                id: hideButton
                icon.source: Qt.resolvedUrl("images/icon-hide-show.svg")
                anchors {
                    bottom: parent.bottom
                    right: parent.right
                }

                onPressed: {
//                    hideButton.visible = !hideButton.visible
                    photoTitle.visible = !photoTitle.visible
                }
            }

            IconButton {
                id: showBroadcast
                icon.source: (site === "NOS") ? Qt.resolvedUrl("images/icon-nos.svg") : Qt.resolvedUrl("images/icon-the-guardian.svg")
                anchors {
//                    bottom: photoContainer.top - (Screen.primaryOrientation === Qt.LandscapeOrientation) ? height : 0
//                    top: page.isPortrait ? image.bottom : header.bottom
                    top: parent.top
                    right: parent.right
                }

                onClicked: ExternalLinks.browse(link)
            }
        }
    }
}
