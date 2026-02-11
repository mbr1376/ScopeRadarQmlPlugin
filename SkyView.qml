
import QtQuick
import QtQuick.Shapes
//import SatelliteInformation

Rectangle {
    id: root

    // Multisample this item to get rid of aliasing in our custom shapes.
    layer.enabled: true
    layer.samples: 4
    // Sample text to calculate sky view size properly
    Text {
        id: sampleText
        visible: false
        text: "270°"
        font.pixelSize: Theme.smallFontSize
        font.weight: Theme.fontLightWeight
    }

        required property var radarModel
    //required property color inViewColor
    //required property color inUseColor


    readonly property real fullRadius: width < height ? width / 2 - sampleText.width * 1.1
                                                      : height / 2 - sampleText.height * 1.1

    readonly property real maxUsedRadius: 0.9 * fullRadius
    readonly property real radiusStep: maxUsedRadius / 9
    readonly property int centerX: width / 2
    readonly property int centerY: height / 2

    color: Theme.darkBackgroundColor

    // Shape for the SkyView
    Shape {
        id: rootShape
        readonly property color mainColor: Theme.textMainColor
        readonly property color dashedColor: Qt.rgba(mainColor.r,
                                                     mainColor.g,
                                                     mainColor.b,
                                                     0.5)
        // Circles
        component ElevationCircle: ShapePath {
            id: circle

            property color color: "white"
            property real radius: 0
            property bool dashed: false

            strokeColor: circle.color
            fillColor: "transparent"
            strokeStyle: circle.dashed ? ShapePath.DashLine : ShapePath.SolidLine
            dashPattern: [4, 4]
            PathAngleArc {
                centerX: root.centerX
                centerY: root.centerY
                radiusX: circle.radius
                radiusY: circle.radius
                startAngle: 0
                sweepAngle: 360
            }
        }

        ElevationCircle {
            radius: root.fullRadius
            color: Theme.greenColor
        }
        ElevationCircle {
            radius: root.radiusStep * 9
            color: rootShape.dashedColor
            dashed: true
        }
        ElevationCircle {
            radius: root.radiusStep * 7
            color: rootShape.dashedColor
            dashed: true
        }
        ElevationCircle {
            radius: root.radiusStep * 5
            color: rootShape.dashedColor
            dashed: true
        }
        ElevationCircle {
            radius: root.radiusStep * 3
            color: rootShape.dashedColor
            dashed: true
        }
        ElevationCircle {
            radius: root.radiusStep
            color: rootShape.mainColor
        }

        // Lines
        component Line: ShapePath {
            id: line
            readonly property color green: Theme.greenColor
            strokeColor: Qt.rgba(green.r, green.g, green.b, 0.5)
            property real angle
            property real radianAngle: line.angle / 180 * Math.PI
            startX: root.centerX + root.fullRadius * Math.cos(radianAngle)
            startY: root.centerY + root.fullRadius * Math.sin(radianAngle)
            PathLine {
                x: root.centerX + root.fullRadius * Math.cos(line.radianAngle + Math.PI)
                y: root.centerY + root.fullRadius * Math.sin(line.radianAngle + Math.PI)
            }
        }

        Line {
            angle: 0
        }
        Line {
            angle: 30
        }
        Line {
            angle: 60
        }
        Line {
            angle: 90
        }
        Line {
            angle: 120
        }
        Line {
            angle: 150
        }

        // Azimuth captions
        component AzimuthCaption: Text {
            id: textElement
            property real angle
            property real offsetX: 0
            property real offsetY: 0
            // Subtract 90, because 0 should be on top, not on the right
            property real radianAngle: (angle - 90) / 180 * Math.PI
            // end of line coordinates
            property int lineX: root.centerX + root.fullRadius * Math.cos(radianAngle)
            property int lineY: root.centerY + root.fullRadius * Math.sin(radianAngle)
            x: lineX + offsetX
            y: lineY + offsetY
            text: angle.toFixed(0) + '°'
            color: Theme.textMainColor
            font.pixelSize: Theme.smallFontSize
            font.weight: Theme.fontLightWeight
        }

        AzimuthCaption {
            text: 'N'
            angle: 0
            offsetY: -height
            offsetX: -width / 2
        }
        AzimuthCaption {
            angle: 30
            offsetY: -height
        }
        AzimuthCaption {
            angle: 60
            offsetX: width * 0.5
            offsetY: -height / 2
        }
        AzimuthCaption {
            text: 'E'
            angle: 90
            offsetX: width * 0.5
            offsetY: -height / 2
        }
        AzimuthCaption {
            angle: 120
        }
        AzimuthCaption {
            angle: 150
        }
        AzimuthCaption {
            text: 'S'
            angle: 180
            offsetX: -width / 2
        }
        AzimuthCaption {
            angle: 210
            offsetX: -width / 2
            offsetY: height / 2
        }
        AzimuthCaption {
            angle: 240
            offsetX: -width
        }
        AzimuthCaption {
            text: 'W'
            angle: 270
            offsetX: -width * 1.5
            offsetY: -height / 2
        }
        AzimuthCaption {
            angle: 300
            offsetX: -width
            offsetY: -height
        }
        AzimuthCaption {
            angle: 330
            offsetX: -width
            offsetY: -height
        }

        // Elevation captions
        component ElevationCaption: Text {
            property real step
            x: root.centerX - implicitWidth / 2
            y: root.centerY - (step * root.radiusStep + implicitHeight)
            color: Theme.textMainColor
            font.pixelSize: Theme.smallFontSize
            font.weight: Theme.fontLightWeight
        }

        ElevationCaption {
            text: "80°"
            step: 1
        }
        ElevationCaption {
            text: "60°"
            step: 3
        }
        ElevationCaption {
            text: "40°"
            step: 5
        }
        ElevationCaption {
            text: "20°"
            step: 7
        }
        ElevationCaption {
            text: "0°"
            step: 9
        }
    }
    Canvas {
            id: radarCanvas
            anchors.fill: parent
            antialiasing: true

            property real angle: 0
            property real radius: root.fullRadius

            onAngleChanged: requestPaint()

            onPaint: {
                var ctx = getContext("2d")

                ctx.globalCompositeOperation = "destination-out"
                ctx.fillStyle = "rgba(0,0,0,0.12)"
                ctx.fillRect(0, 0, width, height)
                ctx.globalCompositeOperation = "source-over"

                var cx = root.centerX
                var cy = root.centerY
                var rad = (angle - 90) * Math.PI / 180

                var grad = ctx.createLinearGradient(
                            cx, cy,
                            cx + radius * Math.cos(rad),
                            cy + radius * Math.sin(rad))

                grad.addColorStop(0.0, "rgba(0,255,0,0.0)")
                grad.addColorStop(0.6, "rgba(0,255,0,0.25)")
                grad.addColorStop(1.0, "rgba(0,255,0,0.9)")

                ctx.strokeStyle = grad
                ctx.lineWidth = 2

                ctx.beginPath()
                ctx.moveTo(cx, cy)
                ctx.lineTo(
                    cx + radius * Math.cos(rad),
                    cy + radius * Math.sin(rad)
                )
                ctx.stroke()
            }

            NumberAnimation on angle {
                from: 0
                to: 360
                duration: 2500
                loops: Animation.Infinite
                easing.type: Easing.Linear
            }
        }
    Repeater {
        model: radarModel

        delegate: Rectangle {
            id: targetRect

            property real rad: (azimuth - 90) * Math.PI / 180
            property real dist: root.maxUsedRadius * (90 - elevation) / 90

            x: root.centerX + dist * Math.cos(rad) - width / 2
            y: root.centerY + dist * Math.sin(rad) - height / 2

            // آیا sweep روی این نقطه است؟
            property bool sweepOnPoint: Math.abs((radarCanvas.angle % 360) - azimuth) < 1.5

            // رنگ و اندازه وقتی sweep روی نقطه است
            color: sweepOnPoint ? Qt.rgba(0, 1, 0, 1.0) : Qt.rgba(0, 1, 0, strength)
            width: sweepOnPoint ? 14 : 8
            height: width
            radius: width / 2
            property bool hover: false

                   MouseArea {
                       anchors.fill: parent
                       hoverEnabled: true
                       onEntered: targetRect.hover = true
                       onExited: targetRect.hover = false
                   }

                   // نمایش مقدار elevation
                   Rectangle {
                       visible: targetRect.hover
                       x: parent.width + 5
                       y: -10
                       color: Theme.legendBackgroundColor
                       radius: 4
                       border.color: "gray"
                       border.width: 1
                       width: infoText.width + 10
                       height: infoText.height + 4

                       Text {
                           id: infoText
                           anchors.centerIn: parent
                            font.weight: Theme.fontLightWeight
                            text: "Az: " + azimuth.toFixed(0) + "°\nEl: " + elevation.toFixed(0) + "°"
                           font.pixelSize: 12
                           color: Theme.textMainColor
                       }
                   }
        }
    }

}
