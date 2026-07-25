.import "./timezoneData.js" as TZData
.import "./placesearch-helpers.js" as LocSearch

function getPlacesArray() {
    var cfgPlaces = plasmoid.configuration.places
    return JSON.parse(cfgPlaces)
}

function detectCurrentLocation(callback) {
    try {
        var tzAbbr = ""
        if (typeof dataSource !== 'undefined' && dataSource.data["Local"]) {
            tzAbbr = dataSource.data["Local"]["Timezone Abbreviation"] || ""
        }
        if (tzAbbr.length === 0) {
            fallbackToIPDetection(callback)
            return
        }
        var tzIndex = -1
        if (typeof TZData !== 'undefined' && TZData.TZData) {
            for (var i = 0; i < TZData.TZData.length; i++) {
                if (TZData.TZData[i].TZName === tzAbbr || TZData.TZData[i].DSTName === tzAbbr) {
                    tzIndex = i
                    break
                }
            }
        }
        if (tzIndex >= 0) {
            callback({
                city: tzAbbr,
                timezoneID: tzIndex,
                fromDataEngine: true
            })
            return
        }
        fallbackToIPDetection(callback)
    } catch (e) {
        fallbackToIPDetection(callback)
    }
}

function fallbackToIPDetection(callback) {
    LocSearch.detectLocationByIP(function(result) {
        if (result) {
            callback({
                city: result.city || result.region || "Current Location",
                region: result.region,
                country: result.country,
                latitude: result.latitude,
                longitude: result.longitude,
                timezone: result.timezone,
                fromIP: true
            })
        } else {
            callback(null)
        }
    })
}
