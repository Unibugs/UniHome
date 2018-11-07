import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import My_DevList 1.0

Page {
    width: 750 * .5//Screen.width//750 * .472
    height: 1334 * .5//Screen.height//1334 * .472


    property int currentDevIndex: -1

    //设备界面的背景颜色
    Rectangle {
        id: devBack
        anchors.fill: parent
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

    //显示在线设备数量
    Text {
        id: onlineDevText
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 30
        //gridView.count This property holds the number of items in the view.
        text: qsTr("在线设备：" + gridView.count + "台")
    }

    DevDetail {
        id: devDetail
        anchors.fill: parent
        anchors.topMargin: 90
        //opacity: 0.9
        visible: false
    }

    //设备GridView的Delegate
    Component {
        id: gridDelegate
        Item {
            id: wrapper//包装器
            width: gridView.cellWidth
            height: gridView.cellHeight

            //鼠标对象
            MouseArea {
                anchors.fill: parent
                //按下模块矩形 进入模块详情
                onClicked: {
                    //将选择的当前条目赋给currentIndex
                    //加入鼠标控制事件，不加入则只能通过键盘控制
                    //index是ListView暴露的一个属性，代表当前Item所对应的索引位置
                    //DevDetail入口
                    wrapper.GridView.view.currentIndex = index
                    devDetail.visible = true
                    gridView.visible = false

                    addDevButtom_sign.text = "◁"
                    addDevButtom_sign.font.pixelSize = 15
                    addDevButtom_sign.anchors.verticalCenterOffset = 1
                    addDevButtom_sign.anchors.horizontalCenterOffset = -1
                    /*anchors.verticalCenterOffset: 1
                    anchors.horizontalCenterOffset: -1*/
                }

                onPressAndHold: {
                    currentDevIndex = index
                    devERMenu.open()    //显示TouchViewForm中内容
                }
            }

            //模块矩形
            Rectangle {
                id: rolerect
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 3
                radius: 8
                //opacity: 0.9
                width: 178
                height: 110

                //模块里面的状态按钮开关
                Image {
                    id: devstateButton
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 25
                    source: "qrc:/Doc/images/devswitch-off.svg"
                    sourceSize: Qt.size(40, 40)
                    fillMode: Image.PreserveAspectFit   //设置等比例模式
                    smooth: true

                    MouseArea {
                        id: devstateArea
                        anchors.fill: devstateButton
                        onClicked: {
                            wrapper.GridView.view.currentIndex = index
                            currentDevIndex = index
                            if(devstateButton.source == "qrc:/Doc/images/devswitch-on.svg") {
                                devstateButton.source = "qrc:/Doc/images/devswitch-off.svg"
                                devAERDialog.editDevState_off(gridView.model.get(currentDevIndex))
                            }
                            else {
                                devstateButton.source = "qrc:/Doc/images/devswitch-on.svg"
                                devAERDialog.editDevState_on(gridView.model.get(currentDevIndex))
                            }
                        }
                    }
                }
            }

            //设备名称文本
            Text {
                id: devName
                text: devname
                anchors.top: rolerect.top
                anchors.topMargin: 6
                anchors.left: rolerect.left
                anchors.leftMargin: 8
                //如果鼠标点击该成员该文本颜色为红色：白色
                //color: wrapper.GridView.isCurrentItem ? "red" : "black"
                font.pixelSize: 15
            }
            //设备状态文本
            Text {
                id: devState
                text: devstate
                anchors.bottom: rolerect.bottom
                anchors.bottomMargin: 8
                anchors.left: devName.left
                //color: wrapper.GridView.isCurrentItem ? "red" : "black"
                font.pixelSize: 11
            }
            //设备家庭文本
            Text {
                id: devRoom
                text: devroom
                color: "#585757"
                anchors.top: devName.bottom
                anchors.left: devName.left
                font.pixelSize: 12
            }
            //设备地址
            Text {
                id: devAddress
                visible: false
                text: devaddress
                anchors.top: devName.bottom
                anchors.right: rolerect.right
                font.pixelSize: 12
            }
        }
    }

    GridView {
        id: gridView
        visible: true
        anchors.topMargin: 97
        anchors.fill: parent
        cellWidth: parent.width * .5
        cellHeight: 120//parent.height * .5
        //delegate使用listDelegate对象，delegate为列表一列中的子成员，
        //每个子成员如devname称为role，此例中role为2
        delegate: gridDelegate

        //model使用listModel
        //ListModel专门定义列表数据，其内部维护着一个ListElement列表
        /*
        //QML中的model 不能与C++混用
        model: gridModel.createObject(GridView)
        */

        //使用C++ DevList类创建的Model
        model: DevList {
            id: devList
        }

        focus: true
    }


    //实例化DevAERDialog的会话窗体也就是添加修改的窗体
    DevAERDialog {
        id: devAERDialog //设置id 便于其他对象调用
        onFinished: {   //修改或添加信息完成的信号函数
            if (currentDevIndex === -1)
                gridView.model.append(diaName, "关", diaRoom, diaAddress) //调用c++函数添加目标信息
            else
                gridView.model.set(currentDevIndex, diaName, diaState, diaRoom, diaAddress)  //调用c++函数修改目标信息
        }
    }

    //长按设备修改和删除的菜单
    //通过菜单可以进入修改页面，修改页面的会话窗口与添加会话窗口相同，只是更换窗口头
    Menu {
        //ER表示Edit与Remove
        id: devERMenu
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2
        width: parent.width * 0.8
        opacity: 0.9
        modal: true

        //菜单窗体的头文字
        Label {
            padding: 10
            font.bold: true
            width: parent.width
            //居中
            horizontalAlignment: Qt.AlignHCenter
            //当不是添加的索引时菜单头为当前长按目标的设备名字
            text: currentDevIndex >= 0 ? gridView.model.get(currentDevIndex).devname : ""
        }
        //菜单选项之一 编辑该设备
        MenuItem {
            text: qsTr("修改该设备")
            //调用devAERDialog会话的editDev编辑设备函数
            onTriggered: devAERDialog.editDev(gridView.model.get(currentDevIndex))
        }
        //菜单选项之二 移除该设备
        MenuItem {
            text: qsTr("移除该设备")
            onTriggered: gridView.model.remove(currentDevIndex)
        }
    }

    //添加设备按钮
    RoundButton {
        id: addDevButtom
        Text {
            id: addDevButtom_sign
            text: qsTr("+")//◁
            font.pixelSize: 25
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: -1
            anchors.horizontalCenterOffset: 1
        }
        //visible: gridView.visible
        highlighted: true
        opacity: 0.9
        anchors.margins: 10
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            if(addDevButtom_sign.text == "+") {
                //按下添加按钮当前索引设置为-1 准备添加设备
                currentDevIndex = -1
                //调用devAERDialog设备会话窗口的创建设备函数
                devAERDialog.createDev()
            } else {
                addDevButtom_sign.text = "+"
                addDevButtom_sign.font.pixelSize = 25
                addDevButtom_sign.anchors.verticalCenterOffset = -1
                addDevButtom_sign.anchors.horizontalCenterOffset = 1

                devDetail.visible = false
                gridView.visible = true
            }
        }
    }
}
