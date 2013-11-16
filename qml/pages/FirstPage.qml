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

            focus.focusMode: parseInt(focusModeSwitch.value)

            focus.onFocusModeChanged: {
                log("focus mode ch to " + focus.focusMode)
            }

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

        Timer {
            id: searchAndLockTimer
            interval: parseInt(searchLockSlider.value)
            repeat: true
            onTriggered: {
                log("s&L triggered")
                camera.searchAndLock()
                if(unlockSwitch.checked)
                {
                    unlockTimer.start()
                }
            }
        }

        Timer {
            id: unlockTimer
            interval: parseInt(unlockSlider.value)
            onTriggered: {
                log("unlock triggered")
                camera.unlock()
            }
        }

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
            Slider {
                id: focusModeSwitch
                width: parent.width
                minimumValue: 0
                maximumValue: 5
                stepSize: 1
                valueText: value
                label: "focus mode"
            }

            Button {
                text: "Stop searchAndLocking"
                onClicked: {
                    searchAndLockTimer.stop()
                }
            }
            Button {
                text: "Start searchAndLocking every"
                onClicked: {
                    searchAndLockTimer.restart()
                }
            }
            Slider {
                id: searchLockSlider
                width: parent.width
                minimumValue: 0
                maximumValue: 3000
                value: 200
                valueText: parseInt(value) + "ms"

                Component.onCompleted: {
                    value = 200
                }
            }
            TextSwitch {
                id: unlockSwitch
                checked: false
                text: "Unlock after search start in "
            }
            Slider {
                id: unlockSlider
                enabled: unlockSwitch.checked
                width: parent.width
                minimumValue: 0
                maximumValue: 500
                value: 200
                valueText: parseInt(value) + "ms"

                Component.onCompleted: {
                    value = 200
                }

                Rectangle {
                    anchors.fill: parent
                    color: "lightgrey"
                    opacity: 0.8
                    visible: !parent.enabled
                }
            }


        }
    }

    Component.onCompleted: {
        log("build 9")
        log("onSupport: " + onSupport)  // <-- API tells it's supported, but it's not
        log("torchSupport: " + torchSupport)
    }

    function log(msg) {
        console.log(msg)
        logArea.text = msg + "\n" + logArea.text
    }
}
