import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Page {
    width: 750 * .5//Screen.width//750 * .472
    height: 1334 * .5
    //Screen.height//1334 * .472

    //用户界面渐变背景
    Rectangle {
        id: userBack
        anchors.fill:parent
        gradient: Gradient {
            GradientStop {
                position: 0.993
                color: "#ffffff"
            }

            GradientStop {
                position: 0
                color: "#0d84bf"
            }
        }
    }

    Component {
        id: listDelegate
        Item {
            id: wrapper//包装器
            width: parent.width
            height: 40

            //鼠标对象
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    //将选择的当前条目赋给currentIndex
                    //加入鼠标控制事件，不加入则只能通过键盘控制
                    //index是ListView暴露的一个属性，代表桑钱Item所对应的索引位置
                    wrapper.ListView.view.currentIndex = index
                    //添加一条数据
                    //如果在listview内用model.append（{}）
                    /*wrapper.ListView.view.model.append (
                        {
                            "devname" : "003",
                            "devstate" : "关",
                            "devroom" : "bed room"
                        }

                    )
                    //listView.model.setProperty(index, "ddd", "dddd")
                    //删除当前索引的listview中的model中的当前索引的那一列
                    wrapper.ListView.view.model.remove(index)*/
                }
            }
            //内存放Role
            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 13
                //设备名称文本
                Text {
                    id: setName
                    text: setname
                    //如果鼠标点击该成员该文本颜色为红色：白色
                    color: wrapper.ListView.isCurrentItem ? "red" : "black"
                    font.pixelSize: 15
                    //Layout.preferredWidth: 120
                    Layout.fillWidth: true
                }
            }
        }
    }

    //用户界面列表成员
    Component {
        id: listModel
        ListModel {
            ListElement {
                setname: "设备"
            }
            ListElement {
                setname: "固件升级"
            }
            ListElement {
                setname: "能源管理"
            }
        }
    }

    //用户界面圆角方框
    Rectangle {
        id: userRect
        anchors.fill: parent
        anchors.topMargin: 100
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        radius: 8
        opacity: 0.9

        ListView {
            id: listView
            anchors.fill: parent
            anchors.topMargin: 80
            anchors.leftMargin: 20
            //delegate使用listDelegate对象，delegate为列表一列中的子成员，
            //每个子成员如devname称为role，此例中role为2
            delegate: listDelegate
            //model使用listModel
            //ListModel专门定义列表数据，其内部维护着一个ListElement列表
            model: listModel.createObject(listView)

            focus: true
        }
    }

    //显示头像
    Item {
        width: 100
        height: 100
        anchors.horizontalCenter: userRect.horizontalCenter
        anchors.verticalCenter: userRect.top
        Image {
            id: img
            source: "qrc:/Doc/images/head-user.jpg"
            sourceSize: Qt.size(parent.width, parent.height)
            smooth: true
            visible: false
        }
        Rectangle{
            id:mask
            anchors.fill: parent
            radius: width/2.
        }
        OpacityMask {
            anchors.fill: parent
            source: img
            maskSource: mask
        }
    }
}
