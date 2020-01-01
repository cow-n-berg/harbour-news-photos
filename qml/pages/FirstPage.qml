import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Sailfish.Silica 1.0

Page {
    id: firstPage
    allowedOrientations: Orientation.All

    // First Page, this is the category page; this page cointains all categories and gets pushed as initial page.
    // After the app starts, it automatically pushes the mainPage from here.

    // After the firstPage is pushed, this timer starts running and pushes the mainPage and activates the visibleTimer
    Timer {
        interval: 0
        running: true
        onTriggered: {
            pageStack.push(mainPage)
            visibleTimer.start()
        }
    }

    // Wait with making menu visible until mainPage is pushed
    Timer {
        id: visibleTimer
        interval: 5000
        running: false
        onTriggered: {
            menuColumn.visible = true
        }
    }
    SilicaFlickable {
        id: menuPage
        anchors.fill: parent
        contentWidth: parent.width;
        contentHeight: menuColumn.height + Theme.paddingLarge

        flickableDirection: Flickable.VerticalFlick

        Column {
            id: menuColumn
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: "Options"
            }

            IconTextSwitch {
                text: "NOS Nieuws in beeld"
                description: qsTr("New images at around 14:00 and 19:00,<br/>texts are Dutch only.")
                icon.source: Theme.colorScheme == 0  ? Qt.resolvedUrl("images/nos.svg") : Qt.resolvedUrl("images/nos-dark.svg")
                checked: generic.showSiteNOS
                onClicked: generic.showSiteNOS = !generic.showSiteNOS
            }
            IconTextSwitch {
                text: "The Guardian"
                description: qsTr("Photo highlights of the day,<br/>change once a day typically")
                icon.source: Theme.colorScheme == 0  ? Qt.resolvedUrl("images/the-guardian.svg") : Qt.resolvedUrl("images/the-guardian-dark.svg")
                checked: generic.showSiteGuardian
                onClicked: generic.showSiteGuardian = !generic.showSiteGuardian
            }
            IconTextSwitch {
                text: qsTr("Vertical scroll")
                description: qsTr("Or horizontal scroll")
                icon.source: "image://theme/icon-m-transfer"
                checked: generic.preferVerticalScroll
                onClicked: generic.preferVerticalScroll = !generic.preferVerticalScroll
            }
            IconTextSwitch {
                text: qsTr("Show text on top of photo")
                description: qsTr("Text can be hidden or shown on every slide by tapping the 'ooo' icon in lower right corner")
                icon.source: "image://theme/icon-m-dismiss"
                checked: generic.showTextOnPhoto
                onClicked: generic.showTextOnPhoto = !generic.showTextOnPhoto
            }
            IconTextSwitch {
                text: qsTr("Show one photo on cover")
                description: qsTr("Or show grid view of many photos")
                icon.source: Theme.colorScheme == 0  ? Qt.resolvedUrl("images/icon-listview.svg") : Qt.resolvedUrl("images/icon-listview-dark.svg")
                checked: generic.coverShowListView
                onClicked: generic.coverShowListView = !generic.coverShowListView
            }

            ButtonLayout {
                Button {
                    text: qsTr("About")
                    onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                }
                Button {
                    text: qsTr("Show photos")
                    enabled: (generic.showSiteNOS || generic.showSiteGuardian)
                    onClicked: {
                        generic.saveSettings()
                        feedListModel.reload()
                        pageStack.push(mainPage)
                    }
                }
            }
        }
    }

    Page {
        id: mainPage
//        visible: false
        allowedOrientations: Orientation.All

        SlideshowView  {
            id: slideView
            width: parent.width
            height: parent.height
            orientation : (generic.preferVerticalScroll) ? Qt.Vertical : Qt.Horizontal

            // Link to feedListModel
            model: feedListModel
            delegate: PhotoDelegate{}
        }
    }
}
