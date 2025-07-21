_addon.command = 'coal'

require('luau')
bit = require('bit')
packets = require('packets')

local maps = {}
maps.coalition = {
    [0] = '+Procure: Ceizak Battlegrounds', -- 0
    [1] = '+Procure: Foret de Hennetiel',
    [2] = '+Procure: Morimar Basalt Fields',
    [3] = '+Procure: Yorcia Weald',
    [4] = '+Procure: Marjami Ravine',
    [5] = '+Procure: Kamihr Drifts',
    [6] = '+Procure: Cirdas Caverns',
    [7] = "+Procure: Outer Ra'Kaznar",
    [8] = '+Clear: Ceizak Battlegrounds',
    [9] = '+Clear: Foret de Hennetiel',
    [10] = '+Clear: Morimar Basalt Fields',
    [11] = '+Clear: Yorcia Weald',
    [12] = '+Clear: Marjami Ravine',
    [13] = '+Clear: Kamihr Drifts',
    [14] = '+Clear: Cirdas Caverns',
    [15] = "+Clear: Outer Ra'Kaznar",
    [16] = '+Preserve: Ceizak Battlegrounds',   -- 64
    [17] = '+Preserve: Yahse Hunting Grounds',
    [18] = '+Preserve: Foret de Hennetiel',
    [19] = '+Preserve: Morimar Basalt Fields',
    [20] = '+Preserve: Yorcia Weald',
    [21] = '+Preserve: Marjami Ravine',
    [22] = '+Preserve: Kamihr Drifts',
    [23] = '+Preserve: Cirdas Caverns',
    [24] = "+Preserve: Outer Ra'Kaznar",
    [25] = '+Patrol: Rala Waterways',
    [26] = '+Patrol: Sih Gates',
    [27] = '+Patrol: Moh Gates',
    [28] = '+Patrol: Cirdas Caverns',
    [29] = '+Patrol: Dho Gates',
    [30] = '+Patrol: Woh Gates',
    [31] = "+Patrol: Outer Ra'Kaznar",
    [32] = '+Provide: Foret de Hennetiel',  -- 16
    [33] = '+Provide: Morimar Basalt Fields',
    [34] = '+Provide: Yorcia Weald',
    [35] = '+Provide: Marjami Ravine',
    [36] = '+Provide: Kamihr Drifts',
    [37] = '+Deliver: Foret de Hennetiel',
    [38] = '+Deliver: Morimar Basalt Fields',
    [39] = '+Deliver: Yorcia Weald',
    [40] = '+Deliver: Marjami Ravine',
    [41] = '+Deliver: Kamihr Drifts',
    [42] = '+Support: Ceizak Battlegrounds',
    [43] = '+Support: Foret de Hennetiel',
    [44] = '+Support: Morimar Basalt Fields',
    [45] = '+Support: Yorcia Weald',
    [46] = '+Support: Marjami Ravine',
    [47] = '+Support: Kamihr Drifts',
    [48] = '+Survey: Ceizak Battlegrounds', -- 48
    [49] = '+Survey: Foret de Hennetiel',
    [50] = '+Survey: Morimar Basalt Fields',
    [51] = '+Survey: Yorcia Weald',
    [52] = '+Survey: Marjami Ravine',
    [53] = '+Survey: Kamihr Drifts',
    [54] = '+Survey: Sih Gates',
    [55] = '+Survey: Cirdas Caverns',
    [56] = '+Survey: Dho Gates',
    [57] = '+Analyze: Foret de Hennetiel',
    [58] = '+Analyze: Morimar Basalt Fields',
    [59] = '+Analyze: Yorcia Weald',
    [60] = '+Analyze: Marjami Ravine',
    [61] = '+Analyze: Kamihr Drifts',
    [62] = '+Analyze: Cirdas Caverns',
    [63] = "+Analyze: Outer Ra'Kaznar",
    [64] = '+Gather: Rala Waterways',       -- 32
    [65] = '+Gather: Ceizak Battlegrounds',
    [66] = '+Gather: Yahse Hunting Grounds',
    [67] = '+Gather: Foret de Hennetiel',
    [68] = '+Gather: Morimar Basalt Fields',
    [69] = '+Gather: Yorcia Weald',
    [70] = '+Gather: Marjami Ravine',
    [71] = '+Gather: Kamihr Drifts',
    [72] = '+Gather: Sih Gates',
    [73] = '+Gather: Moh Gates',
    [74] = '+Gather: Cirdas Caverns',
    [75] = '+Gather: Dho Gates',
    [76] = '+Gather: Woh Gates',
    [77] = "+Gather: Outer Ra'Kaznar",
    [78] = "+Gather: Ra'Kaznar Inner Court",
    [79] = '+Gather:',
    [80] = '+Recover: Ceizak Battlegrounds',    -- 80
    [81] = '+Recover: Foret de Hennetiel',
    [82] = '+Recover: Morimar Basalt Fields',
    [83] = '+Recover: Yorcia Weald',
    [84] = '+Recover: Marjami Ravine',
    [85] = '+Recover: Kamihr Drifts',
    [86] = '+Research: Rala Waterways',
    [87] = '+Research: Ceizak Battlegrounds',
    [88] = '+Research: Foret de Hennetiel',
    [89] = '+Research: Morimar Basalt Fields',
    [90] = '+Research: Yorcia Weald',
    [91] = '+Research: Marjami Ravine',
    [92] = '+Research: Kamihr Drifts',
    [93] = '+Boost: Foret de Hennetiel',
    [94] = '+Boost: Marjami Ravine',
    [95] = '+Boost: Kamihr Drifts',
}

