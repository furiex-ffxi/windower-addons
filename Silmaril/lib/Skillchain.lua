do
    --Monitors for Skillchian Partners

    local Skillchain_Leader_Name = ''
    local Skillchain_Leader_WS = ''
    local Skillchain_Leader_ID = 0

    local Skillchain_Leader_Name_2 = ''
    local Skillchain_Leader_WS_2 = ''
    local Skillchain_Leader_ID_2 = 0

    local Skillchain_Leader_Name_3 = ''
    local Skillchain_Leader_WS_3 = ''
    local Skillchain_Leader_ID_3 = 0

    local Skillchain_Leader_Name_4 = ''
    local Skillchain_Leader_WS_4 = ''
    local Skillchain_Leader_ID_4 = 0

    local now = os.clock()

    local Skillchain_Time = os.clock()
    local Skillchain_Time_2 = os.clock()
    local Skillchain_Time_3 = os.clock()
    local Skillchain_Time_4 = os.clock()

    local Skillchain_Time_ID = 0
    local Skillchain_Time_ID_2 = 0
    local Skillchain_Time_ID_3 = 0
    local Skillchain_Time_ID_4 = 0

    function skillchain_reset()
        Skillchain_Leader_Name = ''
        Skillchain_Leader_WS = ''
        Skillchain_Leader_ID = 0

        Skillchain_Leader_Name_2 = ''
        Skillchain_Leader_WS_2 = ''
        Skillchain_Leader_ID_2 = 0

        Skillchain_Leader_Name_3 = ''
        Skillchain_Leader_WS_3 = ''
        Skillchain_Leader_ID_3 = 0

        Skillchain_Leader_Name_4 = ''
        Skillchain_Leader_WS_4 = ''
        Skillchain_Leader_ID_4 = 0

        now = os.clock()

        Skillchain_Time = os.clock()
        Skillchain_Time_2 = os.clock()
        Skillchain_Time_3 = os.clock()
        Skillchain_Time_4 = os.clock()

        Skillchain_Time_ID = 0
        Skillchain_Time_ID_2 = 0
        Skillchain_Time_ID_3 = 0
        Skillchain_Time_ID_4 = 0
    end


    function skillchain(Name, WS, ID, Delay)
        if Name ~= 'none' and WS ~= 'none' and WS ~= '' and ID ~= 0 then
            if Name ~= Skillchain_Leader_Name or WS ~= Skillchain_Leader_WS then
                send_to_chat(8,'Skillchain #1 - Monitoring ['..Name..'] for ['..WS..'].')
            end
            Skillchain_Leader_Name = Name
            Skillchain_Leader_WS = WS
            Skillchain_Leader_ID = tonumber(ID)
            Skillchain_Delay = tonumber(Delay)
            Skillchain_Time = os.clock() - 60
            Skillchain_Time_ID = 0
        else
            Skillchain_Leader_Name = ''
            Skillchain_Leader_WS = ''
            Skillchain_Leader_ID = 0
            Skillchain_Delay = 0
            Skillchain_Time = os.clock()
            Skillchain_Time_ID = 0
        end
    end

    function skillchain2(Name, WS, ID, Delay)
        if Name ~= 'none' and WS ~= 'none' and WS ~= '' and ID ~= 0 then
            if Name ~= Skillchain_Leader_Name_2 or WS ~= Skillchain_Leader_WS_2 then
                send_to_chat(8,'Skillchain #2 - Monitoring ['..Name..'] for ['..WS..'].')
            end
            Skillchain_Leader_Name_2 = Name
            Skillchain_Leader_WS_2 = WS
            Skillchain_Leader_ID_2 = tonumber(ID)
            Skillchain_Delay_2 = tonumber(Delay)
            Skillchain_Time_2 = os.clock() - 60
            Skillchain_Time_ID_2 = 0
        else
            Skillchain_Leader_Name_2 = ''
            Skillchain_Leader_WS_2 = ''
            Skillchain_Leader_ID_2 = 0
            Skillchain_Delay_2 = 0
            Skillchain_Time_2 = os.clock()
            Skillchain_Time_ID_2 = 0
        end
    end

    function skillchain3(Name, WS, ID, Delay)
        if Name ~= 'none' and WS ~= 'none' and WS ~= '' and ID ~= 0 then
            if Name ~= Skillchain_Leader_Name_3 or WS ~= Skillchain_Leader_WS_3 then
                send_to_chat(8,'Skillchain #3 - Monitoring ['..Name..'] for ['..WS..'].')
            end
            Skillchain_Leader_Name_3 = Name
            Skillchain_Leader_WS_3 = WS
            Skillchain_Leader_ID_3 = tonumber(ID)
            Skillchain_Delay_3 = tonumber(Delay)
            Skillchain_Time_3 = os.clock() - 60
            Skillchain_Time_ID_3 = 0
        else
            Skillchain_Leader_Name_3 = ''
            Skillchain_Leader_WS_3 = ''
            Skillchain_Leader_ID_3 = 0
            Skillchain_Delay_3 = 0
            Skillchain_Time_3 = os.clock()
            Skillchain_Time_ID_3 = 0
        end
    end

    function skillchain4(Name, WS, ID, Delay)
        if Name ~= 'none' and WS ~= 'none' and WS ~= '' and ID ~= 0 then
            if Name ~= Skillchain_Leader_Name_4 or WS ~= Skillchain_Leader_WS_4 then
                send_to_chat(8,'Skillchain #4 - Monitoring ['..Name..'] for ['..WS..'].')
            end
            Skillchain_Leader_Name_4 = Name
            Skillchain_Leader_WS_4 = WS
            Skillchain_Leader_ID_4 = tonumber(ID)
            Skillchain_Delay_4 = tonumber(Delay)
            Skillchain_Time_4 = os.clock() - 60
            Skillchain_Time_ID_4 = 0
        else
            Skillchain_Leader_Name_4 = ''
            Skillchain_Leader_WS_4 = ''
            Skillchain_Leader_ID_4 = 0
            Skillchain_Delay_4 = 0
            Skillchain_Time_4 = os.clock()
            Skillchain_Time_ID_4 = 0
        end
    end

    -- Called via Packets.lua
    function run_ws_skillchain(data, type)

        local ws = nil

        if type == "NPC" then
            ws = get_monster_ability(data.param)
        elseif type == "Avatar" then
            ws = get_ability(data.param)
        elseif type == "Player" then
            ws = get_weaponskill(data.param)
        end

        if not ws then return end

        local id = data.targets[1].id
        now = os.clock()

        -- The correct person with correct ws
        if data.actor_id == Skillchain_Leader_ID and ws.en == Skillchain_Leader_WS then 
            -- Check if it is a new mob
            if Skillchain_Time_ID ~= id then 
                -- Set the time and update the ID since its a new mob
                Skillchain_Time = os.clock()
                Skillchain_Time_ID = id
                -- Send the update
                log('['..Skillchain_Leader_Name..'] Weaponskill ['..ws.en..'] on ['..id..'] Follower #1')
                que_packet('skillchain_'..ws.en..'_'..Skillchain_Leader_Name..'_'..id)
                -- Return since it was decieded this is the skillchain
                return
            else
                -- Since not a new mob check if enough time has elapsed
                if now - Skillchain_Time > Skillchain_Delay then 
                    Skillchain_Time = os.clock() 
                    log('['..Skillchain_Leader_Name..'] Weaponskill ['..ws.en..'] on ['..id..'] Follower #1')
                    que_packet('skillchain_'..ws.en..'_'..Skillchain_Leader_Name..'_'..id)
                    -- Return since it was decieded this is the skillchain
                    return
                end
            end
        end

        -- The correct person with correct ws
        if data.actor_id == Skillchain_Leader_ID_2 and ws.en == Skillchain_Leader_WS_2 then
            -- Check if it is a new mob
            if Skillchain_Time_ID_2 ~= id then 
                -- Set the time and update the ID
                Skillchain_Time_2 = os.clock()
                Skillchain_Time_ID_2 = id
                -- Send the update
                log('['..Skillchain_Leader_Name_2..'] Weaponskill ['..ws.en..'] on ['..id..'] Follower #2')
                que_packet('skillchain2_'..ws.en..'_'..Skillchain_Leader_Name_2..'_'..id)
                return
            else
                -- Since not a new mob check if enough time has elapsed
                if now - Skillchain_Time_2 > Skillchain_Delay_2 then 
                    Skillchain_Time_2 = os.clock() 
                    log('['..Skillchain_Leader_Name_2..'] Weaponskill ['..ws.en..'] on ['..id..'] Follower #2')
                    que_packet('skillchain2_'..ws.en..'_'..Skillchain_Leader_Name_2..'_'..id)
                    return
                end
            end
        end

        -- The correct person with correct ws
        if data.actor_id == Skillchain_Leader_ID_3 and ws.en == Skillchain_Leader_WS_3 then
            -- Check if it is a new mob
            if Skillchain_Time_ID_3 ~= id then 
                -- Set the time and update the ID
                Skillchain_Time_3 = os.clock()
                Skillchain_Time_ID_3 = id
                -- Send the update
                log('['..Skillchain_Leader_Name_3..'] Weaponskill ['..ws.en..'] on ['..id..'] Follower #3')
                que_packet('skillchain3_'..ws.en..'_'..Skillchain_Leader_Name_3..'_'..id)
                return
            else
                -- Since not a new mob check if enough time has elapsed
                if now - Skillchain_Time_3 > Skillchain_Delay_3 then 
                    Skillchain_Time_3 = os.clock() 
                    log('['..Skillchain_Leader_Name_3..'] Weaponskill ['..ws.en..'] on ['..id..'] Follower #3')
                    que_packet('skillchain3_'..ws.en..'_'..Skillchain_Leader_Name_3..'_'..id)
                    return
                end
            end
        end

        -- The correct person with correct ws
        if data.actor_id == Skillchain_Leader_ID_4 and ws.en == Skillchain_Leader_WS_4 then
            -- Check if it is a new mob
            if Skillchain_Time_ID_4 ~= id then 
                -- Set the time and update the ID
                Skillchain_Time_4 = os.clock()
                Skillchain_Time_ID_4 = id
                -- Send the update
                log('['..Skillchain_Leader_Name_4..'] Weaponskill ['..ws.en..'] on ['..id..'] Follower #4')
                que_packet('skillchain4_'..ws.en..'_'..Skillchain_Leader_Name_4..'_'..id)
                return
            else
                -- Since not a new mob check if enough time has elapsed
                if now - Skillchain_Time_4 > Skillchain_Delay_4 then 
                    Skillchain_Time_4 = os.clock() 
                    log('['..Skillchain_Leader_Name_4..'] Weaponskill ['..ws.en..'] on ['..id..'] Follower #4')
                    que_packet('skillchain4_'..ws.en..'_'..Skillchain_Leader_Name_4..'_'..id)
                    return
                end
            end
        end
    end

    -- Called via Packets.lua
    function run_spell_check(data)

        -- Get the spell data
        local spell = get_spell(data.param)
        if not spell then return end

        local id = data.targets[1].id

        now = os.clock()
        if data.actor_id == Skillchain_Leader_ID and spell.en == Skillchain_Leader_WS then

            -- Check if enough time have elapsed on the correct mob
            if Skillchain_Time_ID == id then
                if now - Skillchain_Time < Skillchain_Delay then return end
            end

            Skillchain_Time = os.clock()
            Skillchain_Time_ID = id

            log('['..Skillchain_Leader_Name..'] skillchain with spell ['..spell.en..'] on ['..id..'] for Follower #1')
            que_packet('skillchain_'..spell.en..'_'..Skillchain_Leader_Name..'_'..id)

        elseif data.actor_id == Skillchain_Leader_ID_2 and spell.en == Skillchain_Leader_WS_2 then

            -- Check if enough time have elapsed on the correct mob
            if Skillchain_Time_ID_2 == id then
                if now - Skillchain_Time_2 < Skillchain_Delay_2 then return end
            end

            Skillchain_Time_2 = os.clock()
            Skillchain_Time_ID_2 = id

            log('['..Skillchain_Leader_Name_2..'] skillchain with spell ['..spell.en..'] on ['..id..'] for Follower #2')
            que_packet('skillchain2_'..spell.en..'_'..Skillchain_Leader_Name_2..'_'..id)

        elseif data.actor_id == Skillchain_Leader_ID_3 and spell.en == Skillchain_Leader_WS_3 then

            -- Check if enough time have elapsed on the correct mob
            if Skillchain_Time_ID_3 == id then
                if now - Skillchain_Time_3 < Skillchain_Delay_3 then return end
            end

            Skillchain_Time_3 = os.clock()
            Skillchain_Time_ID_3 = id

            log('['..Skillchain_Leader_Name_3..'] skillchain with spell ['..spell.en..'] on ['..id..'] for Follower #3')
            que_packet('skillchain3_'..spell.en..'_'..Skillchain_Leader_Name_3..'_'..id)

        elseif data.actor_id == Skillchain_Leader_ID_4 and spell.en == Skillchain_Leader_WS_4 then
            
            -- Check if enough time have elapsed on the correct mob
            if Skillchain_Time_ID_4 == id then
                if now - Skillchain_Time_4 < Skillchain_Delay_4 then return end
            end

            Skillchain_Time_4 = os.clock()
            Skillchain_Time_ID_4 = id

            log('['..Skillchain_Leader_Name_4..'] skillchain with spell ['..spell.en..'] on ['..id..'] for Follower #4')
            que_packet('skillchain4_'..spell.en..'_'..Skillchain_Leader_Name_4..'_'..id)

        end
    end

    -- Called via Burst.lua
    function run_property_skillchain(name, id)

        now = os.clock()
        if Skillchain_Leader_WS == name then

            -- Check if enough time have elapsed on the correct mob
            if Skillchain_Time_ID == id then
                if now - Skillchain_Time < Skillchain_Delay then return end
            end

            Skillchain_Time = os.clock()
            Skillchain_Time_ID = id

            log('['..name..'] on ['..id..'] Follower #1')
            que_packet('skillchain_'..name..'_Anyone_'..id)

        elseif Skillchain_Leader_WS_2 == name then

            -- Check if enough time have elapsed on the correct mob
            if Skillchain_Time_ID_2 == id then
                if now - Skillchain_Time_2 < Skillchain_Delay_2 then return end
            end

            Skillchain_Time_2 = os.clock()
            Skillchain_Time_ID_2 = id

            log('['..name..'] on ['..id..'] Follower #2')
            que_packet('skillchain2_'..name..'_Anyone_'..id)

        elseif Skillchain_Leader_WS_3 == name then

            -- Check if enough time have elapsed on the correct mob
            if Skillchain_Time_ID_3 == id then
                if now - Skillchain_Time_3 < Skillchain_Delay_3 then return end
            end

            Skillchain_Time_3 = os.clock()
            Skillchain_Time_ID_3 = id

            log('['..name..'] on ['..id..'] Follower #3')
            que_packet('skillchain3_'..name..'_Anyone_'..id)

        elseif Skillchain_Leader_WS_4 == name then

            -- Check if enough time have elapsed on the correct mob
            if Skillchain_Time_ID_4 == id then
                if now - Skillchain_Time_4 < Skillchain_Delay_4 then return end
            end

            Skillchain_Time_4 = os.clock()
            Skillchain_Time_ID_4 = id

            log('['..name..'] on ['..id..'] Follower #4')
            que_packet('skillchain4_'..name..'_Anyone_'..id)
        end
    end

end