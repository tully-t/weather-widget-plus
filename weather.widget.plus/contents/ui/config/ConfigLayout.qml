import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM
// import "../"

KCM.SimpleKCM {

    id: appearancePage
    property int cfg_layoutType
    property int cfg_widgetOrder

    property string cfg_leftOuterMargin: plasmoid.configuration.leftOuterMargin
    property string cfg_innerMargin: plasmoid.configuration.innerMargin
    property string cfg_rightOuterMargin: plasmoid.configuration.rightOuterMargin
    property string cfg_topOuterMargin: plasmoid.configuration.topOuterMargin
    property string cfg_bottomOuterMargin: plasmoid.configuration.bottomOuterMargin

    // property alias cfg_textVisible: textVisible.checked // moved to Appearance
    // property alias cfg_iconVisible: iconVisible.checked // moved to Appearance
    // property int cfg_hourSpanOm // moved to Meteogram
    // property int cfg_widgetWidth // moved to Meteogram
    // property int cfg_widgetHeight // moved to Meteogram
    // property int cfg_desktopMode // moved to Meteogram



    onCfg_layoutTypeChanged: {
        switch (cfg_layoutType) {
            case 0:
                layoutTypeGroup.checkedButton = layoutTypeRadioHorizontal;
                break;
            case 1:
                layoutTypeGroup.checkedButton = layoutTypeRadioVertical;
                break;
            case 2:
                layoutTypeGroup.checkedButton = layoutTypeRadioCompact;
                break;
            default:
        }
    }

    Component.onCompleted: {
        cfg_layoutTypeChanged()
    }

    ButtonGroup {
        id: layoutTypeGroup
    }

    onCfg_widgetOrderChanged: {
        switch (cfg_widgetOrder) {
            case 0:
                widgetOrderGroup.checkedButton = widgetOrderIconFirst;
                break;
            case 1:
                widgetOrderGroup.checkedButton = widgetOrderTextFirst;
                break;
            default:
        }
    }

    ButtonGroup {
        id: widgetOrderGroup

        Component.onCompleted: {
            cfg_widgetOrderChanged()
        }
    }

    // onCfg_desktopModeChanged: {
    //     switch (cfg_desktopMode) {
    //         case 0:
    //             desktopModeGroup.checkedButton = desktopModeIcon;
    //             break;
    //         case 1:
    //             desktopModeGroup.checkedButton = desktopModeMeteogram;
    //             break;
    //         default:
    //     }
    // }
    //
    // ButtonGroup {
    //     id: desktopModeGroup
    //
    //     Component.onCompleted: {
    //         cfg_desktopModeChanged()
    //     }
    // }

    GridLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        columns: 3

        Label {
            text: i18n("Layout type") + ":"
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        }
        RadioButton {
            id: layoutTypeRadioHorizontal
            ButtonGroup.group: layoutTypeGroup
            text: i18n("Horizontal")
            onCheckedChanged: if (checked) cfg_layoutType = 0;
        }
        Label {
            text: i18n("Layout type is not available in the system tray")
            Layout.rowSpan: 3
            Layout.preferredWidth: 250
            wrapMode: Text.WordWrap
        }
        Item {
            width: 2
            height: 2
            Layout.rowSpan: 2
        }
        RadioButton {
            id: layoutTypeRadioVertical
            ButtonGroup.group: layoutTypeGroup
            text: i18n("Vertical")
            onCheckedChanged: if (checked) cfg_layoutType = 1;
        }
        RadioButton {
            id: layoutTypeRadioCompact
            ButtonGroup.group: layoutTypeGroup
            text: i18n("Compact")
            onCheckedChanged: if (checked) cfg_layoutType = 2;
        }

        Item {
            width: 2
            height: 10
            Layout.columnSpan: 3
        }

        Label {
            text: i18n("Widget order") + ":"
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        }
        RadioButton {
            id: widgetOrderIconFirst
            ButtonGroup.group: widgetOrderGroup
            text: i18n("Icon first")
            onCheckedChanged: if (checked) cfg_widgetOrder = 0;
        }
        Label {
            text: i18n("Widget order is not available in either the system tray or the Compact layout")
            Layout.rowSpan: 3
            Layout.preferredWidth: 250
            wrapMode: Text.WordWrap
        }
        Item {
            width: 2
            height: 2
            Layout.rowSpan: 2
        }
        Item {
            width: 2
            height: 2
            Layout.columnSpan: 1
        }
        RadioButton {
            id: widgetOrderTextFirst
            ButtonGroup.group: widgetOrderGroup
            text: i18n("Text first")
            onCheckedChanged: if (checked) cfg_widgetOrder = 1;
        }

        // Item {
        //     width: 2
        //     height: 5
        //     Layout.columnSpan: 3
        // }
        //
        // Label {
        //     text: i18n("Desktop mode") + ":"
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        // }
        // RadioButton {
        //     id: desktopModeIcon
        //     ButtonGroup.group: desktopModeGroup
        //     text: i18n("Icon")
        //     onCheckedChanged: if (checked) cfg_desktopMode = 0;
        // }
        // // Label {
        // //     text: i18n("Desktop meteogram mode is not affected by any other Layout or Appearance options")
        // //     Layout.rowSpan: 3
        // //     Layout.preferredWidth: 250
        // //     wrapMode: Text.WordWrap
        // // }
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
        //     id: desktopModeMeteogram
        //     ButtonGroup.group: desktopModeGroup
        //     text: i18n("Meteogram")
        //     onCheckedChanged: if (checked) cfg_desktopMode = 1;
        // }

        Item {
            width: 2
            height: 18
            Layout.columnSpan: 3
        }

        Label {
            text: i18n("Top Margin") + ":"
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        }

        Item {
            SpinBox {
                id: topOuterMargin
                live: true
                Layout.alignment: Qt.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                stepSize: 1
                from: -999
                value: cfg_topOuterMargin
                to: 999
                onValueChanged: {
                    cfg_topOuterMargin = topOuterMargin.value
                }
                contentItem: TextInput {
                    text: topOuterMargin.value
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    color: Kirigami.Theme.textColor
                    selectionColor: Kirigami.Theme.highlightColor
                    leftPadding: 8
                    rightPadding: 2
                }
            }
            Label {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:topOuterMargin.right
                anchors.leftMargin: 4
                text: i18nc("pixels", "px")
            }
        }

        // Item {
        //     Label {
        //         id: widgetWidthLabel
        //         text: i18n("Widget Width") + ":"
        //         Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        //     }
        // }

        // Item {
        //     // Layout.alignment: Qt.AlignVCenter
        //     Label {
        //         id: widgetWidthLabel
        //         text: i18n("Meteogram width") + ":"
        //         Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        //     }
        //
        //     SpinBox {
        //         id: widgetWidth
        //         Layout.alignment: Qt.AlignVCenter
        //         anchors.left: widgetWidthLabel.right
        //         anchors.top: widgetWidthLabel.top
        //         // anchors.verticalCenter: parent.verticalCenter
        //         anchors.topMargin: -8
        //         anchors.leftMargin: 4
        //         stepSize: 1
        //         from: 800
        //         value: cfg_widgetWidth
        //         to: Screen.desktopAvailableWidth * 0.9
        //         onValueChanged: {
        //             cfg_widgetWidth = widgetWidth.value
        //         }
        //         // Component.onCompleted: {
        //         //     // loadingData.failedAttemptCount = 0
        //         //     //EndMe.loadDataFromInternet()
        //         //     Reload.reload()
        //         // }
        //     }
        //
        //     Label {
        //         text: i18nc("pixels", "px")
        //         anchors.left: widgetWidth.right
        //         anchors.leftMargin: 4
        //     }
        // }

        Item {
            width: 2
            height: 14
            Layout.columnSpan: 3
        }

        Label {
            text: i18n("Left Margin") + ":"
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        }

        Item {
            SpinBox {
                id: leftOuterMargin
                live: true
                Layout.alignment: Qt.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                stepSize: 1
                from: -999
                value: cfg_leftOuterMargin
                to: 999
                onValueChanged: {
                    cfg_leftOuterMargin = leftOuterMargin.value
                }
                contentItem: TextInput {
                    text: leftOuterMargin.value
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    color: Kirigami.Theme.textColor
                    selectionColor: Kirigami.Theme.highlightColor
                    leftPadding: 8
                    rightPadding: 2
                }
            }
            Label {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:leftOuterMargin.right
                anchors.leftMargin: 4
                text: i18nc("pixels", "px")
            }
        }

        // Item {
        //     // Layout.alignment: Qt.AlignVCenter
        //     Label {
        //         id: widgetHeightLabel
        //         text: i18n("Meteogram height") + ":"
        //         Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        //     }
        //
        //     SpinBox {
        //         id: widgetHeight
        //         Layout.alignment: Qt.AlignVCenter
        //         anchors.left: widgetHeightLabel.right
        //         anchors.top: widgetHeightLabel.top
        //         // anchors.verticalCenter: parent.verticalCenter
        //         anchors.topMargin: -8
        //         anchors.leftMargin: 4
        //         stepSize: 1
        //         from: 320
        //         value: cfg_widgetHeight
        //         to: Screen.desktopAvailableHeight * 0.75
        //         onValueChanged: {
        //             cfg_widgetHeight = widgetHeight.value
        //         }
        //         // Component.onCompleted: {
        //         //     // loadingData.failedAttemptCount = 0
        //         //     //EndMe.loadDataFromInternet()
        //         //     Reload.reload()
        //         // }
        //     }
        //
        //     Label {
        //         text: i18nc("pixels", "px")
        //         anchors.left: widgetHeight.right
        //         anchors.leftMargin: 4
        //     }
        // }

        // Item {
        //     CheckBox {
        //         id: iconVisible
        //         Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        //     }
        //
        //     Label {
        //         text: i18n("Icon visible")
        //         anchors.left: iconVisible.right
        //         anchors.leftMargin: 4
        //     }
        // }

        Item {
            width: 2
            height: 14
            Layout.columnSpan: 3
        }

        Label {
            text: i18n("Inner Margin") + ":"
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        }

        Item {
            SpinBox {
                id: innerMargin
                live: true
                Layout.alignment: Qt.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                stepSize: 1
                from: -999
                value: cfg_innerMargin
                to: 999
                onValueChanged: {
                    cfg_innerMargin = innerMargin.value
                }
                contentItem: TextInput {
                    text: innerMargin.value
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    color: Kirigami.Theme.textColor
                    selectionColor: Kirigami.Theme.highlightColor
                    leftPadding: 8
                    rightPadding: 2
                }
            }
            Label {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:innerMargin.right
                anchors.leftMargin: 4
                text: i18nc("pixels", "px")
            }
        }

        // Item {
        //     // Layout.alignment: Qt.AlignVCenter
        //     Label {
        //         id: hourSpanOmLabel
        //         text: i18n("OM forecast length") + ":"
        //         Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        //     }
        //
        //     SpinBox {
        //         id: hourSpanOm
        //         Layout.alignment: Qt.AlignVCenter
        //         anchors.left: hourSpanOmLabel.right
        //         anchors.top: hourSpanOmLabel.top
        //         // anchors.verticalCenter: parent.verticalCenter
        //         anchors.topMargin: -8
        //         anchors.leftMargin: 4
        //         stepSize: 1
        //         from: 24
        //         value: cfg_hourSpanOm
        //         to: 144
        //         onValueChanged: {
        //             cfg_hourSpanOm = hourSpanOm.value
        //         }
        //         // Component.onCompleted: {
        //         //     // loadingData.failedAttemptCount = 0
        //         //     // main.loadDataFromInternet()
        //         //     Reload.reload()
        //         // }
        //     }
        //
        //     Label {
        //         text: i18nc("hours", "hrs")
        //         anchors.left: hourSpanOm.right
        //         anchors.leftMargin: 4
        //     }
        // }

        // Label {
        //     id: reloadWidgetLabel
        //     text: i18n("Reload widget to see changes")
        //     Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        //     Layout.topMargin: 5
        // }

        Item {
            width: 2
            height: 14
            Layout.columnSpan: 3
        }

        Label {
            text: i18n("Right Margin") + ":"
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
        }

        Item {
            SpinBox {
                id: rightOuterMargin
                live: true
                Layout.alignment: Qt.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                // decimals: 0
                stepSize: 1
                from: -999
                value: cfg_rightOuterMargin
                to: 999
                onValueChanged: {
                    cfg_rightOuterMargin = rightOuterMargin.value
                }
                contentItem: TextInput {
                    text: rightOuterMargin.value
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    color: Kirigami.Theme.textColor
                    selectionColor: Kirigami.Theme.highlightColor
                    leftPadding: 8
                    rightPadding: 2
                }
            }
            Label {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:rightOuterMargin.right
                anchors.leftMargin: 4
                text: i18nc("pixels", "px")
            }
        }

        Item {
            width: 2
            height: 14
            Layout.columnSpan: 3
        }

        Label {
            text: i18n("Bottom Margin") + ":"
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight


        }

        Item {
            SpinBox {
                id: bottomOuterMargin
                live: true
                Layout.alignment: Qt.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                stepSize: 1
                from: -999
                value: cfg_bottomOuterMargin
                to: 999
                onValueChanged: {
                    cfg_bottomOuterMargin = bottomOuterMargin.value
                }
                contentItem: TextInput {
                    text: bottomOuterMargin.value
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    color: Kirigami.Theme.textColor
                    selectionColor: Kirigami.Theme.highlightColor
                    leftPadding: 8
                    rightPadding: 2
                }
            }

            Label {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:bottomOuterMargin.right
                anchors.leftMargin: 4
                text: i18nc("pixels", "px")
            }
        }

        // Item {
        //     width: 2
        //     height: 20
        //     Layout.columnSpan: 3
        // }

    }
}
