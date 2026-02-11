import QtQuick
Item {

    id:root
    width: 400 //radar.implicitWidth
    height: 400 //radar.implicitWidth
    visible: true
    //title: qsTr("Hello World")
    property var radarModel: RadarTargetModel
    SkyView{
        id:radar
    anchors.centerIn: parent
    width: parent.width
    height: parent.height
    radarModel: root.radarModel
    }
}
