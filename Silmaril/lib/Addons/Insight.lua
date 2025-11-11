-- This version uses Silmaril assets and does not update on render but instead at the "display speed"
-- Default display speed it .25 seconds

do
    local enabled = true
    local x_pos = get_screen_size_x() - 120
    local hpp_y_pos = {}
    local tp_y_pos = {}
    local party_position = {p0=1,p1=2,p2=3,p3=4,p4=5,p5=6,a10=7,a11=8,a12=9,a13=10,a14=11,a15=12,a20=13,a21=14,a22=15,a23=16,a24=17,a25=18}

    -- Enemy HPP
    local hpp = texts.new('${hpp}', 
    {
        pos = { x = -102, y = 0},
        bg = { visible = false,},
        flags = { right = true, bottom = true, bold = true, draggable = false, italic = true,},
        text = {size = 10, alpha = 170, red = 115, green = 166, blue = 255, }, 
    })

    -- Define the default party TP positions for the tp table
    local tp = T{}

    for i = 1, 18 do
        -- Build the TP table for the party
        tp[i] = texts.new('${tp}',
        {
            pos = { x = x_pos, y = 0},
            bg = { visible = false,},
            flags = { right = false, bottom = true, bold = true, draggable = false, italic = true,},
            text = { size = i < 7 and 9.5 or 8,  alpha = 180, red = 255, green = 255, blue = 255,},
        })
    end

    -- Build offeset for a full party
    for i = 1, 6 do 
        hpp_y_pos[i] = -48.5 - 20.2 * i
        tp_y_pos[i] = -34.5 - 20.2 * (6 - i)
        tp_y_pos[i + 6] = -309 - 16 * (6 - i)
        tp_y_pos[i + 12] = -207 - 16 * (6 - i)
    end

    function insight_engine()

        if not enabled then hide_all() return end 

        -- Get the player info from Player.lua
        local p = get_player_data()

        -- Get the Party table from Party.lua
        local pt = get_party_info()

        --[[ Spawn type mapping:
            1 = Other players
            2 = Town NPCs, AH counters, Logging Points, etc.
            Bit 1 = 1 PC
            Bit 2 = 2 NPC (not attackable)
            Bit 3 = 4 Party Member
            Bit 4 = 8 Ally
            Bit 5 = 16 Enemy
            Bit 6 = 32 Door (Environment)
            13 = Self
            14 = Trust NPC in party
            16 = Monsters
            34 = Some doors
        ]]

        -- Display the target info if selected
        if p and p.target_index and p.target_index ~= 0 then
            local enemy = get_mob_by_index(p.target_index)
            if enemy and enemy.spawn_type ~= 34 and enemy.spawn_type ~= 2 then
                hpp:pos_y(hpp_y_pos[pt.party1_count])
                if enemy.spawn_type == 16 then
                    if enemy.claim_id ~= 0 then
                        hpp:color(255, 120, 70)
                    else
                        hpp:color(255, 255, 200)
                    end
                else
                    hpp:color(180, 255, 255)
                end

                hpp:update(enemy)
                hpp:show()
            else
                hpp:hide()
            end
        else
            hpp:hide()
        end

        -- Party TP Section

        -- Get the world info via World.lua
        local world = get_world()
        local party_table = {}

        for position, member in pairs(pt) do
            if type(member) == "table" and member.name and member.name ~= '' then
                local position_location = party_position[position]
                local display_text = tp[position_location]
                party_table[position_location] = true
                if display_text and world and member.zone == world.zone then

                    -- Adjust position for party member count
                    if position_location < 7 then
                        display_text:pos_y(tp_y_pos[position_location + 6 - pt.party1_count])
                    else
                        display_text:pos_y(tp_y_pos[position_location])
                    end

                    -- Color TP display green when TP > 1000
                    if member.tp >= 1000 then
                        display_text:color(0, 255, 0)
                    else
                        display_text:color(255, 255, 255)
                    end

                    display_text:update(member)
                    display_text:show()
                else
                    display_text:hide()
                end
            end
        end

        for i = 1, 18 do
            if not party_table[i] then tp[i]:hide() end
        end

    end

    function hide_all()
        for i = 1, 18 do
            tp[i]:hide()
        end
        hpp:hide()
    end

    function set_insight_enabled(value)
        enabled = value
        if not enabled then
            hide_all()
        end
    end

    function get_hpp()
        return hpp
    end

    function set_hpp(value)
        hpp = value
    end

end