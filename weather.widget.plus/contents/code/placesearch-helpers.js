.import "./timezoneData.js" as TZData
var countries = Array(
            {shortCode: "AD" , displayName: "Andorra"},
            {shortCode: "AE" , displayName: "United Arab Emirates"},
            {shortCode: "AF" , displayName: "Afghanistan"},
            {shortCode: "AG" , displayName: "Antigua and Barbuda"},
            {shortCode: "AI" , displayName: "Anguilla"},
            {shortCode: "AL" , displayName: "Albania"},
            {shortCode: "AM" , displayName: "Armenia"},
            {shortCode: "AO" , displayName: "Angola"},
            {shortCode: "AQ" , displayName: "Antarctica"},
            {shortCode: "AR" , displayName: "Argentina"},
            {shortCode: "AS" , displayName: "American Samoa"},
            {shortCode: "AT" , displayName: "Austria"},
            {shortCode: "AU" , displayName: "Australia"},
            {shortCode: "AW" , displayName: "Aruba"},
            {shortCode: "AX" , displayName: "Aland Islands"},
            {shortCode: "AZ" , displayName: "Azerbaijan"},
            {shortCode: "BA" , displayName: "Bosnia and Herzegovina"},
            {shortCode: "BB" , displayName: "Barbados"},
            {shortCode: "BD" , displayName: "Bangladesh"},
            {shortCode: "BE" , displayName: "Belgium"},
            {shortCode: "BF" , displayName: "Burkina Faso"},
            {shortCode: "BG" , displayName: "Bulgaria"},
            {shortCode: "BH" , displayName: "Bahrain"},
            {shortCode: "BI" , displayName: "Burundi"},
            {shortCode: "BJ" , displayName: "Benin"},
            {shortCode: "BL" , displayName: "Saint Barthelemy"},
            {shortCode: "BM" , displayName: "Bermuda"},
            {shortCode: "BN" , displayName: "Brunei"},
            {shortCode: "BO" , displayName: "Bolivia"},
            {shortCode: "BQ" , displayName: "Bonaire, Saint Eustatius and Saba "},
            {shortCode: "BR" , displayName: "Brazil"},
            {shortCode: "BS" , displayName: "Bahamas"},
            {shortCode: "BT" , displayName: "Bhutan"},
            {shortCode: "BW" , displayName: "Botswana"},
            {shortCode: "BY" , displayName: "Belarus"},
            {shortCode: "BZ" , displayName: "Belize"},
            {shortCode: "CA" , displayName: "Canada"},
            {shortCode: "CC" , displayName: "Cocos Islands"},
            {shortCode: "CD" , displayName: "Democratic Republic of the Congo"},
            {shortCode: "CF" , displayName: "Central African Republic"},
            {shortCode: "CG" , displayName: "Republic of the Congo"},
            {shortCode: "CH" , displayName: "Switzerland"},
            {shortCode: "CI" , displayName: "Ivory Coast"},
            {shortCode: "CK" , displayName: "Cook Islands"},
            {shortCode: "CL" , displayName: "Chile"},
            {shortCode: "CM" , displayName: "Cameroon"},
            {shortCode: "CN" , displayName: "China"},
            {shortCode: "CO" , displayName: "Colombia"},
            {shortCode: "CR" , displayName: "Costa Rica"},
            {shortCode: "CU" , displayName: "Cuba"},
            {shortCode: "CV" , displayName: "Cabo Verde"},
            {shortCode: "CW" , displayName: "Curacao"},
            {shortCode: "CX" , displayName: "Christmas Island"},
            {shortCode: "CY" , displayName: "Cyprus"},
            {shortCode: "CZ" , displayName: "Czechia"},
            {shortCode: "DE" , displayName: "Germany"},
            {shortCode: "DJ" , displayName: "Djibouti"},
            {shortCode: "DK" , displayName: "Denmark"},
            {shortCode: "DM" , displayName: "Dominica"},
            {shortCode: "DO" , displayName: "Dominican Republic"},
            {shortCode: "DZ" , displayName: "Algeria"},
            {shortCode: "EC" , displayName: "Ecuador"},
            {shortCode: "EE" , displayName: "Estonia"},
            {shortCode: "EG" , displayName: "Egypt"},
            {shortCode: "EH" , displayName: "Western Sahara"},
            {shortCode: "ER" , displayName: "Eritrea"},
            {shortCode: "ES" , displayName: "Spain"},
            {shortCode: "ET" , displayName: "Ethiopia"},
            {shortCode: "FI" , displayName: "Finland"},
            {shortCode: "FJ" , displayName: "Fiji"},
            {shortCode: "FK" , displayName: "Falkland Islands"},
            {shortCode: "FM" , displayName: "Micronesia"},
            {shortCode: "FO" , displayName: "Faroe Islands"},
            {shortCode: "FR" , displayName: "France"},
            {shortCode: "GA" , displayName: "Gabon"},
            {shortCode: "GB" , displayName: "United Kingdom"},
            {shortCode: "GD" , displayName: "Grenada"},
            {shortCode: "GE" , displayName: "Georgia"},
            {shortCode: "GF" , displayName: "French Guiana"},
            {shortCode: "GG" , displayName: "Guernsey"},
            {shortCode: "GH" , displayName: "Ghana"},
            {shortCode: "GI" , displayName: "Gibraltar"},
            {shortCode: "GL" , displayName: "Greenland"},
            {shortCode: "GM" , displayName: "Gambia"},
            {shortCode: "GN" , displayName: "Guinea"},
            {shortCode: "GP" , displayName: "Guadeloupe"},
            {shortCode: "GQ" , displayName: "Equatorial Guinea"},
            {shortCode: "GR" , displayName: "Greece"},
            {shortCode: "GS" , displayName: "South Georgia and the South Sandwich Islands"},
            {shortCode: "GT" , displayName: "Guatemala"},
            {shortCode: "GU" , displayName: "Guam"},
            {shortCode: "GW" , displayName: "Guinea-Bissau"},
            {shortCode: "GY" , displayName: "Guyana"},
            {shortCode: "HK" , displayName: "Hong Kong"},
            {shortCode: "HN" , displayName: "Honduras"},
            {shortCode: "HR" , displayName: "Croatia"},
            {shortCode: "HT" , displayName: "Haiti"},
            {shortCode: "HU" , displayName: "Hungary"},
            {shortCode: "ID" , displayName: "Indonesia"},
            {shortCode: "IE" , displayName: "Ireland"},
            {shortCode: "IL" , displayName: "Israel"},
            {shortCode: "IM" , displayName: "Isle of Man"},
            {shortCode: "IN" , displayName: "India"},
            {shortCode: "IQ" , displayName: "Iraq"},
            {shortCode: "IR" , displayName: "Iran"},
            {shortCode: "IS" , displayName: "Iceland"},
            {shortCode: "IT" , displayName: "Italy"},
            {shortCode: "JE" , displayName: "Jersey"},
            {shortCode: "JM" , displayName: "Jamaica"},
            {shortCode: "JO" , displayName: "Jordan"},
            {shortCode: "JP" , displayName: "Japan"},
            {shortCode: "KE" , displayName: "Kenya"},
            {shortCode: "KG" , displayName: "Kyrgyzstan"},
            {shortCode: "KH" , displayName: "Cambodia"},
            {shortCode: "KI" , displayName: "Kiribati"},
            {shortCode: "KM" , displayName: "Comoros"},
            {shortCode: "KN" , displayName: "Saint Kitts and Nevis"},
            {shortCode: "KP" , displayName: "North Korea"},
            {shortCode: "KR" , displayName: "South Korea"},
            {shortCode: "XK" , displayName: "Kosovo"},
            {shortCode: "KW" , displayName: "Kuwait"},
            {shortCode: "KY" , displayName: "Cayman Islands"},
            {shortCode: "KZ" , displayName: "Kazakhstan"},
            {shortCode: "LA" , displayName: "Laos"},
            {shortCode: "LB" , displayName: "Lebanon"},
            {shortCode: "LC" , displayName: "Saint Lucia"},
            {shortCode: "LI" , displayName: "Liechtenstein"},
            {shortCode: "LK" , displayName: "Sri Lanka"},
            {shortCode: "LR" , displayName: "Liberia"},
            {shortCode: "LS" , displayName: "Lesotho"},
            {shortCode: "LT" , displayName: "Lithuania"},
            {shortCode: "LU" , displayName: "Luxembourg"},
            {shortCode: "LV" , displayName: "Latvia"},
            {shortCode: "LY" , displayName: "Libya"},
            {shortCode: "MA" , displayName: "Morocco"},
            {shortCode: "MC" , displayName: "Monaco"},
            {shortCode: "MD" , displayName: "Moldova"},
            {shortCode: "ME" , displayName: "Montenegro"},
            {shortCode: "MF" , displayName: "Saint Martin"},
            {shortCode: "MG" , displayName: "Madagascar"},
            {shortCode: "MH" , displayName: "Marshall Islands"},
            {shortCode: "MK" , displayName: "North Macedonia"},
            {shortCode: "ML" , displayName: "Mali"},
            {shortCode: "MM" , displayName: "Myanmar"},
            {shortCode: "MN" , displayName: "Mongolia"},
            {shortCode: "MO" , displayName: "Macao"},
            {shortCode: "MP" , displayName: "Northern Mariana Islands"},
            {shortCode: "MQ" , displayName: "Martinique"},
            {shortCode: "MR" , displayName: "Mauritania"},
            {shortCode: "MS" , displayName: "Montserrat"},
            {shortCode: "MT" , displayName: "Malta"},
            {shortCode: "MU" , displayName: "Mauritius"},
            {shortCode: "MV" , displayName: "Maldives"},
            {shortCode: "MW" , displayName: "Malawi"},
            {shortCode: "MX" , displayName: "Mexico"},
            {shortCode: "MY" , displayName: "Malaysia"},
            {shortCode: "MZ" , displayName: "Mozambique"},
            {shortCode: "NA" , displayName: "Namibia"},
            {shortCode: "NC" , displayName: "New Caledonia"},
            {shortCode: "NE" , displayName: "Niger"},
            {shortCode: "NF" , displayName: "Norfolk Island"},
            {shortCode: "NG" , displayName: "Nigeria"},
            {shortCode: "NI" , displayName: "Nicaragua"},
            {shortCode: "NL" , displayName: "Netherlands"},
            {shortCode: "NO" , displayName: "Norway"},
            {shortCode: "NP" , displayName: "Nepal"},
            {shortCode: "NR" , displayName: "Nauru"},
            {shortCode: "NU" , displayName: "Niue"},
            {shortCode: "NZ" , displayName: "New Zealand"},
            {shortCode: "OM" , displayName: "Oman"},
            {shortCode: "PA" , displayName: "Panama"},
            {shortCode: "PE" , displayName: "Peru"},
            {shortCode: "PF" , displayName: "French Polynesia"},
            {shortCode: "PG" , displayName: "Papua New Guinea"},
            {shortCode: "PH" , displayName: "Philippines"},
            {shortCode: "PK" , displayName: "Pakistan"},
            {shortCode: "PL" , displayName: "Poland"},
            {shortCode: "PM" , displayName: "Saint Pierre and Miquelon"},
            {shortCode: "PN" , displayName: "Pitcairn"},
            {shortCode: "PR" , displayName: "Puerto Rico"},
            {shortCode: "PS" , displayName: "Palestinian Territory"},
            {shortCode: "PT" , displayName: "Portugal"},
            {shortCode: "PW" , displayName: "Palau"},
            {shortCode: "PY" , displayName: "Paraguay"},
            {shortCode: "QA" , displayName: "Qatar"},
            {shortCode: "RE" , displayName: "Reunion"},
            {shortCode: "RO" , displayName: "Romania"},
            {shortCode: "RS" , displayName: "Serbia"},
            {shortCode: "RU" , displayName: "Russia"},
            {shortCode: "RW" , displayName: "Rwanda"},
            {shortCode: "SA" , displayName: "Saudi Arabia"},
            {shortCode: "SB" , displayName: "Solomon Islands"},
            {shortCode: "SC" , displayName: "Seychelles"},
            {shortCode: "SD" , displayName: "Sudan"},
            {shortCode: "SS" , displayName: "South Sudan"},
            {shortCode: "SE" , displayName: "Sweden"},
            {shortCode: "SG" , displayName: "Singapore"},
            {shortCode: "SH" , displayName: "Saint Helena"},
            {shortCode: "SI" , displayName: "Slovenia"},
            {shortCode: "SJ" , displayName: "Svalbard and Jan Mayen"},
            {shortCode: "SK" , displayName: "Slovakia"},
            {shortCode: "SL" , displayName: "Sierra Leone"},
            {shortCode: "SM" , displayName: "San Marino"},
            {shortCode: "SN" , displayName: "Senegal"},
            {shortCode: "SO" , displayName: "Somalia"},
            {shortCode: "SR" , displayName: "Suriname"},
            {shortCode: "ST" , displayName: "Sao Tome and Principe"},
            {shortCode: "SV" , displayName: "El Salvador"},
            {shortCode: "SX" , displayName: "Sint Maarten"},
            {shortCode: "SY" , displayName: "Syria"},
            {shortCode: "SZ" , displayName: "Eswatini"},
            {shortCode: "TC" , displayName: "Turks and Caicos Islands"},
            {shortCode: "TD" , displayName: "Chad"},
            {shortCode: "TF" , displayName: "French Southern Territories"},
            {shortCode: "TG" , displayName: "Togo"},
            {shortCode: "TH" , displayName: "Thailand"},
            {shortCode: "TJ" , displayName: "Tajikistan"},
            {shortCode: "TK" , displayName: "Tokelau"},
            {shortCode: "TL" , displayName: "Timor Leste"},
            {shortCode: "TM" , displayName: "Turkmenistan"},
            {shortCode: "TN" , displayName: "Tunisia"},
            {shortCode: "TO" , displayName: "Tonga"},
            {shortCode: "TR" , displayName: "Turkey"},
            {shortCode: "TT" , displayName: "Trinidad and Tobago"},
            {shortCode: "TV" , displayName: "Tuvalu"},
            {shortCode: "TW" , displayName: "Taiwan"},
            {shortCode: "TZ" , displayName: "Tanzania"},
            {shortCode: "UA" , displayName: "Ukraine"},
            {shortCode: "UG" , displayName: "Uganda"},
            {shortCode: "US" , displayName: "United States"},
            {shortCode: "UY" , displayName: "Uruguay"},
            {shortCode: "UZ" , displayName: "Uzbekistan"},
            {shortCode: "VA" , displayName: "Vatican"},
            {shortCode: "VC" , displayName: "Saint Vincent and the Grenadines"},
            {shortCode: "VE" , displayName: "Venezuela"},
            {shortCode: "VG" , displayName: "British Virgin Islands"},
            {shortCode: "VI" , displayName: "U.S. Virgin Islands"},
            {shortCode: "VN" , displayName: "Vietnam"},
            {shortCode: "VU" , displayName: "Vanuatu"},
            {shortCode: "WF" , displayName: "Wallis and Futuna"},
            {shortCode: "WS" , displayName: "Samoa"},
            {shortCode: "YE" , displayName: "Yemen"},
            {shortCode: "YT" , displayName: "Mayotte"},
            {shortCode: "ZA" , displayName: "South Africa"},
            {shortCode: "ZM" , displayName: "Zambia"},
            {shortCode: "ZW" , displayName: "Zimbabwe"}
)
function getDisplayNames() {
    let tmp = Array()
    countries.forEach(function(country) {
        tmp.push(country["displayName"])
    })
    return (tmp.sort())
}
function getshortCode(displayName) {
    var __FOUND = countries.find(function(post, index) {
        if(post.displayName == displayName)
            return true
    })
    return __FOUND["shortCode"]
}
function getDisplayName(shortCode) {
    var __FOUND = countries.find(function(post, index) {
        if(post.shortCode == shortCode)
            return true
    })
    return __FOUND["displayName"]
}

