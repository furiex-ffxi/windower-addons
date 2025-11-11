do
    local old_pos = {x=0, y=0, z=0} -- Stores last movement location
    local player_buffs = '' -- built string to send to silmaril
    local old_character = nil -- hold the last character data to compare to new
    local player_buff_ids = {} -- This stores the buff and end times
    local motion = false
    local player_data = nil
    local player_id = "0" -- used for when the lua is being unloaded
    local player_pet = nil
    local player_info = nil
    local stop_time = os.time()
    local player_moving = false
    local epoch_ticks = 10
    local server_delta = 0

    function update_player_info()

        player_data = get_player()
        if not player_data then return end

        -- Update the position info
        player_info = get_mob_by_id(player_data.id)

        if not player_info then return end

        -- Process the updated buffs
        validate_buffs()

        -- This is updated at high speed
        local now = os.clock()

        -- Determine if player is moving
        local movement = math.sqrt((player_info.x-old_pos.x)^2 + (player_info.y-old_pos.y)^2 + (player_info.z-old_pos.z)^2 ) > 0.02

        -- Change of state
        if movement and not motion then
	        motion = true
        elseif not movement and motion then
            stop_time = now
	        motion = false
        end

        if not motion and now - stop_time > .25 then 
            player_moving = false
        else
            player_moving = true
        end

        -- Store the old location
   	    old_pos.x = player_info.x
	    old_pos.y = player_info.y
	    old_pos.z = player_info.z

        --target_index
        if not player_data.target_index then
            player_data.target_index = 0
        end

        -- get the world data
        local w = get_world()
        if not w then return end

        local update_character = 
            'silmaril update '..
            player_info.id..' '..
            get_player_name()..' '..
            w.zone..' '..
            player_info.x..' '..
            player_info.y..' '..
            player_info.z..' '..
            player_info.heading..' '..
            player_info.status..' '..
            player_data.target_index

        -- No update to the character found
        if update_character == old_character then return end

        -- Create a player to update the IPC table
        local character = { 
            id = player_info.id,
            name = get_player_name(), 
            zone = w.zone, 
            x = player_info.x, 
            y = player_info.y, 
            z = player_info.z, 
            heading = player_info.heading, 
            status = player_info.status,
            target_index = player_data.target_index}

        -- Update the party table with your information
		set_party_location(character)

        --Send the information to others via IPC
	    send_ipc(update_character)

        -- Update the last message
        old_character = update_character

    end

    -- A built string to send to silmaril with the character information called via Update.lua
    function send_player_update()
        local player_string = "player"

        if not player_data then return player_string end

        local jp_spent = player_data.job_points[player_data.main_job:lower()].jp_spent

        local locked_on = false

        --target_locked
        if player_data.target_locked then
            locked_on = true
        end

        -- No sub job unlocked or Oddy
        if not player_data.sub_job_id then
            player_data.sub_job_id = 0
            player_data.sub_job_level = 0
        end

        -- Update character status
        player_string = 'player_'..
            string.format("%i",player_data.main_job_id)..','..
            string.format("%i",player_data.main_job_level)..','..
            string.format("%i",player_data.sub_job_id)..','..
            string.format("%i",player_data.sub_job_level)..','..
            string.format("%i",jp_spent)..','..
            tostring(locked_on)..','..
            tostring(player_moving)..','..
            tostring(get_following())..','..
            string.format("%i",get_autorun_target())..','..
            string.format("%i",get_autorun_type())..','..
            tostring(get_mirroring())..','..
            tostring(get_injecting())..','

        return player_string
    end

    function player_packet_buffs(original)    
        local packet = parse_packet('incoming', original)
        if not packet then return end
        player_buff_ids = {}
        for i=1,32 do
            local buff = 'Buffs '..i
            local buff_index = 'Time '..i
            if packet[buff] ~= 255 and packet[buff] ~= 0 then
                -- 1009810800 is GMT: Monday, December 31, 2001 3:00:00 PM
                -- 4294967296 is 32 bit for the roll over
                -- server_delta accounts for a pc that is not time sync'd
                local buff_offset = 1009810800 + ( 4294967296 * epoch_ticks + packet[buff_index] ) / 60 - server_delta
                local end_time = os.date('%Y-%m-%dT%H:%M:%S',buff_offset)
                --log('Buff end time ['..end_time..']')

                -- Need to not key off buff ID's because can have multiple of same
                player_buff_ids[i] = { id = packet[buff], time = end_time }
            end
        end
    end

    function get_moving()
		return moving
	end

    function get_player_data()
		return player_data
	end

    function get_player_info()
		return player_info
	end

    function get_player_buffs()
        return 'playerbuffs_'..player_buffs
    end

    function get_player_name()

        -- Something wrong happened here - couldn't find the player
        if not player_data or not player_data.name then log("Player not found") return "Unknown" end

        -- return the normal name if protection off
        if not get_protection() then return player_data.name end

        -- Protection is on so get the reverse name
        local cache = get_name_cache()

        -- No table is set so return default name
        if not cache then log("No name cache set") return player_data.name end

        if cache[player_data.name] then return cache[player_data.name] end

        -- Wasn't found in table so return normal name anyway
        return player_data.name
    end

    function set_player_pet(value)
        player_pet = value
    end

    function get_player_pet()
        return player_pet
    end

    function get_player_id()
        if not player_data or not player_data.id then return '0' end
        return tostring(player_data.id)
    end

    function set_server_offset(timestamp , offset)
        -- Calculates the roll over times for buffs
        local server_time = timestamp - offset
        local roll_over_rate = 4294967296 / 60
        epoch_ticks =  math.floor(server_time / roll_over_rate)
        server_delta = 1009810800 + server_time - os.time()
        --log('Epoch Ticks ['..epoch_ticks..']')
        --log('Server Delta ['..server_delta..']')
    end

    -- Check for held action packet buffs in Packets.lua
    function validate_buffs()

        player_buffs = ''

        -- Build a table of buffs
        local buff_table = {}

        -- Using packet
        if #player_buff_ids > 0 then
            -- Load the player based packet buffs
            for index, value in pairs(player_buff_ids) do
                player_buffs = player_buffs..value.id..','..value.time..'|'
                buff_table[value.id] = true
                -- log('Adding buff ['..value.id..'] from packet')
            end
        -- Fall back to get_player()
        else
            -- store the unknown buff first and append known later
            for index, value in pairs(player_data.buffs) do
                player_buffs = player_buffs..value..',Unknown|'
                buff_table[value] = true
                -- log('Adding buff ['..value..'] from memory')
            end
        end

        -- The intent is to hold buffs from JA's and Spells for 3 seconds until the packet comes from server with the update
        local packet_buffs = get_packet_buffs()
        for index, value in pairs(packet_buffs) do
            if value.id == player_data.id and not buff_table[value.buff] then
                -- Buff is for the player and is not currently in the windower table
                player_buffs = player_buffs..value.buff..',Unknown|'
                log('Adding unique buff ['..value.buff..']')
            end
        end

        player_buffs = player_buffs:sub(1, #player_buffs - 1)
    end
end