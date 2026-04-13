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
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasma5support as Plasma5Support
import QtQuick.Layouts
import QtQuick.Controls
// import org.kde.ksvg as KSvg

Item {
    id: fullRepresentationInTray

    property int imageWidth: widgetWidth // 800 950
    property int imageHeight: widgetHeight // + defaultFontPixelSize // 320

    property double defaultFontPixelSize: Kirigami.Theme.defaultFont.pixelSize
    property double footerHeight: defaultFontPixelSize

    property int nextDayItemSpacing: defaultFontPixelSize * 1.2 //* 2 2.5
    property int nextDaysSpacing: defaultFontPixelSize
    property int nextDayHeight: defaultFontPixelSize * 4 //4
    property int headingHeight: defaultFontPixelSize * 2
    // property int hourLegendMargin: defaultFontPixelSize * 2 + 2
    // property double hourLegendBottomMargin: defaultFontPixelSize * 0.2
    property string fullRepresentationAlias: main.fullRepresentationAlias

    /*implicitWidth: 600 //imageWidth
    implicitHeight: 300*/ //headingHeight + imageHeight + footerHeight + nextDaysHeight + 14

    // implicitWidth: main.widgetWidthInTray
    // implicitHeight: main.widgetHeightInTray

    // Layout.minimumWidth: 460 //main.widgetWidthInTray //464 //main.widgetWidth
    // Layout.minimumHeight: 300 //main.widgetHeightInTray //300 //main.widgetHeight + headingHeight + footerHeight + 14 + 56

    // Layout.preferredWidth: main.widgetWidthInTray //imageWidth
    // Layout.preferredHeight: main.widgetHeightInTray //headingHeight + imageHeight + footerHeight + nextDaysHeight + 14 + 56 //36 69

    // Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

    onFullRepresentationAliasChanged: {

        // for(const [key,value] of Object.entries(currentPlace)) { console.log(`  ${key}: ${value}`) }
        var t = main.fullRepresentationAlias

        switch (main.timezoneType) {
            case 0:
                t += " (" + getLocalTimeZone()+ ")"
                break
            case 1:
                t += " (" + i18n("UTC") + ")"
                break
            case 2:
                if (main.currentPlace.timezoneShortName === "") {
                    main.currentPlace.timezoneShortName = "unknown"
                }
                t += " (" +  main.currentPlace.timezoneShortName + ")"
                break
            default:
                t += " (" + "TBA" + ")"
                break
        }
        currentLocationText.text = t
    }

    PlasmaComponents.Label {
        id: currentLocationText

        anchors.left: parent.left
        anchors.top: parent.top
        // anchors.topMargin: -10
        verticalAlignment: Text.AlignTop

        text: ""
        Component.onCompleted: {
            dbgprint2("FullRepresentationInTray")
            dbgprint((main.currentPlace.alias))
            dbgprint2(currentLocationText.text)
            // nextDaysCount = nextDaysModel.count
        }
    }

    PlasmaComponents.Button {
        id: nextDaysButton

        anchors.right: parent.right
        anchors.top: currentLocationText.top
        anchors.topMargin: -10
        // verticalAlignment: Text.AlignTop
        // visible: true
        // color: Kirigami.Theme.textColor
        text: i18n("List") + " >>"

        onClicked: {
            dbgprint('clicked weekly forecast button')
            meteogram3.visible = false
            nextDays.visible = true
            hourLegend.visible = true
            meteogramButton.visible = true
            nextDaysButton.visible = false
        }
    }

//     MouseArea {
//         cursorShape: (nextLocationText.visible) ? Qt.PointingHandCursor : Qt.ArrowCursor
//         anchors.fill: nextLocationText
//
//         hoverEnabled: nextLocationText.visible
//         enabled: nextLocationText.visible
//
//         onClicked: {
//             dbgprint('clicked next location')
//             main.setNextPlace(false,"+")
//         }
//
//         onEntered: {
//             nextLocationText.font.underline = true
//         }
//
//         onExited: {
//             nextLocationText.font.underline = false
//         }
//     }

    PlasmaComponents.Button {
        id: meteogramButton

        anchors.right: parent.right
        anchors.top: currentLocationText.top
        anchors.topMargin: -10
        // anchors.rightMargin: 15
        // verticalAlignment: Text.AlignTop
        visible: false
        // color: Kirigami.Theme.textColor
        text: i18n("Meteogram") + " >>"
        // text: "<< " + i18n("Previous")

        onClicked: {
            dbgprint('clicked meteogram button')
            nextDays.visible = false
            hourLegend.visible = false
            meteogram3.visible = true
            nextDaysButton.visible = true
            meteogramButton.visible = false
        }
    }

//     MouseArea {
//         cursorShape: (prevLocationText.visible) ? Qt.PointingHandCursor : Qt.ArrowCursor
//         anchors.fill: prevLocationText
//
//         hoverEnabled: prevLocationText.visible
//         enabled: prevLocationText.visible
//
//         onClicked: {
//             dbgprint('clicked previous location')
//             main.setNextPlace(false,"-")
//         }
//
//         onEntered: {
//             prevLocationText.font.underline = true
//         }
//
//         onExited: {
//             prevLocationText.font.underline = false
//         }
//     }

    MeteogramInTray {
        id: meteogram3
        // anchors.fill: parent.fill

        // fullRepresentationInTray

        anchors.top: currentLocationText.bottom //parent.top //currentLocationText.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: frFooter.top //parent.bottom // frFooter.top

        anchors.topMargin: defaultFontPixelSize * 0.5 //* 2 //headingHeight + 2
        anchors.leftMargin: -labelWidth / 2 + 2// - 2 //-6 - (labelWidth / 2)
        anchors.rightMargin: -labelWidth / 2 + 6 //6
        anchors.bottomMargin: frFooter.height + 22 //frFooter.height + defaultFontPixelSize * 5 //5

        // Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

        width: 470
        height: 300

        Layout.minimumWidth: 460 //main.widgetWidth * 0.58 //464 //main.widgetWidth
        Layout.minimumHeight: 300 //main.widgetHeight

         // implicitWidth: 450 //490
         // implicitHeight: 300 //300

         // Layout.minimumWidth: 490
         // Layout.minimumHeight: 300
        // Layout.minimumWidth: main.widgetWidth / 1.6
        // Layout.minimumHeight: main.widgetHeight

        // visible: true
    }

    // Rectangle {
    //     id: meteogram3Rect
    //     // anchors.fill: parent.fill
    //     anchors.top: parent.top //currentLocationText.bottom
    //     anchors.left: parent.left
    //     anchors.right: parent.right
    //     anchors.bottom: parent.bottom // frFooter.top
    //
    //     // implicitWidth: 450 //490
    //     // implicitHeight: 300 //300
    //     color: "red" //"steelblue"
    // }

    // ScrollView {
    //     id: nextDaysView
    //     visible: false
    //
    //     anchors.top: currentLocationText.bottom
    //     anchors.topMargin: Kirigami.Units.gridUnit
    //     anchors.bottom: frFooter.top
    //     anchors.bottomMargin: defaultFontPixelSize * 2 //defaultFontPixelSize / 2
    //
    //     width: parent.width
    //     height: nextDayHeight * 5 // 5.5

        ListView {
            id: nextDays
            visible: false

            // anchors.fill: nextDays.area
            model: nextDaysModel

            anchors.top: currentLocationText.bottom
            anchors.topMargin: Kirigami.Units.gridUnit * 1.8
            //1.8 for header //0.9 for footer
            anchors.bottom: frFooter.top
            anchors.bottomMargin: defaultFontPixelSize * 0.9
            // * 1.8 for footer// * 1 for header //2.8 defaultFontPixelSize / 2

            width: parent.width
            // height: nextDayHeight * 5 // 5.5

            orientation: Qt.Vertical
            spacing: nextDayItemSpacing
            interactive: true
            snapMode: ListView.SnapToItem
            boundsBehavior: Flickable.StopAtBounds
            displayMarginBeginning: 0
            displayMarginEnd: 0 //0 36
            // headerPositioning: ListView.OverlayHeader
            //footerPositioning: ListView.OverlayFooter
            clip: true //true

            ScrollBar.vertical: ScrollBar {
                // parent: flickable.parent
                anchors.top: nextDays.top
                // anchors.left: nextDays.right
                anchors.bottom: nextDays.bottom
            }
            // Keys.onUpPressed: scrollBar.decrease()
            // Keys.onDownPressed: scrollBar.increase()

            delegate: Item {

                width: nextDays.width// - 25 //75
                height: (defaultFontPixelSize * 3.6)
                //anchors.bottomMargin: Kirigami.Units.gridUnit * 3
                anchors.topMargin: Kirigami.Units.gridUnit * 3 //Kirigami.Units.smallSpacing * 3 //1.5

                // property string svgLineName: 'horizontal-line'

                // KSvg.SvgItem {
                //     anchors.top: dayTitleText.top
                //     width: parent.width
                //     height: lineSvg.elementSize(svgLineName).height
                //     elementId: svgLineName
                //     svg: KSvg.Svg {
                //         id: lineSvg
                //         imagePath: 'widgets/line'
                //     }
                // }

                PlasmaComponents.Label {
                    id: dayTitleText
                    anchors.topMargin: Kirigami.Units.smallSpacing
                    anchors.left: parent.left
                    anchors.leftMargin: Kirigami.Units.smallSpacing * 1.5
                    verticalAlignment: Text.AlignTop
                    text: dayTitle
                    font.pixelSize: defaultFontPixelSize * 1.2
                    font.bold: true
                }

                property double periodMargin: defaultFontPixelSize * 0.5
                property double periodItemWidth: (nextDays.width - 10 - (periodMargin * 4)) / 4
                property double periodItemHeight: defaultFontPixelSize * 1.5

                Item {

                    anchors.top: dayTitleText.bottom
                    height: periodItemHeight

                    NextDayPeriodItem {
                        id: period1

                        width: periodItemWidth
                        height: parent.height

                        temperature: temperature0
                        iconName: iconName0
                        hidden: hidden0
                        partOfDay: partOfDay0
                        pixelFontSize: defaultFontPixelSize * 1.5
                    }

                    NextDayPeriodItem {
                        id: period2

                        anchors.left: period1.right
                        anchors.leftMargin: periodMargin

                        width: periodItemWidth
                        height: parent.height

                        temperature: temperature1
                        iconName: iconName1
                        hidden: hidden1
                        partOfDay: partOfDay1
                        pixelFontSize: defaultFontPixelSize * 1.5
                    }

                    NextDayPeriodItem {
                        id: period3

                        anchors.left: period2.right
                        anchors.leftMargin: periodMargin

                        width: periodItemWidth
                        height: parent.height

                        temperature: temperature2
                        iconName: iconName2
                        hidden: hidden2
                        partOfDay: partOfDay3
                        pixelFontSize: defaultFontPixelSize * 1.5
                    }

                    NextDayPeriodItem {
                        id: period4

                        anchors.left: period3.right
                        anchors.leftMargin: periodMargin

                        width: periodItemWidth
                        height: parent.height

                        temperature: temperature3
                        iconName: iconName3
                        hidden: hidden3
                        partOfDay: partOfDay3
                        pixelFontSize: defaultFontPixelSize * 1.5
                    }
                }

//                 RowLayout {
//                     // anchors.fill: parent
//                     // id: hourLegend
//                     // visible: false
//                     // anchors.bottom: frFooter.top
//                     // anchors.bottomMargin: defaultFontPixelSize
//                     // anchors.right: nextDays.right
//                     // anchors.rightMargin: defaultFontPixelSize * 0.5
//                     anchors.top: dayTitleText.bottom
//                     // anchors.topMargin: defaultFontPixelSize * 2 + 2
//                     anchors.left: parent.left
//                     anchors.leftMargin: defaultFontPixelSize * 1.5
//                     visible: index === 0
//
//                     height: 12
//                     width: nextDays.width - 25
//                     spacing: nextDayItemSpacing * 2
//
//                     PlasmaComponents.Label {
//                         text: twelveHourClockEnabled ? '3AM' : '3:00'
//                         horizontalAlignment: Text.AlignRight
//                         opacity: 0.5
//                         height: 12
//                         // anchors.left: period1.left
//                         // anchors.leftMargin: defaultFontPixelSize * 1.5
//                     }
//                     PlasmaComponents.Label {
//                         text: twelveHourClockEnabled ? '9AM' : '9:00'
//                         horizontalAlignment: Text.AlignRight
//                         opacity: 0.5
//                         height: 12
//                         // anchors.left: period2.left
//                         // anchors.leftMargin: defaultFontPixelSize * 1.5
//                     }
//                     PlasmaComponents.Label {
//                         text: twelveHourClockEnabled ? '3PM' : '15:00'
//                         horizontalAlignment: Text.AlignRight
//                         opacity: 0.5
//                         height: 12
//                         // anchors.left: period3.left
//                         // anchors.leftMargin: defaultFontPixelSize * 1.5
//                     }
//                     PlasmaComponents.Label {
//                         text: twelveHourClockEnabled ? '9PM' : '21:00'
//                         horizontalAlignment: Text.AlignRight
//                         opacity: 0.5
//                         height: 12
//                         // anchors.left: period4.left
//                         // anchors.leftMargin: defaultFontPixelSize * 1.5
//                     }
//                 }
            }
            // header: RowLayout {
            //     // anchors.fill: parent
            //     // id: hourLegendFooter
            //     // visible: false
            //     // anchors.bottom: frFooter.top
            //     // anchors.bottomMargin: defaultFontPixelSize
            //     // anchors.right: nextDays.right
            //     // anchors.rightMargin: defaultFontPixelSize * 0.5
            //     // anchors.top: nextDays.top
            //     // anchors.topMargin: Kirigami.Units.smallSpacing * -1
            //     // anchors.bottom: dayTitleText.top
            //     // anchors.topMargin: defaultFontPixelSize * 2 + 2
            //     anchors.left: parent.left
            //     anchors.leftMargin: defaultFontPixelSize * 1.84
            //     Layout.alignment: Qt.AlignBottom
            //     // visible: index === 0
            //
            //     // height: 36
            //     width: nextDays.width - 25
            //     spacing: nextDayItemSpacing * 1.3
            //     // z: 2
            //
            //     PlasmaComponents.Label {
            //         text: twelveHourClockEnabled ? '3AM' : '3:00'
            //         horizontalAlignment: Text.AlignRight
            //         opacity: 0.5
            //         height: 12
            //         // anchors.left: period1.left
            //         // anchors.leftMargin: defaultFontPixelSize * 1.5
            //     }
            //     PlasmaComponents.Label {
            //         text: twelveHourClockEnabled ? '9AM' : '9:00'
            //         horizontalAlignment: Text.AlignRight
            //         opacity: 0.5
            //         height: 12
            //         // anchors.left: period2.left
            //         // anchors.leftMargin: defaultFontPixelSize * 1.5
            //     }
            //     PlasmaComponents.Label {
            //         text: twelveHourClockEnabled ? '3PM' : '15:00'
            //         horizontalAlignment: Text.AlignRight
            //         opacity: 0.5
            //         height: 12
            //         // anchors.left: period3.left
            //         // anchors.leftMargin: defaultFontPixelSize * 1.5
            //     }
            //     PlasmaComponents.Label {
            //         text: twelveHourClockEnabled ? '9PM' : '21:00'
            //         horizontalAlignment: Text.AlignRight
            //         opacity: 0.5
            //         height: 12
            //         // anchors.left: period4.left
            //         // anchors.leftMargin: defaultFontPixelSize * 1.5
            //     }
            // }
        }
    // }

    RowLayout {
        // anchors.fill: parent
        id: hourLegend
        visible: false
        // visible: false
        anchors.top: currentLocationText.bottom
        anchors.topMargin: defaultFontPixelSize
        // anchors.bottom: frFooter.top
        // anchors.bottomMargin: Kirigami.Units.smallSpacing * 0.5
        anchors.right: nextDays.right
        // anchors.rightMargin: defaultFontPixelSize * 0.5
        // anchors.top: nextDays.top
        // anchors.topMargin: Kirigami.Units.smallSpacing * -1
        // anchors.bottom: dayTitleText.top
        // anchors.topMargin: defaultFontPixelSize * 2 + 2
        anchors.left: nextDays.left
        anchors.leftMargin: defaultFontPixelSize * 1.84
        Layout.alignment: Qt.AlignTop | Qt.AlignHCenter //AlignBottom for footer
        Layout.fillWidth: true
        // visible: index === 0

        // height: 36
        // width: nextDays.width - 25
        spacing: nextDayItemSpacing * 3 //1.3
        // z: 2

        PlasmaComponents.Label {
            text: twelveHourClockEnabled ? '3AM' : '3:00'
            horizontalAlignment: Text.AlignRight
            opacity: 0.5
            height: 12
            // anchors.left: period1.left
            // anchors.leftMargin: defaultFontPixelSize * 1.5
        }
        PlasmaComponents.Label {
            text: twelveHourClockEnabled ? '9AM' : '9:00'
            horizontalAlignment: Text.AlignRight
            opacity: 0.5
            height: 12
            // anchors.left: period2.left
            // anchors.leftMargin: defaultFontPixelSize * 1.5
        }
        PlasmaComponents.Label {
            text: twelveHourClockEnabled ? '3PM' : '15:00'
            horizontalAlignment: Text.AlignRight
            opacity: 0.5
            height: 12
            // anchors.left: period3.left
            // anchors.leftMargin: defaultFontPixelSize * 1.5
        }
        PlasmaComponents.Label {
            text: twelveHourClockEnabled ? '9PM' : '21:00'
            horizontalAlignment: Text.AlignRight
            opacity: 0.5
            height: 12
            // anchors.left: period4.left
            // anchors.leftMargin: defaultFontPixelSize * 1.5
        }
    }

    // Row {
    //     id: hourLegend
    //     visible: false
    //     anchors.bottom: frFooter.top
    //     anchors.bottomMargin: defaultFontPixelSize
    //     // anchors.right: parent.right
    //     // anchors.rightMargin: defaultFontPixelSize
    //     height: 12
    //     width: parent.width
    //     spacing: nextDayItemSpacing * 2
    //
    //     PlasmaComponents.Label {
    //         text: twelveHourClockEnabled ? '3AM' : '3:00'
    //         horizontalAlignment: Text.AlignRight
    //         opacity: 0.6
    //     }
    //     PlasmaComponents.Label {
    //         text: twelveHourClockEnabled ? '9AM' : '9:00'
    //         horizontalAlignment: Text.AlignRight
    //         opacity: 0.6
    //     }
    //     PlasmaComponents.Label {
    //         text: twelveHourClockEnabled ? '3PM' : '15:00'
    //         horizontalAlignment: Text.AlignRight
    //         opacity: 0.6
    //     }
    //     PlasmaComponents.Label {
    //         text: twelveHourClockEnabled ? '9PM' : '21:00'
    //         horizontalAlignment: Text.AlignRight
    //         opacity: 0.6
    //     }
    // }

    // ListView {
    //     id: nextDaysViewTray
    //     anchors.top: meteogram3.bottom
    //     anchors.topMargin: 84
    //     anchors.bottomMargin: footerHeight + nextDaysVerticalMargin
    //     anchors.left: parent.left
    //     anchors.leftMargin: hourLegendMargin// - 2
    //     anchors.right: parent.right
    //     height: nextDaysHeight
    //
    //     model: nextDaysModel
    //     orientation: Qt.Horizontal
    //     spacing: nextDayItemSpacing
    //     interactive: false
    //
    //     delegate: NextDayItemInTray {
    //         width: nextDayItemWidth
    //         height: nextDaysHeight
    //     }
    // }

    // Column {
    //     id: hourLegend
    //     anchors.top: meteogram3.bottom
    //     anchors.topMargin: 124
    //     anchors.bottomMargin: footerHeight + nextDaysVerticalMargin - 4
    //     // anchors.leftMargin: 12
    //     spacing: 1
    //
    //     width: hourLegendMargin * 1.3
    //     height: nextDaysHeight - defaultFontPixelSize
    //
    //     PlasmaComponents.Label {
    //         text: twelveHourClockEnabled ? '3AM' : '3:00'
    //         width: parent.width
    //         height: parent.height / 4
    //         font.pixelSize: defaultFontPixelSize * 0.75
    //         font.pointSize: -1
    //         horizontalAlignment: Text.AlignRight
    //         opacity: 0.6
    //     }
    //     PlasmaComponents.Label {
    //         text: twelveHourClockEnabled ? '9AM' : '9:00'
    //         width: parent.width
    //         height: parent.height / 4
    //         font.pixelSize: defaultFontPixelSize * 0.75
    //         font.pointSize: -1
    //         horizontalAlignment: Text.AlignRight
    //         opacity: 0.6
    //     }
    //     PlasmaComponents.Label {
    //         text: twelveHourClockEnabled ? '3PM' : '15:00'
    //         width: parent.width
    //         height: parent.height / 4
    //         font.pixelSize: defaultFontPixelSize * 0.75
    //         font.pointSize: -1
    //         horizontalAlignment: Text.AlignRight
    //         opacity: 0.6
    //     }
    //     PlasmaComponents.Label {
    //         text: twelveHourClockEnabled ? '9PM' : '21:00'
    //         width: parent.width
    //         height: parent.height / 4
    //         font.pixelSize: defaultFontPixelSize * 0.75
    //         font.pointSize: -1
    //         horizontalAlignment: Text.AlignRight
    //         opacity: 0.6
    //     }
    // }


    /*
     *
     * FOOTER
     *
     */

    MouseArea {
        id: frFooter
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        width: lastReloadedTextComponent.contentWidth
        height: lastReloadedTextComponent.contentHeight

        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        PlasmaComponents.Label {
            id: lastReloadedTextComponent
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            // verticalAlignment: Text.AlignBottom

            text: lastReloadedText
        }

        PlasmaComponents.Label {
            id: reloadTextComponent
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            // verticalAlignment: Text.AlignBottom
            // font.underline: true

            text: '\u21bb '+ i18n("Reload")
            visible: false
        }

        onEntered: {
            lastReloadedTextComponent.visible = false
            reloadTextComponent.visible = true
        }

        onExited: {
            lastReloadedTextComponent.visible = true
            reloadTextComponent.visible = false
        }

        onClicked: {
            main.loadDataFromInternet()
        }
    }

    PlasmaComponents.Label {
        id: creditText

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        verticalAlignment: Text.AlignBottom

        text: currentPlace.creditLabel
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: creditText

        hoverEnabled: true

        onClicked: {
            dbgprint('opening: ', currentPlace.creditLink)
            Qt.openUrlExternally(currentPlace.creditLink)
        }

        onEntered: {
            creditText.font.underline = true
        }

        onExited: {
            creditText.font.underline = false
        }
    }

    // Component.onCompleted: {
    //         dbgprint2("expansionCounted")
    //         meteogram3.buildCurves()
    // }
}
