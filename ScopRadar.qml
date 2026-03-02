import QtQuick
import ScopeRadarQmlPlugin

Item {

    id:root
    width: 400 //radar.implicitWidth
    height: 400 //radar.implicitWidth
    visible: true
    //title: qsTr("Hello World")
    RadarTargetModel {
        id: radarModel
    }
    RadarProperty{
        id:pro
    }


    SkyView{
        id:radar
    anchors.centerIn: parent
    width: parent.width
    height: parent.height
    radarModel: radarModel
    currentRadarHeading : pro.headigRadar
    noiseFloor: pro.noiseFloor
    }
}
