import QtQuick 2.0
import Sailfish.Silica 1.0

import QtMultimedia 5.0

Page {
    id: page

    property bool flashlightOn: flashlightSwitch.checked

    onFlashlightOnChanged: {
        unlockTimer.stop()
        searchAndLockTimer.stop()
        if(flashlightOn) {
            camera.searchAndLock()
        } else {
            camera.unlock()
        }
    }

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

            onLockStatusChanged: {
                log("lock status ch to " + lockStatus)
                if(!flashlightOn) {
                    return;
                }
                if(lockStatus === Camera.Unlocked) {
                    searchAndLockTimer.start()
                } else if ((lockStatus === Camera.Locked) && (unlockSwitch.checked)) {
                    unlockTimer.start()
                } else if ((lockStatus === Camera.Searching) && (!unlockSwitch.checked)) {
                    unlockTimer.start()
                }

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
            onTriggered: {
                log("s&L triggered")
                camera.searchAndLock()
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

            TextSwitch {
                id: flashlightSwitch
                text: "Flashlight on!"
                checked: false
            }
            Slider {
                id: searchLockSlider
                width: parent.width
                minimumValue: 0
                maximumValue: 5000
                value: 200
                valueText: "in " + parseInt(value) + "ms"
                label: "search after status is unlocked"

                Component.onCompleted: {
                    value = 1000
                }
            }
            TextSwitch {
                id: unlockSwitch
                checked: false
                text: "Unlock after Locked (not just searching)"
            }
            Slider {
                id: unlockSlider
                width: parent.width
                minimumValue: 0
                maximumValue: 5000
                value: 3000
                valueText: "in " + parseInt(value) + "ms after " + (unlockSwitch.checked ? "Locked" : "Searching")

                Component.onCompleted: {
                    value = 3000
                }
            }


        }
    }

    Component.onCompleted: {
        log("build 10")
        log("FocusContinuous is " + Camera.FocusContinuous)
    }

    function log(msg) {
        console.log(msg)
        logArea.text = msg + "\n" + logArea.text
    }
}
