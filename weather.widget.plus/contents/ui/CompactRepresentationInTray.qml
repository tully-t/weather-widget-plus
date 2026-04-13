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
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore

Loader {
    id: compactRepresentation

    anchors.fill: parent

    property int defaultWidgetSize: -1
    property int temperatureType: plasmoid.configuration.temperatureType
    property bool loadingDataComplete: main.loadingDataComplete //main.loadingDataComplete

    sourceComponent: compactIteminTray

    onTemperatureTypeChanged: {
        if (main.loadingDataComplete === true) {
            dbgprint2('TemperatureType changed')
            main.updateCompactItem()
        }
    }

    CompactIteminTray {
        id: compactIteminTray
    }

    MouseArea {
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.MiddleButton

        hoverEnabled: true

        onClicked: (mouse)=> {
            dbgprint("CompactRepresentationInTray")
            let t = main.expanded
            if (t) {
                dbgprint("Closing FullRepresentationInTray")
            } else {
                dbgprint("Opening FullRepresentationInTray")

            }
            if (mouse.button === Qt.MiddleButton) {
                loadingData.failedAttemptCount = 0
                main.loadDataFromInternet()
            } else {
                main.expanded = !main.expanded
                // MeteogramInTray.plasmoidExpanded = true
                // layoutTimer2.start()
                // MeteogramInTray.expansionCounter()
                // meteogram3.buildCurves()
            }
        }

        onEntered: main.refreshTooltipSubText()

    }

}
