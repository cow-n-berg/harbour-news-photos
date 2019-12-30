import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {
    id: container
    contentHeight: Theme.itemSizeHuge

        Image {
            id: containerImage
            anchors {
                fill: parent
                centerIn: parent
            }

            fillMode: Image.PreserveAspectCrop
            source: image
        }
    }

    onClicked: {
        pageStack.push(mainPage)
    }
}
