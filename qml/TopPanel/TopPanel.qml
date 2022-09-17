import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0

Rectangle {
    id: topPanel
    property alias buildingsButtonState: buildingsButton.state
    property alias dashboardButtonState: dashboardButton.state
    property alias logoutButtonState: logoutButton.state

    function showTopMenu(show) {
        if (show) {
            topMenu.visible = true;
            topMenu.x = appIcon.x + appIcon.width;
        } else {
            topMenu.visible = false;
            topMenu.x = topPanel.width;
        }
    }

    signal dashboardClicked()
    signal buildingsClicked()
    signal logoutClicked();

    Image {
        id: appIcon
        height: parent.height
        source: "qrc:/resources/logo.png"
        width: heights*2+30
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(login){
                    // do Open
                    sideDrawer.open()
                }
            }
        }
    }

    Text {
        id: dashBoardLoginText
        visible: !topMenu.visible
        text: qsTr("IIOT Dashboard System")
        font.letterSpacing: 2
        color: "gray"
        font.pixelSize: 24
        font.bold:true
        anchors{
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: topMenu
        x: topPanel.width
        y: 0
        width: topPanel.width - appIcon.width
        height: topPanel.height
        visible: loginFlag;
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1377e0" }
            GradientStop { position: 1.0; color: "#3f3be0" }
        }

        Behavior on x {
            NumberAnimation {
                //This specifies how long the animation takes
                duration: 600
                //This selects an easing curve to interpolate with, the default is Easing.Linear
                easing.type: Easing.OutBounce
            }
        }

        RowLayout {
            anchors.fill: topMenu
            anchors.margins: 0
            spacing: 0

            MenuButton {
                id: dashboardButton
                buttonText: qsTr("DASHBOARD")
                state: "Pressed"
                onClicked: {
                    topPanel.dashboardClicked()
                    buildingsButton.state = "Normal"
                }
            }

            MenuButton {
                id: buildingsButton
                buttonText: qsTr("BUILDINGS")
                onClicked: {
                    topPanel.buildingsClicked()
                    dashboardButton.state = "Normal"
                }
            }

            MenuButton {
                id: logoutButton
                buttonText: qsTr("Logout")
                onClicked: {
                    topPanel.logoutClicked()
                    topPanel.showTopMenu(false);
                    logoutButton.state = "Normal"
                    login = false;
                }
            }

            MenuButton {
                id: deviceStatus
                buttonText: qsTr("Device Status")
                onClicked: {

                }
            }


            MenuButton {
                id: sensorStatus
                buttonText: qsTr("Sensor Status")
                onClicked: {

                }
            }
            MenuButton {
                id: sensorData
                buttonText: qsTr("Sensor Data")
                onClicked: {

                }
            }
            MenuButton {
                id: quite
                buttonText: qsTr("Quit")
                onClicked: {
                    Qt.quit()
                }
            }

            Item {
                // spacer item
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}


