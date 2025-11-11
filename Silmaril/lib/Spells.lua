do
    local all_spells = get_res_all_spells()
    local player_spells = {}
    local player_trusts = {}
    local spell_recasts = {}

    -- Used once via sync request Sync.lua
    function get_all_spells() 
        local formattedString = get_player_id()..";spelldata_"
        local all_spell_count = 0

        for id, spell in pairs(all_spells) do
            -- For Buffs of Spells
            local status = '0'
            if spell.status then status = spell.status end

            formattedString = formattedString..spell.id..'|'..spell.en..'|'..spell.cast_time..'|'..spell.mp_cost..'|'..spell.range..'|'..spell.type..'|'..targets_table(spell.targets)..'|'..status..','

            if spell.id and tonumber(spell.id) > tonumber(all_spell_count) then
                all_spell_count = spell.id
            end

        end
        formattedString = formattedString:sub(1, #formattedString - 1)
        --log(formattedString)
        return formattedString..'_'..all_spell_count
    end

    function get_spell_recast()
        local formattedString = "spells_"
        spell_recasts = get_spell_recasts()
        if not spell_recasts then return formattedString end

        for index, recast in pairs(player_spells) do
            formattedString = formattedString..recast..'|'..string.format("%.2f",spell_recasts[recast])..','
        end
        formattedString = formattedString:sub(1, #formattedString - 1)
        --log(formattedString)
        return formattedString
    end

    function get_trust_recast()
        local formattedString = "trusts_"
        if not spell_recasts then return formattedString end

        for index, recast in pairs(player_trusts) do
            formattedString = formattedString..recast..'|'..string.format("%.2f",spell_recasts[recast])..','
        end
        formattedString = formattedString:sub(1, #formattedString - 1)
        --log(formattedString)
        return formattedString
    end

     -- Call this on initial load, job change, and periodically (30 sec)
    function get_player_spells()

        -- Clear the old spell list
        player_spells = {}
        player_trusts = {}

        -- Load in the player data
        local p = get_player_data()
        if not p then return end

        -- Try to get the spell data from the game
        local spells_have = nil

        repeat
            spells_have = get_spells()
            if not spells_have then
                sleep_time(.1)
            end
        until spells_have
        
        for id, spell in pairs (all_spells) do
            if spells_have[id] == true then
                if spell.type == "Trust" then
                    table.insert(player_trusts, id)
                else
                    for job, level in pairs (spell.levels) do
                        if(job == p.main_job_id and level > 99) then -- Merit spell.  You have learned since it appears from the windower.ffxi.get_spells()
                            level = 99
                        end
                        if (job == p.main_job_id and level <= p.main_job_level) or (job == p.sub_job_id and level <= p.sub_job_level) then
                            table.insert(player_spells, id)
                            break
                        end
                    end
                end
            end
        end
    end

    function get_spell(id)
        return all_spells[id]
    end
end