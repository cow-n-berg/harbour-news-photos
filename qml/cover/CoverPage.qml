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
        delegate: CoverDelegate{}

        // Dirty hack to show only first news item on cover
//        spacing: Theme.paddingLarge * 20
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: Theme.colorScheme == 0  ? Qt.resolvedUrl("dark-cover-camera.png") : Qt.resolvedUrl("light-cover-camera.png")
            onTriggered: {
                feedListModel.reload()
            }
        }

//        CoverAction {
//            iconSource: "image://theme/icon-cover-subview"
//            onTriggered: {
//                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
//            }
//        }
    }
}
