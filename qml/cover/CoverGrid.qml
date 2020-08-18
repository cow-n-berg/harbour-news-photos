import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    SilicaGridView {
        id: coverListView
        anchors.fill: parent

        cellWidth: width / 2
        cellHeight: width / 3.5
        // Link to feedListModel
        model: feedListModel
        delegate: Image {
            width: parent.width / 2
            height: parent.width / 3.5
//            anchors.centerIn: parent
            fillMode: Image.PreserveAspectCrop
            source: model.image
        }
    }

    Rectangle {
        id: labelRect
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        height: appName2.height * 1.5
        width: parent.width
        color: "black"
        opacity: (coverShowAppName) ? 0.4 : 0
    }

    Label {
        id: appName2
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        font.pixelSize: Theme.fontSizeLarge
        color: Theme.primaryColor

        text: (coverShowAppName) ? 'News Photos' : ''
    }

    Rectangle {
        id: actionRect
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        height: labelRect.height
        width: parent.width
        color: "black"
        opacity: 0.4
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            id: renewList
//            iconSource: Theme.colorScheme == 0  ? Qt.resolvedUrl("dark-cover-camera.png") : Qt.resolvedUrl("light-cover-camera.png")
            iconSource: Qt.resolvedUrl("dark-cover-camera.png")
            onTriggered: {
                feedListModel.reload()
            }
        }
    }
}
