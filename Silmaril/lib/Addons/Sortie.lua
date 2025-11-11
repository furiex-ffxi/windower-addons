do
    local enabled = true
    local tracking_window = texts.new("", {
			text={size=10,font='Consolas',red=255,green=255,blue=255,alpha=255},
			pos={x=0,y=0},
			bg={visible=true,red=0,green=0,blue=0,alpha=102},})
    local location = 'A'
    local hunt_index = 1
    local bitzer_position = {
            [1] = {name = 'Diaphanous Bitzer (E)', index = 837, x = 0, y = 0, z = 0 , direction = 'NE'},
            [2] = {name = 'Diaphanous Bitzer (F)', index = 838, x = 0, y = 0, z = 0 , direction = 'NE'},
            [3] = {name = 'Diaphanous Bitzer (G)', index = 839, x = 0, y = 0, z = 0 , direction = 'NE'},
            [4] = {name = 'Diaphanous Bitzer (H)', index = 840, x = 0, y = 0, z = 0 , direction = 'NE'}, }
    local mob_tracking = {
            [1] = {name = 'Abject Obdella', index = 144, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [2] = {name = 'Biune Porxie', index = 223, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [3] = {name = 'Cachaemic Bhoot', index = 285, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [4] = {name = 'Demisang Deleterious', index = 373, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [5] = {name = 'Esurient Botulus', index = 427, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [6] = {name = 'Fetid Ixion', index = 498, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [7] = {name = 'Gyvewrapped Naraka', index = 552, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [8] = {name = 'Haughty Tulittia', index = 622, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},}
    local zone_1 = 133
    local zone_2 = 189
    local zone_3 = 275
    local p_loc = nil
    local world = nil
    local position_time = os.clock()
    local repositioned = false
    local repositioned_tick = os.clock()
    local tracking_time = os.clock()
    local display = true

    function sortie_engine()
        if not enabled then return end

        p_loc = get_player_info()
        if not p_loc then return end

        world = get_world()
        if not world then return end

        if world.zone == zone_1 or world.zone == zone_2 or world.zone == zone_3 then
            tracking_update()
        else
            tracking_window:hide()
            log('Turning off Sortie - Wrong Zone')
            enabled = false
            sortie_command('A')
            track_off()
            mob_tracking = {
            [1] = {name = 'Abject Obdella', index = 144, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [2] = {name = 'Biune Porxie', index = 223, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [3] = {name = 'Cachaemic Bhoot', index = 285, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [4] = {name = 'Demisang Deleterious', index = 373, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [5] = {name = 'Esurient Botulus', index = 427, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [6] = {name = 'Fetid Ixion', index = 498, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [7] = {name = 'Gyvewrapped Naraka', index = 552, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},
            [8] = {name = 'Haughty Tulittia', index = 622, distance = 0, direction = 'NE', X = 0, Y = 0, Z = 0},}
            return
        end

        -- Wait till you finish moving to check for area
        if repositioned then
            -- Actively try to get the update
            if os.clock() - repositioned_tick > 2 then
                position_update()
                repositioned_tick = os.clock()
            end
            -- Time out of trying to find the bitzer
            if os.clock() - position_time > 5 then
                repositioned = false
                if world.zone ~= zone_1 and world.zone ~= zone_2 and world.zone ~= zone_3 then return end
                info('Bitzer Check Timed Out')
            end
        end
    end

    function packet_in_0x0F5(data)
        p_loc = get_player_info()
        if not p_loc then return end

        local packet = parse_packet('incoming', data)
        if not packet['X'] or not packet['Y'] or not packet['Index'] then log("Enemy not found") return end

        local enemy_x = packet['X']
        local enemy_y = packet['Y']

        if mob_tracking[hunt_index].index ~= packet['Index'] then log(packet['Index']) return end

        -- Enemy is dead
        if enemy_x == 0 and enemy_y == 0 then
            -- Try to get a new track every 2 sec
            if os.clock() - tracking_time > 2 and os.clock() - position_time < 8 then
                start_track()
            elseif os.clock() - position_time > 8 then
                mob_tracking[hunt_index].distance = 'Dead'
                log('Dead')
                track_off()
            end
            return
        end

        local angle = AngleBetween(enemy_x, enemy_y)
        local direction = GetCardinalForAngle(angle)
        local distance = round(((p_loc.x - enemy_x)^2 + (p_loc.y - enemy_y)^2):sqrt(),1)
        mob_tracking[hunt_index].direction = direction
        mob_tracking[hunt_index].distance = distance
        mob_tracking[hunt_index].X = packet['X']
        mob_tracking[hunt_index].Y = packet['Y']
        mob_tracking[hunt_index].Z = packet['Z']

        --que_packet_silent('sortie_bitzer_'..packet['Index']..'_'..string.format("%.1f",packet['X'])..'_'..string.format("%.1f",packet['Y'])..'_'..string.format("%.1f",packet['Z']))
        --log('Track: ['..mob_tracking[hunt_index].index..'] - ['..string.format("%5.1f",enemy_x)..', '..string.format("%5.1f",enemy_y)..'] and distance of ['..distance..'] and direction of ['..direction..']')
    end

    -- Used to track mobs and objectives
    function tracking_update()
        -- Update the player position
        local maxWidth = 45
        local lines = T{}
        local bitzer_status = {}
        local bitzer_distance = 0
        lines:insert("     //sm sortie X to change floors")
        lines:insert("")
        lines:insert("            Current Area ["..location.."]")
        lines:insert("")
        -- pads the number - this includes decimal point and integer
        if mob_tracking[hunt_index] and mob_tracking[hunt_index].distance ~= 'Dead' then 
            local distance_direction = string.format("%5.1f",mob_tracking[hunt_index].distance)..' - '..mob_tracking[hunt_index].direction   
            lines:insert(" "..mob_tracking[hunt_index].name..string.format('[%s]  ', distance_direction):lpad(' ',maxWidth - string.len(mob_tracking[hunt_index].name)))
        elseif mob_tracking[hunt_index].distance == 'Dead' then 
            lines:insert(" "..mob_tracking[hunt_index].name..string.format('[%s]  ', 'Dead'):lpad(' ',maxWidth - string.len(mob_tracking[hunt_index].name)))
        else
            lines:insert("")
        end
        lines:insert("")
        if location == "A" then
            --Top Floor A
            lines:insert(" Shard #A")
            lines:insert("   Single target magic killing blow 3x")
            lines:insert(" Coffer #A")
            lines:insert("   Kill Abject Obdella")
            lines:insert(" Casket #A1")
            lines:insert("   Kill 5x enemies")
            lines:insert(" Casket #A2")
            lines:insert("   /heal past the #A1 gate")
        elseif location == 'B' then
            -- Top Floor B
            lines:insert(" Shard #B")
            lines:insert("   WS before death on 5x Biune")
            lines:insert(" Coffer #B")
            lines:insert("   Kill Porxie after opening Casket #B1")
            lines:insert(" Casket #B1")
            lines:insert("   Kill 3x Biune < 30 sec")
            lines:insert(" Casket #B2")
            lines:insert("   Open a #B locked Gate")
        elseif location == 'C' then
            -- Top Floor C
            lines:insert(" Shard #C")
            lines:insert("   Magic burst on 3x enemies while alive")
            lines:insert(" Coffer #C")
            lines:insert("   Kill Cachaemic Bhoot < 5 min")
            lines:insert(" Casket #C1")
            lines:insert("   Kill 3x enemies < 15 seconds")
            lines:insert(" Casket #C2")
            lines:insert("   Kill all enemies")
        elseif location == 'D' then
            -- Top Floor D
            lines:insert(" Shard #D")
            lines:insert("   Do a 4-step skillchain on 3x enemies")
            lines:insert(" Coffer #D")
            lines:insert("   Kill 3x enemies after NM")
            lines:insert(" Casket #D1")
            lines:insert("   Kill 6x Demisang of different jobs")
            lines:insert(" Casket #D2")
            lines:insert("   WAR->MNK->WHM->BLM->RDM->THF")
        elseif location == 'E' then
            -- Basement E
            bitzer_distance = round(((p_loc.x - bitzer_position[1].x)^2 + (p_loc.y - bitzer_position[1].y)^2):sqrt(),1)
            local angle = AngleBetween(bitzer_position[1].x, bitzer_position[1].y)
            local direction = GetCardinalForAngle(angle)
            lines:insert(" "..bitzer_position[1].name ..string.format('[%s]  ',string.format("%5.1f",bitzer_distance)..' - '..direction):lpad(' ',maxWidth - string.len(bitzer_position[1].name)))
            lines:insert("")
            lines:insert(" Metal #E")
            lines:insert("   Majority of damage from behind NM")
            lines:insert(" Coffer #E")
            lines:insert("   Kill all Naakuals")
            lines:insert(" Casket #E1")
            lines:insert("   All foes around bitzer (12x)")
            lines:insert(" Casket #E2")
            lines:insert("   All flan (15x)")
        elseif location == 'F' then
            -- Basement F
            bitzer_distance = round(((p_loc.x - bitzer_position[2].x)^2 + (p_loc.y - bitzer_position[2].y)^2):sqrt(),1)
            local angle = AngleBetween(bitzer_position[2].x, bitzer_position[2].y)
            local direction = GetCardinalForAngle(angle)
            lines:insert(" "..bitzer_position[2].name ..string.format('[%s]  ',string.format("%5.1f",bitzer_distance)..' - '..direction):lpad(' ',maxWidth - string.len(bitzer_position[2].name)))
            lines:insert("")
            lines:insert(" Metal #F")
            lines:insert("   Break horn by continuous ws below 20%")
            lines:insert(" Coffer #F")
            lines:insert("   Kill all Naakuals (after re-enter)")
            lines:insert(" Casket #F1")
            lines:insert("   5/5 Empy gear at bitzer")
            lines:insert(" Casket #F2")
            lines:insert("   Defeat all Veela")
        elseif location == 'G' then
            -- Basement G
            bitzer_distance = round(((p_loc.x - bitzer_position[3].x)^2 + (p_loc.y - bitzer_position[3].y)^2):sqrt(),1)
            local angle = AngleBetween(bitzer_position[3].x, bitzer_position[3].y)
            local direction = GetCardinalForAngle(angle)
            lines:insert(" "..bitzer_position[3].name ..string.format('[%s]  ',string.format("%5.1f",bitzer_distance)..' - '..direction):lpad(' ',maxWidth - string.len(bitzer_position[3].name)))
            lines:insert("")
            lines:insert(" Metal #G")
            lines:insert("   Kill Gyvewrapped Naraka")
            lines:insert(" Coffer #G")
            lines:insert("   Bee->Shark->T-Rex->Bird->Tree->Lion")
            lines:insert(" Casket #G1")
            lines:insert("   Target Bizter for 30 sec <6 yalms ")
            lines:insert(" Casket #G2")
            lines:insert("   Kill all Dullahan (19x)")
        elseif location == 'H' then
            -- Basement H
            bitzer_distance = round(((p_loc.x - bitzer_position[4].x)^2 + (p_loc.y - bitzer_position[4].y)^2):sqrt(),1)
            local angle = AngleBetween(bitzer_position[4].x, bitzer_position[4].y)
            local direction = GetCardinalForAngle(angle)
            lines:insert(" "..bitzer_position[4].name ..string.format('[%s]  ',string.format("%5.1f",bitzer_distance)..' - '..direction):lpad(' ',maxWidth - string.len(bitzer_position[4].name)))
            lines:insert("")
            lines:insert(" Metal #H")
            lines:insert("   AoE dmg > 50% on NM")
            lines:insert(" Coffer #H")
            lines:insert("   Bee->Lion->T-Rex->Shark->Bird->Tree")
            lines:insert(" Casket #H1")
            lines:insert("   Leave then enter")
            lines:insert(" Casket #H2")
            lines:insert("   Kill all PLDs")
        end
        lines:insert("")
        tracking_box_refresh(lines)
    end

    -- start tracking a NM
    function track_on(index)
        packet = new_packet('outgoing', 0x0F5, {
            ['Index'] = index,
            ['_junk1'] = 0,
        })
        inject_packet(packet)
        tracking_time = os.clock()
        log('track request for enemy ['..index..']')
    end

    -- stop tracking a NM
    function track_off()
        packet = new_packet('outgoing', 0x0F6, {
            ['_junk1'] = 0,
        })
        inject_packet(packet)
        log('tracking stopped')
    end

    -- NPC Update called from Packets.lua
    function bitzer_Check(data)
        if not repositioned then return end
        local packet = parse_packet('incoming', data)

        if packet['X'] == 0 and packet['Y'] == 0 and packet['Y'] == 0 then return end

        local position = 0

        if packet['Index'] == bitzer_position[1].index then
            position = 1
        elseif packet['Index'] == bitzer_position[2].index then
            position = 2
        elseif packet['Index'] == bitzer_position[3].index then
            position = 3
        elseif packet['Index'] == bitzer_position[4].index then
            position = 4
        else
            return
        end

        -- Update stored position
        bitzer_position[position].x = packet['X']
        bitzer_position[position].y = packet['Y']
        bitzer_position[position].z = packet['Z']
            
        log('Bitzer Found - '..packet['Index']..' ['..packet['X']..'],['..packet['Y']..'],['..packet['Z']..']')
        que_packet('sortie_bitzer_'..packet['Index']..'_'..packet['X']..'_'..packet['Y']..'_'..packet['Z'])
        repositioned = false
    end

    -- Command by user or update called
    function sortie_command(args)
        if not args[1] then return end
        local area = string.gsub(string.upper(args[1]), "%s+", "")
        local old_location = location

        --Top floor
        if args == 'Boss' then
            location = 'Boss'
            coroutine.schedule(track_off, 2)
        elseif args == 'Off' then
            if enabled then info('Setting Display Off') end
            display = false
            track_off()
        elseif args == 'On' then
            if enabled then info('Setting Display On') end
            display = true
        elseif area ~= location then
            location = area
        end

        que_packet('sortie_reposition_'..location)

        -- Start the Tracking if on
        set_sortie_hunt_index(location)
    end

    function start_track()
        if mob_tracking[hunt_index].index then
            track_on(mob_tracking[hunt_index].index)
        end
    end

    -- Repositioning called from Packets.lua
    function sortie_position()
        position_time = os.clock()
        repositioned_tick = os.clock()
        repositioned = true
    end

    -- Called periodically to try to ping for basement bitzer
    function position_update()
        -- Zone E
        if location == 'E' then
            local packet = new_packet('outgoing', 0x016, {['Target Index'] = bitzer_position[1].index })
            inject_packet(packet)
            packet_log(packet, "out")
        -- Zone F
        elseif location == 'F' then
            local packet = new_packet('outgoing', 0x016, {['Target Index'] = bitzer_position[2].index })
            inject_packet(packet)
            packet_log(packet, "out")
        -- Zone G
        elseif location == 'G' then
            local packet = new_packet('outgoing', 0x016, {['Target Index'] = bitzer_position[3].index })
            inject_packet(packet)
            packet_log(packet, "out")
        -- Zone H
        elseif location == 'H' then
            local packet = new_packet('outgoing', 0x016, {['Target Index'] = bitzer_position[4].index })
            inject_packet(packet)
            packet_log(packet, "out")
        else
            repositioned = false
        end
    end

    function reposition_packet(packet)
        -- Main
        if packet['X'] == -836 and packet['Y'] == -20 and packet['Z'] == -178 then
            sortie_command('A')

        -- A Bitzer
        elseif packet['X'] == -460 and packet['Y'] == 96 and packet['Z'] == -150 then
            sortie_command('A')
        -- Ghatjot Exit
        elseif packet['X'] == -900 and packet['Y'] == 416 and packet['Z'] == -200 then
            sortie_command('A')

        -- B Bitzer
        elseif packet['X'] == -344 and packet['Y'] == -20 and packet['Z'] == -150 then
            sortie_command('B')
        -- Leshonn Exit
        elseif packet['X'] == -24 and packet['Y'] == 420 and packet['Z'] == -200 then
            sortie_command('B')

        -- C Bitzer
        elseif packet['X'] == -460 and packet['Y'] == -136 and packet['Z'] == -150 then
            sortie_command('C')
        -- Skomora Exit
        elseif packet['X'] == -20 and packet['Y'] == -456 and packet['Z'] == -200 then
            sortie_command('C')

        -- D Bitzer
        elseif packet['X'] == -576 and packet['Y'] == -20 and packet['Z'] == -150 then
            sortie_command('D')
        -- Aita Exit
        elseif packet['X'] == -896 and packet['Y'] == -460 and packet['Z'] == -200 then
            sortie_command('D')

        -- E Basement Enter
        elseif packet['X'] == 580 and packet['Y'] == 31.5 and packet['Z'] == 100 then
            sortie_command('E')
            sortie_position()
        -- Dhartok Exit
        elseif packet['X'] == 280 and packet['Y'] == 276 and packet['Z'] == 70 then
            sortie_command('E')
        -- E Basement Exit
        elseif packet['X'] == -460 and packet['Y'] == 35.5 and packet['Z'] == -140 then
            sortie_command('A')

        -- F Basement Enter
        elseif packet['X'] == 631.5 and packet['Y'] == -20 and packet['Z'] == 100 then
            sortie_command('F')
            sortie_position()
        -- Gartell Exit
        elseif packet['X'] == 876 and packet['Y'] == 280 and packet['Z'] == 70 then
            sortie_command('F')
        -- F Basement Exit
        elseif packet['X'] == -404.5 and packet['Y'] == -20 and packet['Z'] == -140 then
            sortie_command('B')

        -- G Basement Enter
        elseif packet['X'] == 580 and packet['Y'] == -71.5 and packet['Z'] == 100 then
            sortie_command('G')
            sortie_position()
        -- Triboulex Exit
        elseif packet['X'] == 880 and packet['Y'] == -316 and packet['Z'] == 70 then
            sortie_command('G')
        -- G Basement Exit
        elseif packet['X'] == -460 and packet['Y'] == -75.5 and packet['Z'] == -140 then
            sortie_command('C')

        -- H Basement Enter
        elseif packet['X'] == 528.5 and packet['Y'] == -20 and packet['Z'] == 100 then
            sortie_command('H')
            sortie_position()
        -- Aita Exit
        elseif packet['X'] == 284 and packet['Y'] == -320 and packet['Z'] == 70 then
            sortie_command('H')
        -- H Basement Exit
        elseif packet['X'] == -515.5 and packet['Y'] == -20 and packet['Z'] == -140 then
            sortie_command('D')

        -- Boss Enter
        elseif packet['X'] == 624 and packet['Y'] == -620 and packet['Z'] == 100 then
            log('Enter Boss Room - Turning off Display')
            sortie_command('Boss')

        -- Aminon Boss
        elseif packet['X'] == 184 and packet['Y'] == -660 and packet['Z'] == 100 then
            log('Enter Boss Room - Turning off Display')
            sortie_command('Boss')
        -- Aminon Exit
        elseif packet['X'] == 186.5 and packet['Y'] == -20 and packet['Z'] == 60 then
            sortie_command('E')
        end
    end

    function set_sortie_display(value)
        display = value
    end

    function set_sortie_enabled(value)
        enabled = value
    end

    -- Sortie tracking box
	function tracking_box_refresh(lines)
        if display and location ~= 'Boss' and enabled then
		    local maxWidth = 41
            for i,line in ipairs(lines) do lines[i] = lines[i]:rpad(' ', maxWidth) end
            tracking_window:text(lines:concat('\n'))
            tracking_window:show()
        else
            tracking_window:hide()
        end
	end

    function get_sortie_window()
		return tracking_window
	end

    function set_sortie_hunt_index(value)
        position_time = os.clock()
        tracking_time = os.clock()
        local mob_index = {['A'] = 1, ['B'] = 2, ['C'] = 3, ['D'] = 4, ['E'] = 5, ['F'] = 6, ['G'] = 7, ['H'] = 8 }
        if mob_index[value] then
		    hunt_index = mob_index[value]
            if enabled and display then
                if value ~= hunt_index then
                    send_to_chat(8,'The Hunt begins for the ['..mob_tracking[hunt_index].name..']....')
                end
                start_track() 
            end
        end
	end

	function set_sortie_window(value)
		tracking_window = value
	end

    function sortie_delay_start()
        log('Turning on Sortie')
        sortie_command('A')
        enabled = true
    end

    function sortie_command_input(message)
        if not world then return end
        if world.zone ~= zone_1 and world.zone ~= zone_2 and world.zone ~= zone_3 then return end
        -- Commands start at 5
        if message[5] == 'nm' then
            local mob_index = {['A'] = 1, ['B'] = 2, ['C'] = 3, ['D'] = 4, ['E'] = 5, ['F'] = 6, ['G'] = 7, ['H'] = 8 }
            local warp_index = mob_index[message[6]]
            if not warp_index then return end
            if mob_tracking[warp_index].X == 0 and mob_tracking[warp_index].Y == 0 and mob_tracking[warp_index].Z == 0 then 
                info('Track the enemy first!') 
                return 
            end
            local zone = world.zone
            local X = mob_tracking[warp_index].X
            local Y = mob_tracking[warp_index].Y
            local Z = mob_tracking[warp_index].Z
            reposition_command(zone, X, Y, Z, 0)
        elseif message[5] == 'track' then
            set_sortie_hunt_index(message[6])
        elseif message[5] == "warp" then
            sortie_command(message[6])
            sortie_position()
        end
    end

    -- Turn tracking on if enabled
    track_off()

end