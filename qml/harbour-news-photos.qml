import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "components"

ApplicationWindow
{
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
//    allowedOrientations: Orientation.Landscape
    allowedOrientations: defaultAllowedOrientations

    XmlListModel {
        id: feedListModel
        source: "https://www.escaperoomgetoutofhere.nl/specials/rob-nos.php"
        namespaceDeclarations: "declare default element namespace 'http://www.w3.org/2005/Atom';"
        query: "/rss/channel/item"

//        namespaceDeclarations: "declare namespace dc='http://purl.org/dc/elements/1.1/'; declare namespace content='http://purl.org/rss/1.0/modules/content/';"

        XmlRole { name: "title"; query: "title/string()"; }
        XmlRole { name: "link"; query: "link/string()";}
        XmlRole { name: "description"; query: "description/string()"; }
        XmlRole { name: "source"; query: "source/string()"; }
        XmlRole { name: "image"; query: "enclosure/@url/string()"; }

        onStatusChanged: {
            root.modelDataError = false
            if (status == XmlListModel.Error) {
                root.state = "Offline"
                root.statusMessage = "Error occurred: " + errorString()
                root.modelDataError = true
                //console.log("Weather Clock: " + root.statusMessage)
            } else if (status == XmlListModel.Ready) {
                // check if the loaded model is not empty, and post a message
                if (get(0) === undefined) {
                    root.state = "Offline"
                    root.statusMessage = "Invalid location \"" + root.location + "\""
                    root.modelDataError = true
                } else {
                    root.state = "Live Weather"
                    root.statusMessage = "Live current weather is available"
                }
                //console.log("Weather Clock: " + root.statusMessage)
            } else if (status == XmlListModel.Loading) {
                root.state = "Loading"
                root.statusMessage = "Forecast data is loading..."
                //console.log("Weather Clock: " + root.statusMessage)
            } else if (status == XmlListModel.Null) {
                root.state = "Loading"
                root.statusMessage = "Forecast data is empty..."
                //console.log("Weather Clock: " + root.statusMessage)
            } else {
                root.modelDataError = false
                console.log("Weather Clock: unknown XmlListModel status:" + status)
            }
        }
    }
}

