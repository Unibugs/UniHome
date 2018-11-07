import QtQuick 2.11
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4  //包含控件风格

Rectangle {
    id: loginRect
    anchors.fill: parent

    Image {
        id: logoImage
        source: "qrc:/Doc/images/750-1334.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit   //设置等比例模式
    }

    //登录界面ui，为账号和密码输入ui，内部负责与c++通信
    LoginForm {
        id: loginForm
        //水平中线对齐父级水平中线
        anchors.horizontalCenter: parent.horizontalCenter
        //垂直中线对齐父级垂直中线
        anchors.verticalCenter: parent.verticalCenter
        //垂直中线向上移动70点
        anchors.verticalCenterOffset: 0

        account.onTextEdited: {
            accounttipText.visible = false
            if(account.text === "")
                accounttipText.visible = true
        }

        password.onTextEdited: {
            passwordtipText.visible = false
            if(password.text === "")
                passwordtipText.visible = true
        }
    }

    /*gradient: Gradient {
        GradientStop {
            position: 0.993
            color: "#ffffff"
        }

        GradientStop {
            position: 0
            color: "#0d84bf"
        }
    }*/

    //相当于全局声明，在此qml外可以操作loginButton对象
    property alias loginButton: loginButton
    //登录按钮
    Button {
        id: loginButton
        height: 45
        width: 280
        //垂直中线对齐loginForm的垂直中线
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 150
        Text {
            id: loginText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
            text: "登录"
            color: "#ffffff"
        }

        style: ButtonStyle {    //style只在QtQuick.Controls 1.x中才有 2.x会报错 ButtonStyle在QtQuick.Controls.Styles中
            background: Rectangle { //用Rectangle定制背景
                //Rectangle填充按钮
                anchors.fill: parent
                //如果按下或悬停按键为c0c0c0否则888888
                color: control.pressed ? "#31a56e" : "#24c789"
                //绘制圆角
                radius: 22.5
            }
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
