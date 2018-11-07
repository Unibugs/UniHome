import QtQuick 2.11
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4



/*会话窗体
  实现修改增加目标的界面
*/
//网格布局对象
GridLayout {
    id: grid


    /*
     结构：property alias 别名：属性名
     取下文TextField的id为属性名并给他定义一个fullName的别名
     为了其他的QML文档访问TextField对象，让每个文本字段对象有自己的名字
    */
    property alias diaName: diaName
    property alias diaState: diaState
    property alias diaRoom: diaRoom
    property alias diaAddress: diaAddress


    /*
      qml 中的 property 的作用是动态为对象添加属性，并且添加的属性可以进行跟踪（值被修改了就会发出信号）
    */
    property int minimumInputSize: 120
    property string placeholderText: qsTr("<enter>")

    rows: 3 //设置网格4行
    columns: 2 //设置网格2列

    //文本对象
    Label {
        text: qsTr("设备名称：") //设置文本内容
        Layout.alignment: Qt.AlignLeft //布局对其：左对齐和基线对齐
    }

    //文本字段对象
    TextField {
        id: diaName
        focus: true
        Layout.fillWidth: true //布局填充宽度
        Layout.minimumWidth: grid.minimumInputSize //设置最小宽度为网格最小尺寸
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline //布局对其：左对齐和基线对齐
        placeholderText: grid.placeholderText //文本空字段使用网格的空字段 也就是上面的property string placeholderText: qsTr("<enter>")
    }

    Label {
        visible: false
        text: qsTr("设备状态")
        Layout.alignment: Qt.AlignLeft
    }

    TextField {
        id: diaState
        visible: false
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        placeholderText: grid.placeholderText
    }

    Label {
        text: qsTr("设备房间：")
        Layout.alignment: Qt.AlignLeft
    }

    TextField {
        id: diaRoom
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        placeholderText: grid.placeholderText
    }

    Label {
        text: qsTr("设备地址：")
        Layout.alignment: Qt.AlignLeft
    }

    TextField {
        id: diaAddress
        Layout.fillWidth: true
        Layout.minimumWidth: grid.minimumInputSize
        Layout.alignment: Qt.AlignLeft | Qt.AlignBaseline
        placeholderText: grid.placeholderText
    }
}
