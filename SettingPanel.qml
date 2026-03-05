import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
Drawer {
    width: Theme.widthScreen *0.24
    height: Theme.heightScreen
    property string longitude
    property string latitude
    property string altitude
    property string prf
    property string basewidth
    property string pulsewidth
    property string noisefloor
    property string speedrpm
    property int currentRadarMode
    signal apply (string lon,
                  string lat,
                  string alt,
                  string prf,
                  string beamwidth,
                  string pulsewidth,
                  string  noise,
                  string speedrpm,
                  int radarmode)
    background:Rectangle {
        anchors.fill: parent
        color: Theme.slideColor
    }

       ColumnLayout{

            anchors.centerIn: parent
            FloatingComboBox{
                id:_radarmode
                label: "RadarMode"
                model:["Search","Lock"]
                currentIndex:currentRadarMode

            }

            TexfildeItem{
                id:_lon
                label: "Longitude"
                text: longitude
            }
            TexfildeItem{
                id:_lat
                label: "Latitude"
                text: latitude
            }
            TexfildeItem{
                id:_alt
                label: "Altitude"
                text: altitude
            }
            TexfildeItem{
                id:_prf
                label: "Repetition Frequency"
                text: prf
            }
            TexfildeItem{
                id:_beam
                label: "BeamWidth"
                text: basewidth
            }
            TexfildeItem{
                id:_pulse
                label: "PulseWidth"
                text: pulsewidth
            }
            TexfildeItem{
                id:_noise
                label: "NoiseFloor"
                text: noisefloor
            }
            TexfildeItem{
                id:_speedrpm
                label: "AntennaSpeedRPM"
                text: speedrpm
            }

            Button{
                text: "Apply"

                checkable: true
                hoverEnabled: true
                Layout.alignment:  Qt.AlignHCenter
                onClicked:{
                    apply(_lon.text,
                          _lat.text,
                          _alt.text,
                          _prf.text,
                          _beam.text,
                          _pulse.text,
                          _noise.text,
                          _speedrpm.text,
                          _radarmode.currentIndex)
                }

                background:Rectangle {
                    id:rec
                    width: Theme.widthElemnt
                    height: Theme.heightElement
                    color:  parent.hovered ? Theme.greenColorhover: Theme.buttonBackgroundColor

                }
                contentItem :Text {
                    anchors.centerIn: rec
                    text: parent.text
                    color: Theme.darkMode ? Theme.darkGrayColor: Theme.lightGrayColor
                }
            }
        }
}
