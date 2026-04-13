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
import org.kde.plasma.core 2.0 as PlasmaCore
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import Qt5Compat.GraphicalEffects
import org.kde.kirigami as Kirigami


Loader {
    id: compactRepresentation

    anchors.fill: parent

    readonly property bool vertical: (Plasmoid.formFactor == PlasmaCore.Types.Vertical)

    property int defaultWidgetSize: -1
    property int widgetOrder: main.widgetOrder
    property int layoutType: main.layoutType
    property int temperatureType: plasmoid.configuration.temperatureType
    property bool loadingDataComplete: main.loadingDataComplete

    sourceComponent: layoutType === 2 ? compactItem : widgetOrder === 1 ? compactItemReverse : compactItem

    Layout.fillWidth: compactRepresentation.vertical
    Layout.fillHeight: !compactRepresentation.vertical
    Layout.minimumWidth: item.Layout.minimumWidth
    Layout.minimumHeight: item.Layout.minimumHeight

    onTemperatureTypeChanged: {
        if (loadingDataComplete === true) {
        dbgprint2('TemperatureType changed')
        main.updateCompactItem()
        }
    }

    Component {
        id: compactItem
        CompactItem {
            vertical: compactRepresentation.vertical
        }
    }

    Component {
        id: compactItemReverse
        CompactItemReverse {
            vertical: compactRepresentation.vertical
        }
    }

    PlasmaComponents.BusyIndicator {
        id: busyIndicator
        anchors.fill: parent
        visible: false
        running: false

        states: [
            State {
                name: 'loading'
                when: !loadingDataComplete

                PropertyChanges {
                    target: busyIndicator
                    visible: true
                    running: true
                }

                PropertyChanges {
                    target: compactItem
                }
            }
        ]
    }

    MouseArea {
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.MiddleButton

        hoverEnabled: true

        onClicked: (mouse)=> {
            if (mouse.button === Qt.MiddleButton) {
                loadingData.failedAttemptCount = 0
                main.loadDataFromInternet()
            } else {
                main.expanded = !main.expanded
            }
        }

        onEntered: main.refreshTooltipSubText()

        PlasmaCore.ToolTipArea {
            id: toolTipArea
            anchors.fill: parent
            active: !main.expanded
            interactive: true
            mainText: main.currentPlace.alias
            subText:  main.toolTipSubText
            textFormat: Text.RichText
        }
    }

    Component.onCompleted: {
        if ((defaultWidgetSize === -1) && (compactRepresentation.width > 0 ||  compactRepresentation.height)) {
            defaultWidgetSize = Math.min(compactRepresentation.width, compactRepresentation.height)
        }
    }
}
