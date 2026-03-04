import QtQuick
import QtQuick.Controls
 import Qt5Compat.GraphicalEffects
Item {
    width: 800
    height : 480
    Rectangle{
        anchors.fill: parent
        color: Theme.darkBackgroundColor
    }
    Switch {
               id: themeSwitch
               checked: Theme.darkMode
               anchors.top: parent.top
               anchors.left: parent.left
               anchors.margins: Theme.defaultSpacing
               onToggled: {
                  Theme.darkMode = checked;
               }
               width: 60
               height: 35
               background: Rectangle {
                   radius: height / 2
                   color: Theme.switchColor

               }
               indicator: Rectangle {
                       width: parent.height * 0.9
                       height: parent.height * 0.9
                       radius: width / 2
                       color: Theme.settingsEntryBackground
                       Image {
                              width: parent.width * 0.8
                              height:  parent.height* 0.8
                              fillMode: Image.PreserveAspectFit
                              anchors.centerIn: parent
                              source: Theme.darkMode ? "icons/darkMode.png" : "icons/lightMode.png"
                              ColorOverlay{
                                anchors.fill: parent
                                source: parent
                                color: Theme.darkMode ? Theme.lightGrayColor : Theme.yellowColor
                              }
                       }
                       Behavior on x {
                           NumberAnimation {
                               duration: 200 // زمان انیمیشن بر حسب میلی‌ثانیه
                               easing.type: Easing.InOutQuad
                           }
                       }

                       x: themeSwitch.checked
                          ? themeSwitch.width - width
                          : 0
                       anchors.verticalCenter: parent.verticalCenter
                   }
    }


    ScopRadar{
        anchors.centerIn: parent
    }

}
