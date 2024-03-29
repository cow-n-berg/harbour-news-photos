# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-news-photos

CONFIG += sailfishapp_qml

DISTFILES += qml/harbour-news-photos.qml \
    qml/cover/CoverDelegate.qml \
    qml/cover/CoverPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/PhotoDelegate.qml \
    qml/pages/PhotoPage.qml \
    qml/scripts/ExternalLinks.js \
    qml/scripts/Storage.js \
    rpm/harbour-news-photos.changes.in \
    rpm/harbour-news-photos.changes.run.in \
    rpm/harbour-news-photos.spec \
    rpm/harbour-news-photos.yaml \
    translations/*.ts \
    harbour-news-photos.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

DEFINES += \
    APP_VERSION=\"\\\"$${VERSION}\\\"\"

# to disable building translations every time, comment out the
# following CONFIG line
#CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/harbour-news-photos-nl.ts
