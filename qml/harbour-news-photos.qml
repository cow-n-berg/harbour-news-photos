import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import QtQuick.LocalStorage 2.0
import Sailfish.Silica 1.0
import "pages"
import "scripts/Storage.js" as Storage


ApplicationWindow
{
    id: generic

    property string version            : "2.4"
    property int  showSiteVolkskrant   : Storage.get( "showSiteVolkskrant", 1 )
    property bool showSiteGuardian     : Storage.get( "showSiteGuardian", true )
    property int  showSiteSpiegel      : Storage.get( "showSiteSpiegel", 1 )
    property bool preferVerticalScroll : Storage.get( "preferVerticalScroll", false )
    property bool showTextOnPhoto      : Storage.get( "showTextOnPhoto", true )
    property bool showPhotoNumber      : Storage.get( "showPhotoNumber", true )
    property bool coverShowListView    : Storage.get( "coverShowListView", true )
    property bool coverShowAppName     : Storage.get( "coverShowAppName", false )

    function xmlSiteUrl(showSiteVolkskrant, showSiteGuardian, showSiteSpiegel) {
        var textShowVolkskrant = showSiteVolkskrant.toString()
        var textShowGuardian = (showSiteGuardian) ? "true" : "false"
        var textShowSpiegel = showSiteSpiegel.toString()
        var site = "http://www.cow-n-berg.nl/sailfishos/news-photos.php"
        var url = site + "?volkskrant=" + textShowVolkskrant + "&guardian=" + textShowGuardian + "&spiegel=" + textShowSpiegel
        console.log( url );

        return url;
    }

    function saveSettings() {
        Storage.set( "showSiteVolkskrant"  , showSiteVolkskrant  )
        Storage.set( "showSiteGuardian"    , showSiteGuardian    )
        Storage.set( "showSiteSpiegel"     , showSiteSpiegel     )
        Storage.set( "preferVerticalScroll", preferVerticalScroll)
        Storage.set( "showTextOnPhoto"     , showTextOnPhoto     )
        Storage.set( "showPhotoNumber"     , showPhotoNumber     )
        Storage.set( "coverShowListView"   , coverShowListView   )
        Storage.set( "coverShowAppName"    , coverShowAppName    )
    }

    initialPage: Component { PhotoPage { } }
    cover: (coverShowListView) ? Qt.resolvedUrl("cover/CoverList.qml") : Qt.resolvedUrl("cover/CoverGrid.qml")
    allowedOrientations: Orientation.All

    XmlListModel {
        id: feedListModel
        source: xmlSiteUrl(showSiteVolkskrant, showSiteGuardian, showSiteSpiegel)
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
