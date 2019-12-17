#include <sailfishapp.h>
#include <QtQuick>
#include <QScopedPointer>
#include "demomodel.h"
//#include "photomodel.h"

int main(int argc, char *argv[])
{
    // Set up qml engine.
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> v(SailfishApp::createView());

    qmlRegisterType<DemoModel>("harbour-news-photos", 1, 0, "DemoModel");
//    qmlRegisterType<PhotoModel>("harbour-news-photos", 1, 0, "PhotoModel");

    // Start the application.
    v->setSource(SailfishApp::pathTo("qml/harbour-news-photos.qml"));
    v->show();
    return app->exec();
}