var globalSearchIndex = []
var globalSearchLoaded = false
var globalSearchLoading = false
var loadedCountryCodes = {}

function preloadCSVForSearch(callback) {
    if (globalSearchLoaded || globalSearchLoading) {
        if (callback) callback()
        return
    }
    globalSearchLoading = true

    var priorityCountries = ["IN", "US", "GB", "CA", "AU", "DE", "FR", "JP", "BR", "IT", "ES", "PK", "BD", "LK", "NP"]
    var loadedCount = 0
    var total = priorityCountries.length

    priorityCountries.forEach(function(cc) {
        var url
        if (typeof env_QML_XHR_ALLOW_FILE_READ !== 'undefined' && env_QML_XHR_ALLOW_FILE_READ) {
            url = Qt.resolvedUrl("./db/" + cc + ".csv")
        } else {
            url = "http://weatherwidgetqt6.000webhostapp.com/" + cc + ".csv"
        }
        var xhr = new XMLHttpRequest
        xhr.open("GET", url)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                loadedCount++
                if (xhr.status === 200 && xhr.responseText.length > 0) {
                    var tmpDB = xhr.responseText.split(/\r?\n/)
                    var countryName = getDisplayName(cc)
                    for (var i = 0; i < tmpDB.length - 1; i++) {
                        var parsed = parseCSVLineExt(tmpDB[i], cc, countryName)
                        if (parsed) {
                            globalSearchIndex.push(parsed)
                        }
                    }
                }
                loadedCountryCodes[cc] = true
                if (loadedCount >= total) {
                    globalSearchIndex.sort(function(a, b) {
                        return a.searchKey.localeCompare(b.searchKey)
                    })
                    globalSearchLoaded = true
                    globalSearchLoading = false
                    if (callback) callback()
                }
            }
        }
        xhr.send()
    })
}

