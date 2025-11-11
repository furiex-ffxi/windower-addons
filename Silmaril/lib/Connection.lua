do
    -- socket
    local socket = require("socket")
    local udp = nil
    local port = 2025
    local ip = "127.0.0.1"
    local action_packets = {}
    local action_count = 1

    -- Called from the hooks after loaded - Windower.lua or Ashita.lua
    function connect()

        -- via Sync.lua
        initialize() 

        -- Initialization is completed so progress to open up the port
        udp = assert(socket.udp())
        udp:settimeout(0)
        udp:setpeername(ip, port)

        -- start the main proecess via Engine.lua
        main_engine() 
    end

    -- Called from Engine.lua
    function request()
        skillchain_reset()
        update_player_info()
        local request = get_player_id()..";request_".._addon.version..'_'..get_player_name()
        log(request)
        send_packet(request) -- Send directly
    end

    -- Builts a packet to send to silmaril
    function que_packet (msg)
        if msg and get_connected() then
            action_packets[action_count] = msg
            action_count = action_count +1
            log(msg)
        end
    end

    -- Builts a packet to send to silmaril without a log
    function que_packet_silent (msg)
        if msg and get_connected() then
            action_packets[action_count] = msg
            action_count = action_count +1
        end
    end

    --Send the outgoing packet to silmaril
    function send_packet (msg)
        if msg and udp then
            assert(udp:send(msg))
        else
            log('Unable to send data')
        end
    end

    function receive_info()
        repeat
            data, msg = udp:receive()
            if data then

                local message = data:split('_')
                local cmd = message[2]

                -- Check if valid message
                if message[1] ~= get_player_id() then log('Wrong Message ['..cmd..']') return end

                -- Connection established with silmaril
                if cmd == "accepted" then
                    skillchain_reset()
                    info('\31\200[\31\05Silmaril Addon\31\200]\31\207 '..message[3])
                    set_connected(true)

                -- Sync process
                elseif cmd == "sync" then
                    sync_cmd(message[3])

                -- Notify if the versions do not match and unload the addon
                elseif cmd == "version" then
                    info('Version miss match - unloading the in game Lua!')
                    info('The in game lua is ['.._addon.version..'] and the Silmaril version is ['..message[3]..'].')
                    send_command('lua u silmaril')

                -- Reset command from silmaril (Rest Button)
                elseif cmd == "reset" then
                    reset_request(message[3])
                    log(message)

                -- If any character logs - reset the party table.
                elseif cmd == "clear" then
                    clear_party_location()
                    log('Clearing Party Tables')

                -- Turn the addon on
                elseif cmd == "on" then
                    on_cmd(message[3],message[4],message[5])
                    log(message)

                -- Turn the addon off
                elseif cmd == "off" then
                    off_cmd()
                    log(message)

                elseif cmd == "addon" then
                    addon_commands(message) -- via Addons.lua

                elseif cmd == "reposition" then
                    reposition_command(message[3],message[4],message[5],message[6],message[7])
                    log(message)

                -- Display the mirroring results
                elseif cmd == "results" then
                    mirror_results(message[3])

                -- Standard commands from Silmaril
                elseif cmd == "input" then
                    log(data)
                    input_message(message[3],message[4],message[5],message[6],message[7])
                    log(message)

                -- Raw commands that do not require processing
                elseif cmd == "script" then
                    log(data)
                    send_command(to_shift_jis(message[3]))
                    log(message)

                -- Sent the skillchains to watch for
                elseif cmd == "skillchain" then
                    skillchain(message[3],message[4],message[5],message[6])
                elseif cmd == "skillchain2" then
                    skillchain2(message[3],message[4],message[5],message[6])
                elseif cmd == "skillchain3" then
                    skillchain3(message[3],message[4],message[5],message[6])
                elseif cmd == "skillchain4" then
                    skillchain4(message[3],message[4],message[5],message[6])

                -- This process standard settings saved in the Config.xml file
                elseif cmd == "config" then
                    config_msg(message[3])

                -- Load in the mirror black lists
                elseif cmd == "blacklist" then
                    add_black_list(message[3])

                -- This is the list to protect
                elseif cmd == "protectlist" then
                    protectlist(message[3], message[4], message[5], message[6])

                -- Enable protection
                elseif cmd == "protection" then
                    set_protection(message[3])

                end
            end
        until not data
    end

    -- Build the tables for the characters
    function protectlist(param,param2,param3,param4)
        --Parse the message to two tables
        local temp_cache = {}
        for item in string.gmatch(param, "([^,]+)") do
            table.insert(temp_cache, item)
        end

        local temp_reverse = {}
        for item in string.gmatch(param2, "([^,]+)") do
            table.insert(temp_reverse, item)
        end

        -- If the tables match make a combined table
        local name_cache = {}
        local reverse_name_cache = {}
        if #temp_cache == #temp_reverse then
            for i = 1, #temp_cache do
                name_cache[temp_cache[i]] = temp_reverse[i]
                reverse_name_cache[temp_reverse[i]] = temp_cache[i]
            end
        else
            info("Mis-match on Protection Names")
        end

        set_name_cache(name_cache)
        set_reverse_name_cache(reverse_name_cache)

        -- Build the temp LS cache
        temp_cache = {}
        for item in string.gmatch(param3, "([^,]+)") do
            table.insert(temp_cache, item)
        end

        temp_reverse = {}
        for item in string.gmatch(param4, "([^,]+)") do
            table.insert(temp_reverse, item)
        end

        name_cache = {}
        reverse_name_cache = {}
        if #temp_cache == #temp_reverse then
            for i = 1, #temp_cache do
                name_cache[temp_cache[i]] = temp_reverse[i]
                reverse_name_cache[temp_reverse[i]] = temp_cache[i]
            end
        else
            info("Mis-match on Protection Names")
        end

        set_ls_cache(name_cache)
        set_reverse_ls_cache(reverse_name_cache)
    end

    function reset_request(param)
        -- set to reload the file unless a clear is sent
        if param == "clear" then
            log('Clear command Sent')
            set_auto_load(false)
        else
            log('Reset Request')
            set_auto_load(true)
        end
        set_connected(false)
        set_enabled(false)
        set_mirror_on(false)
    end

    -- Updates the display of the mirroring
    function mirror_results(param)
        local all_results = {}
        for item in string.gmatch(param, "([^|]+)") do
            local result = string.split(item,",",2)
            all_results[result[1]] = result[2]
        end
        set_status_time()
        npc_box_status(all_results)
    end

    -- Sets the global environment after start up
    function config_msg(param)
        local commands = {}
        for item in string.gmatch(param, "([^,]+)") do
            table.insert(commands, item)
        end

        -- Toggles Mode of mirroring via Mirroring.lua
        npc_mirror_state(commands[1])

        -- Sets the Dress Up addon reloading via Protection.lua
        set_dressup_enable(commands[2])

        -- Sets the state of random player names via Protection.lua
        set_anon(commands[3])
    end

    function sync_cmd(param)
        if not param then return end
        sync_data(param) -- method called via Sync.lua
    end

    function on_cmd(file,sub,name)
        set_enabled(true)
        if not file then
            file = 'Profile Not Loaded'
        else
            if sub then file = file..'_'..sub end
            if name then file = file..'_'..name end
        end
        info('\31\200[\31\05Silmaril\31\200]\31\207'..' Actions: \31\06[ON]'..' \31\207 Profile: \31\06['..file..']')
    end

    function off_cmd()
        runstop()
        set_enabled(false)
        info('\31\200[\31\05Silmaril\31\200]\31\207'..' Actions: \31\03[OFF]')
    end

    function get_action_packets()
        return action_packets
    end

    function reset_action_packets()
        action_count = 1
        action_packets = {}
    end

    function reposition_command(Zone,X,Y,Z,Rotation)
        log('Repositioning in zone ['..Zone..'] to ['..X..'],['..Y..'], ['..Z..'] with angle ['..Rotation..']')
        local p = get_player_data()
        local world = get_world()
        if not p or not world then return end
        if world.zone ~= tonumber(Zone) then log('Wrong Zone') end
        local packet = new_packet('incoming', 0x065, 
        {
            ['ID'] = p.id,
            ['Index'] = p.index,
            ['Animation'] = 0,
            ['Rotation'] = tonumber(Rotation),
            ['X'] = tonumber(X),
            ['Y'] = tonumber(Y),
            ['Z'] = tonumber(Z),
        })
        packet_log_full(packet,'incoming')
        inject_packet(packet)
    end

end