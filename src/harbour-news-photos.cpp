#include <sailfishapp.h>
#include <QtQuick>
#include <QScopedPointer>
#include "photomodel.h"

int main(int argc, char *argv[])
{
    // Set up qml engine.
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> v(SailfishApp::createView());

    // If you wish to publish your app on the Jolla harbour, follow
    // https://harbour.jolla.com/faq#5.3.0 about naming own QML modules.
    qmlRegisterType<PhotoModel>("harbour-news-photos", 1, 0, "DemoModel");

    // Start the application.
    v->setSource(SailfishApp::pathTo("qml/harbour-news-photos.qml"));
    v->show();
    return app->exec();
}

