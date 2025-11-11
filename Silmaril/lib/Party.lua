do
    local party_position = {p0=1,p1=2,p2=3,p3=4,p4=5,p5=6,a10=7,a11=8,a12=9,a13=10,a14=11,a15=12,a20=13,a21=14,a22=15,a23=16,a24=17,a25=18}
    local party_ids = {}
    local alliance_ids = {}
    local party_location = {}
    local party_info = {}
    local party_table = {}

    function get_party_data()
        local party_data = {}

        -- Update the table of the party
        party_info = get_party() 
        if not party_info then return party_data end

        -- Get the player info
        local p = get_player_data()
        if not p then return party_data end

        -- Get the player data
        local p_info = get_player_info()
        if not p_info then return party_data end

        --Clear old Tables
        party_ids = {}
        alliance_ids = {}
        trust_ids = {}
        party_table = {}

        for position, member in pairs(party_info) do
            if type(member) == "table" and member.name and member.name ~= '' then
                local position_location = party_position[position]
                local formattedString = "party_"..string.format("%i",position_location - 1)..'_'..member.name..','
                ..string.format("%i",member.hp)..','..string.format("%i",member.hpp)..','..string.format("%i",member.mp)..','
                ..string.format("%i",member.mpp)..','..string.format("%i",member.tp)..','..string.format("%i",member.zone)

                party_table[position_location] = true

                if member.mob then
                    -- Blank update
                    local mob = {0,0,0,0,0,0,0,0,0,'false','false','|0|0|0|0|0|0|0|0|0|0|0'}
                    local local_player = party_location[member.mob.id]

                    -- Build a party table to use later
                    if party_position[position] < 7 then
                        party_ids[member.mob.id] = position
                        if member.mob.is_npc then
                            trust_ids[member.mob.id] = position
                        end
                    end

                    alliance_ids[member.mob.id] = position

                    if local_player then -- update with local IPC information
                        if local_player.id == p.id then
                            member.mob.target_index = p.target_index
                            member.mob.status = p_info.status
                            member.mob.heading = p_info.heading
                            member.mob.x = p_info.x
                            member.mob.y = p_info.y
                            member.mob.z = p_info.z
                        else
                            member.mob.x = local_player.x
                            member.mob.y = local_player.y
                            member.mob.z = local_player.z
                            member.mob.heading = local_player.heading
                        end
                    end

                    for index, value in pairs(member.mob) do
                        if index == 'id' then
                            mob[1] = string.format("%i",value)
                        elseif index == 'index' then
                            mob[2] = string.format("%i",value)
                        elseif index == 'target_index' then
                            mob[3] = string.format("%i",value)
                        elseif index == 'status' then
                            mob[4] = string.format("%i",value)
                        elseif index == 'heading' then
                            mob[5] = string.format(value)
                        elseif index == 'x' then
                            mob[6] = string.format(value)
                        elseif index == 'y' then
                            mob[7] = string.format(value)
                        elseif index == 'z' then
                            mob[8] = string.format(value)
                        elseif index == 'model_size' then
                            mob[9] = string.format(value)
                        elseif index == 'is_npc' then
                            mob[10] = tostring(value)
                        elseif index == 'pet_index' then
                            local pet = get_mob_by_index(value)
                            -- Update the player's' pet
                            if pet then
                                if member.mob.id == p.id then
                                    local player_pet = get_player_pet()
                                    if player_pet then
                                        pet.tp = player_pet.tp
                                        pet.status = player_pet.status
                                        -- Check is its targeting itself
                                        if pet.index == player_pet.target then
                                            pet.target = 0
                                            pet.status = 0
                                        else
                                            pet.target = player_pet.target
                                        end
                                    end
                                    set_player_pet(pet)
                                end
                                -- Add to the party table
                                party_ids[pet.id] = position
                            else
                                pet = {}
                                pet.name = "None"
                                pet.id = 0
                                pet.index = 0
                                pet.hpp = 0
                                pet.tp = 0
                                pet.x = 0
                                pet.y = 0
                                pet.z = 0
                                pet.zone = 0
                                pet.status = 0
                                pet.target = 0
                                pet.model_size = 0
                            end

                            if not pet.tp then pet.tp = 0 end
                            if not pet.target then pet.target = 0 end
                            if not pet.status then pet.status = 0 end

                            local pet_string = pet.name..'|'..string.format("%i",pet.id)..'|'..string.format("%i",pet.index)..'|'..string.format("%i",pet.hpp)..'|'..string.format("%i",pet.tp)..
                            '|'..string.format("%.3f",pet.x)..'|'..string.format("%.3f",pet.y,2)..'|'..string.format("%.3f",pet.z,2)..'|'..string.format("%i",member.zone)..
                            '|'..string.format("%i",pet.status)..'|'..string.format("%i",pet.target)..'|'..string.format("%.3f",pet.model_size)
                            mob[12] = pet_string
                        end
                    end

                    if not mob[12] then -- No pet active
                        local pet_string = "0|0|0|0|0|0|0|0|0|0|0|0"
                        mob[12] = pet_string 
                    end

                    if party_info['party1_leader'] == member.mob['id'] then
                        mob[11] = 'true'
                    else
                        mob[11] = 'false'
                    end

                    for index, value in ipairs(mob) do
                        formattedString = formattedString..','..value
                    end
                else
                    formattedString = formattedString..',0,0,0,0,0,0,0,0,0,false,false,|0|0|0|0|0|0|0|0|0|0|0'
                end
                party_data[party_position[position]] = formattedString
                --log(formattedString)
            end
        end

        -- Fill out the remaining party table
        for i = 1, 18 do
            if not party_table[i] then 
                party_data[i] = "party_"..string.format("%i",i-1)..'_Player '..string.format("%i",i)..',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,false,false,|0|0|0|0|0|0|0|0|0|0|0'
            end
        end

        return party_data
    end

    function get_party_ids()
        return party_ids
    end

    function get_alliance_ids()
        return alliance_ids
    end

    function get_trust_ids()
        return trust_ids
    end

    function get_party_info()
        return party_info
    end

    function get_party_location()
        return party_location
    end

    function set_party_location(value)
        party_location[value.id] = value
    end

    function clear_party_location()
        log("Clearing Party Location")
        party_location = {}
    end

end
