import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    SilicaListView {
        id: coverListView
        anchors.fill: parent

        // Link to feedListModel
        model: feedListModel
        delegate: CoverListDelegate{}

        // Dirty hack to show only first news item on cover
        spacing: Theme.paddingLarge * 20
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: Theme.colorScheme == 0  ? Qt.resolvedUrl("dark-cover-camera.png") : Qt.resolvedUrl("light-cover-camera.png")
            onTriggered: {
                feedListModel.reload()
            }
        }
    }
}
