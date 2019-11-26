#include "downloader.h"

Downloader::Downloader(QObject *parent) :
    QObject(parent)
{
}

void Downloader::getPhotos()
{
    // News site
    QString urlNewsSite = "https://nos.nl/";

    // Group all Regular Expressions together for future changes
    // Level 1: the section
    QString regExpSection = '<section id="nieuws_in_beeld">(.*)<\\/section>';
    // Level 2: 10 Photos, RegExp containing *? as the lazy (non greedy) form of *.
    QString regExpPhoto   = '<figure >(.*?)<\\/figure>';
    // Level 3: Information for each photo
    QString regExpJpgFile = 'src="([^"]*)"';
    QString regExpTitle   = 'class="caption-title">([^<]*)<';
    QString regExpCaption = 'class="caption-meta">([^<]*)<';
    QString regExpSource  = 'class="caption-source">([^<]*)<';

    // Download the html file
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);

    QNetworkRequest request;
    request.setUrl(QUrl(urlNewsSite));

    QNetworkReply *reply = manager->get(request);

    QString tekst = reply->readAll();

    QRegularExpression reSection(regExpSection);
    QRegularExpression::PatternOption = QRegularExpression::DotMatchesEverythingOption;

    QRegularExpressionMatch match = reSection.match(tekst);

    QString section;
    QJsonArray photoArray;

    if (match.hasMatch()) {
        section = match.captured(0);

        section.replace(QRegularExpression("\t"), "");
        section.replace(QRegularExpression("\n"), "");

        // So there's a Section text now, containing the 10 Photos
        QRegularExpression rePhoto(regExpPhoto);
        QRegularExpressionMatchIterator i = rePhoto.globalMatch(section);
        while (i.hasNext()) {
            QRegularExpressionMatch sectionMatch = i.next();
            QString photo = sectionMatch.captured(1);

            QString title   = "";
            QString caption = "";
            QString source  = "";

            // Within each Photo we have to find the data
            QRegularExpression rb(regExpTitle);
            QRegularExpressionMatch matchb = rb.globalMatch(photo);
            if (matchb.hasMatch()) title = matchd.captured(0);

            QRegularExpression rc(regExpCaption);
            QRegularExpressionMatch matchc = rc.globalMatch(photo);
            if (matchc.hasMatch()) caption = matchd.captured(0);

            QRegularExpression rd(regExpSource);
            QRegularExpressionMatch matchd = rd.globalMatch(photo);
            if (matchd.hasMatch()) source = matchd.captured(0);

            QRegularExpression ra(regExpJpgFile);
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
                    {"jpgPix",  jpgPix},
                    {"title",   title},
                    {"caption", caption},
                    {"source",  source}
                };
                photoArray->insert(photo);

            }

        }

    }

    return section;

}

