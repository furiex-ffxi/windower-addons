_addon.name     = 'orders'
_addon.author   = 'Elidyr'
_addon.version  = '0.20201101'
_addon.command  = 'ord'

require('tables')
require('strings')

local accounts  = {'Furyex', 'Cleobabe', 'Lolababe', 'Mailman'}
local gdelay    = 0.75

windower.register_event('addon command', function(...)
    local a = T{...}
    local c = a[1] or false

    if c then
        c = c:lower()

        if c == '@' then
            print(c)

            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(3, #table.concat(a, ' '))
            local order     = {}
            local self      = ''

            for i,v in ipairs(accounts) do
                local name = v

                if name and name ~= '' and name ~= player.name then

                    if i == 1 then
                        table.insert(order, string.format('||%s %s', name, command))

                    elseif i > 1 then
                        table.insert(order, string.format('||%s %s', name, command))

                    end

                elseif name and name ~= '' and name == player.name then
                    self = string.format('%s', command)
                    print(self)
                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))
            windower.send_command(windower.convert_auto_trans(self))

        elseif c == '@*' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(3, #table.concat(a, ' '))
            local order     = {}

            for i,v in ipairs(accounts) do
                local name = v

                if name and name ~= '' and name ~= player.name then

                    if i == 1 then
                        table.insert(order, string.format('||%s %s', name, command))

                    elseif i > 1 then
                        table.insert(order, string.format('||%s %s', name, command))

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))

        elseif c == '@@' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(4, #table.concat(a, ' '))
            local order     = {}
            local self      = ''
            local delay     = 0

            for i,v in ipairs(accounts) do
                local name = v

                if name and name ~= '' and name ~= player.name then

                    if i == 1 then
                        table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                        delay = (delay + gdelay)

                    elseif i > 1 then
                        table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                        delay = (delay + gdelay)

                    end

                elseif name and name ~= '' and name == player.name then
                    self = string.format('wait %s; %s', delay, command)
                    delay = (delay + gdelay)

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))
            windower.send_command(windower.convert_auto_trans(self))

        elseif c == '@@*' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(4, #table.concat(a, ' '))
            local order     = {}
            local delay     = 0

            for i,v in ipairs(accounts) do
                local name = v

                if name and name ~= '' and name ~= player.name then

                    if i == 1 then
                        table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                        delay = (delay + gdelay)

                    elseif i > 1 then
                        table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                        delay = (delay + gdelay)

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))

        elseif c == 'r' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(3, #table.concat(a, ' '))
            local order     = {}
            local self      = ''

            for i,v in ipairs(accounts) do
                local name      = v
                local target    = windower.ffxi.get_mob_by_name(name) or false

                if name and name ~= '' and name ~= player.name and target and (target.distance):sqrt() < 25 then

                    if i == 1 then
                        table.insert(order, string.format('||%s %s', name, command))

                    elseif i > 1 then
                        table.insert(order, string.format('||%s %s', name, command))

                    end

                elseif name and name ~= '' and name == player.name then
                    self = string.format('%s', command)

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))
            windower.send_command(windower.convert_auto_trans(self))

        elseif c == 'r*' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(3, #table.concat(a, ' '))
            local order     = {}

            for i,v in ipairs(accounts) do
                local name      = v
                local target    = windower.ffxi.get_mob_by_name(name) or false

                if name and name ~= '' and name ~= player.name and target and (target.distance):sqrt() < 25 then

                    if i == 1 then
                        table.insert(order, string.format('||%s %s', name, command))

                    elseif i > 1 then
                        table.insert(order, string.format('||%s %s', name, command))

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))

        elseif c == 'rr' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(4, #table.concat(a, ' '))
            local order     = {}
            local self      = ''
            local delay     = 0

            for i,v in ipairs(accounts) do
                local name = v
                local target    = windower.ffxi.get_mob_by_name(name) or false

                if name and name ~= '' and name ~= player.name and target and (target.distance):sqrt() < 25 then

                    if i == 1 then
                        table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                        delay = (delay + gdelay)

                    elseif i > 1 then
                        table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                        delay = (delay + gdelay)

                    end

                elseif name and name ~= '' and name == player.name then
                    self = string.format('wait %s; %s', delay, command)
                    delay = (delay + gdelay)

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))
            windower.send_command(windower.convert_auto_trans(self))

        elseif c == 'rr*' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(4, #table.concat(a, ' '))
            local order     = {}
            local delay     = 0

            for i,v in ipairs(accounts) do
                local name = v
                local target    = windower.ffxi.get_mob_by_name(name) or false

                if name and name ~= '' and name ~= player.name and target and (target.distance):sqrt() < 25 then

                    if i == 1 then
                        table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                        delay = (delay + gdelay)

                    elseif i > 1 then
                        table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                        delay = (delay + gdelay)

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))

        elseif c == 'o' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(3, #table.concat(a, ' '))
            local order     = {}
            local self      = ''

            for i,v in ipairs(accounts) do
                local name      = v

                if name and name ~= '' and name ~= player.name then
                    
                    if i == 1 then
                        table.insert(order, string.format('||%s %s', name, command))

                    elseif i > 1 then
                        table.insert(order, string.format('||%s %s', name, command))

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))

        elseif c == 'oo' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(4, #table.concat(a, ' '))
            local order     = {}
            local self      = ''
            local delay     = 0

            for i,v in ipairs(accounts) do
                local name = v

                if name and name ~= '' and name ~= player.name then

                    if i == 1 then
                        table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                        delay = (delay + gdelay)

                    elseif i > 1 then
                        table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                        delay = (delay + gdelay)

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))

        elseif c == 'p' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(3, #table.concat(a, ' '))
            local party     = windower.ffxi.get_party()
            local order     = {}
            local self      = ''

            for i,v in ipairs(accounts) do
                local name = v

                if name ~= '' and name ~= player.name then
                    
                    for ii,vv in pairs(party) do
                        
                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and name == vv.name then
                            
                            if i == 1 then
                                table.insert(order, string.format('||%s %s', name, command))

                            elseif i > 1 then
                                table.insert(order, string.format('||%s %s', name, command))

                            end

                        end

                    end

                elseif name ~= '' and name == player.name then

                    for ii,vv in pairs(party) do

                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and name == vv.name then
                            self = string.format('%s', command)

                        end

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))
            windower.send_command(windower.convert_auto_trans(self))

        elseif c == 'p*' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(3, #table.concat(a, ' '))
            local party     = windower.ffxi.get_party()
            local order     = {}

            for i,v in ipairs(accounts) do
                local name = v

                if name ~= '' and name ~= player.name then
                    
                    for ii,vv in pairs(party) do
                        
                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and name == vv.name then
                            
                            if i == 1 then
                                table.insert(order, string.format('||%s %s', name, command))

                            elseif i > 1 then
                                table.insert(order, string.format('||%s %s', name, command))

                            end

                        end

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))

        elseif c == 'pp' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(4, #table.concat(a, ' '))
            local party     = windower.ffxi.get_party()
            local order     = {}
            local self      = ''
            local delay     = 0

            for i,v in ipairs(accounts) do
                local name = v
                
                if name and name ~= '' and name ~= player.name then
                    
                    for ii,vv in pairs(party) do

                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and vv.name and name == vv.name then
                            
                            if i == 1 then
                                table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                                delay = (delay + gdelay)

                            elseif i > 1 then
                                table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                                delay = (delay + gdelay)

                            end

                        end

                    end

                elseif name and name ~= '' and name == player.name then
                    
                    for ii,vv in pairs(party) do

                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and vv.name and name == vv.name then
                            self = string.format('wait %s; %s', delay, command)
                            delay = (delay + gdelay)

                        end

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))
            windower.send_command(windower.convert_auto_trans(self))

        elseif c == 'pp*' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(4, #table.concat(a, ' '))
            local party     = windower.ffxi.get_party()
            local order     = {}
            local delay     = 0

            for i,v in ipairs(accounts) do
                local name = v
                
                if name and name ~= '' and name ~= player.name then
                    
                    for ii,vv in pairs(party) do

                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and vv.name and name == vv.name then
                            
                            if i == 1 then
                                table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                                delay = (delay + gdelay)

                            elseif i > 1 then
                                table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                                delay = (delay + gdelay)

                            end

                        end

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))

        elseif c == 'z' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(3, #table.concat(a, ' '))
            local party     = windower.ffxi.get_party()
            local zone      = windower.ffxi.get_info().zone
            local order     = {}
            local self      = ''

            for i,v in ipairs(accounts) do
                local name = v

                if name ~= '' and name ~= player.name then
                    
                    for ii,vv in pairs(party) do
                        
                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and name == vv.name and zone == vv.zone then
                            
                            if i == 1 then
                                table.insert(order, string.format('||%s %s', name, command))

                            elseif i > 1 then
                                table.insert(order, string.format('||%s %s', name, command))

                            end

                        end

                    end

                elseif name ~= '' and name == player.name then

                    for ii,vv in pairs(party) do

                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and name == vv.name and zone == vv.zone then
                            self = string.format('%s', command)

                        end

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))
            windower.send_command(windower.convert_auto_trans(self))

        elseif c == 'z' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(3, #table.concat(a, ' '))
            local party     = windower.ffxi.get_party()
            local zone      = windower.ffxi.get_info().zone
            local order     = {}
            local self      = ''

            for i,v in ipairs(accounts) do
                local name = v

                if name ~= '' and name ~= player.name then
                    
                    for ii,vv in pairs(party) do
                        
                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and name == vv.name and zone == vv.zone then
                            
                            if i == 1 then
                                table.insert(order, string.format('||%s %s', name, command))

                            elseif i > 1 then
                                table.insert(order, string.format('||%s %s', name, command))

                            end

                        end

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))

        elseif c == 'zz' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(4, #table.concat(a, ' '))
            local party     = windower.ffxi.get_party()
            local zone      = windower.ffxi.get_info().zone
            local order     = {}
            local self      = ''
            local delay     = 0

            for i,v in ipairs(accounts) do
                local name = v
                
                if name and name ~= '' and name ~= player.name then
                    
                    for ii,vv in pairs(party) do
                        
                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and vv.name and name == vv.name and zone == vv.zone then
   
                            if i == 1 then
                                table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                                delay = (delay + gdelay)

                            elseif i > 1 then
                                table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                                delay = (delay + gdelay)

                            end

                        end

                    end

                elseif name and name ~= '' and name == player.name then
                    
                    for ii,vv in pairs(party) do
                        
                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and vv.name and name == vv.name and zone == vv.zone then
                            self = string.format('wait %s; %s', delay, command)
                            delay = (delay + gdelay)

                        end

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))
            windower.send_command(windower.convert_auto_trans(self))

        elseif c == 'zz*' then
            local player    = windower.ffxi.get_player() or false
            local command   = table.concat(a, ' '):sub(4, #table.concat(a, ' '))
            local party     = windower.ffxi.get_party()
            local zone      = windower.ffxi.get_info().zone
            local order     = {}
            local self      = ''
            local delay     = 0

            for i,v in ipairs(accounts) do
                local name = v
                
                if name and name ~= '' and name ~= player.name then
                    
                    for ii,vv in pairs(party) do
                        
                        if (ii:sub(1,1) == "p" or ii:sub(1,1) == "a") and tonumber(ii:sub(2)) ~= nil and vv.name and name == vv.name and zone == vv.zone then
   
                            if i == 1 then
                                table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                                delay = (delay + gdelay)

                            elseif i > 1 then
                                table.insert(order, string.format('||%s wait %s; %s', name, delay, command))
                                delay = (delay + gdelay)

                            end

                        end

                    end

                end

            end
            windower.send_ipc_message(windower.convert_auto_trans(table.concat(order, ' ')))

        end

    end

end)

windower.register_event('ipc message', function(message)
    local player  = windower.ffxi.get_player()
    local message = message or false

    if player and message then
        order = message:split('||')

        if order then
            
            for _,v in ipairs(order) do

                if v:sub(1, (#player.name)) == player.name then
                    windower.send_command(v:sub(#player.name+2, #v))
                end

            end

        end

    end

end)