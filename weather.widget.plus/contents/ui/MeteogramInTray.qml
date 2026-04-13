/*
 * Copyright 2015  Martin Kotelnik <clearmartin@seznam.cz>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http: //www.gnu.org/licenses/>.
 */
import QtQuick
import QtQuick.Window
import QtQml.Models
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import "../code/unit-utils.js" as UnitUtils
import "../code/icons.js" as IconTools

Item {
    id: meteogram
    // visible: true

    // anchors.fill: parent.fill
    // width: meteogram3.width
    // height: meteogram3.height


    // implicitWidth: 450 //490
    // implicitHeight: 300 //300

    // width: 450
    // height: 300
    // || main.widgetWidth / 1.6 //meteogram3.width
    // || main.widgetHeight //meteogram3.height

    // Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

    Layout.minimumWidth: 300 //main.widgetWidthInTray //main.widgetWidth * 0.58 //460
    Layout.minimumHeight: 200 //main.widgetHeightInTray //300

    property int widgetWidth: main.widgetWidthInTray //470 //Kirigami.Units.largeSpacing * 4 //main.widgetWidthInTray //Math.max(main.widgetWidthInTray, meteogram.width) //464 * 0.58 // 460
    property int widgetHeight: main.widgetHeightInTray //300 //Kirigami.Units.largeSpacing * 3 //main.widgetHeightInTray //Math.max(main.widgetHeightInTray, meteogram.height) //300
    // property int widgetWidth: meteogram3.width //main.widgetWidth / 1.63 //meteogram3.width
    // property int widgetHeight: meteogram3.height //main.widgetHeight //meteogram3.height
    property int hourSpanOm: main.hourSpanOm
    property int imageWidth: widgetWidth - (labelWidth * 2)
    property int imageHeight: widgetHeight  - (labelHeight * 1.75) - 28 //windarea
    property int labelWidth: textMetrics.width
    property int labelHeight: textMetrics.height
    property int graphAreaWidth: graphArea.width
    property int graphAreaHeight: graphArea.height

    property int mgAxisFontSize: main.mgAxisFontSize - 2 //9
    property int mgPressureFontSize: main.mgAxisFontSize - 2 //9
    property int mgHoursFontSize: main.mgHoursFontSize - 1 //main.mgHoursFontSize - 3
    property int mgTrailingZeroesFontSize: main.mgTrailingZeroesFontSize //4

    // property bool tempLabelVisible: plasmoid.configuration.tempLabelVisible
    // property bool pressureLabelVisible: plasmoid.configuration.pressureLabelVisible
    // property int tempLabelPosition: plasmoid.configuration.tempLabelPosition
    // property int pressureLabelPosition: plasmoid.configuration.pressureLabelPosition
    // property bool precLabelVisChoice: plasmoid.configuration.precLabelVisChoice

    // property int windarea: 28

    property bool meteogramModelChanged: main.meteogramModelChanged

    property int temperatureYGridCount: 21 // temperatureIncrementDegrees > 21 ? 35 : 21   // Number of vertical grid Temperature elements
    property double temperatureIncrementDegrees: 0 // Major Step - How much each Temperature grid element rises by in Degrees
    property double temperatureIncrementPixels: imageHeight / (temperatureYGridCount - 1)  // Major Step - How much each Temperature grid element rises by in Pixels

    property int pressureSizeY: 101     // Number of virtual grid Pressure Elements
    property int pressureMultiplier: Math.round((pressureSizeY - 1) / (temperatureYGridCount - 1)) // Major Step - How much each Pressure grid element rises by in HPa

    property int pressureOffsetY: -950 // Move Pressure Graph down by 950
    property double pressureMultiplierY: imageHeight / (pressureSizeY - 1)// Major Step - How much each Pressure grid element rises by in Pixels
    // property double topBottomCanvasMargin: (imageHeight / temperatureYGridCount) * 0.5

    property int dataArraySize: 2

    property bool textColorLight: ((Kirigami.Theme.textColor.r + Kirigami.Theme.textColor.g + Kirigami.Theme.textColor.b) / 3) > 0.5
    property color gridColor: textColorLight ? Qt.tint(Kirigami.Theme.textColor, '#80000000') : Qt.tint(Kirigami.Theme.textColor, '#80FFFFFF')
    property color gridColorHighlight: textColorLight ? Qt.tint(Kirigami.Theme.textColor, '#50000000') : Qt.tint(Kirigami.Theme.textColor, '#50FFFFFF')
    property color gridColorBrightHighlight: textColorLight ? Qt.tint(Kirigami.Theme.textColor, '#25000000') : Qt.tint(Kirigami.Theme.textColor, '#25FFFFFF')
    property color pressureColor: Kirigami.Theme.positiveTextColor
    property color temperatureWarmColor: Kirigami.Theme.negativeTextColor
    property color temperatureColdColor: Kirigami.Theme.visitedLinkColor
    property color rainColor: Kirigami.Theme.linkColor // textColorLight ? Qt.tint(Kirigami.Theme.linkColor, '#25FFFFFF') : Qt.tint(Kirigami.Theme.linkColor, '#50000000')


    property int precipitationFontPixelSize: 7
    property int precipitationHeightMultiplier: 15
    // property bool precLabelVisible: counter > 0

    property double sampleWidth: graphArea.width / (meteogramModel.count - 1)

    property int temperatureType: main.temperatureType
    property int timezoneType: main.timezoneType
    property int pressureType: main.pressureType
    property int windSpeedType: main.windSpeedType
    property int precType: main.precType

    // property bool plasmoidExpanded: main.expanded
    // property int counter: 0

    onMeteogramModelChangedChanged: {
        dbgprint2('METEOGRAM changed')
        buildMeteogramData()
        processMeteogramData()
        buildCurves()
    }

    // onPlasmoidExpandedChanged: {
    //     // buildCurves()
    //     // loadingData.failedAttemptCount = 0
    //     // meteogram.counter = counter + 1
    //     // main.loadDataFromInternet()
    //     // dbgprint2("expansionCounted")
    //     expansionCounter()
    // }

    // onCanvasesWidthChanged: {
    //     buildCurves()
    // }

    onWidgetWidthChanged: {
        // buildCurves()
        if (main.loadingDataComplete === true) {
            dbgprint2('Meteogram width in tray changed')
            loadingData.failedAttemptCount = 0
            main.loadDataFromInternet()
        }
    }

    onWidgetHeightChanged: {
        // buildCurves()
        if (main.loadingDataComplete === true) {
            dbgprint2('Meteogram height in tray changed')
            loadingData.failedAttemptCount = 0
            main.loadDataFromInternet()
        }
    }

    onHourSpanOmChanged: {
        if (main.loadingDataComplete === true) {
            dbgprint2('Hour Span changed')
            loadingData.failedAttemptCount = 0
            main.loadDataFromInternet()
        }
    }

    // onTimezoneTypeChanged: {
    //     dbgprint2('TimezoneType changed')
    //     loadingData.failedAttemptCount = 0
    //     main.loadDataFromInternet()
    // }


    ListModel {
        id: verticalGridModel
    }
    ListModel {
        id: hourGridModel
    }
    ListModel {
        id: bufferGridModel
    }
    ListModel {
        id: actualWeatherModel
    }
    ListModel {
        id: nextDaysModel
    }

    TextMetrics {
        id: textMetrics
        font.family: Kirigami.Theme.defaultFont.family
        font.pixelSize: 11
        text: "999999"
    }

    // Item {
    //     id: meteogram
    //     width: imageWidth + (labelWidth * 2)
    //     height: imageHeight + (labelHeight) + windarea
    // }

    Rectangle {
        id: graphArea
        width: imageWidth
        height: imageHeight
        anchors.top: meteogram.top
        anchors.topMargin: labelHeight + 24
        anchors.left: meteogram.left
        anchors.leftMargin: labelWidth
        // anchors.fill: meteogram
        // anchors.right: meteogram.right
        // anchors.rightMargin: labelWidth

        // anchors.bottom: meteogram.bottom

        // anchors.bottomMargin: -1

        // Layout.minimumWidth: imageWidth
        // Layout.minimumHeight: imageHeight

        border.color: "transparent" //gridColor
        color: "transparent"

        // Component.onCompleted: {
        //     buildCurves()
        // }

        // Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
    }

    Rectangle {
        id: bufferArea
        width: imageWidth
        height: imageHeight + 42 //54
        anchors.top: meteogram.top
        anchors.topMargin: labelHeight
        anchors.left: meteogram.left
        anchors.leftMargin: labelWidth
        // anchors.fill: meteogram
        // anchors.right: meteogram.right
        // anchors.rightMargin: labelWidth
        
        // anchors.bottom: meteogram.bottom

        // anchors.bottomMargin: -22 //labelHeight + windspeedAnchor.height

        border.color: gridColor
        color: "transparent"

        // Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
    }

    ListView {
        id: horizontalLines
        model: verticalGridModel
        anchors.fill: graphArea
        anchors.top: graphArea.top - 38
        // anchors.topMargin: 38
        // anchors.left: graphArea.left
        // anchors.right: graphArea.right
        interactive: false
        // orientation: ListView.Vertical
        // snapMode: ListView.SnapToItem
        displayMarginBeginning: 48
        displayMarginEnd: 4
        // contentY: 0

        Component.onCompleted: {
            positionViewAtBeginning()
            // forceLayout()
            // decrementCurrentIndex()
        }

        delegate: Item {
            height: graphArea.height / (temperatureYGridCount - 1)
            width: graphArea.width //imageWidth
            visible:  num % 2 === 0
            anchors.top: index < 1 ? parent.top : undefined

            Rectangle {
                id: gridLine
                width: parent.width
                height: 1
                color: gridColor
            }
            PlasmaComponents.Label {
                text: UnitUtils.getTemperatureNumberExt(-temperatureIncrementDegrees + (temperatureYGridCount - num), temperatureType)
                height: labelHeight
                width: labelWidth
                horizontalAlignment: Text.AlignRight
                anchors.top: gridLine.top
                anchors.topMargin: -labelHeight / 2
                anchors.left: gridLine.left
                anchors.leftMargin: -labelWidth - 6
                font.pixelSize: mgAxisFontSize
                font.pointSize: -1
            }
            PlasmaComponents.Label {
                text: String(UnitUtils.getPressureNumber((pressureSizeY - 1 - num * pressureMultiplier) -pressureOffsetY, pressureType))
                height: labelHeight
                width: labelWidth
                anchors.top: gridLine.top
                anchors.topMargin: -labelHeight / 2
                anchors.left: gridLine.right
                anchors.leftMargin: 6
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: mgAxisFontSize
                font.pointSize: -1
                color: pressureColor
            }
        }
    }

    PlasmaComponents.Label {
        text: UnitUtils.getPressureEnding(pressureType)
        height: labelHeight
        width: labelWidth
        horizontalAlignment: Text.AlignLeft //(UnitUtils.getPressureEnding(pressureType).length > 4) ? Text.AlignRight : Text.AlignLeft
        anchors.right: (graphArea.right)
        anchors.rightMargin: -labelWidth * 1.1 //textMetrics.width //pressureType === 2 ? -labelWidth * 1.10 : -labelWidth * 1.15
        // visible: pressureLabelPosition === 2 ? false : true
        font.pixelSize: mgAxisFontSize
        font.pointSize: -1
        color: pressureColor
        anchors.top: bufferArea.top
    }

    PlasmaComponents.Label {
        text: temperatureType === 0 ? "°C" : temperatureType === 1 ? "°F" : "K"
        height: labelHeight
        width: labelWidth
        horizontalAlignment: Text.AlignRight //(UnitUtils.getPressureEnding(pressureType).length > 4) ? Text.AlignRight : Text.AlignLeft
        anchors.left: graphArea.left
        anchors.leftMargin: -labelWidth * 1.15 //textMetrics.width
        // visible: tempLabelPosition === 2 ? false : true
        font.pixelSize: mgAxisFontSize
        font.pointSize: -1
        // color: gridColorBrightHighlight
        // opacity: 0.6
        anchors.top: bufferArea.top //graphArea.top
        // anchors.topMargin: tempLabelPosition === 1 ? -labelHeight : 0 //6
        // anchors.bottom: bufferArea.top //graphArea.top
        // anchors.bottomMargin: -labelHeight //6
    }

    ListView {
        id: hourGrid
        model: hourGridModel
        property double hourItemWidth: hourGridModel.count === 0 ? 0 : graphArea.width / (hourGridModel.count - 1)
        anchors.fill: bufferArea
        anchors.leftMargin: 1
        anchors.rightMargin : 1
        interactive: false
        orientation: ListView.Horizontal
        delegate: Item {
            height: labelHeight
            width: hourGrid.hourItemWidth
            anchors.leftMargin: labelWidth

            property int hourFrom: dateFrom.getHours()
            property string hourFromStr: UnitUtils.getHourText(hourFrom, twelveHourClockEnabled)
            property string hourFromEnding: twelveHourClockEnabled ? UnitUtils.getAmOrPm(hourFrom) : '00'
            property bool dayBegins: hourFrom === 0
            property bool hourVisible: hourFrom % 2 === 0
            property bool textVisible: hourVisible && index < hourGridModel.count-1
            property int timePeriod: isDaytime ? 0 : 1

            property double precAvg: parseFloat(precipitationAvg) || 0

            property string precAvgStr: precipitationFormat(precAvg)

            Rectangle {
                id: verticalLine
                width: dayBegins ? 2 : 1
                height: bufferArea.height //imageHeight
                color: dayBegins ? gridColorHighlight : gridColor
                visible: hourVisible
                anchors.leftMargin: labelWidth
                anchors.top: parent.top
            }

            PlasmaComponents.Label {
                id: hourText
                text: hourFromStr
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignHCenter
                height: labelHeight
                width: hourGrid.hourItemWidth
                anchors.top: verticalLine.bottom
                anchors.topMargin: 1 //2
//                anchors.horizontalCenter: verticalLine.left
                anchors.horizontalCenter: verticalLine.horizontalCenter
                font.pixelSize: mgHoursFontSize //10 11
                font.pointSize: -1
                // font.family: "Neuropol X Cd Sb"
                visible: textVisible
            }

            PlasmaComponents.Label {
                text: hourFromEnding
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                anchors.top: hourText.top
                anchors.left: hourText.right
                font.pixelSize: mgTrailingZeroesFontSize //5 6
                font.pointSize: -1
                visible: false
            }
            function windFrom(rotation) {
                rotation = (Math.round( rotation / 22.5 ) * 22.5)
                rotation = (rotation >= 180) ? rotation - 180 : rotation + 180
                return rotation
            }
            function windStrength(windspeed,themecolor) {
                var img = "../images/"
                img += (themecolor) ? "light" : "dark"
                img += Math.min(5,Math.trunc(windspeed / 5) + 1)
                return img
            }
            function precipitationFormat(precFloat) {
                if (precFloat >= 0.1) {
                    var result = Math.round(precFloat * 10) / 10
                    return String(result)
                }
                return ''
            }

            Item {
                id: windspeedAnchor
                width: parent.width
                height: 32
                anchors.top: hourText.bottom
                anchors.left: hourText.left

                ToolTip{
                    id: windspeedhover
                    text: (index % 2 == 1) ? UnitUtils.getWindSpeedText(windSpeedMps, windSpeedType) : ""
                    padding: 4
                    x: windspeedAnchor.width + 6
                    y: (windspeedAnchor.height / 2)
                    opacity: 1
                    visible: false
                }

                Image {
                    id: wind
                    source: windStrength(windSpeedMps,textColorLight)
                    anchors.horizontalCenter: parent.horizontalCenter
                    rotation: windFrom(windDirection)
                    anchors.top: windspeedAnchor.top
                    width: 12
                    height: 12
                    fillMode: Image.PreserveAspectFit
                    visible: (index % 2 == 1) && (index < hourGridModel.count-1)
                    anchors.leftMargin: -9 //-8
                    anchors.topMargin: 3
                    anchors.left: parent.left
                    //                    visible: ((windDirection > 0) || (windSpeedMps > 0)) && (! textVisible) && (index > 0) && (index < hourGridModel.count-1)
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        windspeedhover.visible = (windspeedhover.text.length > 0)
                    }

                    onExited: {
                        windspeedhover.visible = false
                    }
                }
            }
            PlasmaComponents.Label {
                id: dayTest
                text: Qt.locale().dayName(dateFrom.getDay(), Locale.LongFormat)
                height: labelHeight
                anchors.top: parent.top
                anchors.topMargin: -labelHeight
                anchors.left: parent.left
                anchors.leftMargin: parent.width / 2.5 //parent.width / 2
                font.pixelSize: 11
                font.pointSize: -1
                visible: (dayBegins && (index < (hourGridModel.count - 12))) || ((index === 0) && (hourFrom < 15))
            }

            Rectangle {
                id: precipitationMaxRect
                width: parent.width
                height: Math.min((precAvg * precipitationHeightMultiplier) + (precAvg > 0 && index < 2 ? (precipitationLabelLeft.height - 4) : 0), 90)
                // height: ((precMax < precAvg ? precAvg : precMax) * precipitationHeightMultiplier) + (precAvg > 0 || precMax > 0 ? (precipitationLabelLeft.height - 4) : 0)
                color: rainColor
                anchors.left: verticalLine.left
                anchors.bottom: verticalLine.bottom
                anchors.bottomMargin: 1
                visible: index < (hourGridModel.count - 1)
            }

            PlasmaComponents.Label {
                id: precipitationUnits
                width: parent.width
                text: precAvgStr // precType === 1 ? (precMaxInchStr || precAvgInchStr) : (precMaxStr || precAvgStr)
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignHCenter
                anchors.bottom: precipitationMaxRect.top
                anchors.horizontalCenter: precipitationMaxRect.horizontalCenter
                font.pixelSize: precipitationFontPixelSize
                font.pointSize: -1
                //visible: true // precType === 1 ? precVisibleInch : precLabelVisible
            }

            PlasmaComponents.Label {
                font.pixelSize: 12
                font.pointSize: -1
                width: parent.width
                anchors.top: parent.top
                anchors.topMargin: (temperatureYGridCount - (temperature + temperatureIncrementDegrees)) * temperatureIncrementPixels - font.pixelSize * 2.5 + 32
                anchors.left: verticalLine.left
                // anchors.leftMargin: currentPlace.providerId === 'om' ? (-8 + (Math.abs(currentPlace.timezoneOffset / 3600) * 0.5)) : -8
                anchors.leftMargin: currentPlace.providerId === 'om' ? -4 : -8
                z: 999
                font.family: 'weathericons'
                text: (differenceHours === 1 && textVisible) || index === hourGridModel.count-1 || index === 0 || iconName === '' ? '' : IconTools.getIconCode(iconName, currentPlace.providerId, timePeriod)
                visible: iconName != "\uf07b" && (y > 10) && (y < graphArea.height)
                Component.onCompleted: {
                }
            }
        }

        Item {
            id: precipitationLabelContainer
            anchors.left: hourGrid.left //graphArea.left
            // anchors.leftMargin: -1 //precType === 1 ? undefined :
            anchors.bottom: hourGrid.bottom //bufferArea.bottom
            anchors.bottomMargin: precType === 1 ? precipitationLabelLeft.height + 1 :  precipitationLabelLeft.height //-1 2
            // anchors.leftMargin: -1
            /*visible: false*/ //precLabelVisChoice //&& precLabelVisible


            Rectangle {
                id: precipitationLabelRect
                width: precType === 1 ? precipitationLabelLeft.width * 1.8 : precipitationLabelLeft.width * 1.3 //1.4
                height: precType === 1 ? precipitationLabelLeft.height - 1 : precipitationLabelLeft.height - 1
                anchors.top: parent.top
                // width: parent.width
                // height: parent.height
                // width: precType === 1 ? precipitationLabelLeft.width * 1.8 : precipitationLabelLeft.width + 5
                // height: precType === 1 ? precipitationLabelLeft.height : precipitationLabelLeft.height - 1 //2 // labelHeight / 1.8
                color: rainColor
                // z: -1
                // anchors.leftMargin: -2
                // anchors.bottomMargin: -2
                // anchors.bottomMargin: -2
            }

            PlasmaComponents.Label {
                id: precipitationLabelLeft
                text: precType === 1 ? "in" : "mm" // precipitationPresent() //"mm"
                // anchors.horizontalCenter: precipitationLabelRect.horizontalCenter
                // anchors.verticalCenter: precipitationLabelRect.verticalCenter
                anchors.left: precipitationLabelRect.left
                anchors.leftMargin: precipitationLabelRect.width / 9
                anchors.bottom: precipitationLabelRect.bottom
                anchors.bottomMargin: -1
                // anchors.top: precipitationLabelContainer.top
                // anchors.topMargin: precType === 1 ? 2 : 0
                // anchors.bottomMargin: 2
                font.pixelSize: precipitationFontPixelSize
                font.pointSize: -1
                // font.bold: true
            }

            DropShadow {
                anchors.fill: precipitationLabelLeft
                radius: 3
                samples: 16
                spread: 0.8
                fast: true
                color: Kirigami.Theme.backgroundColor
                source: precipitationLabelLeft
                visible: precipitationLabelLeft.visible
            }
        }
    }

    Item {
        z: 1
        id: canvases
        // width: imageWidth
        // height: imageHeight

        // anchors.top: meteogram.top
        // anchors.topMargin: labelHeight + 24
        // anchors.left: meteogram.left
        // anchors.leftMargin: labelWidth
        // anchors.right: meteogram.right
        // anchors.rightMargin: labelWidth
        //
        // anchors.bottom: meteogram.bottom
        anchors.fill: graphArea // graphArea
        // anchors.top: graphArea.top
        // anchors.bottom: graphArea.bottom
        // anchors.right: graphArea.right
        // anchors.left:graphArea.left
        clip: false //true

        Canvas {
            id: meteogramCanvasPressure
            anchors.fill: parent
            contextType: '2d'

            Path {
                id: pressurePath
                startX: 0
            }

            onPaint: {
                var ctx=getContext("2d")
                if (ctx !== null) {
                    ctx.clearRect(0, 0, width, height)
                    ctx.clearRect(0, 0, width, height)

                    ctx.strokeStyle = pressureColor
                    ctx.lineWidth = 1
                    ctx.path = pressurePath
                    ctx.stroke()
                }
            }
        }

        Canvas {
            id: meteogramCanvasWarmTemp
            // anchors.fill: parent

            anchors.top: parent.top
            // anchors.topMargin: -parent.anchors.topMargin
            // clip: false
            width: parent.width
            // anchors.left: parent.left
            // anchors.right: parent.right
            // anchors.bottom: parent.bottom
            height: parent.height - temperatureIncrementPixels * (temperatureIncrementDegrees - 1) + 0

            // graphArea.height - temperatureIncrementPixels * (temperatureIncrementDegrees - 1) + 0 //parent.height

            // onWidthChanged: {
            //
            //     meteogramCanvasWarmTemp.requestPaint()
            // }

            contextType: '2d'

            Path {
                id: temperaturePathWarm
                startX: 0
            }

            onPaint: {
                var ctx=getContext("2d")
                if (ctx !== null) {
                    ctx.clearRect(0, 0, width, height)

                    ctx.strokeStyle = temperatureWarmColor
                    ctx.lineWidth = 2
                    ctx.path = temperaturePathWarm
                    ctx.stroke()
                }
            }
        }

        Item {

            id: meteogramCanvasColdTempContainer

            anchors.fill: parent
            anchors.topMargin: meteogramCanvasWarmTemp.height
            clip: false //true

            Canvas {
                id: meteogramCanvasColdTemp
                // anchors.fill: parent

                anchors.top: parent.top
                // anchors.bottom: parent.bottom
                width: parent.width //imageWidth
                height: parent.height //imageHeight
                // anchors.topMargin: -parent.anchors.topMargin
                contextType: '2d'
                clip: false

                Path {
                    id: temperaturePathCold
                    startX: 0
                }

                onPaint: {
                    var ctx=getContext("2d")
                    if (ctx !== null) {
                        ctx.clearRect(0, 0, width, height)

                        ctx.strokeStyle = temperatureColdColor
                        ctx.lineWidth = 2
                        ctx.path = temperaturePathCold
                        ctx.stroke()
                    }
                }
            }
        }
    }

    function repaintCanvas() {
        meteogramCanvasWarmTemp.requestPaint()
        meteogramCanvasColdTemp.requestPaint()
        meteogramCanvasPressure.requestPaint()
    }

    function parseISOString(s) {
        var b = s.split(/\D+/)
        return new Date(Date.UTC(b[0], --b[1], b[2], b[3], b[4], b[5], b[6]))
    }

    function buildMeteogramData() {
        dbgprint2("buildMetogramData (meteogram)")
        // var counter = 0
        var i = 0
        var precChecker = 0
        var precSum = 0
        const oneHourMs = 3600000
        hourGridModel.clear()

        let offset = 0
        switch (main.timezoneType) {
            case (0):
                offset = dataSource.data["Local"]["timezoneOffset"]
                break;
            case (1):
                offset = 0
                break;
            case (2):
                offset = currentPlace.timezoneOffset
                break;
        }

        while (i < meteogramModel.count) {
            var obj = meteogramModel.get(i)
            var dateFrom = obj.from
            var dateTo = obj.to
            dateFrom.setMinutes(0)
            dateFrom.setSeconds(0)
            dateFrom.setMilliseconds(0)
            var differenceHours = Math.floor((dateTo.getTime() - dateFrom.getTime()) / oneHourMs)
            // dbgprint(dateFrom + "\t" + dateTo + "\t" + differenceHours)
            var differenceHoursMid = Math.ceil(differenceHours / 2) - 1
            var wd = obj.windDirection
            var ws = obj.windSpeedMps
            var ap = obj.pressureHpa
            var airtmp = parseFloat(obj.temperature)
            var icon = obj.iconName
            var prec = precType === 1 ? (obj.precipitationAvg / 25.4) : obj.precipitationAvg

            for (var j = 0; j < differenceHours; j++) {
                // counter = (prec > 0) ? counter + 1 : 0
                var preparedDate = new Date(dateFrom.getTime() + (j * oneHourMs))
                hourGridModel.append({
                                         dateFrom: UnitUtils.convertDate(preparedDate, timezoneType, offset),
                                         iconName: j === differenceHoursMid ? icon : '',
                                         isDaytime: obj.isDaytime,
                                         temperature: airtmp,
                                         precipitationAvg: parseFloat(prec / differenceHours).toFixed(1),
                                         // precipitationLabel: precType === 1 ? "in" : "mm",
                                         // precipitationLabel: (counter === 1) ? precType === 1 ? "in" : "mm" : "",
                                         // precipitationMax: precType === 1 ? parseFloat((prec / differenceHours) / 25.4).toFixed(1) : parseFloat(prec / differenceHours).toFixed(1),
                                         precipitationPresent: true,
                                         canShowDay: true,
                                         canShowPrec: true,
                                         windDirection: parseFloat(wd),
                                         windSpeedMps: parseFloat(ws),
                                         pressureHpa: parseFloat(ap),
                                         differenceHours: differenceHours
                                     })
                // dbgprint(prec)
                precChecker = prec.toFixed(1) > 0 ? precChecker + 1 : precChecker
                // dbgprint(precChecker)
                if (precChecker > 0) {
                    precipitationLabelContainer.visible = true
                } else if (precChecker === 0) {
                    precipitationLabelContainer.visible = false
                }
            }
            i++
            
        }
        // for (i = hourGridModel.count - 5; i < hourGridModel.count; i++) {
        //     hourGridModel.setProperty(i, 'canShowDay', false)
        // }
        // hourGridModel.setProperty(hourGridModel.count - 1, 'canShowPrec', false)

    }

    function buildCurves() {
        // dbgprint2("buildCurves")
        var newPathElements = []
        var newPressureElements = []

        if (meteogramModel.count === 0) {
            return
        }
        for (var i = 0; i < meteogramModel.count; i++) {
            var dataObj = meteogramModel.get(i)

            var rawTempY = temperatureYGridCount - (dataObj.temperature + temperatureIncrementDegrees)
            var temperatureY = rawTempY * temperatureIncrementPixels
            var rawPressY = pressureSizeY - (dataObj.pressureHpa + pressureOffsetY)
            var pressureY = rawPressY * pressureMultiplierY
            if (i === 0) {
                temperaturePathWarm.startY = temperatureY
                temperaturePathCold.startY = temperatureY
                pressurePath.startY = pressureY
            }
            newPathElements.push(Qt.createQmlObject('import QtQuick 2.0; PathCurve { x: ' + (i * sampleWidth) + '; y: ' + temperatureY + ' }', graphArea, "dynamicTemperature" + i))
            newPressureElements.push(Qt.createQmlObject('import QtQuick 2.0; PathCurve { x: ' + (i * sampleWidth) + '; y: ' + pressureY + ' }', graphArea, "dynamicPressure" + i))
        }
        temperaturePathWarm.pathElements = newPathElements
        temperaturePathCold.pathElements = newPathElements
        pressurePath.pathElements = newPressureElements
        repaintCanvas()
    }

    function processMeteogramData() {

        dataArraySize = meteogramModel.count

        if (dataArraySize === 0) {
            dbgprint('model is empty -> clearing canvas and exiting')
            clearCanvas()
            return
        }

        var minValue = null
        var maxValue = null
        var i = 0

        for (i = 0; i < dataArraySize; i++) {
            var obj = meteogramModel.get(i)
            var value = obj.temperature
            if (minValue === null) {
                minValue = value
                maxValue = value
                continue
            }
            if (value < minValue) {
                minValue = value
            }
            if (value > maxValue) {
                maxValue = value
            }
        }

        var tempRange = maxValue - minValue

        if (Math.abs(tempRange) > 20) {
            temperatureYGridCount = 35
            // temperatureIncrementPixels = imageHeight / (temperatureYGridCount - 1)
        } else if (Math.abs(tempRange) > 35) {
            temperatureYGridCount = 41
            // temperatureIncrementPixels = imageHeight / (temperatureYGridCount - 1)
        } else {
            temperatureYGridCount = 21
            // temperatureIncrementPixels = imageHeight / (temperatureYGridCount - 1)
        }

        var mid = (maxValue - minValue) / 2 + minValue
        var halfSize = temperatureYGridCount / 2
        temperatureIncrementDegrees = Math.round(- (mid - halfSize))

        for (var i = 0; i <= 41; i++) {
            verticalGridModel.append({ num: i })
        }

        dbgprint(minValue)
        dbgprint(maxValue)
        dbgprint(mid)
        dbgprint(temperatureIncrementDegrees)
    }

    // function expansionCounter() {
    //
    //     // var a = 0
    //     var counter2 = counter
    //
    //     // if (main.expanded) {
    //     //     counter2 = counter + 1
    //     // }
    //
    //     if (counter < 2) {
    //         // if (counter < 2 && main.expanded) {
    //             dbgprint2("expansionCounted")
    //             buildCurves()
    //         }
    //     }
    //
    //     // if (counter < 3 && main.expanded) {
    //     //     loadingData.failedAttemptCount = 0
    //     //     buildCurves()
    //     // }
    // }

    // Component.onCompleted: {
    //     if (main.expanded)
    //         layoutTimer1.start()
    // }
    //

    // Timer {
    //     id: layoutTimerMeteogram
    //     interval: 750
    //     // running: true
    //     repeat: false
    //     onTriggered: {
    //
    //         if (main.loadingDataComplete === true) {
    //             dbgprint2('timerTriggered')
    //             loadingData.failedAttemptCount = 0
    //             main.loadDataFromInternet()
    //         }
    //     }
    // }
    //
    // Component.onCompleted: {
    //
    //     start(layoutTimerMeteogram)
    //     // buildCurves()
    //     // loadingData.failedAttemptCount = 0
    //     // main.loadDataFromInternet()
    // }
}
