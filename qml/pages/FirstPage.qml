import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Sailfish.Silica 1.0

Page {
    id: mainPage
    visible: false
    allowedOrientations: Orientation.All

    SlideshowView  {
        id: slideView
        width: parent.width
        height: parent.height
        orientation : Qt.Horizontal

        // Link to feedListModel
        model: feedListModel
        delegate: PhotoDelegate{}
    }

    PullDownMenu {
        quickSelect: true

        MenuItem {
            text: qsTr("About")
            onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
        }
//            MenuItem {
//                text: qsTr("Settings")
//                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
//            }
        MenuItem {
            text: qsTr("Refresh")
            onClicked: {
                feedListModel.reload
            }
        }
    }
}

