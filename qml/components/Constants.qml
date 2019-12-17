/**
 * Copyright (c) 2019 Rob Kouwenberg

 *
 * This file is subject to the terms and conditions defined in
 * file 'LICENSE', which is part of this source code package.
 **/

import QtQuick 2.0

QtObject {
    property string devMail: "sailfishapp@cow-n-berg.nl"
    property url devGithub: "https://github.com/cow-n-berg"

    property url repoGithub: "https://github.com/cow-n-berg/harbour-news-photos"

    property string mailSubjectHeader: "[SailfishOS][News Photos " + Qt.application.version + "] "
    property string mailErrorSubjectHeader: "[SailfishOS][News Photos " + Qt.application.version + "][Error] "
    property string mailBodyHeader: "Hey Rob, "
}
