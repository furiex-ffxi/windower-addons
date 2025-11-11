do
    local last_sequence_in = {
        ['0x009'] = {},
        ['0x032'] = {},
        ['0x033'] = {},
        ['0x034'] = {},
        ['0x03E'] = {},
        ['0x052'] = {},
        ['0x05C'] = {},
        ['0x065'] = {},}
    local last_sequence_out = {
        ['0x036'] = {},
        ['0x05B'] = {},
        ['0x05C'] = {},
        ['0x083'] = {},}
    local server_position = {x=0, y=0}
    local packet_buffs = {}

    --Remove all of this and just return the functions.
    function message_in(id, data)
        if id == 0x009 then -- Standard Message
            return packet_in_0x009(data)
        elseif id == 0x00A then -- Zone In
            return packet_in_0x00A(data)
        elseif id == 0x00B then -- Zone Response
            return packet_in_0x00B(data)
        elseif id == 0x00D then -- PC Update
            return packet_in_0x00D(data)
        elseif id == 0x00E then -- NPC Update
            return packet_in_0x00E(data)
        elseif id == 0x017 then -- Chat
            return packet_in_0x017(data)
        elseif id == 0x028 then -- Action
            return packet_in_0x028(data)
        elseif id == 0x029 then -- Action Message
            return packet_in_0x029(data)
        elseif id == 0x032 then -- NPC Interaction
            return packet_in_0x032(data)
        elseif id == 0x033 then  -- NPC Interaction
            return packet_in_0x033(data)
        elseif id == 0x034 then  -- NPC Interaction
            return packet_in_0x034(data)
        elseif id == 0x037 then -- Update Character
            return packet_in_0x037(data)
        elseif id == 0x038 then -- Entity Animation
            return packet_in_0x038(data)
        elseif id == 0x03E then  -- Open Buy/Sell
            return packet_in_0x03E(data)
        elseif id == 0x03F then  -- Shop Response
            return packet_in_0x03F(data)
        elseif id == 0x052 then -- NPC Release
            return packet_in_0x052(data)
        elseif id == 0x053 then -- System Messages
            return packet_in_0x053(data)
        elseif id == 0x05C then -- Dialog information
            return packet_in_0x05C(data)
        elseif id == 0x063 then -- Player buff duration
            return packet_in_0x063(data)
        elseif id == 0x065 then -- Repositioning
            return packet_in_0x065(data)
        elseif id == 0x068 then -- Pet Status Update
            return packet_in_0x068(data)
        elseif id == 0x076 then -- Buffs
            return run_buffs(data) -- via Buffs.lua
        elseif id == 0x0F5 then -- Widescan tacking packet
            return packet_in_0x0F5(data) -- via Sortie.lua
        elseif id == 0x0F9 then -- Reraise Dialog
            return packet_in_0x0F9(data)
        end
    end

    function message_out(id, data)
        if id == 0x01A then -- Action
            return packet_out_0x01A(data)
        elseif id == 0x00D then -- Leaving Zone
            return packet_out_0x00D(data)
        elseif id == 0x05B then  -- User dialog
            return packet_out_0x05B(data)
        elseif id == 0x05C then  -- Warp request
            return packet_out_0x05C(data)
        elseif id == 0x05E then -- Zone Line
            return packet_out_0x05E(data)
        elseif id == 0x015 then -- Player Update
            return packet_out_0x015(data)
        elseif id == 0x036 then -- Menu Item (Trade)
            return packet_out_0x036(data)
        elseif id == 0x083 then -- Buy Item
            return packet_out_0x083(data)
        elseif id == 0x0B5 then -- Speech
            return packet_out_0x0B5(data)
        elseif id == 0x0B6 then -- Speech
            return packet_out_0x0B6(data)
        end
    end

    -----------------------------------------------------------------------
    --------------------------- MESSAGES IN ------------------------------
    -----------------------------------------------------------------------

    -- Standard Message
    function packet_in_0x009(data)
        --Check to make sure you not in the process of buying an item
        if get_buy_sell() and get_mid_inject() then
            local packet = check_incoming_sequence('0x009', data)
            if not packet then return true end
            log('Buy Sell continue')
            npc_inject()
        end
    end

    -- Zone In
    function packet_in_0x00A(data)
        local packet = parse_packet('incoming', data)
        if not packet then return end
        local zone = get_res_all_zones()[packet['Zone']]
        if not zone then return end
        --Zoned into sortie
        if zone.en == "Outer Ra'Kaznar [U1]" or zone.en == "Outer Ra'Kaznar [U2]" or zone.en == "Outer Ra'Kaznar [U3]" then
            log('Sortie zone detected')
            if packet['X'] == -940 and packet['Y'] == -20 and packet['Z'] == -191.5 then
                log('Zoning into Sortie - Enable')
                coroutine.schedule(sortie_delay_start, 3)
            end
        end
    end

    -- Zone Response
    function packet_in_0x00B(data)
        -- Turn off move_to_exit
        zone_completed()
        -- Reload dress up if it hasn't been
        if get_dressup() and get_protection() then
            set_dressup(false)
            send_command("lua u dressup;wait 1;lua l dressup")
        end
    end

    -- PC Update 
    function packet_in_0x00D(data)
    end

    -- NPC Update
    function packet_in_0x00E(data)
        local w = get_world()
        if not w then return end
        local zone = get_res_all_zones()[w.zone]
        if not zone then return end
        --Sortie.lua Addon for bitzer locations
        if zone.en == "Outer Ra'Kaznar [U1]" or zone.en == "Outer Ra'Kaznar [U2]" or zone.en == "Outer Ra'Kaznar [U3]" then
            bitzer_Check(data)
        end
    end

    -- Chat
    function packet_in_0x017(data)
    end

    -- [1] = 'Melee attack',
    -- [2] = 'Ranged attack finish',
    -- [3] = 'Weapon Skill finish',
    -- [4] = 'Casting finish',
    -- [5] = 'Item finish',
    -- [6] = 'Job Ability',
    -- [7] = 'Weapon Skill start',
    -- [8] = 'Casting start',
    -- [9] = 'Item start',
    -- [11] = 'NPC TP finish',
    -- [12] = 'Ranged attack start',
    -- [13] = 'Avatar TP finish',
    -- [14] = 'Job Ability DNC',
    -- [15] = 'Job Ability RUN',

    -- Action
    function packet_in_0x028(data)

        if not get_connected() then return end

        local packet = parse_action_packet(data)

        -- Player actions
        if tostring(packet.actor_id) == get_player_id() then

            -- [2] = 'Ranged attack finish'
            if packet.category == 2 and packet.param == 26739 then
                local particle = 'false'
                if get_hover_shot_particle() then particle = "true" end
                que_packet('shooting_finished_2_Ranged Attack_'..packet.targets[1].id..'_'..particle)
                log("PACKET: Shooting Finished")
                hover_distance()
                local pos = {x = server_position.x, y = server_position.y}
                set_last_shot_pos(pos)
                set_hover_shot_particle(false)

            -- [3] = 'Weapon Skill finish'
            elseif packet.category == 3 and packet.param ~= 0 then
                local ws = get_weaponskill(packet.param)
                if ws then
                    local particle = 'false'
                    if get_hover_shot_particle() then particle = "true" end
                    que_packet('weaponskill_finished_'..ws.id..'_'..ws.en..'_'..packet.targets[1].id..'_'..particle)
                    log("PACKET: Weaponskill Finished")
                    -- Check for Hover shot
                    if ws.skill == 26 or ws.skill == 25 then 
                        hover_distance() 
                        local pos = {x = server_position.x, y = server_position.y}
                        set_last_shot_pos(pos)
                        set_hover_shot_particle(false)
                    end
                end

            -- [4] = 'Casting finish'
            elseif packet.category == 4 then
                que_packet('casting_finished_'..packet.param..'_'..packet.targets[1].id..'_'..packet.targets[1].actions[1].message..'_'..packet.recast)
                log('PACKET: Casting has finished')

            -- [5] = 'Item finish'
            elseif packet.category == 5 then
                que_packet('item_finished')
                log("PACKET: Item Finished")

            -- [6] = 'Job Ability'
            elseif packet.category == 6 then
                local option = "0"
			    local ability = get_ability(packet.param)
			    if ability then
                    -- For Corsair's JA Phantom Roll
                    if packet.targets[1].actions[1].param then option = packet.targets[1].actions[1].param end
                    que_packet('jobability_blocked_'..ability.id..'_'..ability.en..'_'..packet.targets[1].id..'_'..option)
                    log('PACKET: Job Ability ['..ability.en..'] on Target ['..packet.targets[1].id..'] with Option ['..option..']')
			    end

            -- [7] = 'Weapon Skill start'
            elseif packet.category == 7 then

            -- [8] = 'Casting start'
            elseif packet.category == 8 then

                -- Spell Intrupted
                if packet.param == 28787 then 
                    if packet.targets[1].actions[1].param ~= 0 then
					    local spell = get_spell(packet.targets[1].actions[1].param)
                        if spell then
                            que_packet('casting_interrupted_'..spell.id..'_'..spell.en..'_'..packet.targets[1].id)
                            log("PACKET: Casting was interrupted")
                        end
                    end

                -- Casting Spell
                elseif packet.param == 24931 then 
                    if packet.targets[1].actions[1].param ~= 0 then
					    local spell = get_spell(packet.targets[1].actions[1].param)
					    if spell then
                            que_packet('casting_blocked_'..spell.id..'_'..spell.en..'_'..packet.targets[1].id..'_'..string.format("%.2f",spell.cast_time + 2.1))
                            log('PACKET: Casting Spell ['..spell.en..'] on target '..packet.targets[1].id)
					    end
				    end
                end

            -- [9] = 'Item start'
            elseif packet.category == 9 then
                if packet.param == 28787 then
                    que_packet('item_interrupted')
                    log("PACKET: Item use interrupted")
                else
                    que_packet('item_blocked')
                    log("PACKET: Item use started")
                end

             -- [14] = 'DNC or RUN ability'
            elseif packet.category == 14 or packet.category == 15 then
                local option = packet.targets[1].actions[1].message
			    local ability = get_ability(packet.param)
			    if ability then
                    que_packet('jobability_blocked_'..ability.id..'_'..ability.en..'_'..packet.targets[1].id..'_'..option..'_'..packet.targets[1].actions[1].param)
                    log('PACKET: Ability ['..ability.en..'], Target ['..packet.targets[1].id..'], Message ['..option..'], param ['..packet.targets[1].actions[1].param..']')
			    end

            -- [12] = 'Ranged attack start'
            elseif packet.category == 12 then
                if packet.param == 24931 then -- shooting
                    que_packet('shooting_blocked_2_Ranged Attack_'..packet.targets[1].id)
                    log("PACKET: Shooting")

                elseif packet.param == 28787 then -- interrupted
                    que_packet('shooting_interrupted_2_Ranged Attack_'..packet.targets[1].id)
                    log("PACKET: Shooting interrupted")
                end
            end
        end

        -- NPC, Enemy, or out of party buffs
        if packet.category == 3 or packet.category == 4 or packet.category == 5 or packet.category == 6 or packet.category == 11 or packet.category == 13 or packet.category == 14 then 
            local buff_gain = S{82,127,141,160,164,166,186,194,203,205,230,236,237,242,243,266,267,268,269,270,271,272,277,278,279,280,319,320,374,375,412,519,520,521,591,645,754,755}
            local buff_wear = S{64,83,123,159,168,204,206,321,322,341,342,343,344,350,351,378,453,531,647,806} 

            for index, target in pairs(packet.targets) do
                if target.id and target.actions[1].message and target.actions[1].param then
                    local buff = target.actions[1].param

                    -- Handles the dazes for DNC
                    if packet.category == 14 and buff_gain[tonumber(target.actions[1].message)] then
                        local ability = get_ability(packet.param)
                        local daze = get_buff(ability.status)
                        if daze and daze.id then buff = daze.id..'|'..target.actions[1].param end
                    end

                    if buff_gain[tonumber(target.actions[1].message)] then 
                        que_packet('packet_statusgains_'..buff..'_'..target.id)

                    -- Buff Wear
                    elseif buff_wear[tonumber(target.actions[1].message)] then 
                        que_packet('packet_statuswears_'..buff..'_'..target.id)
                    end
                end
            end
        end

        -- Trigger Section

        -- [3] = 'Weapon Skill finish'
        if packet.category == 3 and packet.param ~= 0 then

            -- Check if its an enemy or trust
            local mob_array = get_all_enemies()

            -- Process the action
            if packet.param and packet.actor_id and packet.targets and packet.targets[1].id and mob_array then

                -- Make a list of all the targets
                local target_list = ''
                local result_list = ''
                for index, target in pairs(packet.targets) do
                    if target.id then 
                        target_list = target_list..target.id..'|' 
                        result_list = result_list..target.actions[1].message..'|' 
                    end
                end
                target_list = target_list:sub(1, #target_list - 1)
                result_list = result_list:sub(1, #result_list - 1)

                if mob_array[packet.actor_id] and mob_array[packet.actor_id].spawn_type ~= 1 then
                    que_packet('packet_npcend_'..packet.param..'_'..packet.actor_id..'_'..target_list..'_'..result_list)
                else
                    if packet.targets[1].actions[1].message == 110 then
                        que_packet('packet_abilityend_'..packet.param..'_'..packet.actor_id..'_'..target_list..'_'..result_list)
                    else
                        que_packet('packet_weaponskillend_'..packet.param..'_'..packet.actor_id..'_'..target_list..'_'..result_list)
                    end
                end
            end

            -- Process the skillchain and magic bursts if needed
            local alliance_ids = get_alliance_ids()
            if alliance_ids[packet.actor_id] then
                run_ws_skillchain(packet, "Player")
                run_burst(packet)
            end

        -- [4] = 'Casting finish
        elseif packet.category == 4 then
            
            -- Process the action
            if packet.param and packet.actor_id and packet.targets then

                -- Make a list of all the targets
                local target_list = ''
                local result_list = ''
                local alliance_party = get_alliance_ids()
                local now = os.clock()

                -- Determine if the move has a status associated with it
                local spell = get_spell(packet.param)

                for index, target in pairs(packet.targets) do
                    if target.id then 
                        target_list = target_list..target.id..'|' 
                        result_list = result_list..target.actions[1].message..'|' 
                    end

                    -- Used to store the buff
                    if alliance_party and alliance_party[target.id] and spell and spell.status then
                       local buff = { id = target.id, buff = spell.status, time = now }
                       table.insert(packet_buffs, buff)
                    end
                end

                target_list = target_list:sub(1, #target_list - 1)
                result_list = result_list:sub(1, #result_list - 1)
                que_packet('packet_spellend_'..packet.param..'_'..packet.actor_id..'_'..target_list..'_'..result_list)

            end

            -- Monitor others for Immanence and Skillchains
            local alliance_ids = get_alliance_ids()
            if alliance_ids[packet.actor_id] then
                run_spell_check(packet)
                run_burst(packet)
                local no_effect = S{75,653,654,655,656,66,85,284}
                local message = tonumber(packet.targets[1].actions[1].message)
                if message and not no_effect[message] then
                    corsair_shot(packet)
                end
            end

        -- [6] = 'Job Ability Finish'
        elseif packet.category == 6 or packet.category == 14 or packet.category == 15 then
            
            if not packet.param or not packet.targets or not packet.actor_id then return end

            -- Check if its an enemy or trust
            local monster_ability = false
            local ability = get_ability(packet.param)

            if not ability then
                ability = get_monster_ability(packet.param)
                if ability then
                    monster_ability = true    
                else
                    log('Cat 6: Unable to parse ['..packet.param..'] ability.')
                    return
                end
            end

            -- Make a list of all the targets
            local target_list = ''
            local result_list = ''
            local alliance_party = get_alliance_ids()
            local now = os.clock()

            -- Determine if the move has a status associated with it
            local status = nil
            if ability.status then 
                status = ability.status
            else
                local ability_map = get_ability_maps()[packet.param]
                if ability_map then status = ability_map end
            end

            for index, target in pairs(packet.targets) do
                if target.id then 
                    target_list = target_list..target.id..'|' 
                    result_list = result_list..target.actions[1].message..'|' 
                end

                -- Used to store the buff for two seconds before removing it
                if status and alliance_party and alliance_party[target.id] then
                    local buff = { id = target.id, buff = status, time = now }
                    table.insert(packet_buffs, buff)
                end
            end
            target_list = target_list:sub(1, #target_list - 1)
            result_list = result_list:sub(1, #result_list - 1)

            if monster_ability then
                que_packet('packet_npcend_'..packet.param..'_'..packet.actor_id..'_'..target_list..'_'..result_list)
            else
                que_packet('packet_abilityend_'..packet.param..'_'..packet.actor_id..'_'..target_list..'_'..result_list)
            end

        -- [7] = 'Weaponskill Start'
        elseif packet.category == 7 then
        
            if not packet.param and packet.param ~= 24931 or not packet.targets or not packet.actor_id then return end

            local action_param = packet.targets[1].actions[1].param

            if action_param ~= 0 then
                -- Check if its an enemy or trust
                local monster_tp = false
                local ws = get_weaponskill(action_param)

                if not ws then
                    ws = get_monster_ability(action_param)
                    if ws then
                        monster_tp = true    
                    else
                        log('Cat 7: Unable to parse ['..action_param..'] weaponskill.')
                        return
                    end
                end

                if monster_tp then
                    que_packet('packet_npcstart_'..ws.id..'_'..packet.actor_id..'_'..packet.targets[1].id)
                else
                    que_packet('packet_weaponskillstart_'..ws.id..'_'..packet.actor_id..'_'..packet.targets[1].id)
                end
            end

        -- [8] = 'Casting Start'
        elseif packet.category == 8 then
        
            if not packet.param and packet.param ~= 24931 then return end

            -- Process the action
            if packet.actor_id and packet.targets[1].actions[1].param then
                que_packet('packet_spellstart_'..packet.targets[1].actions[1].param..'_'..packet.actor_id..'_'..packet.targets[1].id)
            end

        -- [11] = 'NPC TP finish',
        elseif packet.category == 11 and packet.param ~= 0 then

            -- Process the action
            if packet.actor_id and packet.targets then

                -- Make a list of all the targets
                local target_list = ''
                local result_list = ''
                for index, target in pairs(packet.targets) do
                    if target.id then 
                        target_list = target_list..target.id..'|' 
                        result_list = result_list..target.actions[1].message..'|' 
                    end
                end
                target_list = target_list:sub(1, #target_list - 1)
                result_list = result_list:sub(1, #result_list - 1)

                que_packet('packet_npcend_'..packet.param..'_'..packet.actor_id..'_'..target_list..'_'..result_list)
            end

            -- NPC TP Finish (Trusts)
            local party_ids = get_party_ids()
            if party_ids and party_ids[packet.actor_id] then
                run_ws_skillchain(packet, "NPC")
                run_burst(packet)
            end

        -- [13] = 'Avatar TP finish',
        elseif packet.category == 13 then

            -- Process the action
            if packet.param and packet.actor_id and packet.targets then

                -- Make a list of all the targets
                local target_list = ''
                local result_list = ''
                for index, target in pairs(packet.targets) do
                    if target.id then 
                        target_list = target_list..target.id..'|' 
                        result_list = result_list..target.actions[1].message..'|' 
                    end
                end
                target_list = target_list:sub(1, #target_list - 1)

                que_packet('packet_avatar_'..packet.param..'_'..packet.actor_id..'_'..target_list..'_'..result_list)
            end

            -- Avatar TP Finish
            local party_ids = get_party_ids()
            if party_ids and party_ids[packet.actor_id] then
                run_ws_skillchain(packet, "Avatar")
                run_burst(packet)
            end
        end
    end

    -- Action Message
    function packet_in_0x029(data)
        local packet = parse_packet('incoming', data)
        if not packet then return end
        local buff_wear = S{64,204,206,321,322,341,342,343,344,350,351,378,531,647}    
        if packet['Message'] == 48 then -- Reraise Fail
            que_packet('packet_castfail_'..packet['Param 1']..'_'..packet['Target'])
        elseif packet['Message'] == 234 then -- Auto Target
            que_packet('packet_autotarget_'..packet['Target Index'])
        elseif buff_wear:contains(tonumber(packet['Message'])) then -- Buff Wear
            que_packet('packet_statuswears_'..packet['Param 1']..'_'..packet['Target'])
        end
    end

    -- NPC Interaction Type 1
    function packet_in_0x032(data)
    set_interaction_type("Type 1")
        if process_NPC(data, '0x032') then return true end
    end

    -- String NPC Interaction
    function packet_in_0x033(data)
    set_interaction_type("Type String")
        if process_NPC(data, '0x033') then return true end
    end

    -- NPC Interaction Type 2
    function packet_in_0x034(data)
    set_interaction_type("Type 2")
        if process_NPC(data, '0x034') then return true end
    end

    function process_NPC(data, type)
        -- This is in response to the client sending a Action packet to start interaction.
        local packet = parse_packet('incoming', data)
        if not packet then return end

        -- Store a temp menu ID to cancel the active dialog for warps/doors
        set_temp_menu_id(packet['Menu ID'])
        
        log('Menu ID ['..packet['Menu ID']..']')

        log(packet)
        log(type)

        -- Block the menu on a trade
        if get_trade() and not get_mirroring() then npc_inject() log('got here') return true end

        -- Non standard way to start a mirror (clears so set menu after)
        if get_mirror_on() and not get_mirroring() then

            if not check_incoming_sequence(type,data) then return true end

            log("interact called "..type)
            packet['Target'] = packet['NPC']
            local p = get_player_data()
            for index, value in ipairs(p.buffs) do
                if value == 254 then log('Battle Field Exit') clear_npc_data() return end
            end
            npc_mirror_start(packet)
        end

        if get_injecting() and not get_mid_inject() then

            if not check_incoming_sequence(type,data) then return true end

            -- Assign the Menu ID
            set_menu_id(packet['Menu ID'])
            set_interaction_type("Type 1")

            if get_mirror_message()[1] ~= "Poke" then
                -- Menu will be blocked so you can go ahead and start sending the messages
                log('npc_inject() called from '..type..' with Menu ID of ['..get_menu_id()..']')
                npc_inject()

                --Blocks the menu
                log('Blocking on the '..type..' Packet')
                return true
            else
                log('Poke Detected')
                clear_npc_data()
            end
        end

        -- Augmentation addon
        if get_augmentation_enabled() and type == '0x034' then if augmentation_npc_response(packet) then return true end end

    end

    -- Update Character
    function packet_in_0x037(data)
        local packet = parse_packet('incoming', data)
        if not packet then return end

        -- Used to calculate relative time
        set_server_offset(packet['Timestamp'],packet['Time offset?']/60)

        -- Player is in a menu
        if packet['Status'] == 4 then 
            -- Player has mirroring enabled
            if get_mirror_on() and not get_mirroring() and not get_blacklisted() and get_menu_id() then
                -- Start recording as the player has entered a menu with mirroring enabled
                -- This is not a normal sequence as an action packet should have turned on Mirroring
                -- Porter prompts and other non-user interactions cause this
                log("Mirror sequence started via [0x037] packet")
                set_mirroring(true)
            end
        else
            -- Released from NPC while a player was sending a packet stream so send the result to silmaril
            if get_injecting() and os.clock() - get_message_time() > 2 then
                -- If all messages were sent report success
                local msg = get_mirror_message()
                if not msg or #msg == 0 then 
                    log("Player is released from menu")
                    que_packet("mirror_status_completed")
                    set_injecting(false)
                end
            end
        end

        local p = get_player_data()
        if not p then return end

        -- This to handle where the client and server are out of sync
        if packet['Status'] == 0 and p.status == 1 then
            -- Send a disengage packet since not attacking acording to server
            log(p.name.." is not attacking according to server via [0x037] packet")
            que_packet('packet_noattack')
        end
    end

    -- Entity Animation
    function packet_in_0x038(data)
        local packet = parse_packet('incoming', data)
        if not packet then return end

        if tostring(packet.Mob) == get_player_id() then
            if packet.Type == "hov1" then
                set_hover_shot_particle(true)
            else
                set_hover_shot_particle(false)
            end
        end
    end

    -- Open Buy/Sell Menu
    function packet_in_0x03E(data)

        -- Set the mode when you are generating a mirror
        if get_mirror_on() and get_mirroring() then
            if not check_incoming_sequence('0x03E',data) then return true end
            log('Shop Response - Mirror mode is purchasing')
            set_buy_sell(true)
        end

        -- Block the menu if you are mirroring a transaction
        if get_injecting() then
            if not check_incoming_sequence('0x03E',data) then return true end
            log("Blocking on the 0x03E Packet [Buy/Sell Menu]")
            set_buy_sell(true)
            return true
        end
    end

    -- Shop buy response
    function packet_in_0x03F(data)
        -- Continue the injecting
        if get_injecting() then
            log("Shop Response 0x03F Packet [Buy/Sell Menu]")
            npc_inject()
        end
    end

    -- NPC Release
    function packet_in_0x052(data)

        -- Run the check if the mirror is completed
        if get_injecting() and not get_block_release() then
            local packet = check_incoming_sequence('0x052',data)
            if not packet then return true end
            npc_in_release(packet)
        end

        -- This tells us the Server released the player - next should follow a status from 4 -> 0
        -- The engine is used to make this determination
        if get_mirroring() then
            local packet = check_incoming_sequence('0x052',data)
            if not packet then return true end
            log("Setting mirror_release to true")
            set_mirror_release(true)
        end
    end

    -- System Messages
    function packet_in_0x053(data)
        local packet = parse_packet('incoming', data)
        if not packet then return end
        if packet['Message ID'] == 300 then
            que_packet('system_enmity')
        elseif packet['Message ID'] == 299 then
            que_packet('system_duplicate')
        end
    end

    -- Dialog information response
    function packet_in_0x05C(data)
        log('Incoming 0x05C')
        if get_augmentation_enabled() then start_oseem(data) end -- Augmentation addon
        if not get_injecting() then return end
        if not check_incoming_sequence('0x05C',data) then return true end
        log('npc_inject() called from [0x05C]')
        npc_inject()
    end

    -- Player buff duration
    function packet_in_0x063(data)
        if data:byte(0x05) ~= 0x09 then return end
        -- Process the buffs via the Player.lua
        player_packet_buffs(data) 
    end

    -- Repositioning
    function packet_in_0x065(data)
        -- Turn off force warps if on
        set_force_warp(false)
        local packet = check_incoming_sequence('0x065', data)
        if not packet then return end
        local w = get_world()
        if not w then return end
        local zone = get_res_all_zones()[w.zone]
        if not zone then return end

        log('Repositioning Packet: ['..packet['X']..'] ['..packet['Y']..'] ['..packet['Z']..']')

        -- Used to turn off when warped back to lobby
        if zone.en == "Walk of Echoes [P1]" or zone.en == "Walk of Echoes [P2]" then
            if packet['X'] == 20 and packet['Y'] == 12 and packet['Z'] == -.5 then
                set_enabled(false)
                que_packet("stop")
            end
        end

        -- Used to Identify areas
        if zone.en == "Outer Ra'Kaznar [U1]" or zone.en == "Outer Ra'Kaznar [U2]" or zone.en == "Outer Ra'Kaznar [U3]" then
            reposition_packet(packet)
        end

    end

    -- Pet status update
    function packet_in_0x068(data)
        local packet = parse_packet('incoming', data)
        if not packet then return end

        if tostring(packet['Owner ID']) == get_player_id() then
            local player_pet = get_player_pet()
            -- No pet info so get info
            if not player_pet then
                log('Getting Data of Pet')
                player_pet = get_mob_by_index(packet['Pet Index'])
            end
            if player_pet then
                local pet_target = get_mob_by_id(packet['Target ID'])
                if not pet_target then
                    log('Set to idle (Deactive)')
                    player_pet.target = 0
                    player_pet.status = 0
                else
                    player_pet.tp = packet['Pet TP']
                    player_pet.target = pet_target.index
                    player_pet.status = 1
                    if player_pet.tp and pet_target.index then
                        log('Packet 0x068 Update - TP ['..player_pet.tp..'] Target ['..pet_target.index..']')
                    end
                end
            end
            --Assign the updates to the pet
            set_player_pet(player_pet)
        end
    end

    -- Reraise Dialog
    function packet_in_0x0F9(data)
        local packet = parse_packet('incoming', data)
        if not packet then return end
        if packet['Category'] ~= 1 then return end
        log("Reraise Menu")
        coroutine.schedule(delay_raise, 2)
    end

    function delay_raise()
        que_packet('packet_reraise_')
    end

    -----------------------------------------------------------------------
    --------------------------- MESSAGES OUT ------------------------------
    -----------------------------------------------------------------------

    -- Leaving Zone
    function packet_out_0x00D(data)

        -- Turn off move_to_exit
        zone_completed()

        -- Turn off Silmaril
        if get_enabled() then
            que_packet("stop")
        end

        -- Finish the mirror since you are leaving
        if get_injecting() then
            log("Zone - Mirroring completed")
            que_packet("mirror_status_completed")
        end

        -- You are mirroring and zoning so complete the action
        if get_mirror_on() and get_mirroring() then 
            log("Leaving zone - finishing mirroring action")
            npc_mirror_complete()
        end

        -- clear any old Mirroring
        clear_npc_data()

        -- clear pet info
        set_player_pet(nil)
    end

    -- Player Update
    function packet_out_0x015(data)
        local packet = parse_packet('outgoing', data)
        if not packet then return end

        -- Store last out going postion packet
        server_position.x = packet['X']
        server_position.y = packet['Y']
        server_position.z = packet['Z']

        -- Start the spoof sequence
        if get_force_warp() then

            -- Modifiy the packet
            local target = get_mirror_target()
            if target and target.name == "Generated Target" then
                packet['X'] = tonumber(target.x)
                packet['Y'] = tonumber(target.y)
                packet['Z'] = tonumber(target.z)
            end

            -- This allows the first 0x015 to position before trying to inject
            if get_warp_spoof() then
                set_warp_spoof(false)
            else
                if get_outgoing_warp() then
                    set_outgoing_warp(false)
                    -- Finally call the injection now that server has you next to bitzer
                    npc_build_message(target, get_warp_message())
                end
            end

            -- Release the modified packet
            return false, build_packet(packet)
        end
    end

    -- Action
    function packet_out_0x01A(data)
        local packet = parse_packet('outgoing', data)
        if not packet then return end

        -- NPC Interaction
        if packet['Category'] == 0x00 then
            if not get_mirror_on() then return end
            local p = get_player_data()
            for index, value in ipairs(p.buffs) do
                if value == 254 then log('Battle Field Exit') return end
            end
            log("Clearing from Action out - 0x01A")
            clear_npc_data()
            npc_mirror_start(packet)

        -- Engage monster
        elseif packet['Category'] == 0x02 then
            log('Engage packet ['..tostring(packet['Target Index'])..']')
            que_packet('packet_engage_'..packet['Target Index'])

        -- Cast Spell and apply an offset if needed
        elseif packet['Category'] == 0x03 then
            local watch_spell = get_watch_spell()
            if not watch_spell then return end
            if watch_spell['Target'] ~= packet['Target'] then clear_watch_spell() return end
            if watch_spell['Target Index'] ~= packet['Target Index'] then clear_watch_spell() return end
            if watch_spell['Category'] ~= packet['Category'] then clear_watch_spell() return end
            if watch_spell['Param'] ~= packet['Param'] then clear_watch_spell() return end
            local spell_option = watch_spell['Option']:split(',')
            packet["X Offset"] = tonumber(spell_option[1])
            packet["Y Offset"] = tonumber(spell_option[2])
            packet["Z Offset"] = tonumber(spell_option[3])
            clear_watch_spell()
            -- Release the modified packet
            return false, build_packet(packet)

        -- Disengage monster
        elseif packet['Category'] == 0x04 then
            log('Disengage from an enemy')

        -- Switch target
        elseif packet['Category'] == 0x0F then
            log('Switch packet ['..tostring(packet['Target Index'])..']')
            que_packet('packet_switch_'..packet['Target Index'])

        -- Ranged Attack
        elseif packet['Category'] == 0x10 then
            log('Ranged Attack Action packet ['..tostring(packet['Target Index'])..']')
            set_last_hover_time(os.clock())
            set_hover_shot(true)

        -- Ranged Attack
        elseif packet['Category'] == 0x07 then
            log('Weaponskill Action packet ['..tostring(packet['Target Index'])..']')
            local ws = get_weaponskill(packet.param)
            if not ws then return end
            if ws.skill == 26 or ws.skill == 25 then 
                set_last_hover_time(os.clock())
                set_hover_shot(true)
            end
        end
    end

    -- Menu Item (Trade)
    function packet_out_0x036(data)
        if not get_mirror_on() then return end
        local packet = check_outgoing_sequence('0x036',data)
        if not packet then return end

        -- Start the mirroring actions if not black listed
        set_trade(true)
        npc_mirror_start(packet)
        log('Trade Packet Out Detected')

        -- Do nothing if its blacklisted
        if not get_mirroring() then return end

        if not packet['Number of Items'] then return end

        local items = get_items(0)
        local formattedString = ""
        for i=1,packet['Number of Items'] do
            local item = 'Item Index '..string.format("%i",i)
            local item_count = 'Item Count '..string.format("%i",i)
            if packet[item_count] > 0 then -- traded quantity
                local inv_count = packet[item_count]
                local inv_item = 0
                if packet[item] ~= 0 then inv_item = items[packet[item]].id end -- not gil so get item id
                formattedString = formattedString..inv_item..'\\'..inv_count..','
            end
        end
        formattedString = formattedString:sub(1, #formattedString - 1)
        formattedString = formattedString..'|'..packet['Number of Items']
        npc_out_trade(packet, formattedString) -- Send the trade message
    end

    -- User dialog
    function packet_out_0x05B(data)
        -- Used with automatic dialogs like warps/doors
        if get_block_release() then
            local packet = check_outgoing_sequence('0x05B',data)
            if not packet then return end
            set_block_release(false)
            log('Calling npc_inject from the blocked outoing 0x05B')
            set_injecting(true)
            set_menu_id(packet['Menu ID'])
            npc_inject()
            return true
        end

        if get_mirror_on() then
            local packet = check_outgoing_sequence('0x05B',data)
            if not packet then return end
            npc_out_dialog(packet)
        end
    end

    -- Warp request
    function packet_out_0x05C(data)
        if not get_mirror_on() then return end
        local packet = check_outgoing_sequence('0x05C',data)
        if not packet then return end
        npc_out_warp(packet)
    end

    -- Zone Line
    function packet_out_0x05E(data)

        local packet = parse_packet('outgoing', data)
        if not packet then return end

        -- Turn off move_to_exit
        zone_completed()

        -- Turn off Silmaril
        if get_enabled() then que_packet("stop") end

        local p_loc = get_player_info()
        if not p_loc then return end

        local w = get_world()
        if not w then return end

        local packet = parse_packet('outgoing', data)
        if not packet then return end

        send_ipc('silmaril zone '..
            p_loc.id..' '..
            w.zone..' '..
            p_loc.x..' '..
            p_loc.y..' '..
            p_loc.z..' '..
            packet['Type']..' '..
            packet['Zone Line']..' '..
            packet['MH Door Menu'])

        log("IPC zone line sent")
    end

    -- Buy Item
    function packet_out_0x083(data)
        if not get_mirror_on() then return end
        local packet = check_outgoing_sequence('0x083',data)
        if not packet then return end
        npc_out_buy(packet)
        log("npc_out_buy() called from [0x083]")
    end

    -- Outgoing Message
    function packet_out_0x0B5(data)
        local packet = parse_packet('outgoing', data)
        que_packet('chat_'..packet['Mode']..'_'..get_player_name()..'_'..from_shift_jis(windower_auto_trans(packet['Message'])))
    end

    -- Outgoing Tell
    function packet_out_0x0B6(data)
        local packet = parse_packet('outgoing', data)
        que_packet('chat_3_>>'..packet['Target Name']..'_'..from_shift_jis(windower_auto_trans(packet['Message'])))
    end

    -----------------------------------------------------------------------
    ----------------------------- HELPERS  --------------------------------
    -----------------------------------------------------------------------


    function check_incoming_sequence(id, data)
        -- Check to verify unique sequence ID
        local packet = parse_packet('incoming', data)
        if not packet then return end
        if packet_validate(last_sequence_in[id], packet, id) then 
            log("Duplicate ["..id.."] Sequence ["..packet['_sequence']..']')
            packet_log(packet, 'Incoming')
            return false 
        end
        last_sequence_in[id] = packet
        return packet
    end

    function check_outgoing_sequence(id, data)
        -- Check to verify unique sequence ID
        local packet = parse_packet('outgoing', data)
        if packet_validate(last_sequence_out[id], packet, id) then 
            log("Duplicate ["..id.."] Sequence ["..packet['_sequence']..']')
            packet_log(packet, 'Outgoing')
            return false 
        end
        last_sequence_out[id] = packet
        return packet
    end

    function get_server_position()
        return server_position
    end

    function packet_validate(old, new, id)
        if old['_raw'] == new['_raw'] then
            return true
        else
            return false
        end
    end

    function get_packet_buffs()
        return packet_buffs
    end

    function reset_packet_buffs()
        local now = os.clock()
        for index, target in pairs(packet_buffs) do
            if now - target.time > 2 then -- Removes after 2 seconds
                log('Removing ['..target.id..'] ['..target.buff..'] ['..target.time..']')
                table.remove(packet_buffs, index)
            end
        end
    end

end