import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: firstPage

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
//    allowedOrientations: Orientation.Landscape
//    allowedOrientations: Orientation.All

    SilicaListView {
        id: listView
        anchors.fill: parent
        header: PageHeader {
            id: pageHeader
            // Adjust page title to current feed
            title: { "NOS Nieuws in beeld"   }
        }

        // Link to feedListModel
        model: feedListModel
        delegate: PhotoDelegate{}

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

}

