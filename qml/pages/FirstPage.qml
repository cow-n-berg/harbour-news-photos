import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: firstPage

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
//    allowedOrientations: Orientation.Landscape
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        id: columnFlickable
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                text: qsTr("Refresh")
                onClicked: {
//                    feedListModel.reload
                }
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            height: page.height
            spacing: Theme.paddingLarge

//            PageHeader {
//                title: "UI Template"
//            }
            Image {
                fillMode: Image.Stretch
                source: Qt.resolvedUrl("../images/img01.jpg")
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}

