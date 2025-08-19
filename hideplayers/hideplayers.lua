_addon.name = 'HidePlayers'
_addon.version = '0.2.0'
_addon.author = 'Furyex'

require('logger')
local packets = require("packets")

local so = {
    player = false,
    partymembers = {},
    zone = false,
}

-- Add the names you want to hide here (all lowercase, case-insensitive match)
local hidden_names = {
    ['inyani'] = true,
    ['bloodvessel'] = true,
    ['ujizero'] = true,
    ['redcell'] = true,
    ['enlarge'] = true,
    ['cleobabe'] = true,
    -- Add more names as needed
}

windower.register_event('load','login',function()
    -- Initialize player and zone information
    print('HidePlayers addon loaded. Hiding specified players...')
    so.player = windower.ffxi.get_player()
    so.zone = windower.ffxi.get_info().zone
    so.partymembers = windower.ffxi.get_party()
end)

windower.register_event('zone change',function(id)
    so.zone = id
end)

windower.register_event('unload','logout', function()
    so.player = false
    so.zone = false
end)

windower.register_event('incoming chunk', function (id, org, mod, inj)
    if not so.player or inj then
        print('HidePlayers: Not ready or packet injection detected, skipping...')
        return
    end

    -- Hide players with specific names everywhere
    if id == 0x00D then
        local p = packets.parse('incoming', org)
        if p and p.Name then
            print('HidePlayers: Player name found: ' .. p.Name)
            local name = p.Name:lower()
            print('Checking name: ' .. name)
            if hidden_names[name] then  
                p.Despawn = true
                return packets.build(p)
            end
        end
    end
end)