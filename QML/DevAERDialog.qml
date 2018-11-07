import QtQuick 2.11
import QtQuick.Controls 2.4

/*会话窗体
  功能：实现创建和修改触摸目标
  窗体中小窗体在ui中声明
*/
Dialog {
    id: dialog  //设置会话id

    x: parent.width / 2 - width / 2
    y: parent.height / 2 - height / 2

    opacity: 0.9
    focus: true
    modal: true
    title: qsTr("Add Dev")    //设置对话框标题
    standardButtons: Dialog.Ok | Dialog.Cancel  //设置对话框按钮 OK和Cancle

    contentItem: DevAERDialogForm {
        id: devAERDialogForm
    }

    //会话完成信号
    signal finished(string diaName, string diaState, string diaRoom, string diaAddress)

    //函数创建触摸目标
    function createDev() {
        //清除DialogForm（会话ui）姓名，dialogForm为下面DialogForm的声明，使得可以访问DialogForm中的属性
        //相当于一个声明
        devAERDialogForm.diaName.clear();
        devAERDialogForm.diaState.clear();
        devAERDialogForm.diaRoom.clear();
        devAERDialogForm.diaAddress.clear();

        dialog.title = qsTr("Add Dev");   //设置dialog标题为Add Touch
        dialog.open();          //打开会话窗口
    }

    function editDev(DevInfor) {
        devAERDialogForm.diaName.text = DevInfor.devname;
        devAERDialogForm.diaState.text = DevInfor.devstate;
        devAERDialogForm.diaRoom.text = DevInfor.devroom;
        devAERDialogForm.diaAddress.text = DevInfor.devaddress;

        dialog.title = qsTr("Edit Dev Target");
        dialog.open();
    }

    function editDevState_on(DevInfor) {
        devAERDialogForm.diaName.text = DevInfor.devname;
        devAERDialogForm.diaState.text = "开";
        devAERDialogForm.diaRoom.text = DevInfor.devroom;
        devAERDialogForm.diaAddress.text = DevInfor.devaddress;

        dialog.accept();
    }

    function editDevState_off(DevInfor) {
        devAERDialogForm.diaName.text = DevInfor.devname;
        devAERDialogForm.diaState.text = "关";
        devAERDialogForm.diaRoom.text = DevInfor.devroom;
        devAERDialogForm.diaAddress.text = DevInfor.devaddress;

        dialog.accept();
    }

    onAccepted: finished(devAERDialogForm.diaName.text, devAERDialogForm.diaState.text,
                         devAERDialogForm.diaRoom.text, devAERDialogForm.diaAddress.text)
}
