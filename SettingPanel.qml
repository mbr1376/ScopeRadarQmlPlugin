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
    background:Rectangle {
        anchors.fill: parent
        color: Theme.slideColor
    }

       ColumnLayout{

            anchors.centerIn: parent
            FloatingComboBox{
                label: "RadarMode"
                _model:["Search","Lock"]
            }

            TexfildeItem{
                label: "Longitude"
                textField: longitude
            }
            TexfildeItem{
                label: "Latitude"
                textField: latitude
            }
            TexfildeItem{
                label: "Altitude"
                textField: altitude
            }
            TexfildeItem{
                label: "Repetition Frequency"
                textField: prf
            }
            TexfildeItem{
                label: "BeamWidth"
                textField: basewidth
            }
            TexfildeItem{
                label: "PulseWidth"
                textField: pulsewidth
            }
            TexfildeItem{
                label: "NoiseFloor"
                textField: noisefloor
            }
            TexfildeItem{
                label: "AntennaSpeedRPM"
                textField: speedrpm
            }

            Button{
                text: "Apply"

                checkable: true
                hoverEnabled: true
                Layout.alignment:  Qt.AlignHCenter
                background:Rectangle {
                    id:rec
                    width: Theme.widthElemnt
                    height: Theme.heightElement
                    color:  Theme.buttonBackgroundColor
                }
                contentItem :Text {
                    anchors.centerIn: rec
                    text: parent.text
                    color: Theme.darkMode ? Theme.darkGrayColor: Theme.lightGrayColor
                }
            }
        }
}