function searchLocalCSV(query) {
    if (!globalSearchLoaded || query.length < 2) {
        return []
    }
    var q = query.toLowerCase().trim()
    var results = []
    for (var i = 0; i < globalSearchIndex.length; i++) {
        if (globalSearchIndex[i].searchKey.indexOf(q) !== -1) {
            results.push({
                location: globalSearchIndex[i].location,
                area: globalSearchIndex[i].area,
                country: globalSearchIndex[i].country,
                latitude: globalSearchIndex[i].latitude,
                longitude: globalSearchIndex[i].longitude,
                altitude: globalSearchIndex[i].altitude,
                timezoneId: globalSearchIndex[i].timezoneId,
                timezoneDisplay: TZData.TZData[globalSearchIndex[i].timezoneId] ? TZData.TZData[globalSearchIndex[i].timezoneId].displayName : ""
            })
            if (results.length >= 15) break
        }
    }
    return results
}

var nominatimRequestPending = false
var nominatimTimer = 0

function searchNominatim(query, callback) {
    if (nominatimRequestPending) return
    var now = new Date().getTime()
    if (now - nominatimTimer < 1100) {
        return
    }
    nominatimRequestPending = true
    nominatimTimer = now
    var xhr = new XMLHttpRequest
    xhr.timeout = 10000
    xhr.open("GET", "https://geocoding-api.open-meteo.com/v1/search?name=" + encodeURIComponent(query) + "&count=8&language=en&format=json")
    xhr.onerror = function() {
        nominatimRequestPending = false
        callback([])
    }
    xhr.ontimeout = function() {
        nominatimRequestPending = false
        callback([])
    }
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            nominatimRequestPending = false
            if (xhr.status === 200) {
                try {
                    var data = JSON.parse(xhr.responseText)
                    var results = []
                    if (data.results) {
                        for (var i = 0; i < data.results.length; i++) {
                            var item = data.results[i]
                            var tzId = -1
                            var tzDisplay = ""
                            if (item.timezone && typeof TZData !== 'undefined' && TZData.TZData) {
                                for (var t = 0; t < TZData.TZData.length; t++) {
                                    var tzName = TZData.TZData[t].displayName.replace(/_/gi, " ")
                                    if (tzName.toLowerCase().indexOf(item.timezone.toLowerCase().replace(/_/gi, " ")) !== -1) {
                                        tzId = TZData.TZData[t].id
                                        tzDisplay = TZData.TZData[t].displayName.replace(/_/gi, " ")
                                        break
                                    }
                                }
                            }
                            results.push({
                                location: item.name || query,
                                area: item.admin1 || (item.country || ""),
                                country: item.country || "",
                                latitude: parseFloat(item.latitude),
                                longitude: parseFloat(item.longitude),
                                altitude: item.elevation || 0,
                                timezoneId: tzId,
                                timezoneDisplay: tzDisplay
                            })
                        }
                    }
                    callback(results)
                } catch(e) {
                    callback([])
                }
            } else {
                callback([])
            }
        }
    }
    xhr.send()
}

