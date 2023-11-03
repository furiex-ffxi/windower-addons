---------------------------
-- Utility functions for zones.
-- @class module
-- @name zone_util

_libs = _libs or {}

require('lists')

local res = require('resources')

local zone_util = {}

_raw = _raw or {}

_libs.zone_util = zone_util

local cities = S{
    "Ru'Lude Gardens",
    "Upper Jeuno",
    "Lower Jeuno",
    "Port Jeuno",
    "Port Windurst",
    "Windurst Waters",
    "Windurst Woods",
    "Windurst Walls",
    "Heavens Tower",
    "Port San d'Oria",
    "Northern San d'Oria",
    "Southern San d'Oria",
    "Chateau d'Oraguille",
    "Port Bastok",
    "Bastok Markets",
    "Bastok Mines",
    "Metalworks",
    "Aht Urhgan Whitegate",
    "The Colosseum",
    "Tavnazian Safehold",
    "Nashmau",
    "Selbina",
    "Mhaura",
    "Rabao",
    "Norg",
    "Kazham",
    "Eastern Adoulin",
    "Western Adoulin",
    "Celennia Memorial Library",
    "Mog Garden",
    "Leafallia"
}

---
-- Checks if a given zone identifier corresponds to a city.
--
-- @param zone_id (string) The identifier of the zone to be checked.
-- @return (boolean) True if the zone is a city, false otherwise.
---
function zone_util.is_city(zone_id)
    return cities:contains(res.zones[zone_id].en)
end

return zone_util