import QtQuick 2.0
import Sailfish.Silica 1.0
import "../scripts/ExternalLinks.js" as ExternalLinks

Item {
    id: container

    property bool showBackground: generic.showTextOnPhoto
    property real textOpacity: 0.3

    height: parent.height
    width: parent.width

    Rectangle {
        id: photoRect
        anchors {
            fill: parent
        }
        color: "black"
        opacity: Theme.colorScheme == Theme.LightOnDark  ? 0.65 : 0.9
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

        Rectangle {
            id: titleRect
            height: photoTitle.height
            width: parent.width
            anchors {
                bottom: parent.bottom
//                top: photoContainer.bottom - (Screen.primaryOrientation === Qt.LandscapeOrientation) ? height : 0
                left: parent.left
            }
            color: Qt.rgba(0, 0, 0, textOpacity)
            visible: generic.showTextOnPhoto
            Behavior on opacity {
                FadeAnimation {}
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    photoTitle.visible = !photoTitle.visible
                    titleRect.opacity = photoTitle.visible ? 1.0 : 0.0
                }
            }
        }

        Label {
            id: photoTitle
            width: parent.width
            anchors {
                bottom: parent.bottom
//                top: photoContainer.bottom - (Screen.primaryOrientation === Qt.LandscapeOrientation) ? height : 0
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

        Rectangle {
            id: showBroadcast
            height: 40
            width: 120
            anchors {
                topMargin: showBroadcast.height
                rightMargin: showBroadcast.height
                top: parent.top
                right: parent.right
            }
            color: "transparent"
//            color: Qt.rgba(0, 0, 0, 0)

            Image {
                id: iconContainer
                anchors {
                    fill: parent
                    centerIn: parent
                }
                fillMode: Image.PreserveAspectFit
                source: (site === "NOS") ? Qt.resolvedUrl("images/icon-nos.svg") : Qt.resolvedUrl("images/icon-the-guardian.svg")
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    ExternalLinks.browse(link)
                }
            }
        }
    }
}
