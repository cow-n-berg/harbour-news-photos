import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: firstPage
    allowedOrientations: Orientation.All

    property bool deVolkskrant: (generic.showSiteVolkskrant > 0)
    property bool derSpiegel: (generic.showSiteSpiegel > 0)


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
        interval: 3000
        running: false
        onTriggered: {
            menuColumn.visible = true
        }
    }

    SilicaFlickable {
        id: menuPage
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: menuColumn.height + Theme.paddingLarge

        flickableDirection: Flickable.VerticalFlick

        PullDownMenu {
            id: pullDownMenu
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        Column {
            id: menuColumn
            width: parent.width
            spacing: Theme.paddingLarge
            visible : false

            PageHeader {
                title: qsTr("Options")
            }

            IconTextSwitch {
                text: "The Guardian"
                description: qsTr("Photo highlights of the day, change once a day typically and not on Saturdays")
                icon.source: Theme.colorScheme == Theme.LightOnDark ? Qt.resolvedUrl("images/the-guardian.svg") : Qt.resolvedUrl("images/the-guardian-dark.svg")
                checked: generic.showSiteGuardian
                onClicked: generic.showSiteGuardian = !generic.showSiteGuardian
            }
            IconTextSwitch {
                text: "de Volkskrant"
                description: qsTr("Photo specials. Texts are Dutch only.")
//                icon.source: Theme.colorScheme == 0  ? Qt.resolvedUrl("images/nos.svg") : Qt.resolvedUrl("images/nos-dark.svg")
                icon.source: Theme.colorScheme == Theme.LightOnDark ? Qt.resolvedUrl("images/de-volkskrant.svg") : Qt.resolvedUrl("images/de-volkskrant-dark.svg")
                checked: deVolkskrant
                onClicked: deVolkskrant = !deVolkskrant
            }
            Slider {
                id: sliderVolkskrant
                value: generic.showSiteVolkskrant
                minimumValue:0
                maximumValue:7
                stepSize: 1
                width: parent.width
                valueText: value.toString()
                label: "Number of photos from de Volkskrant"
            }
            IconTextSwitch {
                text: "Der Spiegel"
                description: qsTr("Bilder des Tages, one photo per day and not on Sundays")
                icon.source: Theme.colorScheme == Theme.LightOnDark ? Qt.resolvedUrl("images/spiegel.svg") : Qt.resolvedUrl("images/spiegel-dark.svg")
                checked: derSpiegel
                onClicked: derSpiegel = !derSpiegel
            }
            Slider {
                id: sliderSpiegel
                value: generic.showSiteSpiegel
                minimumValue:0
                maximumValue:7
                stepSize: 1
                width: parent.width
                valueText: value.toString()
                label: "Number of photos from Der Spiegel"
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
                description: qsTr("Text can be hidden or shown on every slide by tapping it")
                icon.source: "image://theme/icon-m-dismiss"
                checked: generic.showTextOnPhoto
                onClicked: generic.showTextOnPhoto = !generic.showTextOnPhoto
            }
            IconTextSwitch {
                text: qsTr("Show photo number in text")
                description: qsTr("Number will be shown as e.g. 1/10")
                icon.source: "image://theme/icon-m-new"
                checked: generic.showPhotoNumber
                onClicked: generic.showPhotoNumber = !generic.showPhotoNumber
            }
            IconTextSwitch {
                text: qsTr("Show one photo on cover")
                description: qsTr("Or show grid view of many photos")
                icon.source: Theme.colorScheme == 0  ? Qt.resolvedUrl("images/icon-listview.svg") : Qt.resolvedUrl("images/icon-listview-dark.svg")
                checked: generic.coverShowListView
                onClicked: generic.coverShowListView = !generic.coverShowListView
            }
            IconTextSwitch {
                text: qsTr("Show app name on cover")
                description: qsTr("'News Photos' for better recognition of app tiles")
                icon.source: "image://theme/icon-m-about"
                checked: generic.coverShowAppName
                onClicked: generic.coverShowAppName = !generic.coverShowAppName
            }

            ButtonLayout {
                Button {
                    text: qsTr("Save and show photos")
                    enabled: (generic.showSiteVolkskrant || generic.showSiteGuardian || (derSpiegel && generic.showSiteSpiegel > 0))
                    onClicked: {
                        if (deVolkskrant) {
                            generic.showSiteVolkskrant = sliderVolkskrant.value
                        }
                        else {
                            generic.showSiteVolkskrant = 0
                        }
                        if (derSpiegel) {
                            generic.showSiteSpiegel = sliderSpiegel.value
                        }
                        else {
                            generic.showSiteSpiegel = 0
                        }
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

			ViewPlaceholder {
				id: placeh
				enabled: feedListModel.count === 0
	//            enabled: (!feedListModel.populated || feedListModel.count === 0) || root.deletingItems
				text: "Waiting for photos to download"
				hintText: "If nothing happens, please report"
			}

            // Link to feedListModel
            model: feedListModel
            delegate: PhotoDelegate{}
        }
    }
}