var ipDetectionPending = false
var lastDetectionTime = 0

function detectLocationByIP(callback) {
    if (ipDetectionPending) return
    ipDetectionPending = true
    var xhr = new XMLHttpRequest
    xhr.timeout = 10000
    xhr.open("GET", "http://ip-api.com/json/?fields=city,regionName,country,lat,lon,timezone")
    xhr.onerror = function() {
        ipDetectionPending = false
        callback(null)
    }
    xhr.ontimeout = function() {
        ipDetectionPending = false
        callback(null)
    }
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            ipDetectionPending = false
            if (xhr.status === 200) {
                try {
                    var data = JSON.parse(xhr.responseText)
                    if (data.lat && data.lon) {
                        lastDetectionTime = new Date().getTime()
                        callback({
                            city: data.city || "",
                            region: data.regionName || "",
                            country: data.country || "",
                            latitude: parseFloat(data.lat),
                            longitude: parseFloat(data.lon),
                            timezone: data.timezone || ""
                        })
                        return
                    }
                } catch(e) {
                }
            }
            callback(null)
        }
    }
    xhr.send()
}

function getLastDetectionTime() {
    return lastDetectionTime
}

function parseCSVLineExt(csvLine, countryCode, countryName) {
    if (!csvLine || csvLine.length === 0) return null
    var items = csvLine.split(/\t/)
    if (items.length < 6) return null
    var tzId = parseInt(items[5])
    var tzDisplay = TZData.TZData[tzId] ? TZData.TZData[tzId].displayName : ""
    return {
        area: (items[0] || "").trim(),
        location: (items[1] || "").trim(),
        latitude: parseFloat(items[2]),
        longitude: parseFloat(items[3]),
        altitude: parseInt(items[4]) || 0,
        timezoneId: tzId,
        searchKey: ((items[1] || "") + " " + (items[0] || "") + " " + countryName).toLowerCase().trim(),
        country: countryName,
        countryCode: countryCode
    }
}

