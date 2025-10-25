_addon.name = 'Hide Players'
_addon.version = '0.1.0'
_addon.author = 'Furiex'

require('logger')
local packets = require("packets")
local settings = {} -- Will be loaded from data/settings.lua
local settings_path = windower.addon_path .. 'data/settings.lua'

-- ##################################################
-- # Settings
-- ##################################################
local function load_settings()
    -- Use pcall (protected call) to safely load the settings file
    local success, file = pcall(dofile, settings_path)
    
    if success and type(file) == 'table' then
        settings = file
        log('Settings loaded from data/settings.lua')
    else
        -- Fallback to default settings if file is missing or broken
        log('Error loading data/settings.lua. Using default settings.')
        settings = {
            denylist = {
                'Ahalee'
            }
        }
    end
end
-- ##################################################

-- Stores our current state
local so = {
    player = false,
    zone = false,
}

-- Helper function to check if a player is allowed to be seen
local function is_allowed(name)
    if not name then
        return true
    end
    local lower_name = name:lower()

    -- 1. Check explicit denylist
    for _, denied_name in ipairs(settings.denylist) do
        if denied_name:lower() == lower_name then
            return false
        end
    end

    return true
end

-- Event: Addon Load / Player Login
windower.register_event('load', 'login', function()
    load_settings()
    so.player = windower.ffxi.get_player()
    so.zone = windower.ffxi.get_info().zone
end)

-- Event: Zone Change
windower.register_event('zone change', function(id)
    so.zone = id
    so.player = windower.ffxi.get_player() -- Re-acquire player data on zone
end)

-- Event: Addon Unload / Player Logout
windower.register_event('unload', 'logout', function()
    so.player = false
    so.zone = false
end)

-- Event: Incoming Packet
windower.register_event('incoming chunk', function (id, org, mod, inj)
    -- Only run if we are logged in and the packet is not injected
    if not so.player or inj then
        return
    end

    -- 0x00D = Player Spawn packet
    if id == 0x00D then
        -- Check if the spawning player is US. If so, always allow.
        if string.sub(org, 5, 8):unpack("I") == so.player.id then
            return
        end

        local p = packets.parse('incoming', org)

        local mob = windower.ffxi.get_mob_by_id(p.Player)

        -- If the player is too close AND is NOT allowed (not whitelisted, not party)
        if mob and not is_allowed(mob.name) then
            p.Despawn = true -- Make them invisible
            return packets.build(p)
        end
    end
end)