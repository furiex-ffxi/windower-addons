_addon.name = 'Safe Oboro'
_addon.version = '0.1.2'
_addon.author = 'Lili'

require('logger')
local packets = require("packets")

local so = {
    player = false,
    partymembers = {},
    zone = false,
}

local res = {}
res.buffs = require('resources').buffs
res.zones = require('resources').zones

-- returns current zone name
local function get_zone()
    return res.zones[windower.ffxi.get_info().zone].en
end

-- returns true if current zone is a city or town. 
local in_town = function()
	local Cities = S{ 
            "Northern San d'Oria", "Southern San d'Oria", "Port San d'Oria", "Chateau d'Oraguille",
            "Bastok Markets", "Bastok Mines", "Port Bastok", "Metalworks",
            "Windurst Walls", "Windurst Waters", "Windurst Woods", "Port Windurst", "Heavens Tower",
            "Ru'Lude Gardens", "Upper Jeuno", "Lower Jeuno", "Port Jeuno",
            "Selbina", "Mhaura", "Kazham", "Norg", "Rabao", "Tavnazian Safehold",
            "Aht Urhgan Whitegate", "Al Zahbi", "Nashmau",
            "Southern San d'Oria (S)", "Bastok Markets (S)", "Windurst Waters (S)",
            -- "Walk of Echoes", "Provenance",
            "Western Adoulin", "Eastern Adoulin", "Celennia Memorial Library",
            "Bastok-Jeuno Airship", "Kazham-Jeuno Airship", "San d'Oria-Jeuno Airship", "Windurst-Jeuno Airship",
            "Ship bound for Mhaura", "Ship bound for Selbina", "Open sea route to Al Zahbi", "Open sea route to Mhaura",
            "Silver Sea route to Al Zahbi", "Silver Sea route to Nashmau", "Manaclipper", "Phanauet Channel",
            "Chocobo Circuit", "Feretory", "Mog Garden", 
            }
    return function()
        if Cities:contains(get_zone()) then
            return true
        end
    end
end()

function is_blocked (t)
	local BlockedPlayers = S{ 
                "Ujizero",
                "Inyani",
                "Enlarge",
                "Bloodvessel",
                "Redcell"
            }
    if BlockedPlayers:contains(t) then
        return true
    end
    return false
end

function oboro_is_near(t)
    local t = t or windower.ffxi.get_mob_by_target('me')
    local player_name = windower.ffxi.get_player().name
    print(player_name)
    return is_blocked(player_name)
end


windower.register_event('load','login',function()
    so.player = windower.ffxi.get_player()
    so.zone = windower.ffxi.get_info().zone
    so.partymembers = windower.ffxi.get_party()
end)

windower.register_event('unload','logout', function()
    so.player = false
    so.zone = false
end)

windower.register_event('incoming chunk', function (id, org, mod, inj)
    if not in_town() or not so.player or inj then
        return
    end
    
    if id == 0x00D and string.sub(org, 5,8):unpack("I") ~= so.player.id then
        
        local p = packets.parse('incoming', org)
       
        if oboro_is_near(p) then -- oboro.r > math.sqrt((oboro.x - p.X)^2 + (oboro.y - p.Y)^2) then
           p.Despawn = true
           return packets.build(p) 
        end
    end
end)