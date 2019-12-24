import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutPage

    property string version: "0.1"
    property string devMail: "sailfishapp@cow-n-berg.nl"
    property url devGithub: "https://github.com/cow-n-berg"

    property url repoGithub: "https://github.com/cow-n-berg/harbour-news-photos"

    property string mailSubjectHeader: "[SailfishOS][News Photos " + version + "] "
    property string mailErrorSubjectHeader: "[SailfishOS][News Photos " + version + "][Error] "
    property string mailBodyHeader: "Hey Rob, "

//    allowedOrientations: Orientation.Landscape
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent

        contentWidth: parent.width;
        contentHeight: pageHeader.height + contentColumn.height + Theme.paddingLarge

        flickableDirection: Flickable.VerticalFlick

        PageHeader {
            id: pageHeader
            title: qsTr("About")
        }

        Column {
            id: contentColumn

            spacing: Theme.paddingLarge
            anchors {
                top: pageHeader.bottom
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width

            Rectangle {
                color: "transparent"
                width: parent.width
                height: childrenRect.height

                Image {
                    id: coverImage
                    source: Qt.resolvedUrl("../images/img01.jpg")
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    clip: true
                    asynchronous: true
                    width: Screen.width
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label {
                    id: topText
                    anchors {
                        top: coverImage.bottom
                        topMargin: Theme.paddingSmall
                        horizontalCenter: parent.horizontalCenter
                    }
                    width: parent.width - 2*Theme.paddingLarge
                    text: qsTr("Your daily fix of NOS News Photos")
                    font.pixelSize: Theme.fontSizeSmall
                    horizontalAlignment: Text.AlignHCenter
                }

                Label {
                    anchors {
                        top: topText.bottom
                        topMargin: Theme.paddingSmall
                        horizontalCenter: parent.horizontalCenter
                    }
                    width: parent.width
                    text: qsTr("version %1").arg(version)
                    font.pixelSize: Theme.fontSizeExtraSmall
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle {
                color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity / 3)
                width: coverImage.width - 2*Theme.paddingLarge
                height: childrenRect.height + 2*Theme.paddingMedium
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    id: authorLabel
                    anchors {
                        top: parent.top
                        topMargin: Theme.paddingMedium
                        horizontalCenter: parent.horizontalCenter
                    }
                    font {
                        italic: true
                        pixelSize: Theme.fontSizeExtraSmall
                    }
                    color: Theme.highlightColor
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("created by %1").arg("Rob Kouwenberg")
                }

                Row {
                    id: authorLinksRow
                    anchors {
                        top: authorLabel.bottom
                        topMargin: Theme.paddingMedium
                        horizontalCenter: parent.horizontalCenter
                    }
                    spacing: Theme.paddingLarge

                    IconButton {
                        id: authorGithubButton
                        height: Theme.iconSizeMedium
                        width: Theme.iconSizeMedium
                        icon {
                            source: Theme.colorScheme == 0  ? Qt.resolvedUrl("../images/icons/light/github.png") : Qt.resolvedUrl("../../images/icons/dark/github.png")
                            height: Theme.iconSizeMedium
                            fillMode: Image.PreserveAspectFit
                        }
                        onClicked: ExternalLinks.browse(constants.devGithub)
                    }

                    IconButton {
                        id: authorMailButton
                        height: Theme.iconSizeMedium
                        width: Theme.iconSizeMedium
                        icon {
                            source: "image://theme/icon-m-mail"
                            height: Theme.iconSizeMedium
                            fillMode: Image.PreserveAspectFit
                        }
                        onClicked: ExternalLinks.mail(constants.devMail, mailSubjectHeader, constants.mailBodyHeader)
                    }
                }

            }

            Label {
                id: codeLabel
                width: parent.width - 2*Theme.paddingLarge
                text: qsTr("The source code is available at
                       <br/><a href='%1'>%2</a>
                       <br/>You can contact me for any remarks,
                       <br/>bugs, feature requests, ideas,...
                       <br/>
                       <br/>This app was inspired by Daily Comics,
                       <br/>by Damien Tardy-Panis. I did use some
                       <br/>of his code to start with.").arg(repoGithub).arg(repoGithub)
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.pixelSize: Theme.fontSizeExtraSmall
                horizontalAlignment: Text.AlignHCenter
                textFormat: Text.StyledText
                linkColor: Theme.highlightColor
                onLinkActivated: ExternalLinks.browse(link)
            }

            Label {
                id: historyLabel
                width: parent.width - 2*Theme.paddingLarge
                text: qsTr("Unfortunately, I couldn't get the
                       <br/>binding straight between QML and C++,
                       <br/>so I settled for an easier way.
                       <br/>The XmlViewList approach was adopted
                       <br/>from SanderKlootwijk. The RegExp stuff
                       <br/>appeared to be very easy in php, so
                       <br/>I created a cron on a web server for
                       <br/>this. The only straightforward piece
                       <br/>of coding in this project...")
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.pixelSize: Theme.fontSizeExtraSmall
                horizontalAlignment: Text.AlignHCenter
                textFormat: Text.StyledText
                linkColor: Theme.highlightColor
                onLinkActivated: ExternalLinks.browse(link)
            }

            Label {
                id: enjoyLabel
                width: parent.width
                text: qsTr("Enjoy!")
                font.pixelSize: Theme.fontSizeLarge
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
