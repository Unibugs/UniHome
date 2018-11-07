import QtQuick 2.11
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4



/*会话窗体
  实现修改增加目标的界面
*/
//网格布局对象
Item {
    id: logoTextInput

    property alias account: account
    property alias accounttipText: accounttipText
    property alias password: password
    property alias passwordtipText: passwordtipText
    //文本字段对象
    TextInput {
        id: account
        width: 280
        height: 45
        font.pointSize: 30
        anchors.centerIn: parent
        //placeholderText: "手机号/邮箱/用户名"
        color: "#ffffff"

        Rectangle {
            color: "#ffffff"
            height: 0.5
            width: parent.width
            opacity: 0.3
            anchors.top: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: accounttipText
            text: qsTr("手机号/邮箱/用户名")
            color: "#ffffff"
            opacity: 0.3
            font.pointSize: 20
            anchors.centerIn: parent
        }
    }

    TextInput {
        id: password
        width: 280
        height: 45
        font.pointSize: 30
        anchors.top: account.bottom
        anchors.topMargin: 20
        anchors.left: account.left
        color: "#ffffff"
        echoMode: TextInput.Password
        //placeholderText: "密码"
        Rectangle {
            color: "#ffffff"
            height: 0.5
            width: parent.width
            opacity: 0.3
            anchors.top: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: passwordtipText
            text: qsTr("密码(至少六位)")
            color: "#ffffff"
            opacity: 0.3
            font.pointSize: 20
            anchors.centerIn: parent
        }
    }
}


/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
