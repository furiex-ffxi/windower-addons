do
    local player_enemy_data = "enemy_"
    local player_npc_data = "npc_"
    local world = nil
    local mob_array = nil

    function get_world_data()
        local formattedString = "world_"

        world = get_info()
        if not world then return formattedString end

        get_mob_data() -- refresh the Enemy and NPC lists
        formattedString = formattedString..tostring(world.menu_open)..','..world.zone..','..world.day..','..world.weather..','..tostring(world.mog_house)
        --log(formattedString)
        return formattedString
    end

    function get_mob_data()
        local formattedString = "enemy_"
        local formattedString2 = "npc_"
        player_enemy_data = "enemy_"
        player_npc_data = "npc_"

        mob_array = get_mob_array()
        if not mob_array then return end

        for id, enemy in pairs(mob_array) do
            if not enemy.target_index then
                enemy.target_index = 0
            end
            if enemy and enemy.is_npc and enemy.valid_target and not enemy.in_party and not enemy.charmed and enemy.spawn_type == 16 then
                    formattedString = formattedString..enemy.name..'|'..string.format("%.3f",enemy.distance:sqrt())..'|'..enemy.hpp..'|'..enemy.id..'|'..enemy.index..'|'..enemy.status..'|'
                ..string.format("%.3f",enemy.x)..'|'..string.format("%.3f",enemy.y)..'|'..string.format("%.3f",enemy.z)..'|'..enemy.spawn_type..'|'..enemy.claim_id..'|'..world.zone..'|'
                ..string.format("%.2f",enemy.model_size)..'|'..enemy.heading..','
            elseif enemy and enemy.valid_target and not enemy.in_party and enemy.spawn_type == 1 then
                formattedString2 = formattedString2..enemy.name..'|'..string.format("%.3f",enemy.distance:sqrt())..'|'..enemy.hpp..'|'..enemy.id..'|'..enemy.index..'|'..enemy.status..'|'
                ..string.format("%.3f",enemy.x)..'|'..string.format("%.3f",enemy.y)..'|'..string.format("%.3f",enemy.z)..'|'..enemy.spawn_type..'|'..enemy.claim_id..'|'..world.zone..'|'
                ..string.format("%.2f",enemy.model_size)..'|'..enemy.target_index..'|'..tostring(enemy.in_party)..'|'..tostring(enemy.in_alliance)..'|'..tostring(enemy.is_npc)..'|'..enemy.heading..','
            end
        end
        if(#formattedString > 6) then
            player_enemy_data = formattedString:sub(1, #formattedString - 1)
        end
        if(#formattedString2 > 4) then
            player_npc_data = formattedString2:sub(1, #formattedString2 - 1)
        end
    end

    function get_enemy_data()
        formattedString = player_enemy_data
        player_enemy_data = "enemy_"
        return formattedString
    end

    function get_npc_data()
        formattedString = player_npc_data
        player_npc_data = "npc_"
        return formattedString
    end

    function get_world()
        return world
    end

    function set_world(value)
        world = value
    end

    function get_all_enemies()
        return mob_array
    end

end