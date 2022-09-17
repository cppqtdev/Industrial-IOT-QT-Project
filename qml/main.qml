import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtGraphicalEffects 1.0

import "./ContentView"
import "./TopPanel"
import "../Drawer"
ApplicationWindow {
    id: mainWindow
    visibility: "FullScreen"
    width: 1024
    height: 680
    title: qsTr("IIOT DashBoard")
   // flags: Qt.FramelessWindowHint
    // This is available in all editors.
    property bool loginFlag: false
    color: "white"

    minimumWidth: 1024
    minimumHeight: 680


    Column {
        anchors.topMargin: parent.topMargin
        anchors.verticalCenter: parent.verticalCenter
        spacing: 0

        TopPanel {
            id: topPanel
            width: mainWindow.width
            height: 70
            dashboardButtonState: "Pressed"
        }
        ContentView {
            id: contentView
            objectName:"contentView"
            height: mainWindow.height - topPanel.height
            width: mainWindow.width

            onLogedIn: {
                topPanel.showTopMenu(true);
            }

            onLogedOut: {
                topPanel.showTopMenu(false);
            }

            onShowNotificationDetails: {
                topPanel.dashboardButtonState = "Normal";
                topPanel.buildingsButtonState = "Pressed"
            }
        }
    }

    Connections {
        target: topPanel
        onDashboardClicked: {
            contentView.showBuildingsView(false);
            contentView.showDashboard(true);
        }
        onBuildingsClicked: {
            contentView.showDashboard(false);
            contentView.showBuildingsView(true);
        }

        onLogoutClicked: {
            contentView.showLoginView(true);
        }
    }

    /*Side Drawer */

    PageDrawer {
         id: sideDrawer

         //
         // Icon properties
         //
         iconTitle: "IIOT DashBoard"
         iconSource: "qrc:/resources/logo.png"
         iconSubtitle: qsTr ("Version 1.0 Beta")

         //
         // Define the actions to take for each drawer item
         // Drawers 5 and 6 are ignored, because they are used for
         // displaying a spacer and a separator
         //
         actions: {
             0: function() { console.log ("Item 1 clicked!") },
             1: function() { console.log ("Item 2 clicked!") },
             2: function() { console.log ("Item 3 clicked!") },
             3: function() { console.log ("Item 4 clicked!") },
             4: function() { console.log ("Item 5 clicked!") },
             7: function() { console.log ("Item 6 clicked!") },
             8: function() { console.log ("Item 7 clicked!") }
         }

         //
         // Define the drawer items
         //
         items: ListModel {
             id: pagesModel

             ListElement {
                 pageTitle: qsTr ("Home")
                 pageIcon: "qrc:/DrawerIcons/house-user-solid.svg"
             }

             ListElement {
                 pageTitle: qsTr ("Scores Table")
                 pageIcon: "qrc:/DrawerIcons/mobile-screen-solid.svg"
             }

             ListElement {
                 pageTitle: qsTr ("Charts")
                 pageIcon: "qrc:/DrawerIcons/chart-line-solid.svg"
             }

             ListElement {
                 pageTitle: qsTr ("Leaderboard")
                 pageIcon: "qrc:/DrawerIcons/cash-register-solid.svg"
             }

             ListElement {
                 pageTitle: qsTr ("Settings")
                 pageIcon: "qrc:/DrawerIcons/sliders-solid.svg"
             }

//             ListElement {
//                 spacer: true
//             }

             ListElement {
                 separator: true

             }

             ListElement {
                 pageTitle: qsTr ("Learn Romanian Whist")
                 pageIcon: "qrc:/DrawerIcons/star-half-stroke-solid.svg"
             }

             ListElement {
                 pageTitle: qsTr ("Feature Requests / Bugs")
                 pageIcon: "qrc:/DrawerIcons/bug-solid.svg"
             }

         }
     }
}
