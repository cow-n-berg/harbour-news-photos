import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    id: generic

    property bool showSiteNOS          : true
    property bool showSiteGuardian     : true
    property bool preferVerticalScroll : false
    property bool showTextOnPhoto      : true

    function xmlSiteUrl(showSiteNOS, showSiteGuardian) {
        var textShowNOS = (showSiteNOS) ? "true" : "false";
        var textShowGuardian = (showSiteGuardian) ? "true" : "false";
        return "https://www.escaperoomgetoutofhere.nl/specials/rob-nos.php?nos=" + textShowNOS + "&guardian=" + textShowGuardian;
    }

    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
//    allowedOrientations: defaultAllowedOrientations
    allowedOrientations: Orientation.All

    XmlListModel {
        id: feedListModel
//        source: "https://www.escaperoomgetoutofhere.nl/specials/rob-nos.php"
        source: xmlSiteUrl(showSiteNOS, showSiteGuardian)
        query: "/rss/channel/item"

        namespaceDeclarations: "declare namespace dc='http://purl.org/dc/elements/1.1/'; declare namespace content='http://purl.org/rss/1.0/modules/content/';"

        XmlRole { name: "title"; query: "title/string()"; }
        XmlRole { name: "link"; query: "link/string()";}
        XmlRole { name: "description"; query: "description/string()"; }
        XmlRole { name: "source"; query: "source/string()"; }
        XmlRole { name: "site"; query: "site/string()"; }
        XmlRole { name: "image"; query: "enclosure/@url/string()"; }
    }
}
