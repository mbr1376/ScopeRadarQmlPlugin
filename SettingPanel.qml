import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
Item {
    width: Theme.widthScreen *0.24
    height: Theme.heightScreen
    Rectangle{
        anchors.fill: parent
        color: "transparent"
        border.color: Theme.satelliteItemBorderColor
        border.width: 1
        ColumnLayout{

            anchors.fill: parent
            Button{
                text: "Apply"
                width: 80
                height: 5
                checkable: true
                hoverEnabled: true
                Layout.alignment:  Qt.AlignHCenter
                background:Rectangle {
                    id:rec
                    width: 80
                    height: 50
                    border.color: Theme.satelliteItemBorderColor
                    color: Theme.switchColor
                }
                contentItem :Text {
                    anchors.centerIn: rec
                    text: parent.text
                    color: Theme.darkMode ? Theme.darkGrayColor: Theme.lightGrayColor
                }
            }
        }
    }
}
