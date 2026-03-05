import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: Theme.widthElemnt * 2.1
    height: Theme.heightElement

    property string label: "Label"
    property string  textField: "Label"
    property alias text: field.text
    property bool error: false
    property int bw: 1
    property int r: 4
    readonly property bool floating:
        field.activeFocus || field.text.length > 0

    /* ---------- TextField ---------- */
    TextField {
        id: field
        text: textField
        anchors.fill: parent
        padding: 12
        color: Theme.textMainColor
        font.pixelSize: Theme.mediumFontSize
        background: null
    }

    /* ---------- Border سفارشی (Theme-based) ---------- */
    Item {
        id: border
        anchors.fill: parent

        property color borderColor: error
            ? Theme.redColor
            : (field.activeFocus
               ? Theme.borderTexfieldColor
               : Theme.satelliteItemBorderColor)



        /* چپ */
        Rectangle {
            x: 0; y: r
            width: bw
            height: parent.height - r * 2
            color: border.borderColor
        }

        /* راست */
        Rectangle {
            x: parent.width - bw; y: r
            width: bw
            height: parent.height - r * 2
            color: border.borderColor
        }

        /* پایین */
        Rectangle {
            x: r; y: parent.height - bw
            width: parent.width - r * 2
            height: bw
            color: border.borderColor
        }

        /* بالا – سمت چپ */
        Rectangle {
            x: r
            y: 0
            height: bw
            width: floating
                   ? floatingLabel.x - r - 4
                   : parent.width - r * 2
            color: border.borderColor
            visible: !floating || width > 0
        }

        /* بالا – سمت راست */
        Rectangle {
            x: floating
               ? floatingLabel.x + floatingLabel.width + 4
               : 0
            y: 0
            height: bw
            width: floating
                   ? parent.width - x - r
                   : 0
            color: border.borderColor
            visible: floating
        }
    }

    /* ---------- Floating Label ---------- */
    Label {
        id: floatingLabel
        text: root.label

        color: error
            ? Theme.redColor
            : (field.activeFocus
               ? Theme.borderTexfieldColor
               : Theme.textSecondaryColor)

        font.pixelSize: floating
            ? Theme.smallFontSize
            : Theme.mediumFontSize

        font.weight: Theme.fontLightWeight

        anchors.left: parent.left
        anchors.leftMargin: 12

        y: floating
           ? -Theme.smallFontSize / 2
           : parent.height / 2 - height / 2

        Behavior on y {
            NumberAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
        }

        Behavior on font.pixelSize {
            NumberAnimation { duration: 150 }
        }
    }
}
