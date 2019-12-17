/*
 * Copyright (C) 2019 Rob Kouwenberg
 *
 * This file is part of News Photos application.
 * https://github.com/cow-n-berg/harbour-news-photos
 *
 * News Photos is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * News Photos is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with News Photos.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"


Dialog {
    id: settingsPage

    allowedOrientations: Orientation.All
//    allowedOrientations: Orientation.Portrait

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

//        contentWidth: parent.width
//        contentHeight: pageHeader.height + contentColumn.height + Theme.paddingLarge
//        flickableDirection: Flickable.VerticalFlick

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge

//            spacing: 10
//            anchors.fill: parent

            DialogHeader {
                title: "Settings"
            }

            SectionHeader {
                text: "News site"
            }

            TextField {
                focus: true
                id: urlNewsSite
                width: parent.width
                label: "URL News Site"
                text: newsSiteURL
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: reSection.focus = true
            }
            TextArea  {
                id: textExplanation
                width: parent.width
                readOnly: true
                text: qsTr("There are 3 levels of information.\n1. The main section containing 10 photos.\n2. The photo sections (figures).\n3. The information for each photo: url, caption, text, source.")
                font.pixelSize: Theme.fontSizeExtraSmall
                horizontalAlignment: Text.AlignLeft
            }

            SectionHeader {
                text: "Section level"
            }

            TextArea {
                id: reSection
                width: parent.width
                label: "RegExp for extracting the section"
                text: sectionRE
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: rePhoto.focus = true
            }

            SectionHeader {
                text: "Photo level"
            }

            TextField {
                id: rePhoto
                width: parent.width
                label: "RegExp for extracting each photo"
                text: photoRE
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: reJpg.focus = true
            }

            SectionHeader {
                text: "Photo details level"
            }

            TextField {
                id: reJpg
                width: parent.width
                label: "RegExp for extracting the jpg from each photo"
                text: jpgRE
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: reTitle.focus = true
            }
            TextField {
                id: reTitle
                width: parent.width
                label: "RegExp for extracting the title from each photo"
                text: titleRE
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: reCaption.focus = true
            }
            TextField {
                id: reCaption
                width: parent.width
                label: "RegExp for extracting the caption from each photo"
                text: captionRE
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: reSource.focus = true
            }
            TextField {
                id: reSource
                width: parent.width
                label: "RegExp for extracting the source from each photo"
                text: sourceRE
                EnterKey.iconSource: "image://theme/icon-m-enter-close"
                EnterKey.onClicked: focus = false
            }
            Button {
                text: "Reset all Settings"
                onClicked: {
                    resetPhoto()
                    urlNewsSite.text = newsSiteURL
                    reSection.text   = sectionRE
                    rePhoto.text     = photoRE
                    reJpg.text       = jpgRE
                    reTitle.text     = titleRE
                    reCaption.text   = captionRE
                    reSource.text    = sourceRE
                }
            }
        }
    }

    onDone: {
        if (result == DialogResult.Accepted) {
        }
    }
}
