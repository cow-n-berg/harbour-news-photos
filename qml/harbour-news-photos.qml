import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import QtQuick.LocalStorage 2.0
import Sailfish.Silica 1.0
import "pages"
import "scripts/Storage.js" as Storage


ApplicationWindow
{
    id: generic

    property bool showSiteNOS          : Storage.get( "showSiteNOS", true )
    property bool showSiteGuardian     : Storage.get( "showSiteGuardian", true )
    property bool preferVerticalScroll : Storage.get( "preferVerticalScroll", false )
    property bool showTextOnPhoto      : Storage.get( "showTextOnPhoto", true )
    property bool showPhotoNumber      : Storage.get( "showPhotoNumber", true )
    property bool coverShowListView    : Storage.get( "coverShowListView", true )

    function xmlSiteUrl(showSiteNOS, showSiteGuardian) {
        var textShowNOS = (showSiteNOS) ? "true" : "false";
        var textShowGuardian = (showSiteGuardian) ? "true" : "false";
        return "https://www.escaperoomgetoutofhere.nl/specials/news-photos.php?nos=" + textShowNOS + "&guardian=" + textShowGuardian;
    }

    function saveSettings() {
        Storage.set( "showSiteNOS"         , showSiteNOS         );
        Storage.set( "showSiteGuardian"    , showSiteGuardian    );
        Storage.set( "preferVerticalScroll", preferVerticalScroll);
        Storage.set( "showTextOnPhoto"     , showTextOnPhoto     );
        Storage.set( "showPhotoNumber"     , showPhotoNumber     );
        Storage.set( "coverShowListView"   , coverShowListView   );
    }

    initialPage: Component { FirstPage { } }
    cover: (coverShowListView) ? Qt.resolvedUrl("cover/CoverList.qml") : Qt.resolvedUrl("cover/CoverGrid.qml")
    allowedOrientations: Orientation.All

    XmlListModel {
        id: feedListModel
        source: xmlSiteUrl(showSiteNOS, showSiteGuardian)
        query: "/rss/channel/item"

        namespaceDeclarations: "declare namespace dc='http://purl.org/dc/elements/1.1/'; declare namespace content='http://purl.org/rss/1.0/modules/content/';"

        XmlRole { name: "title"; query: "title/string()"; }
        XmlRole { name: "link"; query: "link/string()";}
        XmlRole { name: "description"; query: "description/string()"; }
        XmlRole { name: "source"; query: "source/string()"; }
        XmlRole { name: "site"; query: "site/string()"; }
        XmlRole { name: "number"; query: "number/string()"; }
        XmlRole { name: "image"; query: "enclosure/@url/string()"; }
    }
}
