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
            verticalCenter: parent.verticalCenter
        }

        Image {
            id: containerImage
            width: parent.width
            anchors {
                top: parent.top
                topMargin: (showSiteNOS) ? parent.height * 0.65 : parent.height * 0.45
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
