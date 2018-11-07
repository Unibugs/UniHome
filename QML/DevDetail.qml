import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

DevDetailForm {
    id: devDetailForm


    Text {
        id: powerText
        text: qsTr("text")
    }
    //相当于全局声明，在此qml外可以操作loginButton对象
    /*property alias reDevPageButton: reDevPageButton
    RoundButton {
        id: reDevPageButton
        text: qsTr("×")
        height: 15
        width: 15
        highlighted: true
        anchors.margins: 15
        anchors.right: parent.right
        anchors.top: parent.top

    }*/
}


