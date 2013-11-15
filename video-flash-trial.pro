# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = video-flash-trial

# Maybe isn't really needed for QML camera, but just in case
QT += multimedia

CONFIG += sailfishapp

SOURCES += src/video-flash-trial.cpp

OTHER_FILES += qml/video-flash-trial.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/video-flash-trial.spec \
    rpm/video-flash-trial.yaml \
    video-flash-trial.desktop

