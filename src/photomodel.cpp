/*
  Copyright (C) 2015 Jolla Ltd.
  Contact: Jussi Pakkanen <jussi.pakkanen@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include "photomodel.h"

PhotoModel::PhotoModel(QObject *parent) :
    QAbstractListModel(parent)
{
    backing << "sea cow" << "platypus" << "axolotl" << "quokka" << "pitahui" << "jerboa";
}

void PhotoModel::resetRegExp() {
    newsSiteURL = "https://nos.nl/";
    sectionRE   = "<section id=\"nieuws_in_beeld\">(.*)<\\/section>";
    photoRE     = "<figure >(.*?)<\\/figure>";
    jpgRE       = "src=\"([^\"]*)\"";
    titleRE     = "class=\"caption-title\">([^<]*)<";
    captionRE   = "class=\"caption-meta\">([^<]*)<";
    sourceRE    = "class=\"caption-source\">([^<]*)<";
}

void PhotoModel::getPhotos()
{
    if (newsSiteURL.empty()) PhotoModel::resetRegExp();

    // Download the html file
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);

    QNetworkRequest request;
    request.setUrl(QUrl(newsSiteURL));

    QNetworkReply *reply = manager->get(request);

    QString tekst = reply->readAll();

    QRegularExpression reSection(sectionRE);
    QRegularExpression::PatternOption = QRegularExpression::DotMatchesEverythingOption;

    QRegularExpressionMatch match = reSection.match(tekst);

    QString section;

    if (match.hasMatch()) {
        section = match.captured(0);

        section.replace(QRegularExpression("\t"), "");
        section.replace(QRegularExpression("\n"), "");

        // So there's a Section text now, containing the 10 Photos
        QRegularExpression rePhoto(photoRE);
        QRegularExpressionMatchIterator i = rePhoto.globalMatch(section);
        while (i.hasNext()) {
            QRegularExpressionMatch sectionMatch = i.next();
            QString photo = sectionMatch.captured(1);

            QString title   = "";
            QString caption = "";
            QString source  = "";

            // Within each Photo we have to find the data
            QRegularExpression rb(titleRE);
            QRegularExpressionMatch matchb = rb.globalMatch(photo);
            if (matchb.hasMatch()) title = matchb.captured(0);

            QRegularExpression rc(captionRE);
            QRegularExpressionMatch matchc = rc.globalMatch(photo);
            if (matchc.hasMatch()) caption = matchc.captured(0);

            QRegularExpression rd(sourceRE);
            QRegularExpressionMatch matchd = rd.globalMatch(photo);
            if (matchd.hasMatch()) source = matchd.captured(0);

            QRegularExpression ra(jpgRE);
            QRegularExpressionMatch matcha = ra.globalMatch(photo);
            if (matcha.hasMatch()) {
                QString jpgUrl = matcha.captured(0);

                // Download jpg
                request.setUrl(QUrl(jpgUrl));
                QNetworkReply *reply = manager->get(request);
                QPixmap jpgPix;
                jpgPix.loadFromData(reply->readAll());

                // Construct JSON
                QJsonObject photo
                {
                    {"jpgUrl",  jpgUrl},
                    {"jpgPix",  jpgPix},
                    {"title",   title},
                    {"caption", caption},
                    {"source",  source}
                };
                photoArray->insert(photo);
            }
        }
    }
}
