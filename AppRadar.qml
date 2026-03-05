import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import ScopeRadarQmlPlugin

Item {
    width: Theme.widthScreen
    height : Theme.heightScreen
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
    Image {
        visible: !settingPanel.visible
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Theme.defaultSpacing
        source: "icons/settings.png"
        ColorOverlay{
            id:overlayer
            source: parent
            anchors.fill: parent
            color: Theme.greenColor
        }
        MouseArea{
            id:mouseArea
            hoverEnabled: true
            anchors.fill: parent
            onEntered:  {overlayer.color =Theme.greenColorhover;}
            onExited: {overlayer.color = Theme.greenColor;}
            onClicked: settingPanel.open()
        }

    }
    RadarProperty{
        id:pro
    }
    ScopRadar{
        anchors.centerIn: parent
    }

    SettingPanel{
        id:settingPanel
        edge: Qt.RightEdge
        prf:pro.pRF
        basewidth:pro.beamWidth
        pulsewidth:pro.pulseWidth
        noisefloor:pro.noiseFloor
        speedrpm:pro.antennaSpeedRPM
        longitude:pro.longitude
        latitude:pro.latitude
        altitude:pro.altitude
        currentRadarMode:pro.radarMode
        onApply:function ( lon,
                           lat,
                           alt,
                           prf,
                           beamwidth,
                           pulsewidth,
                           noise,
                           speedrpm,
                          radarmode){
            pro.setLongitude(parseFloat(lon))
            pro.setLatitude(parseFloat(lat))
            pro.setAltitude(parseFloat(alt))
            pro.setPRF(parseFloat(prf))
            pro.setBeamWidth(parseFloat(beamwidth))
            pro.setPulseWidth(parseFloat(pulsewidth))
            pro.setNoiseFloor(parseFloat(noise))
            pro.setAntennaSpeedRPM(parseFloat(speedrpm))
            pro.setRadarMode(parseInt(radarmode))
            console.info("set Settings")
        }


    }

}
