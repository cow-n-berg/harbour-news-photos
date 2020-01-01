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

    CoverActionList {
        id: coverAction

        CoverAction {
//            iconSource: Theme.colorScheme == 0  ? Qt.resolvedUrl("dark-cover-camera.png") : Qt.resolvedUrl("light-cover-camera.png")
            iconSource: Qt.resolvedUrl("dark-cover-camera.png")
            onTriggered: {
                feedListModel.reload()
            }
        }
    }
}
