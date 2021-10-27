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
        id: photoAndTitle
        anchors {
            fill: parent
            leftMargin: Theme.paddingMedium
            rightMargin: Theme.paddingMedium
            verticalCenter: parent.verticalCenter
        }

        Label {
            id: appName
            anchors {
                top: parent.top
                topMargin: Theme.paddingMedium
                horizontalCenter: parent.horizontalCenter
            }

            font.pixelSize: Theme.fontSizeMedium / 1.2
            color: Theme.secondaryHighlightColor

            text: (coverShowAppName) ? 'News Photos' : ''
        }

        Image {
            id: containerImage
            width: parent.width
            anchors {
                top: parent.top
                topMargin: (showSiteVolkskrant) ? parent.height * 0.75 : parent.height * 0.65
                horizontalCenter: parent.horizontalCenter
            }

            fillMode: Image.PreserveAspectFit
            source: image
        }

        Label {
            id: categoryLabel
//            width: parent.width
//            height: parent.height / 3
            anchors {
                top: containerImage.bottom
                horizontalCenter: parent.horizontalCenter
            }

            font.pixelSize: Theme.fontSizeMedium / 1.2
            color: Theme.secondaryColor

            property string titl: (title.length > 20) ? title.substr(0, 20) + "..." : title
            property string descr: (description.length > 20) ? description.substr(0, 20) + "..." : description
            text: (titl) ? titl : descr
        }
    }

    onClicked: {
        pageStack.push(mainPage)
    }
}
