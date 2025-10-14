import QtQuick
import "../../code/model-utils.js" as ModelUtils
import "../../code/data-loader.js" as DataLoader
import "../../code/unit-utils.js" as UnitUtils

Item {
    id: openMeteo



    property int hourSpanOm: main.hourSpanOm
    property var locale: Qt.locale()
    property string providerId: 'om'
    // property string creditLink: 'https://open-meteo.com/'
    property string urlPrefixOm: 'https://api.open-meteo.com/v1/forecast?'
    property string urlSuffixOm: '&daily=sunrise,sunset&hourly=temperature_2m,pressure_msl,precipitation,wind_speed_10m,wind_direction_10m,weather_code&current=temperature_2m,weather_code,pressure_msl,cloud_cover,relative_humidity_2m,wind_speed_10m,wind_direction_10m&timezone=GMT&forecast_days=8&wind_speed_unit=ms'

    property bool weatherDataFlag: false
    property bool sunRiseSetFlag: false

    // onHourSpanOmChanged: {
    //     dbgprint2('Hour Span changed')
    //     loadingData.failedAttemptCount = 0
    //     main.loadDataFromInternet()
    // }

    function getCreditLabel(placeIdentifier) {
        return i18n("Forecast data provided by Open-Meteo")
    }

    function getCreditLink(placeIdentifier) {
        var weatherURLTest = urlPrefixOm + placeIdentifier + urlSuffixOm
        var creditLink = weatherURLTest
        return creditLink
    }

    function parseDate(dateString) {
        return new Date(dateString + '.000Z')
    }

    function loadDataFromInternet(successCallback, failureCallback, locationObject) {

        dbgprint2("loadDataFromInternet: " + currentPlace.alias)

        var placeIdentifier = locationObject.placeIdentifier
        weatherDataFlag = false
        sunRiseSetFlag = false

        var weatherURL = urlPrefixOm + placeIdentifier + urlSuffixOm
        if (! useOnlineWeatherData) {
            weatherURL = Qt.resolvedUrl('../../code/weather/weather.json')
        }
        dbgprint("Downloading Weather Data from: " + weatherURL)
        var xhr1 = DataLoader.fetchJsonFromInternet(weatherURL, successWeather, failureCallback)
        return [xhr1]

        function successWeather(jsonString) {
            var readingsArray = JSON.parse(jsonString)
            successSRAS(readingsArray)
            updatecurrentWeather(readingsArray)
            updateNextDaysModel(readingsArray)
            buildMetogramData(readingsArray)
            refreshTooltipSubText()
            loadCompleted()
        }

        function successSRAS(readingsArray) {
            dbgprint2("successSRAS")

            dbgprint("Sunrise:" + JSON.stringify(readingsArray.daily.sunrise[0] + "+00:00"))
            let offset = 0
            switch (main.timezoneType) {
                case (0):
                    offset = dataSource.data["Local"]["Offset"]
                    break;
                case (1):
                    offset = 0
                    break;
                case (2):
                    offset = currentPlace.timezoneOffset // 0
                    break;
            }

            if ((readingsArray.daily !== undefined)) {


                currentWeatherModel.sunRise = new Date(readingsArray.daily.sunrise[0] + "+00:00")
                currentWeatherModel.sunSet = new Date(readingsArray.daily.sunset[0] + "+00:00")

                currentWeatherModel.sunRiseTime = UnitUtils.convertDate(currentWeatherModel.sunRise, main.timezoneType, offset).toTimeString()
                currentWeatherModel.sunSetTime = UnitUtils.convertDate(currentWeatherModel.sunSet, main.timezoneType, offset).toTimeString()
            }

            sunRiseSetFlag = true
        }

        function parseISOString(s) {
            var b = s.split(/\D+/)
            return new Date(Date.UTC(b[0], --b[1], b[2], b[3], b[4], b[5], b[6]))
        }

        function updatecurrentWeather(readingsArray) {
            dbgprint2("Build Current Weather")
            // let offset = 0
            // switch (main.timezoneType) {
            //     case (0):
            //         offset = dataSource.data["Local"]["Offset"]
            //         break;
            //     case (1):
            //         offset = 0
            //         break;
            //     case (2):
            //         offset = currentPlace.timezoneOffset // * 2
            //         break;
            // }

            var currentWeather = readingsArray.current
            var futureWeather = readingsArray.hourly
            var nfCurrentTime = UnitUtils.convertDate(new Date(currentWeather.time), 2, currentPlace.timezoneOffset)
            var nfCurrentTime2 = UnitUtils.convertDate(new Date(readingsArray.current.time), 2, currentPlace.timezoneOffset * 2)
            var nfCurrentTimeString = UnitUtils.convertDate(new Date(currentWeather.time), 2, currentPlace.timezoneOffset).toTimeString()
            var nfCurrentTimeGMT = new Date(readingsArray.current.time)
            var nfCurrentTimeRAW = readingsArray.current.time
            var nfIndex = nfCurrentTimeGMT.getHours()
            // var futureWeatherTemp = readingsArray.hourly.temperature_2m
            // var futureWeatherCond = readingsArray.hourly.weather_code
            currentWeatherModel.iconName = currentWeather["weather_code"] + 1
            currentWeatherModel.windDirection = currentWeather["wind_direction_10m"]
            currentWeatherModel.windSpeedMps = currentWeather["wind_speed_10m"]
            currentWeatherModel.pressureHpa = currentWeather["pressure_msl"]
            currentWeatherModel.humidity = currentWeather["relative_humidity_2m"]
            currentWeatherModel.cloudiness = currentWeather["cloud_cover"]
            currentWeatherModel.temperature = currentWeather["temperature_2m"]
            currentWeatherModel.nearFutureWeather.temperature = futureWeather.temperature_2m[nfIndex + 1]
            currentWeatherModel.nearFutureWeather.iconName = futureWeather.weather_code[nfIndex + 1] + 1
            // future weather index: 1 / 0 / Math.abs(currentPlace.timezoneOffset / 3600)
            // currentPlace.timezoneOffset = currentPlace.timezoneOffset
            // currentPlace.timezoneOffset
            // currentPlace.timezoneOffset
            // readingsArray.utc_offset_seconds
            // currentWeatherModel.nearFutureWeather.temperature = futureWeatherTemp.data.instant.details["1"]
            // currentWeatherModel.nearFutureWeather.iconName = futureWeatherCond.data.instant.details["1"]
            // main.timezoneType, offset / 2,currentPlace.timezoneOffset

            // let sunRise = UnitUtils.convertDate(currentWeatherModel.sunRise,2,currentPlace.timezoneOffset)
            // let sunSet = UnitUtils.convertDate(currentWeatherModel.sunSet,2,currentPlace.timezoneOffset)
            // let updated = UnitUtils.convertDate(new Date(readingsArray.current.time) , 2 , currentPlace.timezoneOffset)

            // let sunRise = UnitUtils.convertDate(new Date(readingsArray.daily.sunrise[0]), 2, currentPlace.timezoneOffset)
            // //new Date(readingsArray.daily.sunrise[0])// currentWeatherModel.sunRise
            // let sunSet = UnitUtils.convertDate(new Date(readingsArray.daily.sunset[0]), 2, currentPlace.timezoneOffset)
            // //new Date(readingsArray.daily.sunset[0])// currentWeatherModel.sunSet

            // var currentSunrise = UnitUtils.convertDate(new Date(readingsArray.daily.sunrise[0] + ":00Z"), 2, currentPlace.timezoneOffset)
            // var currentSunset = UnitUtils.convertDate(new Date(readingsArray.daily.sunset[0] + ":00Z"), 2, currentPlace.timezoneOffset)
            // Date.parse(currentSunset)

            // let sunRise = currentWeatherModel.sunRiseTime
            // let sunSet = currentWeatherModel.sunSetTime
            // let sunRise = new Date(readingsArray.daily.sunrise[0])
            // let sunSet = new Date(readingsArray.daily.sunset[0])
            // let sunRise = readingsArray.daily.sunrise[0]
            // let sunSet = readingsArray.daily.sunset[0]
            // let updated = nfCurrentTimeString


            // var ss = Date.parse(sunRise) / 1000
            // var sr = Date.parse(sunSet) / 1000
            // let lt = Date.parse(updated) / 1000
            // while (lt > (sr + 86400)) {
            //     // dbgprint("+")
            //     sr = sr + 86400
            //     ss = ss + 86400
            // }
            // currentWeatherModel.isDay =  ((lt >= sr ) && (lt <= ss)) ? 0 : 1

            // dbgprint("Updated=" + readingsArray.hourly.time[0] + "\t" + currentWeatherModel.sunRise + "\t" + currentWeatherModel.sunSet)
            // dbgprint("Updated=" + updated/1000 + "\t" + sunRise/1000 + "\t" + sunSet/1000)
            // dbgprint("Updated=" + updated/1000 + "\t" + (updated > sunRise) + "\t" + (updated < sunSet))
            let sunRise = new Date(readingsArray.daily.sunrise[0])
            let sunSet = new Date(readingsArray.daily.sunset[0])
            let updated = nfCurrentTimeGMT
            currentWeatherModel.isDay = ((updated > sunRise) && (updated < sunSet)) ? 0 : 1

            dbgprint(JSON.stringify(currentWeatherModel))
        }

        function createDate(t) {
            let arr = t.split(":")
            return Date.parse(new Date(1970, 1, 1, arr[0], arr[1], 0))/1000
        }

        function updateNextDaysModel(readingsArray) {
            dbgprint2("updateNextDaysModel")
            nextDaysModel.clear()

            function blankObject() {
                const myblankObject = {}
                for(let f = 0; f < 4; f++) {
                    myblankObject["temperature" + f] = -999
                    myblankObject["iconName" + f] = ""
                    myblankObject['hidden' + f] = true
                }
                return myblankObject
            }

            let offset = 0
            switch (main.timezoneType) {
                case (0):
                    offset = dataSource.data["Local"]["Offset"]
                    break;
                case (1):
                    offset = 0
                    break;
                case (2):
                    offset = currentPlace.timezoneOffset
                    break;
            }

            var localOffset = Math.abs(currentPlace.timezoneOffset / 3600)
            // dbgprint2("localOffset:" + localOffset)
            let wd = readingsArray.hourly
            let wdPtr = Math.round(localOffset) //Math.abs(currentPlace.timezoneOffset / 3600) // 0 | 3 | 23
            // Math.abs(currentPlace.timezoneOffset / 3600)
            // let currentPlace.timezoneOffset = readingsArray.utc_offset_seconds
            // let omPtr = 8
            var localTime =  UnitUtils.convertDate(new Date(wd.time[wdPtr] + ":00Z"), 2, currentPlace.timezoneOffset)
            var displayTime = UnitUtils.convertDate(new Date(wd.time[wdPtr] + ":00Z"), main.timezoneType, offset)
            while ((wdPtr < wd.time.length) && ((displayTime.getHours() - 3) % 6 ) != 0) {

                wdPtr++
                //omPtr++
                displayTime = UnitUtils.convertDate(new Date(wd.time[wdPtr]), main.timezoneType, offset)
            }
            let x = 0
            let y = 0
            let nextDaysData = blankObject()
            let airTemp = -999

            let srasPtr = parseInt(wdPtr / 24)
            var sunrise1 = UnitUtils.convertDate(new Date(readingsArray.daily.sunrise[srasPtr] + ":00Z"), 2, currentPlace.timezoneOffset)
            // new Date(readingsArray.daily.sunrise[srasPtr] + ":00Z")
            // // UnitUtils.convertDate(currentWeatherModel.sunRise,2,currentPlace.timezoneOffset)
            var sunset1 = UnitUtils.convertDate(new Date(readingsArray.daily.sunset[srasPtr] + ":00Z"), 2, currentPlace.timezoneOffset)
            // new Date(readingsArray.daily.sunset[srasPtr] + ":00Z")
            // UnitUtils.convertDate(currentWeatherModel.sunSet,2,currentPlace.timezoneOffset)
            // var targetTime = new Date(wd.time[wdPtr])
            dbgprint("**********************")
            dbgprint(sunrise1 + "\t" + sunset1)
            var ss = Date.parse(sunset1) / 1000
            var sr = Date.parse(sunrise1) / 1000

            while (wdPtr < wd.time.length) {
                localTime = UnitUtils.convertDate(new Date(wd.time[wdPtr] + ":00Z"), 2, currentPlace.timezoneOffset)
                displayTime = UnitUtils.convertDate(new Date(wd.time[wdPtr] + ":00Z"), main.timezoneType, offset)
                // displayTime = UnitUtils.convertDate(new Date(wd.time[wdPtr]), main.timezoneType, offset)
                let lt = Date.parse(localTime) / 1000
                let dt = Date.parse(displayTime) / 1000

                while (lt > (sr + 86400)) {
                    dbgprint("+")
                    sr = sr + 86400
                    ss = ss + 86400
                }
                if (displayTime.getHours() % 6 === 3) {
                    let isDayTime =  ((lt >= sr ) && (lt <= ss)) ? 0 : 1
                    // let isDayTime =  ((lt >= sr ) && (lt <= ss)) ? 0 : 1
                    y = Math.trunc(displayTime.getHours() / 6,0)
                    // dbgprint("omPtr:" + omPtr + "API Time:" + wd.time[omPtr])
                    dbgprint("TZOffset:" + currentPlace.timezoneOffset)
                    dbgprint("displayTimeOffset:" + offset)
                    dbgprint("wdPtr:" + wdPtr + "\t" + wd.time[wdPtr] + "\t x = " + x + "\t y = " + y)
                    dbgprint(isDayTime + "\t\t" + displayTime + "\t" + localTime+ "\t" + new Date(sr * 1000) + "\t" + new Date(ss * 1000) )
                    nextDaysData['dayTitle'] = composeNextDayTitle(displayTime)
                    nextDaysData['temperature' + y] = wd.temperature_2m[wdPtr]
                    // wd[wdPtr].data.instant.details["air_temperature"]
                    nextDaysData['hidden' + y] = false
                    let obj = wd.weather_code[wdPtr] + 1
                    dbgprint("weatherCode: " + obj)
                    dbgprint("ND Temperature: " + wd.temperature_2m[wdPtr])
                    nextDaysData['iconName' + y] = obj.toString()
                    nextDaysData['partOfDay' + y] = isDayTime
                    if (y == 3) {
                        nextDaysModel.append(nextDaysData)
                        nextDaysData=blankObject()
                        x++
                    }

                }
                wdPtr++
                //omPtr++
            }

            if ((y < 3) && (x < 7)) {
                nextDaysModel.append(nextDaysData)
            }
            dbgprint("nextDaysModel Count:" + nextDaysModel.count)
        }

        function buildMetogramData(readingsArray) {

            let offset = 0
            switch (main.timezoneType) {
                case (0):
                    offset = dataSource.data["Local"]["Offset"]
                    break;
                case (1):
                    offset = 0
                    break;
                case (2):
                    offset = currentPlace.timezoneOffset
                    break;
            }

            dbgprint2("buildMetogramData (Om)" + currentPlace.identifier)
            meteogramModel.clear()

            var dateFrom = parseISOString(readingsArray.current.time + ":00Z")
            var dateFromRaw = new Date(readingsArray.current.time)
            // dbgprint2("current time:" + readingsArray.current.time + ":00Z")
            var sunrise1 = UnitUtils.convertDate(currentWeatherModel.sunRise,2,currentPlace.timezoneOffset)
            var sunset1 = UnitUtils.convertDate(currentWeatherModel.sunSet,2,currentPlace.timezoneOffset)
            dbgprint("Sunrise \t(GMT)" + new Date(currentWeatherModel.sunRise).toTimeString() + "\t(LOCAL)" + sunrise1.toTimeString())
            dbgprint("Sunset \t(GMT)" + new Date(currentWeatherModel.sunSet).toTimeString() + "\t(LOCAL)" + sunset1.toTimeString())

            var hourFrom = dateFromRaw.getHours()
            var hourFromRound = Math.round(hourFrom)

            var localOffset = Math.abs(currentPlace.timezoneOffset / 3600)

            var i = Math.round(hourFrom)//Math.round(hourFrom) + Math.round(localOffset)
            // Math.round(localOffset) //Math.abs(currentPlace.timezoneOffset / 3600) //6  0  1

            dbgprint2("hourFrom:" + hourFrom)
            // dbgprint2("dateThenMg:" + dateThenMg)

            var precipitation_unit = readingsArray.hourly_units["precipitation"]
            var counter = 0

                while (i < main.hourSpanOm + 1 + hourFromRound) { // readingsArray.hourly.time[i] / 72 / 65
                    var obj = readingsArray.hourly
                    var dateTo = parseISOString(obj.time[i] + ":00Z")
                    var isDaytime = (dateTo > sunrise1) && (dateTo < sunset1) ? true : false
                    var wd = obj.wind_direction_10m[i]
                    var ws = obj.wind_speed_10m[i]
                    var ap = obj.pressure_msl[i]
                    var airtmp = parseFloat(obj.temperature_2m[i])
                    var icon = obj.weather_code[i] + 1
                    var prec = obj.precipitation[i]
                    counter = (prec > 0) ? counter + 1 : 0
                    let localtimestamp = UnitUtils.convertDate(dateTo, 2 , currentPlace.timezoneOffset)

                    if (localtimestamp >= sunrise1) {
                        if (localtimestamp < sunset1) {
                            isDaytime = true
                        } else {
                            sunrise1.setDate(sunrise1.getDate() + 1)
                            sunset1.setDate(sunset1.getDate() + 1)
                            isDaytime = false
                        }
                    }

                    dbgprint("Meteogram Data:" + "DateFrom=" + dateFrom.toISOString() + "\tLocal Time=" + UnitUtils.convertDate(dateFrom,2,currentPlace.timezoneOffset).toTimeString() + "\t Sunrise=" + sunrise1.toTimeString() + "\tSunset=" + sunset1.toTimeString() + "\t" + (isDaytime ? "isDay\n" : "isNight\n"))

                    meteogramModel.append({
                        from: dateFrom,
                        to: dateTo,
                        isDaytime: isDaytime,
                        temperature: parseFloat(airtmp),
                                        precipitationAvg: parseFloat(prec),
                                        precipitationMax: parseFloat(prec),
                                        precipitationLabel: (counter === 1) ? "mm" : "",
                                        windDirection: parseFloat(wd),
                                        windSpeedMps: parseFloat(ws),
                                        pressureHpa: parseFloat(ap),
                                        iconName: icon.toString()
                    })
                    dateFrom = dateTo
                    i++
                }
            main.loadingDataComplete = true
        }

        function formatTime(ISOdate) {
            return ISOdate.substr(11,5)
        }

        function formatDate(ISOdate) {
            return ISOdate.substr(0,10)
        }

        function composeNextDayTitle(date) {
            return Qt.locale().dayName(date.getDay(), Locale.ShortFormat) + ' ' + date.getDate() + '/' + (date.getMonth() + 1)
        }

        function failureCallback() {
            dbgprint("DOH!")
            currentWeatherModel = emptyWeatherModel()
            // loadingData.loadingDatainProgress=false
            main.loadingDataComplete = true
        }

        function loadCompleted() {
            successCallback()
        }

        function calculateOffset(seconds) {
            let hrs = String("0" + Math.floor(Math.abs(seconds) / 3600)).slice(-2)
            let mins = String("0" + (seconds % 3600)).slice(-2)
            let sign = (seconds >= 0) ? "+" : "-"
            return(sign + hrs + ":" + mins)
        }
    }

    function reloadMeteogramImage(placeIdentifier) {
        main.overviewImageSource = ""
    }

    function windDirection(bearing) {
        var Directions = ['N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW','N']
        var brg = Math.round((bearing + 11.25) / 22.5)
        return(Directions[brg])
    }
}
