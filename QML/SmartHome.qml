import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Window 2.11
import My_DevList 1.0

ApplicationWindow {
    visible: true
    width: Screen.width//750 * .472
    height: Screen.height//1334 * .472
    title: qsTr("SmartHome")
    //实现ios沉浸状态栏
    modality: Qt.NonModal
    //实现ios沉浸状态栏
    Component.onCompleted: {
        this.showNormal();
    }

    Login {
        id: loginView
        visible: true
        loginButton.onClicked: {
            loginView.visible = false
            swipeView.visible = true
            //tabBar.visible = true
        }
    }

    //Swipe界面实例
    SwipeView {
        id: swipeView
        visible: false
        anchors.fill: parent
        //设置当前索引为tabBar的当前索引
        currentIndex: tabBar.currentIndex

        //设备窗口实例
        Dev {
        }
        //用户窗口实例
        User {
        }
    }

    //footer窗口页脚 TabBar 不同视图或子任务的切换
    footer: TabBar {
        id: tabBar
        visible: false
        //设置当前索引为Swipe的当前索引
        currentIndex: swipeView.currentIndex

        //页脚TabButton(表按钮)实例
        TabButton {
            text: qsTr("设备")
        }
        //页脚TabButton(表按钮)实例
        TabButton {
            text: qsTr("用户")
        }
    }
}
