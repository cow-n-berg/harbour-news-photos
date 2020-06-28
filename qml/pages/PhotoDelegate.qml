import QtQuick 2.0
import Sailfish.Silica 1.0
import "../scripts/ExternalLinks.js" as ExternalLinks

Item {
    id: container

    //property bool showBackground: generic.showTextOnPhoto
    property int noneOpacity: 0
    property int textOpacity: 1
    property int fullOpacity: 2
    property int showOpacity: generic.showTextOnPhoto ? textOpacity : noneOpacity

    function toggleOpacity() {
        if (generic.showTextOnPhoto) {
            showOpacity++
            if (showOpacity > fullOpacity)
                showOpacity = noneOpacity
            }
        else {
            showOpacity = noneOpacity
        }
    }

    function rectOpacity() {
        switch (showOpacity) {
        case noneOpacity:
            return 0.0
        case textOpacity:
            return 0.2
        case fullOpacity:
            return 1.0
        }
    }

    height: parent.height
    width: parent.width

    Rectangle {
        id: photoRect
        height: container.height
        width: container.width
//        border.color: "yellow"
//        border.width: 1
        color: "black"
        opacity: Theme.colorScheme == Theme.LightOnDark ? 0.65 : 0.9
    }

    Item {
        id: photoBox
        height: container.height
        width: container.width

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
            color: Qt.rgba(0, 0, 0, rectOpacity())

            Behavior on opacity {
                FadeAnimation {}
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    toggleOpacity()
                    photoTitle.visible = (showOpacity != noneOpacity)
                    titleRect.opacity = rectOpacity()
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

            property string titl: (title) ? title + " - " : ""
            property string descr: (description) ? description + " - " : ""
            property string nr: (showPhotoNumber) ? " " + number : ""
            property string sourc: (source) ? " - " + source : ""

            text: plain(titl + descr + site + nr + sourc )
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.lightSecondaryColor
            wrapMode: Text.WordWrap
//                visible: (Screen.primaryOrientation === Qt.LandscapeOrientation) ? generic.showTextOnPhoto : true
            visible: (showOpacity != noneOpacity)
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

            Image {
                id: iconContainer
                anchors {
                    fill: parent
                    centerIn: parent
                }
                fillMode: Image.PreserveAspectFit

                function showLogo( currentSite ) {
                    var url
                    if (site === "NOS") {
                        url = Qt.resolvedUrl("images/icon-nos.svg")
                    }
                    else if (site === "The Guardian") {
                        url = Qt.resolvedUrl("images/icon-the-guardian.svg")
                    }
                    else {
                        url = Qt.resolvedUrl("images/icon-spiegel.svg")
                    }
                    return url
                }

                source: showLogo( site )
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