local missions = {completed={},current={}}

function to_set(data)
    return {data:unpack('q64':rep(#data/4))}
end

function to_list(data)
    local t = {}
    for x = 0, 8*#data-1 do
        if data:unpack('q', math.floor(x/8)+1, x%8+1) then
            t[#t+1] = x
        end
    end
    return t
end

function shift_assignments(data)
    return data:sub(1,2) .. data:sub(9,10) ..
           data:sub(3,4) .. data:sub(7,8) ..
           data:sub(5,6) .. data:sub(11)
end

windower.register_event('incoming chunk', function(id, data, modified, injected, blocked)
    if id == 0x056 then
        local p = packets.parse('incoming', data)
        local Type = bit.band(p.Type, 0xFFFF)
        if Type == 0x0100 then
            missions.current.coalition = p['Quest Flags']
        elseif Type == 0x0108 then
            missions.completed.coalition = p['Quest Flags']
        elseif Type == 0x00F0 then
            missions.current.adoulin = p['Quest Flags']
        elseif Type == 0x00F8 then
            missions.completed_adoulin = p['Quest Flags']
        end
    end
end)

windower.register_event('addon command', function(...)
    if arg[1] == 'eval' then
        assert(loadstring(table.concat(arg, ' ',2)))()
    else
        if not missions.completed.coalition then
            windower.add_to_chat(167, 'You must change areas before using this addon')
            return
        end
        local red = 167
        local green = 204
        local blue = 207
        local yellow = 159
        local complete_count,current_count = 0,0
        local current_coalition = to_set(shift_assignments(missions.current.coalition))
        local completed_coalition = to_set(shift_assignments(missions.completed.coalition))
        windower.add_to_chat(blue, 'Inactive\31\204 Completed\31\167 Current\31\159 Completed + Current')
        for id = 0, #maps.coalition do
            if #maps.coalition[id] > 8 then
                local complete = completed_coalition[id+1]
                local current = current_coalition[id+1]
                if complete then
                    complete_count = complete_count + 1
                end
                if current then
                    current_count = current_count + 1
                end
                local color = complete and current and yellow or complete and green or current and red or blue
                windower.add_to_chat(color, maps.coalition[id]:sub(2))
            end
        end
        windower.add_to_chat(blue,'%d/95 Complete and %d Current assignments':format(complete_count, current_count))
    end
end)