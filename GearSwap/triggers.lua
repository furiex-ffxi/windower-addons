--Copyright (c) 2013~2016, Byrthnoth
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of <addon name> nor the
--      names of its contributors may be used to endorse or promote products
--      derived from this software without specific prior written permission.

--THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
--ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
--WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--DISCLAIMED. IN NO EVENT SHALL <your name> BE LIABLE FOR ANY
--DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
--(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
--ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
--(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.




-----------------------------------------------------------------------------------
--Name: outgoing_text(original,modified,blocked,ffxi)
--Desc: Searches the client's outgoing text for GearSwap handled commands and 
--      returns '' if it finds one. Otherwise returns the command unaltered.
--Args:
---- original - String entered by the user
---- modified - String after being modified by upstream addons/plugins
---- blocked  - Boolean indicating whether the outgoing text is blocked upstream
---- ffxi     - Boolean indicating whether the outgoing text is generated by FFXI
-----------------------------------------------------------------------------------
--Returns:
---- none or ''
-----------------------------------------------------------------------------------
windower.register_event('outgoing text',function(original,modified,blocked,ffxi,extra_stuff,extra2)
    windower.debug('outgoing text')
    if gearswap_disabled then return modified end
    
    local splitline = windower.from_shift_jis(windower.convert_auto_trans(modified)):gsub('<wait[%s%d%.]*>',''):gsub('"(.-)"',function(str)
            return ' '..str:gsub(' ',string.char(7))..' '
        end):split(' '):filter(-'')
    
    if splitline.n == 0 then return end

    local command = splitline[1]
    local bstpet = (command == '/bstpet' and tonumber(splitline[2]))
    local unified_prefix = unify_prefix[command]
    local abil, temptarg, temp_mob_arr
    if splitline[2] and not bstpet then
        abil = splitline[2]:gsub(string.char(7),' '):lower() -- Why am I removing \x7?
    elseif splitline[2] and bstpet then
        local pet_abilities = {}
        for _,v in ipairs(windower.ffxi.get_abilities().job_abilities) do
            if v >= bstpet_range.min and v <= bstpet_range.max then
                pet_abilities[#pet_abilities+1] = v
            end
        end
        if pet_abilities[tonumber(splitline[2])] then
            abil = res.job_abilities[pet_abilities[tonumber(splitline[2])]].name:gsub(string.char(7),' '):lower() -- .name, or .english?
        end
    end

    if validabils[language][unified_prefix] and validabils[language][unified_prefix][abil] then
        temptarg, temp_mob_arr = valid_target(splitline[3])
    elseif validabils[language][unified_prefix] then
        temptarg, temp_mob_arr = valid_target(splitline[2])
    end

    if unified_prefix and temptarg and (validabils[language][unified_prefix][abil] or unified_prefix=='/ra') then
        if st_flag then
            st_flag = nil
            return modified
        elseif temp_mob_arr then
            refresh_globals()

            local r_line, find_monster_skill

            function find_monster_skill(abil)
                local line = false
                if player.species and player.species.tp_moves then
                    -- Iterates over currently available monster TP moves instead of using validabils
                    for i,v in pairs(player.species.tp_moves) do
                        if res.monster_skills[i][language]:lower() == abil then
                            line = copy_entry(res.monster_skills[i])
                            break
                        end
                    end
                end
                return line
            end

            if unified_prefix == '/ma' then
                r_line = copy_entry(res.spells[validabils[language][unified_prefix][abil]])
                storedcommand = command..' "'..windower.to_shift_jis(r_line[language])..'" '
            elseif unified_prefix == '/ms' and find_monster_skill(abil) then
                r_line = find_monster_skill(abil)
                storedcommand = command..' "'..windower.to_shift_jis(r_line[language])..'" '
            elseif unified_prefix == '/ws' then
                r_line = copy_entry(res.weapon_skills[validabils[language][unified_prefix][abil]])
                storedcommand = command..' "'..windower.to_shift_jis(r_line[language])..'" '
            elseif unified_prefix == '/ja' then
                r_line = copy_entry(res.job_abilities[validabils[language][unified_prefix][abil]])
                if bstpet then
                    storedcommand = command..' '..splitline[2]
                else
                    storedcommand = command..' "'..windower.to_shift_jis(r_line[language])..'" '
                end
            elseif unified_prefix == '/item' then
                r_line = copy_entry(res.items[validabils[language][unified_prefix][abil]])
                r_line.prefix = '/item'
                r_line.type = 'Item'
                storedcommand = command..' "'..windower.to_shift_jis(r_line[language])..'" '
            elseif unified_prefix == '/ra' then
                r_line = copy_entry(resources_ranged_attack)
                storedcommand = command..' '
            end

            r_line.name = r_line[language]
            local spell = spell_complete(r_line)
            spell.target = temp_mob_arr
            spell.action_type = action_type_map[command]

            if filter_pretarget(spell) then
                if tonumber(splitline[splitline.n]) then
                    -- If the target is a number
                    local ts = command_registry:new_entry(spell)

                    if spell.prefix == '/item' then
                        -- Item use packet handling here
                        if bit.band(spell.target.spawn_type, 2) == 2 and find_inventory_item(spell.id) then
                            --0x36 packet
                            spell.action_type = 'Trade'
                            if spell.target.distance <= 6 then
                                command_registry[ts].proposed_packet = assemble_menu_item_packet(spell.target.id,spell.target.index,spell.id)
                            else
                                 windower.add_to_chat(67, "Target out of range.")
                                 return true
                            end
                        elseif find_usable_item(spell.id) then
                            --0x37 packet
                            command_registry[ts].proposed_packet = assemble_use_item_packet(spell.target.id,spell.target.index,spell.id)
                        end
                    else
                        command_registry[ts].proposed_packet = assemble_action_packet(spell.target.id,spell.target.index,outgoing_action_category_table[unify_prefix[spell.prefix]],spell.id,initialize_arrow_offset(spell.target))
                    end
                    -- The packets created above should not be used.
                    if command_registry[ts].proposed_packet then
                        equip_sets('precast',ts,spell)
                        return true
                    end
                else
                    if spell.prefix == '/item' and spell.target.type ~= 'NONE' then
                        if bit.band(spell.target.spawn_type, 2) == 2 and find_inventory_item(spell.id) then
                            --0x36 packet
                            spell.action_type = 'Trade'
                        end
                    end
                    return equip_sets('pretarget',-1,spell)
                end
			else
                return equip_sets('filtered_action',-1,spell)
			end
        end
    end
    return modified
end)



-----------------------------------------------------------------------------------
--Name: parse.i[0x028](act)
--Desc: Calls midcast or aftercast functions as appropriate in response to incoming
--      action packets.
--Args:
---- act - Action packet array (described on the dev wiki)
-----------------------------------------------------------------------------------
--Returns:
---- none
-----------------------------------------------------------------------------------
parse.i[0x028] = function (data)
    local act = windower.packets.parse_action(data)
    if gearswap_disabled or act.category == 1 then return end
    
--    local spell_res = ActionPacket.new(act):get_spell()
        
    --print(((res[unpackedaction.resource] or {})[unpackedaction.spell_id] or {}).english,unpackedaction.type,unpackedaction.value,unpackedaction.interruption)
    local temp_player_mob_table,temp_pet,pet_id = windower.ffxi.get_mob_by_index(player.index)
    if temp_player_mob_table and temp_player_mob_table.pet_index then
        temp_pet = windower.ffxi.get_mob_by_index(temp_player_mob_table.pet_index)
        if temp_pet then
            pet_id = temp_pet.id
        end
    end

    if act.actor_id ~= player.id and act.actor_id ~= pet_id then
        return -- If the action is not being used by the player, the pet, or is a melee attack then abort processing.
    end
    
    local prefix = ''
    
    if act.actor_id == pet_id then 
        prefix = 'pet_'
    end
    
    local spell = get_spell(act)
--    if not spell_res or (spell.english ~= spell_res.english) then print('Did not match.',spell.english,spell_res) end
    
    if spell then logit('\n\n'..tostring(os.clock)..'(178) Event Action: '..tostring(spell[language])..' '..tostring(act.category))
    else logit('\n\nNil spell detected') end
    
    if spell and spell[language] then
        spell.target = target_complete(windower.ffxi.get_mob_by_id(act.targets[1].id))
        spell.action_type = action_type_map[unify_prefix[spell.prefix or 'Monster']]
    elseif S{84,78}:contains(act.targets[1].actions[1].message) then -- "Paralyzed" and "too far away" respectively
        local ts,tab = command_registry:delete_by_id(act.targets[1].id)
        if tab and tab.spell and tab.spell.prefix == '/pet' then 
            tab.spell.interrupted = true
            equip_sets('pet_aftercast',nil,tab.spell)
        elseif tab and tab.spell then
            tab.spell.interrupted = true
            equip_sets('aftercast',nil,tab.spell)
        end
        return
    else
        if debugging.general then windower.send_command('input /echo Incoming Action packet did not generate a spell/aftercast.')end
        return
    end
    
    --[[4 (action message) = "out of range" when attempting to melee something that's too far away
       78 (action message) = "too far away" when attempting to engage or cast magic on something that's too far away
       78 (action) = "too far away" when attempting to WS something that's too far away
       154 (action message) - "out of range" when attempting to use a JA on something that's too far away. param_1 is the JA ID]]
       
    -- Paralysis of JAs/spells/etc. and Out of Range messages for avatars both send two action packets when they occur.
    -- The first packet is a paralysis packet that contains the message and spell-appropriate information.
    -- The second packet contains the interruption code and no useful information as far as I can see.
    -- The same occurs for items, except that they are both category 9 messages.
    
    -- For some reason avatar Out of Range messages send two packets (Category 4 and Category 7)
    -- Category 4 contains real information, while Category 7 does not.
    -- I do not know if this will affect automatons being interrupted.
    local ts = command_registry:find_by_spell(spell)
    if (jas[act.category] or uses[act.category]) then
        if uses[act.category] and act.param == 28787 then
            spell.action_type = 'Interruption'
            spell.interrupted = true
        else
            spell.value = act.targets[1].actions[1].param
        end
        if ts then --or spell.prefix == '/item' then
            -- Only aftercast things that were precasted.
            -- Also, there are some actions (like being paralyzed while casting Ninjutsu) that sends two result action packets. Block the second packet.
            refresh_globals()
            command_registry[ts].midaction = false
            equip_sets(prefix..'aftercast',ts,spell)
        elseif debugging.command_registry then
            msg.debugging('Hitting Aftercast without detecting an entry in command_registry')
        end
    elseif (readies[act.category] and act.param == 28787) then -- and not (act.category == 9 or (act.category == 7 and prefix == 'pet_'))) then
        spell.action_type = 'Interruption'
        spell.interrupted = true
        if ts or spell.prefix == '/item' then
            -- Only aftercast things that were precasted.
            -- Also, there are some actions (like being paralyzed while casting Ninjutsu) that sends two result action packets. Block the second packet.
            refresh_globals()
            if command_registry[ts] then command_registry[ts].midaction = false end
            equip_sets(prefix..'aftercast',ts,spell)
        elseif debugging.command_registry then
            msg.debugging('Hitting Aftercast without detecting an entry in command_registry')
        end
    elseif readies[act.category] and prefix == 'pet_' and act.targets[1].actions[1].message ~= 0 then
        -- Entry for pet midcast. Excludes the second packet of "Out of range" BPs.
        ts = command_registry:new_entry(spell)
        refresh_globals()
        command_registry[ts].pet_midaction = true
        equip_sets('pet_midcast',ts,spell)
    end
end



-----------------------------------------------------------------------------------
--Name: parse.i[0x029](data)
--Desc: Responds to incoming action message packets.
--Args:
---- arr - Action message packet arguments (described on the dev wiki):
  -- actor_id,target_id,param_1,param_2,param_3,actor_index,target_index,message_id)
-----------------------------------------------------------------------------------
--Returns:
---- none
-----------------------------------------------------------------------------------
parse.i[0x029] = function (data)
    if gearswap_disabled then return end
    local arr = {}
    arr.actor_id = data:unpack('I',0x05)
    arr.target_id = data:unpack('I',0x09)
    arr.param_1 = data:unpack('I',0x0D)
    arr.param_2 = data:unpack('I',0x11)%64 -- First 6 bits
    arr.param_3 = math.floor(data:unpack('I',0x11)/64) -- Rest
    arr.actor_index = data:unpack('H',0x15)
    arr.target_index = data:unpack('H',0x17)
    arr.message_id = data:unpack('H',0x19)%32768
    
    
    windower.debug('action message')
    if T{6,20,113,406,605,646}:contains(arr.message_id) then -- death messages
        local ts,tab = command_registry:delete_by_id(arr.target_id)
        if tab and tab.spell and tab.spell.prefix == '/pet' then
            equip_sets('pet_aftercast',nil,tab.spell)
        elseif tab and tab.spell then
            equip_sets('aftercast',nil,tab.spell)
        end
        return
    end
    
    local tempplay = windower.ffxi.get_player()
    local prefix = ''
    if arr.actor_id ~= tempplay.id then
        if tempplay.pet_index then
            if arr.actor_id ~= windower.ffxi.get_mob_by_index(tempplay.pet_index).id then
                return
            else
                prefix = 'pet_'
            end
        else
            return
        end
    end
    
    if unable_to_use:contains(arr.message_id) then
        logit('\n\n'..tostring(os.clock)..'(195) Event Action Message: '..tostring(message_id)..' Interrupt')
        local ts,tab = command_registry:find_by_time()
        
        if tab and tab.spell then
            tab.spell.interrupted = true
            tab.spell.action_type = 'Interruption'
            command_registry[ts].midaction = false
            refresh_globals()
            equip_sets(prefix..'aftercast',ts,tab.spell)
        end
    end
end
