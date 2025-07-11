﻿import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../code/config-utils.js" as ConfigUtils
import "../../code/placesearch-helpers.js" as Helper
import "../../code/timezoneData.js" as TZData
import Qt.labs.qmlmodels
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    function dbgprint(msg) {
        if (!cfg_debugLogging) {
            return
        }

        print('[test weatherWidgetPlus] ' + msg)
    }


    id: generalConfigPage

    property alias cfg_reloadIntervalMin: reloadIntervalMin.value
    property string cfg_places
    property alias cfg_debugLogging: debugLogging.checked
    property double defaultFontPixelSize: Kirigami.Theme.defaultFont.pixelSize
    property bool env_QML_XHR_ALLOW_FILE_READ: plasmoid.configuration.qml_XHR_ALLOW_FILE_READ
    property bool textColorLight: ((Kirigami.Theme.textColor.r + Kirigami.Theme.textColor.g + Kirigami.Theme.textColor.b) / 3) > 0.5
    property var backgroundColor: Kirigami.Theme.backgroundColor
    property var alternateBackgroundColor: Kirigami.Theme.alternateBackgroundColor
    property var highlightColor: Kirigami.Theme.highlightColor


    Component.onCompleted: {

        var places = ConfigUtils.getPlacesArray()
        var f = 0
        ConfigUtils.getPlacesArray().forEach(function (placeObj) {
            placesModel.appendRow({
                providerId: placeObj.providerId,
                placeIdentifier: placeObj.placeIdentifier,
                placeAlias: placeObj.placeAlias,
                timezoneID: (placeObj.timezoneID !== undefined) ? placeObj.timezoneID : -1,
            })
        })
        let timezoneArray = TZData.TZData.sort(dynamicSort("displayName"))
        timezoneArray.forEach(function (tz) {
            timezoneDataModel.append({displayName: tz.displayName.replace(/_/gi, " "), id: tz.id});
        })
    }

    function dynamicSort(property) {
        var sortOrder = 1;

        if (property[0] === "-") {
            sortOrder = -1;
            property = property.substr(1);
        }

        return function (a,b) {
            if (sortOrder == -1){
                return b[property].localeCompare(a[property]);
            } else {
                return a[property].localeCompare(b[property]);
            }
        }
    }
    function isNumeric(n) {
        return !isNaN(parseFloat(n)) && isFinite(n);
    }
    function placesModelChanged() {
        dbgprint("placesModelChanged")
        var newPlacesArray = []
        for (var i = 0; i < placesModel.rowCount; i++) {
            var placeObj = placesModel.getRow(i)
            newPlacesArray.push({
                providerId: placeObj.providerId,
                placeIdentifier: placeObj.placeIdentifier,
                placeAlias: placeObj.placeAlias,
                timezoneID: (placeObj.timezoneID !== undefined) ? placeObj.timezoneID : -1

            })
        }
        cfg_places = JSON.stringify(newPlacesArray)
    }
    function updatenewMetnoCityOKButton() {
        dbgprint("updatenewMetnoCityOKButton")
        // buttons.standardButton(Dialog.Ok).enabled = false
        var latValid = newMetnoCityLatitudeField.acceptableInput
        var longValid = newMetnoCityLongitudeField.acceptableInput
        var altValid = newMetnoCityAltitudeField.acceptableInput
        dbgprint(newMetnoCityAlias.length + "\t" + latValid + "\t" + longValid + "\t" + altValid + "\t" + addMetnoCityIdDialog.timezoneID )
        if ((latValid && longValid && altValid) && (newMetnoCityAlias.length >0) && (addMetnoCityIdDialog.timezoneID > -1)) {
            buttons.standardButton(Dialog.Ok).enabled = true
        } else {
            buttons.standardButton(Dialog.Ok).enabled = false
        }
    }
    function updateUrl() {
        var Url=""
        var latValid = newMetnoCityLatitudeField.acceptableInput
        var longValid = newMetnoCityLongitudeField.acceptableInput
        var altValid = newMetnoCityAltitudeField.acceptableInput
        if (latValid) {
            Url += "lat=" + (Number.fromLocaleString(newMetnoCityLatitudeField.text))
        }
        if (longValid) {
            if (Url.length > 0) {
                Url += "&"
            }
            Url += "lon=" + (Number.fromLocaleString(newMetnoCityLongitudeField.text))
        }
        if (altValid) {
            if (Url.length > 0) {
                Url += "&"
            }
            Url += "altitude=" + (Number.fromLocaleString(newMetnoCityAltitudeField.text))
        }
        newMetnoUrl.text = Url
        updatenewMetnoCityOKButton()
    }

    function updatenewOmCityOKButton() {
        dbgprint("updatenewOmCityOKButton")
        // buttonsOM.standardButton(Dialog.Ok).enabled = false
        var latValid = newOmCityLatitudeField.acceptableInput
        var longValid = newOmCityLongitudeField.acceptableInput
        var altValid = newOmCityAltitudeField.acceptableInput
        dbgprint(newOmCityAlias.length + "\t" + latValid + "\t" + longValid + "\t" + altValid + "\t" + addOmCityIdDialog.timezoneID )
        if ((latValid && longValid && altValid) && (newOmCityAlias.length >0) && (addOmCityIdDialog.timezoneID > -1)) {
            buttonsOM.standardButton(Dialog.Ok).enabled = true
        } else {
            buttonsOM.standardButton(Dialog.Ok).enabled = false
        }
    }
    function updateOmUrl() {
        var Url=""
        var latValid = newOmCityLatitudeField.acceptableInput
        var longValid = newOmCityLongitudeField.acceptableInput
        var altValid = newOmCityAltitudeField.acceptableInput
        if (latValid) {
            Url += "latitude=" + (Number.fromLocaleString(newOmCityLatitudeField.text))
        }
        if (longValid) {
            if (Url.length > 0) {
                Url += "&"
            }
            Url += "longitude=" + (Number.fromLocaleString(newOmCityLongitudeField.text))
        }
        if (altValid) {
            if (Url.length > 0) {
                Url += "&"
            }
            Url += "altitude=" + (Number.fromLocaleString(newOmCityAltitudeField.text))
        }
        newOmUrl.text = Url
        updatenewOmCityOKButton()
    }

    ListModel {
        id: timezoneDataModel
    }

    ListModel {
        id: countryCodesModel
    }

    TableModel {
        id: placesModel
        TableModelColumn {
            display: "providerId"
            // title: "Source"
        }
        // TableModelColumn {
        //     display: "placeIdentifier"
        //     // title: "Place Identifier"
        // }
        TableModelColumn {
            display: "placeAlias"
            // title: "City Name"
        }
        TableModelColumn {
            display: "timezoneID"
            // title: "Action"
        }
    }

    TableModel {
        id: filteredCSVData
        TableModelColumn {
            display: "Location"
        }
        TableModelColumn {
            display: "Area"
        }
        TableModelColumn {
            display: "Latitude"
        }
        TableModelColumn {
            display: "Longitude"
        }
        TableModelColumn {
            display: "Altitude"
        }
        TableModelColumn {
            display: "Timezone"
        }
    }

    TableModel {
        id: myCSVData
        TableModelColumn {
            display: "Location"
        }
        TableModelColumn {
            display: "Area"
        }
        TableModelColumn {
            display: "Latitude"
        }
        TableModelColumn {
            display: "Longitude"
        }
        TableModelColumn {
            display: "Altitude"
        }
        TableModelColumn {
            display: "Timezone"
        }
        TableModelColumn {
            display: "timezoneId"
        }

    }

    // ConfigLocation home page
    ColumnLayout {
        id: rhsColumn
        width: parent.width
        spacing: 0

        // Item {
        //     width: 2
        //     height: 10
        // }

            HorizontalHeaderView {
                id: myhorizontalHeader
                // anchors.left: mytableView.left
                // anchors.leftMargin: 0
                // anchors.topMargin: 2
                // anchors.top: parent.top
                // anchors.right: parent.right
                // anchors.rightMargin: 2

                syncView: mytableView
                // columnSpacing: 0
                // clip: true
                model: ListModel {
                    Component.onCompleted: {
                        append({ display: i18n("Source") });
                        // append({ display: i18n("Place Identifier") });
                        append({ display: i18n("City Name") });
                        append({ display: i18n("Action") });
                        // append({ display: ("TBA") });
                    }
                }
            }

        ScrollView {
            id: placesTable
            width: parent.width
            clip: true
            Layout.preferredHeight: 190
            Layout.preferredWidth: parent.width
            Layout.columnSpan: 2

            TableView {
                id: mytableView
                anchors.fill: parent
                property var columnWidths: [14, 59, 27]
                columnWidthProvider: function (column) {
                    let aw = placesTable.width - placesTable.effectiveScrollBarWidth
                    return parseInt(aw * columnWidths[column] / 100 )

                }

                implicitHeight: 200
                implicitWidth: 600
                clip: true
                interactive: true
                rowSpacing: 1
                columnSpacing: 1
                boundsBehavior: Flickable.StopAtBounds
                model: placesModel
                alternatingRows: true

                selectionBehavior: TableView.SelectRows
                selectionModel: ItemSelectionModel {}

                delegate: myChooser

                DelegateChooser {
                    id: myChooser
                    DelegateChoice {
                        column: 0
                        delegate: Rectangle {
                            color: (row % 2) === 0 ? backgroundColor : alternateBackgroundColor
                            Text {
                                anchors.fill: parent
                                anchors.leftMargin: Kirigami.Units.smallSpacing
                                anchors.rightMargin: Kirigami.Units.smallSpacing
                                text: display
                                color: Kirigami.Theme.textColor
                                font.family: Kirigami.Theme.defaultFont.family
                                font.pixelSize: 0
                                verticalAlignment: Text.AlignVCenter
                                clip: false
                            }
                        }
                    }
                    DelegateChoice {
                        column: 1
                        delegate: Rectangle {
                            color: (row % 2) === 0 ? backgroundColor : alternateBackgroundColor
                            Text {
                                anchors.fill: parent
                                anchors.leftMargin: Kirigami.Units.smallSpacing
                                anchors.rightMargin: Kirigami.Units.smallSpacing
                                text: display
                                color: Kirigami.Theme.textColor
                                font.family: Kirigami.Theme.defaultFont.family
                                font.pixelSize: defaultFontPixelSize
                                // horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight
                                clip: false
                            }
                        }
                    }
                    // DelegateChoice {
                    //     column: 2
                    //     delegate: Rectangle {
                    //         color: (row % 2) === 0 ? backgroundColor : alternateBackgroundColor
                    //         Text {
                    //             anchors.fill: parent
                    //             anchors.leftMargin: Kirigami.Units.smallSpacing
                    //             anchors.rightMargin: Kirigami.Units.smallSpacing
                    //             id: tableLocation
                    //             text: display
                    //             color: Kirigami.Theme.textColor
                    //             font.family: Kirigami.Theme.defaultFont.family
                    //             font.pixelSize: defaultFontPixelSize
                    //             verticalAlignment: Text.AlignVCenter
                    //             elide: Text.ElideRight
                    //             clip: false
                    //         }
                    //     }
                    // }
                    DelegateChoice {
                        column: 2 // 3
                        id:  myChoice3
                        delegate: GridLayout {
                            columnSpacing: 0
                            Text {
                                id: myrowValue
                                visible: false
                                text: display
                            }
                            Button {
                                Layout.leftMargin: Kirigami.Units.smallSpacing
                                Layout.topMargin: 1
                                id:myButton1
                                icon.name: 'go-up'
                                enabled: row === 0  ? false : true
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if (row > 0) {
                                            placesModel.moveRow(row, row - 1, 1)
                                            placesModelChanged()
                                        }
                                    }
                                }
                            }
                            Button {
                                Layout.topMargin: 1
                                id:myButton2
                                icon.name: 'go-down'
                                enabled: row == (placesModel.rowCount - 1)  ? false: true
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if (row < placesModel.rowCount) {
                                            placesModel.moveRow(row, row + 1, 1)
                                            placesModelChanged()
                                        }
                                    }
                                }
                            }
                            Button {
                                Layout.topMargin: 1
                                icon.name: 'list-remove'
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        placesModel.removeRow(row, 1)
                                        placesModelChanged()
                                    }
                                }
                                enabled: (placesModel.rowCount > 1)
                            }
                            Button {
                                // Layout.rightMargin: Kirigami.Units.smallSpacing
                                Layout.topMargin: 1
                                icon.name: 'entry-edit'
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        let entry = placesModel.getRow(row)
                                        if (entry.providerId === "metno") {
                                            let url = entry.placeIdentifier
                                            newMetnoUrl.text = url
                                            var data = url.match(RegExp("([+-]?[0-9]{1,4}[.]?[0-9]{0,4})","g"))
                                            newMetnoCityLatitudeField.text = Number(data[0]).toLocaleString(Qt.locale(),"f",4)
                                            newMetnoCityLongitudeField.text = Number(data[1]).toLocaleString(Qt.locale(),"f",4)
                                            newMetnoCityAltitudeField.text = (data[2] === undefined) ? 0:data[2]
                                            dbgprint("timezone ID=" + entry.timezoneID)
                                            addMetnoCityIdDialog.timezoneID = entry.timezoneID
                                            for (var i = 0; i < timezoneDataModel.count; i++) {
                                                if (timezoneDataModel.get(i).id == Number(entry.timezoneID)) {
                                                    tzComboBox.currentIndex = i
                                                    break
                                                }
                                            }
                                            newMetnoCityAlias.text = entry.placeAlias
                                            addMetnoCityIdDialog.placeNumberID = row
                                            addMetnoCityIdDialog.open()
                                        }
                                        if (entry.providerId === "om") {
                                            let url = entry.placeIdentifier
                                            newOmUrl.text = url
                                            var data = url.match(RegExp("([+-]?[0-9]{1,4}[.]?[0-9]{0,4})","g"))
                                            newOmCityLatitudeField.text = Number(data[0]).toLocaleString(Qt.locale(),"f",4)
                                            newOmCityLongitudeField.text = Number(data[1]).toLocaleString(Qt.locale(),"f",4)
                                            newOmCityAltitudeField.text = (data[2] === undefined) ? 0:data[2]
                                            dbgprint("timezone ID=" + entry.timezoneID)
                                            addOmCityIdDialog.timezoneID = entry.timezoneID
                                            for (var i = 0; i < timezoneDataModel.count; i++) {
                                                if (timezoneDataModel.get(i).id == Number(entry.timezoneID)) {
                                                    tzComboBoxOm.currentIndex = i
                                                    break
                                                }
                                            }
                                            newOmCityAlias.text = entry.placeAlias
                                            addOmCityIdDialog.placeNumberID = row
                                            addOmCityIdDialog.open()
                                        }
                                        if (entry.providerId === "owm") {
                                            newOwmCityIdField.text = "https://openweathermap.org/city/"+entry.placeIdentifier
                                            newOwmCityAlias.text = entry.placeAlias
                                            addOwmCityIdDialog.placeNumberID = row
                                            addOwmCityIdDialog.open()

                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

        }
        Item {
            width: 2
            height: Kirigami.Units.largeSpacing
        }

        Row {
            // anchors.top: mytableView.bottom
            // anchors.topMargin: Kirigami.Units.largeSpacing * 2
            Button {
                icon.name: 'list-add'
                text: 'OM'
                width: 100
                onClicked: {
                    newOmCityAlias.text = ''
                    newOmCityLatitudeField.text = ''
                    newOmCityLongitudeField.text = ''
                    newOmCityAltitudeField.text = ''
                    newOmUrl.text = ''
                    newOmCityLatitudeField.focus = true
                    addOmCityIdDialog.placeNumberID=-1
                    addOmCityIdDialog.open()
                }
            }

        Item {
            width: Kirigami.Units.largeSpacing
            height: 2
        }

        Button {
            icon.name: 'list-add'
            text: 'OWM'
            width: 100
            onClicked: {
                addOwmCityIdDialog.placeNumberID = -1
                newOwmCityIdField.text = ''
                newOwmCityAlias.text = ''
                newOwmCityIdField.focus = true
                addOwmCityIdDialog.open()
            }
        }

            Item {
                width: Kirigami.Units.largeSpacing
                height: 2
            }

            Button {
                icon.name: 'list-add'
                text: 'Met.no'
                width: 100
                onClicked: {

                    newMetnoCityAlias.text = ''
                    newMetnoCityLatitudeField.text = ''
                    newMetnoCityLongitudeField.text = ''
                    newMetnoCityAltitudeField.text = ''
                    newMetnoUrl.text = ''
                    newMetnoCityLatitudeField.focus = true
                    addMetnoCityIdDialog.placeNumberID=-1
                    addMetnoCityIdDialog.open()
                }
            }
        }

        // Label {
        //     topPadding: 16
        //     bottomPadding: 6
        //     text: i18n("Middle-click the widget to reload manually")
        //     //font.bold: true
        //     Layout.alignment: Qt.AlignLeft
        // }
        Item {
            width: 2
            height: 24
            Layout.rowSpan: 2
        }
        Item {
            id: reloadItem
            width: parent.width

            Label {
                id: reloadLabel1
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                text: i18n("Reload interval") + ":"
                Layout.alignment: Qt.AlignLeft
                rightPadding: 6
            }
            SpinBox {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:reloadLabel1.right
                id: reloadIntervalMin
                stepSize: 10

                from: 20
                to: 120
                // suffix: i18nc("Abbreviation for minutes", "min")

            }
            Label {
                id: reloadIntervalAbbreviation
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:reloadIntervalMin.right
                text: i18nc("Abbreviation for minutes", "min")
                leftPadding: 6
            }

        }
        Item {
            id: reloadItemNote
            width: parent.width
            // anchors.top: reloadItem.bottom
            Layout.topMargin: 30
            Label {
                id: reloadIntervalNote
                // font: Kirigami.Theme.smallFont
                text: i18n("Middle-click the widget to reload manually")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:reloadIntervalAbbreviation.right
                // leftPadding: 18
                Layout.rowSpan: 3
                Layout.preferredWidth: 75
                wrapMode: Text.WordWrap
            }
        }

        CheckBox {
            id: debugLogging
            checked: false
            text: "Debug"
            Layout.alignment: Qt.AlignLeft
            visible: false
        }

    }
    Item {
        anchors.bottom: parent.bottom
        Rectangle {
            anchors.fill: parent
            // anchors.top:
        }
        Label {
            id: versionNumber
            anchors.bottom: attributionIcons.top
            anchors.bottomMargin: 2
            font: Kirigami.Theme.smallFont
            text: i18n("Plasmoid version") + ": " + plasmoid.metaData.version
            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: versionNumber

                hoverEnabled: true

                onClicked: {
                    Qt.openUrlExternally('https://github.com/tully-t/weather-widget-plus')
                }

                onEntered: {
                    versionNumber.font.underline = true
                }

                onExited: {
                    versionNumber.font.underline = false
                }
            }
        }
        Label {
            id: attributionIcons
            anchors.bottom: attribution1.top
            anchors.bottomMargin: 2
            font: Kirigami.Theme.smallFont
            text: i18n("Weather icons created by Erik Flowers")
            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: attributionIcons

                hoverEnabled: true

                onClicked: {
                    Qt.openUrlExternally('https://erikflowers.github.io/weather-icons/')
                }

                onEntered: {
                    attributionIcons.font.underline = true
                }

                onExited: {
                    attributionIcons.font.underline = false
                }
            }
        }
        Label {
            id: attribution1
            anchors.bottom: attribution2.top
            anchors.bottomMargin: 2
            font: Kirigami.Theme.smallFont
            text: i18n("Met.no forecast data provided by The Norwegian Meteorological Institute")
            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: attribution1

                hoverEnabled: true

                onClicked: {
                    Qt.openUrlExternally('https://www.met.no/en/About-us')
                }

                onEntered: {
                    attribution1.font.underline = true
                }

                onExited: {
                    attribution1.font.underline = false
                }
            }
        }
        Label {
            id: attribution2
            anchors.bottom: attribution3.top
            anchors.bottomMargin: 2
            font: Kirigami.Theme.smallFont
            text: i18n("Sunrise/sunset data provided by Sunrise - Sunset")
            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: attribution2

                hoverEnabled: true

                onClicked: {
                    Qt.openUrlExternally('https://sunrise-sunset.org/about')
                }

                onEntered: {
                    attribution2.font.underline = true
                }

                onExited: {
                    attribution2.font.underline = false
                }
            }
        }
        Label {
            id: attribution3
            anchors.bottom: attributionOm.top
            anchors.bottomMargin: 2
            font: Kirigami.Theme.smallFont
            text: i18n("OWM forecast data provided by OpenWeather")
            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: attribution3

                hoverEnabled: true

                onClicked: {
                    Qt.openUrlExternally('https://openweathermap.org/about-us')
                }

                onEntered: {
                    attribution3.font.underline = true
                }

                onExited: {
                    attribution3.font.underline = false
                }
            }
        }
        Label {
            id: attributionOm
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            font: Kirigami.Theme.smallFont
            text: i18n("OM forecast data provided by Open-Meteo")
            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: attributionOm

                hoverEnabled: true

                onClicked: {
                    Qt.openUrlExternally('https://open-meteo.com/')
                }

                onEntered: {
                    attributionOm.font.underline = true
                }

                onExited: {
                    attributionOm.font.underline = false
                }
            }
        }

    }

    // changePlaceAliasDialog
    Dialog {
        id: changePlaceAliasDialog
        title: i18n("Change City Name")
        implicitWidth: generalConfigPage.width
        implicitHeight: rhsColumn.height + 20
        background: Rectangle {
            color: Kirigami.Theme.backgroundColor
        }

        standardButtons: Dialog.Ok | Dialog.Cancel

        onAccepted: {
            placesModel.setProperty(changePlaceAliasDialog.tableIndex, 'placeAlias', newPlaceAliasField.text)
            placesModelChanged()
            changePlaceAliasDialog.close()
        }

        property int tableIndex: 0

        TextField {
            id: newPlaceAliasField
            placeholderText: i18n("Enter city name")
            width: parent.width
        }
    }

    // addOwmCityIdDialog
    Dialog {
        id: addOwmCityIdDialog
        title: i18n("Add Open Weather Map Location")
        property int placeNumberID: -1
        //width: 500
        //height: newOwmCityIdField.height * 9
        implicitWidth: generalConfigPage.width
        implicitHeight: rhsColumn.height + 20
        background: Rectangle {
            color: Kirigami.Theme.backgroundColor
        }
        popupType: Popup.Window
        modal: true
        footer: DialogButtonBox {
            id: owmButtons
            standardButtons: Dialog.Ok | Dialog.Cancel
        }

        onAccepted: {
            var url = newOwmCityIdField.text
            var match = /https?:\/\/openweathermap\.org\/city\/([0-9]+)(\/)?/.exec(url)

            var resultString = null

            if (match !== null) {
                resultString = match[1]

                dbgprint(addOwmCityIdDialog.placeNumberID)
                if (addOwmCityIdDialog.placeNumberID === -1) {
                    placesModel.appendRow({
                        providerId: 'owm',
                        placeIdentifier: resultString,
                        placeAlias: newOwmCityAlias.text,
                        timezoneID: -1
                    })
                } else {
                    placesModel.setRow(addOwmCityIdDialog.placeNumberID,{
                        providerId: 'owm',
                        placeIdentifier: resultString,
                        placeAlias: newOwmCityAlias.text,
                        timezoneID: -1
                    })
                }
                placesModelChanged()
                close()
            }
        }

        TextField {
            id: newOwmCityIdField
            placeholderText: i18n("Paste URL here")
            width: parent.width
            onTextChanged: {
                var match = /https?:\/\/openweathermap\.org\/city\/([0-9]+)(\/)?/.exec(newOwmCityIdField.text)
                if (match === null) {
                    owmButtons.standardButton(Dialog.Ok).enabled = false
                } else {
                    owmButtons.standardButton(Dialog.Ok).enabled = true
                }
            }
        }

        TextField {
            id: newOwmCityAlias
            anchors.top: newOwmCityIdField.bottom
            anchors.topMargin: 10
            placeholderText: i18n("City Name")
            width: parent.width
        }

        Label {
            id: owmInfo
            anchors.top: newOwmCityAlias.bottom
            anchors.topMargin: 10
            font.italic: true
            text: i18n("Find your city ID by searching here") + ":"
        }

        Label {
            id: owmLink
            anchors.top: owmInfo.bottom
            font.italic: true
            text: 'http://openweathermap.org/find'
        }

        MouseArea {
            cursorShape: Qt.PointingHandCursor
            anchors.fill: owmLink

            hoverEnabled: true

            onClicked: {
                Qt.openUrlExternally(owmLink.text)
            }

            onEntered: {
                owmLink.font.underline = true
            }

            onExited: {
                owmLink.font.underline = false
            }
        }

        Label {
            anchors.top: owmLink.bottom
            font.italic: true
            text: i18n("and then paste the whole URL into the corresponding field\ne.g. http://openweathermap.org/city/2946447 for Bonn, Germany")
        }

    }

    // addMetnoCityIdDialog
    Dialog {

        id: addMetnoCityIdDialog
        title: i18n("Add Met.no Map Location")

        property int timezoneID: -1
        property int placeNumberID: -1

        implicitWidth: generalConfigPage.width
        implicitHeight: rhsColumn.height + 20
        background: Rectangle {
            color: Kirigami.Theme.backgroundColor
        }
        popupType: Popup.Window
        modal: true
        footer: DialogButtonBox {
            id: buttons
            standardButtons: Dialog.Ok | Dialog.Cancel
        }


        Item {
            anchors.fill: parent
            id: metNoRowLayout
            // implicitWidth: 550
            implicitHeight: metNoRow1.height * 4
            property int labelWidth: 80
            property int textboxWidth:( metNoRowLayout.width - (3* metNoRowLayout) ) / 3
            ColumnLayout{
                id: metNoColumnLayout
                spacing: 8
                RowLayout {
                    id: metNoRow1
                    Layout.preferredWidth: metNoRowLayout.width
                    Label {
                        text: i18n("City Name") + ":"
                        Layout.alignment: Qt.AlignVCenter
                    }
                    TextField {
                        id: newMetnoCityAlias
                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredWidth: (omRowLayout.labelWidth * 3.5)
                        // placeholderText: i18n("City Name")
                        onTextChanged: {
                            updateUrl()
                        }
                    }
                    Item {
                        // spacer item
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        // Rectangle { anchors.fill: parent; color: "#ffaaaa" } // to visualize the spacer
                    }
                    // Button {
                    //     text: i18n("Search")
                    //
                    //     Layout.alignment: Qt.AlignRight
                    //     onClicked: {
                    //         addMetnoCityIdDialog.close()
                    //         searchWindow.open()
                    //     }
                    // }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Label {
                        id: newMetnoCityLatitudeLabel
                        text: i18n("Latitude") + ":"
                        Layout.preferredWidth: metNoRowLayout.labelWidth
                        horizontalAlignment: Text.AlignRight
                    }
                    TextField {
                        id: newMetnoCityLatitudeField
                        Layout.preferredWidth: metNoRowLayout.textboxWidth
                        Layout.fillWidth: true
                        validator: DoubleValidator { bottom: -90; top: 90; decimals: 4 }
                        color: newMetnoCityAltitudeLabel.color
                        onTextChanged: {
                            updateUrl()
                        }
                    }

                    Label {
                        id: newMetnoCityLongitudeLabel
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: metNoRowLayout.labelWidth
                        text: i18n("Longitude") + ":"
                    }

                    TextField {
                        id: newMetnoCityLongitudeField
                        validator: DoubleValidator { bottom: -180; top: 180; decimals: 4 }
                        Layout.fillWidth: true
                        Layout.preferredWidth:  metNoRowLayout.textboxWidth
                        color: newMetnoCityAltitudeLabel.color
                        onTextChanged: {
                            updateUrl()
                        }
                    }
                    Label {
                        id: newMetnoCityAltitudeLabel
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: metNoRowLayout.labelWidth
                        text: i18n("Altitude") + ": "
                    }

                    TextField {
                        id: newMetnoCityAltitudeField
                        Layout.fillWidth: true
                        Layout.preferredWidth:  metNoRowLayout.textboxWidth
                        validator: IntValidator { bottom: -999; top: 5000 }
                        color: newMetnoCityAltitudeLabel.color
                        onTextChanged: {
                            updateUrl()
                        }
                    }
                }
                RowLayout {
                    Layout.preferredWidth: metNoRowLayout.width
                    Label {
                        text: i18n("URL")+": "
                        Layout.alignment: Qt.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: metNoRowLayout.labelWidth
                        visible: false
                    }
                    TextField {
                        id: newMetnoUrl
                        placeholderText: ("lat=####&lon=####&altitude=####")
                        Layout.columnSpan: 5
                        Layout.fillWidth: true
                        color: newMetnoCityAltitudeLabel.color
                        visible: false

                        function updateFields() {
                            function localiseFloat(data) {
                                return Number(data).toLocaleString(Qt.locale(),"f",4)
                            }

                            var data = newMetnoUrl.text.match(RegExp("([+-]?[0-9]{1,4}[.]?[0-9]{0,4})","g"))
                            if (data === undefined)
                                return
                                if (data.length === 3) {
                                    var newlat = localiseFloat(data[0])
                                    var newlon = localiseFloat(data[1])
                                    var newalt = Number(data[2])
                                    if ((! newMetnoCityLatitudeField.acceptableInput) || (newMetnoCityLatitudeField.text.length === 0) || (newMetnoCityLatitudeField.text !== newlat)) {
                                        newMetnoCityLatitudeField.text = newlat
                                    }
                                    if ((! newMetnoCityLongitudeField.acceptableInput) || (newMetnoCityLongitudeField.text.length === 0) || (newMetnoCityLongitudeField.text !== newlon)) {
                                        newMetnoCityLongitudeField.text = newlon
                                    }
                                    if ((! newMetnoCityAltitudeField.acceptableInput) || (newMetnoCityAltitudeField.text.length === 0)  || (newMetnoCityAltitudeField.text !== data[2])) {
                                        //                             if ((newalt >= newMetnoCityAltitudeField.validator.bottom) && (newalt <= newMetnoCityAltitudeField.validator.top)) {
                                        newMetnoCityAltitudeField.text = data[2]
                                        //                             }
                                    }
                                }
                                updatenewMetnoCityOKButton()
                        }

                        onTextChanged: {
                            updateFields()
                        }

                        onEditingFinished: {
                            updateFields()
                        }
                    }
                }
                RowLayout {
                    id: tzRow
                    Layout.fillWidth: true
                    Label {
                        id: newMetnoCityTimezoneLabel
                        text: i18n("Timezone") + ":"
                        // Layout.preferredWidth: metNoRowLayout.labelWidth
                        Layout.alignment: Qt.AlignRight
                    }
                    ComboBox {
                        id: tzComboBox
                        model: timezoneDataModel
                        currentIndex: -1
                        textRole: "displayName"
                        Layout.preferredWidth: (omRowLayout.labelWidth * 3.5)
                        onCurrentIndexChanged: {
                            if (tzComboBox.currentIndex > 0) {
                                addMetnoCityIdDialog.timezoneID = timezoneDataModel.get(tzComboBox.currentIndex).id
                            }
                            updateUrl()
                        }
                    }
                }
            }
            Label {
                id: geonamesInfo
                anchors.top: metNoColumnLayout.bottom
                anchors.topMargin: 10
                font.italic: true
                text: i18n("Find your city data by searching here") + ":"
            }

            Label {
                id: geonamesLink
                anchors.top: geonamesInfo.bottom
                font.italic: true
                text: 'https://www.geonames.org/'
            }

            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: geonamesLink

                hoverEnabled: true

                onClicked: {
                    Qt.openUrlExternally(geonamesLink.text)
                }

                onEntered: {
                    geonamesLink.font.underline = true
                }

                onExited: {
                    geonamesLink.font.underline = false
                }
            }

            Label {
                id: geonamesInfo2
                anchors.top: geonamesLink.bottom
                font.italic: true
                text: i18n("and then paste the appropriate data into the corresponding fields")
            }
            Label {
                id: geonamesInfo3
                anchors.top: geonamesInfo2.bottom
                font.italic: true
                text: i18n("e.g. Latitude: 19.4284 Longitude: -99.1276 Altitude: 2240")
            }
            Label {
                id: geonamesInfo4
                anchors.top: geonamesInfo3.bottom
                font.italic: true
                text: i18n("for Mexico City, Mexico")
            }
            Label {
                id: geonamesInfo5
                anchors.top: geonamesInfo3.bottom
                anchors.left: geonamesInfo4.right
                font.italic: true
                text: i18n(" (Maximum of 4 decimal places)")
            }
            // Label {
            //     id: geonamesLink2
            //     anchors.top: geonamesInfo3.bottom
            //     anchors.left: geonamesInfo4.right
            //     font.italic: true
            //     text: i18n("Mexico City, Mexico")
            // }
            // MouseArea {
            //     cursorShape: Qt.PointingHandCursor
            //     anchors.fill: geonamesLink2
            //
            //     hoverEnabled: true
            //
            //     onClicked: {
            //         Qt.openUrlExternally('https://www.geonames.org/3530597/mexico-city.html')
            //     }
            //
            //     onEntered: {
            //         geonamesLink2.font.underline = true
            //     }
            //
            //     onExited: {
            //         geonamesLink2.font.underline = false
            //     }
            // }

        }
        onOpened: {
            updatenewMetnoCityOKButton()
            // buttons.standardButton(Dialog.Ok).enabled = false;
        }

        onAccepted: {
            var resultString = newMetnoUrl.text
            if (resultString.length === 0) {
                resultString="lat="+newMetnoCityLatitudeField.text+"&lon="+newMetnoCityLongitudeField.text+"&altitude="+newMetnoCityAltitudeField.text
            }
            if (addMetnoCityIdDialog.placeNumberID === -1) {
                placesModel.appendRow({
                    providerId: 'metno',
                    placeIdentifier: resultString,
                    placeAlias: newMetnoCityAlias.text,
                    timezoneID: addMetnoCityIdDialog.timezoneID
                })
            } else {
                placesModel.setRow(addMetnoCityIdDialog.placeNumberID,{
                    providerId: 'metno',
                    placeIdentifier: resultString,
                    placeAlias: newMetnoCityAlias.text,
                    timezoneID: addMetnoCityIdDialog.timezoneID
                })
            }
            placesModelChanged()
            close()
        }

    }

    // addOmCityIdDialog
    Dialog {

        id: addOmCityIdDialog
        title: i18n("Add Open-Meteo Map Location")

        property int timezoneID: -1
        property int placeNumberID: -1

        implicitWidth: generalConfigPage.width
        implicitHeight: rhsColumn.height + 20
        background: Rectangle {
            color: Kirigami.Theme.backgroundColor
        }
        modal: true
        popupType: Popup.Window
        footer: DialogButtonBox {
            id: buttonsOM
            standardButtons: Dialog.Ok | Dialog.Cancel
        }


        Item {
            anchors.fill: parent
            id: omRowLayout
            // implicitWidth: 550
            implicitHeight: omRow1.height * 4
            property int labelWidth: 80
            property int textboxWidth:( omRowLayout.width - (3* omRowLayout) ) / 3
            ColumnLayout{
                id: omColumnLayout
                spacing: 8
                RowLayout {
                    id: omRow1
                    Layout.preferredWidth: omRowLayout.width
                    Label {
                        text: i18n("City Name") + ":"
                        Layout.alignment: Qt.AlignVCenter
                    }
                    TextField {
                        id: newOmCityAlias
                        Layout.alignment: Qt.AlignVCenter
                        // placeholderText: i18n("City Name")
                        Layout.preferredWidth: (omRowLayout.labelWidth * 3.5)
                        onTextChanged: {
                            updateOmUrl()
                        }
                    }
                    Item {
                        // spacer item
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        // Rectangle { anchors.fill: parent; color: "#ffaaaa" } // to visualize the spacer
                    }
                    // Button {
                    //     text: i18n("Search")
                    //
                    //     Layout.alignment: Qt.AlignRight
                    //     onClicked: {
                    //         addMetnoCityIdDialog.close()
                    //         searchWindow.open()
                    //     }
                    // }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Label {
                        id: newOmCityLatitudeLabel
                        text: i18n("Latitude") + ":"
                        Layout.preferredWidth: omRowLayout.labelWidth
                        horizontalAlignment: Text.AlignRight
                    }
                    TextField {
                        id: newOmCityLatitudeField
                        Layout.preferredWidth: omRowLayout.textboxWidth
                        Layout.fillWidth: true
                        validator: DoubleValidator { bottom: -90; top: 90; decimals: 4 }
                        color: newOmCityAltitudeLabel.color
                        onTextChanged: {
                            updateOmUrl()
                        }
                    }

                    Label {
                        id: newOmCityLongitudeLabel
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: omRowLayout.labelWidth
                        text: i18n("Longitude") + ":"
                    }

                    TextField {
                        id: newOmCityLongitudeField
                        validator: DoubleValidator { bottom: -180; top: 180; decimals: 4 }
                        Layout.fillWidth: true
                        Layout.preferredWidth:  omRowLayout.textboxWidth
                        color: newOmCityAltitudeLabel.color
                        onTextChanged: {
                            updateOmUrl()
                        }
                    }
                    Label {
                        id: newOmCityAltitudeLabel
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: omRowLayout.labelWidth
                        text: i18n("Altitude") + ": "
                    }

                    TextField {
                        id: newOmCityAltitudeField
                        Layout.fillWidth: true
                        Layout.preferredWidth:  omRowLayout.textboxWidth
                        validator: IntValidator { bottom: -999; top: 5000 }
                        color: newOmCityAltitudeLabel.color
                        onTextChanged: {
                            updateOmUrl()
                        }
                    }
                }
                RowLayout {
                    Layout.preferredWidth: omRowLayout.width
                    Label {
                        text: i18n("URL")+": "
                        Layout.alignment: Qt.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                        Layout.preferredWidth: omRowLayout.labelWidth
                        visible: false
                    }
                    TextField {
                        id: newOmUrl
                        placeholderText: ("lat=####&lon=####&altitude=####")
                        Layout.columnSpan: 5
                        Layout.fillWidth: true
                        color: newOmCityAltitudeLabel.color
                        visible: false

                        function updateFields() {
                            function localiseFloat(data) {
                                return Number(data).toLocaleString(Qt.locale(),"f",4)
                            }

                            var data = newOmUrl.text.match(RegExp("([+-]?[0-9]{1,4}[.]?[0-9]{0,4})","g"))
                            if (data === undefined)
                                return
                                if (data.length === 3) {
                                    var newlat = localiseFloat(data[0])
                                    var newlon = localiseFloat(data[1])
                                    var newalt = Number(data[2])
                                    if ((! newOmCityLatitudeField.acceptableInput) || (newOmCityLatitudeField.text.length === 0) || (newOmCityLatitudeField.text !== newlat)) {
                                        newOmCityLatitudeField.text = newlat
                                    }
                                    if ((! newOmCityLongitudeField.acceptableInput) || (newOmCityLongitudeField.text.length === 0) || (newOmCityLongitudeField.text !== newlon)) {
                                        newOmCityLongitudeField.text = newlon
                                    }
                                    if ((! newOmCityAltitudeField.acceptableInput) || (newOmCityAltitudeField.text.length === 0)  || (newOmCityAltitudeField.text !== data[2])) {
                                        //                             if ((newalt >= newOmCityAltitudeField.validator.bottom) && (newalt <= newOmCityAltitudeField.validator.top)) {
                                        newOmCityAltitudeField.text = data[2]
                                        //                             }
                                    }
                                }
                                updatenewOmCityOKButton()
                        }

                        onTextChanged: {
                            updateFields()
                        }

                        onEditingFinished: {
                            updateFields()
                        }
                    }
                }
                RowLayout {
                    id: tzRowOm
                    // Layout.fillWidth: true
                    Layout.preferredWidth: omRowLayout.width
                    Label {
                        id: newOmCityTimezoneLabel
                        text: i18n("Timezone") + ":"
                        // Layout.preferredWidth: omRowLayout.labelWidth
                        // horizontalAlignment: Text.AlignRight
                        // Layout.rightMargin: 2
                        Layout.alignment: Qt.AlignRight
                    }
                    ComboBox {
                        id: tzComboBoxOm
                        model: timezoneDataModel
                        currentIndex: -1
                        textRole: "displayName"
                        Layout.preferredWidth: (omRowLayout.labelWidth * 3.5)
                        // Layout.alignment: Qt.AlignVCenter
                        onCurrentIndexChanged: {
                            if (tzComboBoxOm.currentIndex > 0) {
                                addOmCityIdDialog.timezoneID = timezoneDataModel.get(tzComboBoxOm.currentIndex).id
                            }
                            updateOmUrl()
                        }
                    }
                    Item {
                        // spacer item
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        // Rectangle { anchors.fill: parent; color: "#ffaaaa" } // to visualize the spacer
                    }
                }
                // RowLayout {
                //     id: metNoRow1
                //     Layout.preferredWidth: metNoRowLayout.width
                //     Label {
                //         text: i18n("City Name") + ":"
                //         Layout.alignment: Qt.AlignVCenter
                //     }
                //     TextField {
                //         id: newMetnoCityAlias
                //         Layout.alignment: Qt.AlignVCenter
                //         // placeholderText: i18n("City Name")
                //         onTextChanged: {
                //             updateUrl()
                //         }
                //     }
            }
            Label {
                id: geonamesInfoOm
                anchors.top: omColumnLayout.bottom
                anchors.topMargin: 10
                font.italic: true
                text: i18n("Find your city data by searching here") + ":"
            }

            Label {
                id: geonamesLinkOm
                anchors.top: geonamesInfoOm.bottom
                font.italic: true
                text: 'https://www.geonames.org/'
            }

            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: geonamesLinkOm

                hoverEnabled: true

                onClicked: {
                    Qt.openUrlExternally(geonamesLinkOm.text)
                }

                onEntered: {
                    geonamesLinkOm.font.underline = true
                }

                onExited: {
                    geonamesLinkOm.font.underline = false
                }
            }

            Label {
                id: geonamesInfo2Om
                anchors.top: geonamesLinkOm.bottom
                font.italic: true
                text: i18n("and then paste the appropriate data into the corresponding fields")
            }
            Label {
                id: geonamesInfo3Om
                anchors.top: geonamesInfo2Om.bottom
                font.italic: true
                text: i18n("e.g. Latitude: 19.4284 Longitude: -99.1276 Altitude: 2240")
            }
            Label {
                id: geonamesInfo4Om
                anchors.top: geonamesInfo3Om.bottom
                font.italic: true
                text: i18n("for Mexico City, Mexico")
            }
            Label {
                id: geonamesInfo5Om
                anchors.top: geonamesInfo3Om.bottom
                anchors.left: geonamesInfo4Om.right
                font.italic: true
                text: i18n(" (Maximum of 4 decimal places)")
            }
            // Label {
            //     id: geonamesLinkOm2
            //     anchors.top: geonamesInfo3Om.bottom
            //     anchors.left: geonamesInfo4Om.right
            //     font.italic: true
            //     text: i18n("Mexico City, Mexico")
            // }
            // MouseArea {
            //     cursorShape: Qt.PointingHandCursor
            //     anchors.fill: geonamesLinkOm2
            //
            //     hoverEnabled: true
            //
            //     onClicked: {
            //         Qt.openUrlExternally('https://www.geonames.org/3530597/mexico-city.html')
            //     }
            //
            //     onEntered: {
            //         geonamesLinkOm2.font.underline = true
            //     }
            //
            //     onExited: {
            //         geonamesLinkOm2.font.underline = false
            //     }
            // }

        }
        onOpened: {
            updatenewOmCityOKButton()
            // buttons.standardButton(Dialog.Ok).enabled = false;
        }

        onAccepted: {
            var resultString = newOmUrl.text
            if (resultString.length === 0) {
                resultString="latitude="+newOmCityLatitudeField.text+"&longitude="+newOmCityLongitudeField.text+"&altitude="+newOmCityAltitudeField.text
            }
            if (addOmCityIdDialog.placeNumberID === -1) {
                placesModel.appendRow({
                    providerId: 'om',
                    placeIdentifier: resultString,
                    placeAlias: newOmCityAlias.text,
                    timezoneID: addOmCityIdDialog.timezoneID
                })
            } else {
                placesModel.setRow(addOmCityIdDialog.placeNumberID,{
                    providerId: 'om',
                    placeIdentifier: resultString,
                    placeAlias: newOmCityAlias.text,
                    timezoneID: addOmCityIdDialog.timezoneID
                })
            }
            placesModelChanged()
            close()
        }

    }

    // searchWindow
    // Dialog {
    //     title: i18n("Location Search")
    //     id: searchWindow
    //     z: 1
    //     implicitWidth: generalConfigPage.width
    //     implicitHeight: rhsColumn.height + 20
    //     background: Rectangle {
    //         color: Kirigami.Theme.backgroundColor
    //     }
    //     footer: DialogButtonBox {
    //         id: searchWindowButtons
    //         standardButtons: Dialog.Ok | Dialog.Cancel
    //     }
    //
    //     HorizontalHeaderView {
    //         id: mysearchhorizontalHeader
    //         syncView: searchtableView
    //         clip: true
    //         model: ListModel {
    //             Component.onCompleted: {
    //                 append({ display: i18n("Location")  });
    //                 append({ display: i18n("Area") });
    //                 append({ display: i18n("Latitude") });
    //                 append({ display: i18n("Longitude") });
    //                 append({ display: i18n("Alt") });
    //                 append({ display: i18n("Timezone") });
    //                 // append({ display: ("TBA") });
    //             }
    //         }
    //     }
    //
    //     ScrollView {
    //         id: placesTable1
    //         width: parent.width
    //         clip: true
    //         Layout.preferredHeight: 190
    //         Layout.preferredWidth: parent.width
    //         Layout.maximumHeight: 190
    //
    //         Layout.columnSpan: 2
    //         // anchors.fill: parent
    //         anchors.bottom: row2.top
    //         anchors.right: parent.right
    //         anchors.left: parent.left
    //         anchors.top: parent.top
    //         // anchors.bottomMargin: 10
    //         anchors.topMargin: mysearchhorizontalHeader.height + 2
    //
    //         TableView {
    //             id: searchtableView
    //             anchors.fill: parent
    //             anchors.bottomMargin: 10 + placesTable1.effectiveScrollBarHeight
    //             anchors.rightMargin: 10 + placesTable1.effectiveScrollBarWidth
    //             // verticalScrollBarPolicy: Qt.ScrollBarAsNeeded
    //             // highlightOnFocus: true
    //             property var columnWidths: [30, 15, 15, 12, 12, 30, -1]
    //             property int selectedRow: -1
    //             columnWidthProvider: function (column) {
    //                 let aw = placesTable1.width - placesTable1.effectiveScrollBarWidth
    //                 return parseInt(aw * columnWidths[column] / 100 )
    //
    //             }
    //
    //             model: filteredCSVData
    //             clip: true
    //             interactive: true
    //             rowSpacing: 1
    //             columnSpacing: 1
    //
    //             boundsBehavior: Flickable.StopAtBounds
    //             implicitHeight: 200
    //             implicitWidth: 600
    //             Layout.maximumHeight: 200
    //
    //
    //             selectionBehavior: TableView.SelectRows
    //             selectionModel: ItemSelectionModel { }
    //
    //             delegate: searchtableChooser
    //
    //             DelegateChooser {
    //                 id: searchtableChooser
    //                 DelegateChoice {
    //                     column: 0
    //
    //                     delegate: Rectangle {
    //                         required property bool selected
    //                         required property bool current
    //                         border.width: current ? 2 : 0
    //                         implicitWidth: searchtableView.width * 0.3
    //                         implicitHeight: defaultFontPixelSize + 4
    //                             color: (row === searchtableView.selectedRow) ? highlightColor : (row % 2) === 0 ? backgroundColor : alternateBackgroundColor
    //                         Text {
    //                             text: display
    //                             color: Kirigami.Theme.textColor
    //                             font.family: Kirigami.Theme.defaultFont.family
    //                             font.pixelSize: defaultFontPixelSize
    //                             anchors.verticalCenter: parent.verticalCenter
    //                             anchors.fill: parent
    //                         }
    //                         MouseArea {
    //                             anchors.fill: parent
    //                             onClicked: {
    //                                 searchtableView.selectedRow = row
    //                             }
    //                             onDoubleClicked: {
    //                                 saveSearchedData.rowNumber = row
    //                                 saveSearchedData.visible = true
    //                                 saveSearchedData.open()
    //                             }
    //                         }
    //                     }
    //                 }
    //                 DelegateChoice {
    //                     column: 1
    //                     delegate: Rectangle {
    //                         implicitHeight: defaultFontPixelSize + 4
    //                         // implicitWidth: searchtableView.width * 0.1
    //                         color: (row === searchtableView.selectedRow) ? highlightColor : (row % 2) === 0 ? backgroundColor : alternateBackgroundColor
    //                         Text {
    //                             text: display
    //                             color: Kirigami.Theme.textColor
    //                             font.family: Kirigami.Theme.defaultFont.family
    //                             font.pixelSize: defaultFontPixelSize
    //                             anchors.verticalCenter: parent.verticalCenter
    //                         }
    //                         MouseArea {
    //                             anchors.fill: parent
    //                             onClicked: {
    //                                 searchtableView.selectedRow = row
    //                             }
    //                             onDoubleClicked: {
    //                                 saveSearchedData.rowNumber = row
    //                                 saveSearchedData.visible = true
    //                                 saveSearchedData.open()
    //                             }
    //                         }
    //                     }
    //                 }
    //                 DelegateChoice {
    //                     column: 2
    //                     delegate: Rectangle {
    //                         required property bool selected
    //                         required property bool current
    //                         implicitHeight: defaultFontPixelSize + 4
    //                         color: (row === searchtableView.selectedRow) ? highlightColor : (row % 2) === 0 ? backgroundColor : alternateBackgroundColor
    //                         Text {
    //                             text: display
    //                             color: Kirigami.Theme.textColor
    //                             font.family: Kirigami.Theme.defaultFont.family
    //                             font.pixelSize: defaultFontPixelSize
    //                             anchors.verticalCenter: parent.verticalCenter
    //                         }
    //                         MouseArea {
    //                             anchors.fill: parent
    //                             onClicked: {
    //                                 searchtableView.selectedRow = row
    //                             }
    //                             onDoubleClicked: {
    //                                 saveSearchedData.rowNumber = row
    //                                 saveSearchedData.visible = true
    //                                 saveSearchedData.open()
    //                             }
    //                         }
    //                     }
    //                 }
    //                 DelegateChoice {
    //                     column: 3
    //                     delegate: Rectangle {
    //                         implicitHeight: defaultFontPixelSize + 4
    //                         color: (row === searchtableView.selectedRow) ? highlightColor : (row % 2) === 0 ? backgroundColor : alternateBackgroundColor
    //                         Text {
    //                             text: display
    //                             color: Kirigami.Theme.textColor
    //                             font.family: Kirigami.Theme.defaultFont.family
    //                             font.pixelSize: defaultFontPixelSize
    //                             anchors.verticalCenter: parent.verticalCenter
    //                         }
    //                         MouseArea {
    //                             anchors.fill: parent
    //                             onClicked: {
    //                                 searchtableView.selectedRow = row
    //                             }
    //                             onDoubleClicked: {
    //                                 saveSearchedData.rowNumber = row
    //                                 saveSearchedData.visible = true
    //                                 saveSearchedData.open()
    //                             }
    //                         }
    //                     }
    //                 }
    //                 DelegateChoice {
    //                     column: 4
    //                     delegate: Rectangle {
    //                         implicitHeight: defaultFontPixelSize + 4
    //                         color: (row === searchtableView.selectedRow) ? highlightColor : (row % 2) === 0 ? backgroundColor : alternateBackgroundColor
    //                         Text {
    //                             text: display
    //                             color: Kirigami.Theme.textColor
    //                             font.family: Kirigami.Theme.defaultFont.family
    //                             font.pixelSize: defaultFontPixelSize
    //                             anchors.verticalCenter: parent.verticalCenter
    //                         }
    //                         MouseArea {
    //                             anchors.fill: parent
    //                             onClicked: {
    //                                 searchtableView.selectedRow = row
    //                             }
    //                             onDoubleClicked: {
    //                                 saveSearchedData.rowNumber = row
    //                                 saveSearchedData.visible = true
    //                                 saveSearchedData.open()
    //                             }
    //                         }
    //                     }
    //                 }
    //                 DelegateChoice {
    //                     column: 5
    //                     delegate: Rectangle {
    //                         height: defaultFontPixelSize + 4
    //                         color: (row === searchtableView.selectedRow) ? highlightColor : (row % 2) === 0 ? backgroundColor : alternateBackgroundColor
    //                         Text {
    //                             text: display
    //                             color: Kirigami.Theme.textColor
    //                             font.family: Kirigami.Theme.defaultFont.family
    //                             font.pixelSize: defaultFontPixelSize
    //                             anchors.verticalCenter: parent.verticalCenter
    //                         }
    //                         MouseArea {
    //                             anchors.fill: parent
    //                             onClicked: {
    //                                 searchtableView.selectedRow = row
    //                             }
    //                             onDoubleClicked: {
    //                                 saveSearchedData.rowNumber = row
    //                                 saveSearchedData.visible = true
    //                                 saveSearchedData.open()
    //                             }
    //                         }
    //                     }
    //                 }
    //             }
    //         }
    //     }
    //     standardButtons: Dialog.Ok | Dialog.Cancel
    //     onAccepted: {
    //         if (searchtableView.selectedRow > -1) {
    //             saveSearchedData.rowNumber = searchtableView.selectedRow
    //             saveSearchedData.visible = true
    //             saveSearchedData.open()
    //         }
    //     }
    //     onOpened: {
    //         let locale = Qt.locale().name.substr(3,2)
    //         dbgprint(locale)
    //         let userCountry = Helper.getDisplayName(locale)
    //         let tmpDB = Helper.getDisplayNames()
    //         for (var i=0; i < tmpDB.length - 1 ; i++) {
    //             countryCodesModel.append({ id: tmpDB[i] })
    //             if (tmpDB[i] === userCountry) {
    //                 countryList.currentIndex = i
    //             }
    //         }
    //         dbgprint(Helper.getshortCode(userCountry))
    //     }
    //     Item {
    //         id: row1
    //         anchors.bottom: parent.bottom
    //         height: 20
    //         width: parent.width
    //         Label {
    //             id:locationDataCredit
    //             text: i18n("Search data provided by Geonames.org")
    //             anchors.horizontalCenter: parent.horizontalCenter
    //         }
    //     }
    //     MouseArea {
    //         cursorShape: Qt.PointingHandCursor
    //         anchors.fill: row1
    //
    //         hoverEnabled: true
    //
    //         onClicked: {
    //             Qt.openUrlExternally("https://www.geonames.org/")
    //         }
    //
    //         onEntered: {
    //             locationDataCredit.font.underline = true
    //         }
    //
    //         onExited: {
    //             locationDataCredit.font.underline = false
    //         }
    //     }
    //
    //     Item {
    //         id: row2
    //         x: 0
    //         y: 0
    //         height: 54
    //         anchors.left: parent.left
    //         anchors.leftMargin: 0
    //         anchors.right: parent.right
    //         anchors.rightMargin: 0
    //         anchors.bottom: row1.top
    //         anchors.bottomMargin: 0
    //         Label {
    //             id: countryLabel
    //             text: i18n("Country") + ":"
    //             anchors.left: parent.left
    //             anchors.leftMargin: 10
    //             anchors.verticalCenter: parent.verticalCenter
    //         }
    //
    //         ComboBox {
    //             id: countryList
    //             anchors.left: countryLabel.right
    //             anchors.leftMargin: 20
    //             anchors.verticalCenterOffset: 0
    //             anchors.verticalCenter: parent.verticalCenter
    //             model: countryCodesModel
    //             width: 200
    //             editable: false
    //             onCurrentIndexChanged: {
    //                 if (countryList.currentIndex > 0) {
    //                     // dbgprint("Loading Database: "+countryList.textAt(countryList.currentIndex))
    //                     Helper.loadCSVDatabase(countryList.textAt(countryList.currentIndex))
    //                     // Helper.loadCSVDatabase("Malta")
    //                 }
    //                 dbgprint(myCSVData.length)
    //             }
    //         }
    //         Label {
    //             id: locationLabel
    //             anchors.right: locationEdit.left
    //             anchors.rightMargin: 10
    //             anchors.verticalCenter: parent.verticalCenter
    //             text: i18n("Filter") + ":"
    //         }
    //         TextField {
    //             id: locationEdit
    //             anchors.right: parent.right
    //             anchors.verticalCenter: parent.verticalCenter
    //             verticalAlignment: Text.AlignVCenter
    //             width: 160
    //             height: 31
    //             text: ""
    //             focus: true
    //             font.capitalization: Font.Capitalize
    //             selectByMouse: true
    //             clip: false
    //             Keys.onReturnPressed: {
    //                 event.accepted = true
    //             }
    //             onTextChanged: {
    //                 Helper.updateListView(locationEdit.text)
    //             }
    //         }
    //     }
    // }



    // Loader {
    //     id: saveSearchedData
    //     property int rowNumber
    //     function open() {
    //         if (item) {
    //             item.open();
    //         } else {
    //             active = true;
    //         }
    //         item.visible = true;
    //     }
    //
    //     active: false
    //
    //     sourceComponent: Dialog {
    //         title: i18n("Confirmation")
    //         z:2
    //         standardButtons: Dialog.Yes | Dialog.No
    //         visible: true
    //         Text {
    //             anchors.fill: parent
    //             text: i18n("Do you want to select") + " \"" + filteredCSVData.getRow(saveSearchedData.rowNumber).Location + "\" ?"
    //
    //         }
    //         onAccepted: {
    //             let data = filteredCSVData.getRow(rowNumber)
    //             newMetnoCityLatitudeField.text = data["Latitude"]
    //             newMetnoCityLongitudeField.text = data["Longitude"]
    //             newMetnoCityAltitudeField.text = data["Altitude"]
    //             newMetnoUrl.text="lat="+data["Latitude"]+"&lon="+data["Longitude"]+"&altitude="+data["Altitude"]
    //             let loc = data["Location"]+", "+Helper.getshortCode(countryList.textAt(countryList.currentIndex))
    //             newMetnoCityAlias.text = loc
    //             addMetnoCityIdDialog.timezoneID = data["timezoneId"]
    //             for (var i=0; i < timezoneDataModel.count; i++) {
    //                 if (timezoneDataModel.get(i).id == Number(data["timezoneId"])) {
    //                     tzComboBox.currentIndex = i
    //                     break
    //                 }
    //             }
    //             searchWindow.close()
    //             addMetnoCityIdDialog.open()
    //             updatenewMetnoCityOKButton()
    //         }
    //         onRejected: {
    //             visible = false
    //             searchWindow.visible = true
    //         }
    //     }
    // }

}