function updateListView(filter) {
    filteredCSVData.clear()
    for (var f = 0; f < myCSVData.rowCount; f++) {
        let lc = myCSVData.getRow(f).Location.toLowerCase()
        if (myCSVData.getRow(f).Location.toLowerCase().indexOf(filter.toLowerCase()) === 0) {
            filteredCSVData.appendRow(myCSVData.getRow(f))
        }
    }
}
function loadCSVDatabase(countryName) {
    if (countryName.length === 0) {
        return
    }
    myCSVData.clear()
    var URL = ("http://weatherwidgetqt6.000webhostapp.com/" + getshortCode(countryName) + ".csv")
    if (typeof env_QML_XHR_ALLOW_FILE_READ !== 'undefined' && env_QML_XHR_ALLOW_FILE_READ) {
        URL =  Qt.resolvedUrl("./db/" + getshortCode(countryName) + ".csv")
    }
    var xhr = new XMLHttpRequest
    xhr.open("GET", URL)
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            var response = xhr.responseText
            var tmpDB = response.split(/\r?\n/)
            for (var i = 0; i < tmpDB.length - 1; i++) {
                myCSVData.appendRow(parseCSVLine(tmpDB[i]))
            }
            if (typeof locationEdit !== 'undefined') {
                updateListView(locationEdit.text)
            }
        }
    }
    xhr.send()
}
function parseCSVLine(csvLine) {
    function stripquotes(str) {
        return str.replace(/['"]+/g, '')
    }
    var items = csvLine.split(/\t/)
    return ({
                Area: stripquotes((items[0])),
                Location: stripquotes(items[1]),
                Latitude: parseFloat(items[2]).toFixed(3),
                Longitude: parseFloat(items[3]).toFixed(3),
                Altitude: parseInt(items[4]),
                timezoneId: parseInt(items[5]),
                Timezone: TZData.TZData[items[5]].displayName
            })
}
