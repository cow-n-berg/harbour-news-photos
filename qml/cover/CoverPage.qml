import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Column {
        visible: true
        spacing: Theme.paddingLarge

        anchors.centerIn: parent

        Label {
            text: qsTr("News Photos")
            color: Theme.highlightColor
        }

        Image {
            width: parent.width
            height: parent.width / sourceSize.width * sourceSize.height
            fillMode: Image.PreserveAspectCrop
            source: Qt.resolvedUrl("../images/img01.jpg")
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
//                getPhotos()
                firstPage.activate()
            }
        }
    }
}
