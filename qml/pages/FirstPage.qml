import QtQuick 2.0
import Sailfish.Silica 1.0

import QtMultimedia 5.0

Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Show Page 2"
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }

        Camera {
            id: camera

            flash.mode: Camera.FlashOn
            flash.onReadyChanged: {
                log("flash ready ch to " + flash.ready)
            }

            flash.onModeChanged: {
                log("flash mode ch to " + flash.mode)
            }

            onCameraStatusChanged: {
                log("cam status ch to " + cameraStatus)
            }

            onCameraStateChanged: {
                log("cam state ch to " + cameraState)
            }

            onCaptureModeChanged: {
                log("capture mode ch to " + captureMode)
            }

            onErrorStringChanged: {
                log("cam error: " + errorString)
            }

            videoRecorder.onErrorStringChanged: {
                log("vid err: " + errorString)
            }

            videoRecorder.onRecorderStateChanged: {
                log("vid state ch to " + recorderState)
            }

            videoRecorder.onRecorderStatusChanged: {
                log("vid status ch to " + recorderStatus)
            }

            imageCapture.onErrorStringChanged: {
                log("img err: " + errorString)
            }

            Component.onCompleted: {
                log("cam init state: ")
                log("flash ready is " + flash.ready)
                log("flash mode is " + flash.mode)
                log("cam status is " + cameraStatus)
                log("cam state is " + cameraState)
                log("capture mode is " + captureMode)
            }
        }


        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "Test flashlight camera APIs"
            }
            TextArea {
                id: logArea
                height: 200
                width: parent.width
            }
            Button {
                text: "cap mode to just viewfinder"
                onClicked: {
                    camera.captureMode = Camera.CaptureViewfinder
                }
            }
            Button {
                text: "cap mode to still img"
                onClicked: {
                    camera.captureMode = Camera.CaptureStillImage
                }
            }
            Button {
                text: "cap mode to video"
                onClicked: {
                    camera.captureMode = Camera.CaptureVideo
                }
            }
            Button {
                text: "Flash to Off"
                onClicked: {
                    camera.flash.mode = Camera.FlashOff
                }
            }

            Button {
                text: "Flash to On"
                onClicked: {
                    camera.flash.mode = Camera.FlashOn
                }
            }
            Button {
                text: "cam start()"
                onClicked: {
                    camera.start()
                }
            }

            Button {
                text: "cam Stop()"
                onClicked: {
                    camera.stop()
                }
            }

            Button {
                text: "recorder record()"
                onClicked: {
                    camera.videoRecorder.record()
                }
            }

            Button {
                text: "recorder stop()"
                onClicked: {
                    camera.videoRecorder.stop()
                }
            }

            Button {
                text: "capture()"
                onClicked: {
                    camera.imageCapture.capture()
                }
            }

            Button {
                text: "Search and lock"
                onClicked: {
                    camera.searchAndLock()
                }
            }
        }
    }

    Component.onCompleted: {
        log("build 7")
        log("onSupport: " + onSupport)  // <-- API tells it's supported, but it's not
        log("torchSupport: " + torchSupport)
    }

    function log(msg) {
        console.log(msg)
        logArea.text = msg + "\n" + logArea.text
    }
}
