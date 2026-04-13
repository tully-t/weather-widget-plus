import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM
// import "../"

KCM.SimpleKCM {

    id: appearancePage
    // property int cfg_layoutType

    // property string cfg_leftOuterMargin: plasmoid.configuration.leftOuterMargin
    // property string cfg_innerMargin: plasmoid.configuration.innerMargin
    // property string cfg_rightOuterMargin: plasmoid.configuration.rightOuterMargin
    // property string cfg_topOuterMargin: plasmoid.configuration.topOuterMargin
    // property string cfg_bottomOuterMargin: plasmoid.configuration.bottomOuterMargin

    // property alias cfg_textVisible: textVisible.checked // moved to Appearance
    // property alias cfg_iconVisible: iconVisible.checked // moved to Appearance

    // property alias cfg_tempLabelVisible: tempLabelVisible.checked
    // property alias cfg_pressureLabelVisible: pressureLabelVisible.checked
    property int cfg_tempLabelPosition
    property int cfg_pressureLabelPosition

    property int cfg_mgAxisFontSize
    property int cfg_mgPressureFontSize
    property int cfg_mgHoursFontSize
    property int cfg_mgTrailingZeroesFontSize
    // property alias cfg_precLabelVisChoice: precLabelVisChoice.checked

    property int cfg_hourSpanOm
    property int cfg_widgetWidth
    property int cfg_widgetHeight
    property int cfg_widgetWidthInTray
    property int cfg_widgetHeightInTray
    property int cfg_widgetOrder
    property int cfg_desktopMode
    property alias cfg_trailingZeroesVisible: trailingZeroesVisible.checked
    property alias cfg_weeklyForecastVisible: weeklyForecastVisible.checked



    onCfg_desktopModeChanged: {
        switch (cfg_desktopMode) {
            case 0:
                desktopModeGroup.checkedButton = desktopModeIcon;
                break;
            case 1:
                desktopModeGroup.checkedButton = desktopModeMeteogram;
                break;
            default:
        }
    }

    ButtonGroup {
        id: desktopModeGroup

        Component.onCompleted: {
            cfg_desktopModeChanged()
        }
    }

    // onCfg_tempLabelPositionChanged: {
    //     switch (cfg_tempLabelPosition) {
    //         case 0:
    //             tempLabelPositionGroup.checkedButton = tempLabelPositionTop;
    //             break;
    //         case 1:
    //             tempLabelPositionGroup.checkedButton = tempLabelPositionBottom;
    //             break;
    //         case 2:
    //             tempLabelPositionGroup.checkedButton = tempLabelPositionNone;
    //             break;
    //         default:
    //     }
    // }
    //
    // ButtonGroup {
    //     id: tempLabelPositionGroup
    //
    //     Component.onCompleted: {
    //         cfg_tempLabelPositionChanged()
    //     }
    // }
    //
    // onCfg_pressureLabelPositionChanged: {
    //     switch (cfg_pressureLabelPosition) {
    //         case 0:
    //             pressureLabelPositionGroup.checkedButton = pressureLabelPositionTop;
    //             break;
    //         case 1:
    //             pressureLabelPositionGroup.checkedButton = pressureLabelPositionBottom;
    //             break;
    //         case 2:
    //             pressureLabelPositionGroup.checkedButton = pressureLabelPositionNone;
    //             break;
    //         default:
    //     }
    // }
    //
    // ButtonGroup {
    //     id: pressureLabelPositionGroup
    //
    //     Component.onCompleted: {
    //         cfg_pressureLabelPositionChanged()
    //     }
    // }

    GridLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        columns: 3

        // Label {
        //     text: i18n("Layout type") + ":"
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        // }
        // RadioButton {
        //     id: layoutTypeRadioHorizontal
        //     ButtonGroup.group: layoutTypeGroup
        //     text: i18n("Horizontal")
        //     onCheckedChanged: if (checked) cfg_layoutType = 0;
        // }
        // Label {
        //     text: i18n("Layout type is not available in the system tray")
        //     Layout.rowSpan: 3
        //     Layout.preferredWidth: 250
        //     wrapMode: Text.WordWrap
        // }
        // Item {
        //     width: 2
        //     height: 2
        //     Layout.rowSpan: 2
        // }
        // RadioButton {
        //     id: layoutTypeRadioVertical
        //     ButtonGroup.group: layoutTypeGroup
        //     text: i18n("Vertical")
        //     onCheckedChanged: if (checked) cfg_layoutType = 1;
        // }
        // RadioButton {
        //     id: layoutTypeRadioCompact
        //     ButtonGroup.group: layoutTypeGroup
        //     text: i18n("Compact")
        //     onCheckedChanged: if (checked) cfg_layoutType = 2;
        // }
        //
        // Item {
        //     width: 2
        //     height: 5
        //     Layout.columnSpan: 3
        // }
        //
        // Label {
        //     text: i18n("Widget order") + ":"
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        // }
        // RadioButton {
        //     id: widgetOrderIconFirst
        //     ButtonGroup.group: widgetOrderGroup
        //     text: i18n("Icon first")
        //     onCheckedChanged: if (checked) cfg_widgetOrder = 0;
        // }
        // Label {
        //     text: i18n("Widget order is not available in either the system tray or the Compact layout")
        //     Layout.rowSpan: 3
        //     Layout.preferredWidth: 250
        //     wrapMode: Text.WordWrap
        // }
        // Item {
        //     width: 2
        //     height: 2
        //     Layout.rowSpan: 2
        // }
        // Item {
        //     width: 2
        //     height: 2
        //     Layout.columnSpan: 1
        // }
        // RadioButton {
        //     id: widgetOrderTextFirst
        //     ButtonGroup.group: widgetOrderGroup
        //     text: i18n("Text first")
        //     onCheckedChanged: if (checked) cfg_widgetOrder = 1;
        // }
        //
        // Item {
        //     width: 2
        //     height: 5
        //     Layout.columnSpan: 3
        // }

        Label {
            text: i18n("Desktop mode") + ":"
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        }
        RadioButton {
            id: desktopModeIcon
            ButtonGroup.group: desktopModeGroup
            text: i18n("Icon")
            onCheckedChanged: if (checked) cfg_desktopMode = 0;
        }
        Label {
            id: spacer
            // text: i18n("Dimension adjustment is not available in the system tray")
            Layout.rowSpan: 3
            Layout.preferredWidth: 250
            wrapMode: Text.WordWrap
            // anchors.top: widgetWidthLabel.bottom
            // anchors.topMargin: -Kirigami.Units.smallSpacing

            // anchors.left: widgetHeightPx.right
            // anchors.leftMargin: Kirigami.Units.gridUnit
        }
        // Item {
        //     width: 2
        //     height: 2
        //     Layout.rowSpan: 2
        // }
        Item {
            width: 2
            height: 2
            Layout.columnSpan: 1
        }
        RadioButton {
            id: desktopModeMeteogram
            ButtonGroup.group: desktopModeGroup
            text: i18n("Meteogram")
            onCheckedChanged: if (checked) cfg_desktopMode = 1;
        }

        // Label {
        //     text: i18n("Dimension adjustment is not available in the system tray")
        //     Layout.rowSpan: 3
        //     Layout.preferredWidth: 200
            // wrapMode: Text.WordWrap
            // anchors.top: widgetWidthLabel.bottom
            // anchors.left: widgetHeightPx.right
            // anchors.topMargin: -Kirigami.Units.smallSpacing
            // anchors.leftMargin: Kirigami.Units.gridUnit
        // }

        // Item {
        //     width: 2
        //     height: 2
        //     Layout.columnSpan: 3
        // }

        // Label {
        //     text: i18n("Top Margin") + ":"
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        // }
        //
        // Item {
        //     SpinBox {
        //         id: topOuterMargin
        //         Layout.alignment: Qt.AlignVCenter
        //         anchors.verticalCenter: parent.verticalCenter
        //         stepSize: 1
        //         from: -999
        //         value: cfg_topOuterMargin
        //         to: 999
        //         onValueChanged: {
        //             cfg_topOuterMargin = topOuterMargin.value
        //         }
        //     }
        //     Label {
        //         anchors.verticalCenter: parent.verticalCenter
        //         anchors.left:topOuterMargin.right
        //         anchors.leftMargin: 4
        //         text: i18nc("pixels", "px")
        //     }
        // }

        // Item {
        //     Label {
        //         id: widgetWidthLabel
        //         text: i18n("Widget Width") + ":"
        //         Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        //     }
        // }

        Item {
            width: 2
            height: 2
            Layout.columnSpan: 3
        }

            // Layout.alignment: Qt.AlignVCenter
            Label {
                id: widgetWidthLabel
                text: i18n("Meteogram width") + ":"
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            }

            SpinBox {
                id: widgetWidth
                live: true
                Layout.alignment: Qt.AlignVCenter
                // anchors.left: widgetWidthLabel.right
                // anchors.top: widgetWidthLabel.top
                // anchors.verticalCenter: parent.verticalCenter
                anchors.topMargin: -8
                anchors.leftMargin: 5
                stepSize: 1
                from: plasmoid.configuration.weeklyForecastVisible ? 650 : 460 //650 //800 460
                value: cfg_widgetWidth
                to: Screen.desktopAvailableWidth * 0.9
                onValueChanged: {
                    cfg_widgetWidth = widgetWidth.value
                }

                contentItem: TextInput {
                    text: widgetWidth.value
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    color: Kirigami.Theme.textColor
                    selectionColor: Kirigami.Theme.highlightColor
                    leftPadding: 8
                    rightPadding: 2
                }
            }

            Label {
                text: i18nc("pixels", "px")
                anchors.top: widgetWidthLabel.top
                anchors.left: widgetWidth.right
                anchors.leftMargin: 5
            }

        Item {
            width: 2
            height: 2
            Layout.columnSpan: 3
        }

        Label {
            id: widgetHeightLabel
            text: i18n("Meteogram height") + ":"
            Layout.alignment: Qt.AlignTop | Qt.AlignRight
        }

        SpinBox {
            id: widgetHeight
            live: true
            Layout.alignment: Qt.AlignVCenter
            anchors.left: widgetHeightLabel.right
            anchors.top: widgetHeightLabel.top
            // anchors.verticalCenter: parent.verticalCenter
            anchors.topMargin: -8
            anchors.leftMargin: 5
            stepSize: 1
            from: plasmoid.configuration.weeklyForecastVisible ? 200 : 100 //300 200
            value: cfg_widgetHeight
            to: Screen.desktopAvailableHeight * 0.75
            onValueChanged: {
                cfg_widgetHeight = widgetHeight.value
            }

            contentItem: TextInput {
                text: widgetHeight.value
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                color: Kirigami.Theme.textColor
                selectionColor: Kirigami.Theme.highlightColor
                leftPadding: 8
                rightPadding: 2
            }
        }

        Label {
            id: widgetHeightPx
            text: i18nc("pixels", "px")
            anchors.top: widgetHeightLabel.top
            anchors.left: widgetHeight.right
            anchors.leftMargin: 5
        }

        Item {
            width: 2
            height: 2
            Layout.columnSpan: 3
        }

        Label {
                id: widgetWidthLabelInTray
                text: i18n("Meteogram width in tray") + ":"
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            }

            SpinBox {
                id: widgetWidthInTray
                live: true
                Layout.alignment: Qt.AlignVCenter
                // anchors.left: widgetWidthLabelInTray.right
                // anchors.top: widgetWidthLabelInTray.top
                // anchors.verticalCenter: parent.verticalCenter
                anchors.topMargin: -8
                anchors.leftMargin: 5
                stepSize: 1
                from: 300 //650 //800
                value: cfg_widgetWidthInTray
                to: Screen.desktopAvailableWidth * 0.9
                onValueChanged: {
                    cfg_widgetWidthInTray = widgetWidthInTray.value
                }

                contentItem: TextInput {
                    text: widgetWidthInTray.value
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    color: Kirigami.Theme.textColor
                    selectionColor: Kirigami.Theme.highlightColor
                    leftPadding: 8
                    rightPadding: 2
                }
            }

            Label {
                text: i18nc("pixels", "px")
                anchors.top: widgetWidthLabelInTray.top
                anchors.left: widgetWidthInTray.right
                anchors.leftMargin: 5
            }

        Item {
            width: 2
            height: 2
            Layout.columnSpan: 3
        }

        Label {
            id: widgetHeightLabelInTray
            text: i18n("Meteogram height in tray") + ":"
            Layout.alignment: Qt.AlignTop | Qt.AlignRight
        }

        SpinBox {
            id: widgetHeightInTray
            live: true
            Layout.alignment: Qt.AlignVCenter
            anchors.left: widgetHeightLabelInTray.right
            anchors.top: widgetHeightLabelInTray.top
            // anchors.verticalCenter: parent.verticalCenter
            anchors.topMargin: -8
            anchors.leftMargin: 5
            stepSize: 1
            from: 200 //300 200
            value: cfg_widgetHeightInTray
            to: Screen.desktopAvailableHeight * 0.75
            onValueChanged: {
                cfg_widgetHeightInTray = widgetHeightInTray.value
            }

            contentItem: TextInput {
                text: widgetHeightInTray.value
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                color: Kirigami.Theme.textColor
                selectionColor: Kirigami.Theme.highlightColor
                leftPadding: 8
                rightPadding: 2
            }
        }

        Label {
            id: widgetHeightPxInTray
            text: i18nc("pixels", "px")
            anchors.top: widgetHeightLabelInTray.top
            anchors.left: widgetHeightInTray.right
            anchors.leftMargin: 5
        }

        Item {
            width: 2
            height: 2
            Layout.columnSpan: 3
        }

        Label {
            id: hourSpanOmLabel
            text: i18n("Open-Meteo forecast length") + ":"
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        }

        SpinBox {
            id: hourSpanOm
            live: true
            Layout.alignment: Qt.AlignVCenter
            // anchors.left: hourSpanOmLabel.right
            // anchors.top: hourSpanOmLabel.top
            // anchors.verticalCenter: parent.verticalCenter
            anchors.topMargin: -8
            anchors.leftMargin: 5
            stepSize: 1
            from: 24
            value: cfg_hourSpanOm
            to: 144 //main.inTray ? 48 : 144
            onValueChanged: {
                cfg_hourSpanOm = hourSpanOm.value
            }

            contentItem: TextInput {
                text: hourSpanOm.value
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                color: Kirigami.Theme.textColor
                selectionColor: Kirigami.Theme.highlightColor
                leftPadding: 8
                rightPadding: 2
            }
            // Component.onCompleted: {
            //     // loadingData.failedAttemptCount = 0
            //     // main.loadDataFromInternet()
            //     Reload.reload()
            // }
        }

        Label {
            text: i18nc("hours", "hrs")
            anchors.top: hourSpanOmLabel.top
            anchors.left: hourSpanOm.right
            anchors.leftMargin: 5
        }

        Item {
            width: 2
            height: 1
            Layout.columnSpan: 3
        }

        CheckBox {
            id: weeklyForecastVisible
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            // anchors.top: mgTrailingZeroesFontSizeLabel.bottom
            // anchors.topMargin: 13
        }

        Label {
            text: i18n("Weekly forecast visible")
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            // anchors.top: trailingZeroesVisible.top
            // anchors.topMargin: 2
        }

        Item {
            width: 2
            height: 1
            Layout.columnSpan: 3
        }

        CheckBox {
            id: trailingZeroesVisible
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            // anchors.top: mgTrailingZeroesFontSizeLabel.bottom
            // anchors.topMargin: 13
        }

        Label {
            text: i18n("Trailing zeroes visible")
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            // anchors.top: trailingZeroesVisible.top
            // anchors.topMargin: 2
        }

        Item {
            width: 2
            height: 1
            Layout.columnSpan: 3
        }

            // CheckBox {
            //     id: precLabelVisChoice
            //     Layout.topMargin: -4
            //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            // }
            //
            // Label {
            //     text: i18n("Precipitation label")
            //     Layout.topMargin: -4
            //     Layout.alignment: Qt.AlignLeft
            // }
            //
            // Item {
            //     width: 2
            //     height: 4
            //     Layout.columnSpan: 3
            // }

        // Label {
        //     id: reloadWidgetLabel
        //     text: i18n("Reload widget to see changes")
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        //     Layout.topMargin: 5
        // }

        // Item {
        //     width: 2
        //     height: 2
        //     Layout.columnSpan: 3
        // }
        //
        // CheckBox {
        //     id: tempLabelVisible
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        // }
        //
        // Label {
        //     text: i18n("Temperature label visible")
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        // }
        //
        // Item {
        //     width: 2
        //     height: 2
        //     Layout.columnSpan: 3
        // }
        //
        // CheckBox {
        //     id: pressureLabelVisible
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        // }
        //
        // Label {
        //     text: i18n("Pressure label visible")
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        // }
        //
        // Item {
        //     width: 2
        //     height: 4
        //     Layout.columnSpan: 3
        // }

            // Layout.alignment: Qt.AlignVCenter
        //     Label {
        //         id: mgTempFontSizeLabel
        //         text: i18n("Temperature axis font size") + ":"
        //         Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        //     }
        //
        //     SpinBox {
        //         id: mgTempFontSize
        //         Layout.alignment: Qt.AlignVCenter
        //         anchors.left: mgTempFontSizeLabel.right
        //         anchors.top: mgTempFontSizeLabel.top
        //         // anchors.verticalCenter: parent.verticalCenter
        //         anchors.topMargin: -8
        //         anchors.leftMargin: 4
        //         stepSize: 1
        //         from: 2
        //         value: cfg_mgTempFontSize
        //         to: 64
        //         onValueChanged: {
        //             cfg_mgTempFontSize = mgTempFontSize.value
        //         }
        //     }
        //
        //     Label {
        //         text: i18nc("pixels", "px")
        //         anchors.left: mgTempFontSize.right
        //         anchors.leftMargin: 4
        //     }
        //
        // Item {
        //     width: 2
        //     height: 2
        //     Layout.columnSpan: 3
        // }

        // CheckBox {
        //     id: tempLabelVisible
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        // }
        //
        // Label {
        //     text: i18n("Temperature label visible")
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        // }
        //
        // Item {
        //     width: 2
        //     height: 2
        //     Layout.columnSpan: 3
        // }
        //
        // CheckBox {
        //     id: pressureLabelVisible
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        // }
        //
        // Label {
        //     text: i18n("Pressure label visible")
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        // }
        //
        // Item {
        //     width: 2
        //     height: 2
        //     Layout.columnSpan: 3
        // }


        // Item {
        //     anchors.left: parent.left
        //     anchors.leftMargin: Kirigami.Units.largeSpacing //hourSpanOmLabel.left

        // Label {
        //     id: tempLabelRadioGroup
        //     text: i18n("Temperature label") + ":"
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        // }
        // RadioButton {
        //     id: tempLabelPositionTop
        //     ButtonGroup.group: tempLabelPositionGroup
        //     text: i18n("Top")
        //     onCheckedChanged: if (checked) cfg_tempLabelPosition = 0;
        // }
        // Item {
        //     width: 2
        //     height: 2
        //     Layout.rowSpan: 2
        // }
        // Item {
        //     width: 2
        //     height: 2
        //     Layout.columnSpan: 1
        // }
        // RadioButton {
        //     id: tempLabelPositionBottom
        //     ButtonGroup.group: tempLabelPositionGroup
        //     text: i18n("Bottom")
        //     onCheckedChanged: if (checked) cfg_tempLabelPosition = 1;
        // }
        // Item {
        //     width: 2
        //     height: 2
        //     Layout.rowSpan: 2
        // }

//         RadioButton {
//             id: tempLabelPositionNone
//             ButtonGroup.group: tempLabelPositionGroup
//             text: i18n("None")
//             onCheckedChanged: if (checked) cfg_tempLabelPosition = 2;
//         }
//
//         Item {
//             Layout.preferredWidth: 200
//             Layout.rowSpan: 3
//             anchors.top: tempLabelRadioGroup.top
//             anchors.right: parent.right
//             anchors.rightMargin: Kirigami.Units.largeSpacing * 3
//             Label {
//                 id: pressureLabelRadioGroup
//                 text: i18n("Pressure label") + ":"
//                 Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
//             }
//             RadioButton {
//                 id: pressureLabelPositionTop
//                 ButtonGroup.group: pressureLabelPositionGroup
//                 text: i18n("Top")
//                 onCheckedChanged: if (checked) cfg_pressureLabelPosition = 0;
//                 anchors.left: pressureLabelRadioGroup.right
//                 anchors.leftMargin: 5
//                 anchors.topMargin: -2
//                 // anchors.top: pressureLabelRadioGroup.top
//             }
//
//             RadioButton {
//                 id: pressureLabelPositionBottom
//                 ButtonGroup.group: pressureLabelPositionGroup
//                 text: i18n("Bottom")
//                 onCheckedChanged: if (checked) cfg_pressureLabelPosition = 1;
//                 anchors.left: pressureLabelRadioGroup.right
//                 anchors.leftMargin: 5
//                 anchors.top: pressureLabelPositionTop.bottom
//                 anchors.topMargin: 5
//             }
//
//             RadioButton {
//                 id: pressureLabelPositionNone
//                 ButtonGroup.group: pressureLabelPositionGroup
//                 text: i18n("None")
//                 onCheckedChanged: if (checked) cfg_pressureLabelPosition = 2;
//                 anchors.left: pressureLabelRadioGroup.right
//                 anchors.leftMargin: 5
//                 anchors.top: pressureLabelPositionBottom.bottom
//                 anchors.topMargin: 5
//             }
//         }

        Item {
            width: 2
            height: 2
            Layout.columnSpan: 3
        }

            Label {
                id: mgAxisFontSizeLabel
                text: i18n("Vertical axis font size") + ":"
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                // Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                // Layout.topMargin: -5
            }

            SpinBox {
                id: mgAxisFontSize
                live: true
                Layout.alignment: Qt.AlignVCenter
                // anchors.left: mgAxisFontSizeLabel.right
                // anchors.top: mgAxisFontSizeLabel.top
                // anchors.verticalCenter: parent.verticalCenter
                anchors.topMargin: -8
                anchors.leftMargin: 5
                stepSize: 1
                from: 2
                value: cfg_mgAxisFontSize
                to: 64
                onValueChanged: {
                    cfg_mgAxisFontSize = mgAxisFontSize.value
                }

                contentItem: TextInput {
                    text: mgAxisFontSize.value
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    color: Kirigami.Theme.textColor
                    selectionColor: Kirigami.Theme.highlightColor
                    leftPadding: 8
                    rightPadding: 2
                }
            }

            Label {
                id: mgAxisFontSizePx
                text: i18nc("pixels", "px")
                anchors.top: mgAxisFontSizeLabel.top
                anchors.left: mgAxisFontSize.right
                anchors.leftMargin: 5
            }
        // }

            // Item {
                // Layout.leftMargin: Kirigami.Units.largeSpacing
                // Layout.preferredWidth: 125
                // CheckBox {
                //     id: tempLabelVisible
                //     Layout.preferredWidth: 200
                //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                //     anchors.top: mgAxisFontSizeLabel.top
                //     anchors.right: parent.right
                //     anchors.rightMargin: Kirigami.Units.largeSpacing
                //     text: i18n("Temperature label")
                // }

                // Label {
                //     text: i18n("Temperature label")
                //     Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                // }
            // }

            // Item {
            //     width: 2
            //     height: 2
            //     Layout.columnSpan: 3
            // }

            Label {
                id: mgHoursFontSizeLabel
                text: i18n("Time font size") + ":"
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                // anchors.top: mgAxisFontSize.bottom
                // anchors.topMargin: 13
            }

            SpinBox {
                id: mgHoursFontSize
                live: true
                Layout.alignment: Qt.AlignVCenter
                // anchors.left: mgHoursFontSizeLabel.right
                // anchors.top: mgHoursFontSizeLabel.top
                // anchors.verticalCenter: parent.verticalCenter
                anchors.topMargin: -8
                anchors.leftMargin: 5
                stepSize: 1
                from: 2
                value: cfg_mgHoursFontSize
                to: 64
                onValueChanged: {
                    cfg_mgHoursFontSize = mgHoursFontSize.value
                }

                contentItem: TextInput {
                    text: mgHoursFontSize.value
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    color: Kirigami.Theme.textColor
                    selectionColor: Kirigami.Theme.highlightColor
                    leftPadding: 8
                    rightPadding: 2
                }
            }

            Label {
                text: i18nc("pixels", "px")
                anchors.top: mgHoursFontSizeLabel.top
                anchors.left: mgHoursFontSize.right
                anchors.leftMargin: 5
            }

            // CheckBox {
            //     id: pressureLabelVisible
            //     Layout.preferredWidth: 200
            //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            //     anchors.top: mgHoursFontSizeLabel.top
            //     anchors.right: parent.right
            //     anchors.rightMargin: Kirigami.Units.largeSpacing
            //     text: i18n("Pressure label")
            // }

            // Item {
            //     CheckBox {
            //         id: pressureLabelVisible
            //         Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            //     }
            //
            //     Label {
            //         text: i18n("Pressure label visible")
            //         Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            //     }
            // }

        // Item {
        //     width: 2
        //     height: 2
        //     Layout.columnSpan: 3
        // }

        // Layout.alignment: Qt.AlignVCenter
        Label {
            id: mgTrailingZeroesFontSizeLabel
            text: i18n("Trailing zeroes font size") + ":"
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            // anchors.top: mgHoursFontSize.bottom
            // anchors.topMargin: 13
        }

        SpinBox {
            id: mgTrailingZeroesFontSize
            live: true
            Layout.alignment: Qt.AlignVCenter
            // anchors.left: mgTrailingZeroesFontSizeLabel.right
            // anchors.top: mgTrailingZeroesFontSizeLabel.top
            // anchors.verticalCenter: parent.verticalCenter
            anchors.topMargin: -8
            anchors.leftMargin: 5
            stepSize: 1
            from: 2
            value: cfg_mgTrailingZeroesFontSize
            to: 64
            onValueChanged: {
                cfg_mgTrailingZeroesFontSize = mgTrailingZeroesFontSize.value
            }

            contentItem: TextInput {
                text: mgTrailingZeroesFontSize.value
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                color: Kirigami.Theme.textColor
                selectionColor: Kirigami.Theme.highlightColor
                leftPadding: 8
                rightPadding: 2
            }
        }

        Label {
            text: i18nc("pixels", "px")
            anchors.top: mgTrailingZeroesFontSizeLabel.top
            // anchors.topMargin: 13
            anchors.left: mgTrailingZeroesFontSize.right
            anchors.leftMargin: 5
        }

        // Item {
        //     width: 2
        //     height: 2
        //     Layout.columnSpan: 3
        // }

        // CheckBox {
        //     id: trailingZeroesVisible
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        //     // anchors.top: mgTrailingZeroesFontSizeLabel.bottom
        //     // anchors.topMargin: 13
        // }
        //
        // Label {
        //     text: i18n("Trailing zeroes visible")
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        //     // anchors.top: trailingZeroesVisible.top
        //     // anchors.topMargin: 2
        // }


        // Item {
        //     width: 2
        //     height: 2
        //     Layout.columnSpan: 3
        // }
        //
        // CheckBox {
        //     id: weeklyForecastVisible
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        //     // anchors.top: mgTrailingZeroesFontSizeLabel.bottom
        //     // anchors.topMargin: 13
        // }
        //
        // Label {
        //     text: i18n("Weekly forecast visible")
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        //     // anchors.top: trailingZeroesVisible.top
        //     // anchors.topMargin: 2
        // }

        //
        // Item {
        //     width: 2
        //     height: 10
        //     Layout.columnSpan: 3
        // }
        //
        // Label {
        //     text: i18n("Bottom Margin") + ":"
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        //
        //
        // }
        //
        // Item {
        //     SpinBox {
        //         id: bottomOuterMargin
        //         Layout.alignment: Qt.AlignVCenter
        //         anchors.verticalCenter: parent.verticalCenter
        //         stepSize: 1
        //         from: -999
        //         value: cfg_bottomOuterMargin
        //         to: 999
        //         onValueChanged: {
        //             cfg_bottomOuterMargin = bottomOuterMargin.value
        //         }
        //     }
        //
        //     Label {
        //         anchors.verticalCenter: parent.verticalCenter
        //         anchors.left:bottomOuterMargin.right
        //         anchors.leftMargin: 4
        //         text: i18nc("pixels", "px")
        //     }
        // }

        // Item {
        //     width: 2
        //     height: 20
        //     Layout.columnSpan: 3
        // }

    }
}
