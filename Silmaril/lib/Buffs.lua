do
    local party_buffs = {}
    local all_buffs = get_res_all_buffs()

    -- This is only for other members in the party (Not the player)
    function run_buffs(data)

        -- Clear the table
        party_buffs = {}

        local player_id = tonumber(get_player_id())

        for k = 0, 5 do
            local formattedString = ''
            local buff_string = ''
            local Uid = data:unpack('I', k * 48 + 5)

            -- Limit packets being sent and dont send self (grabs it from status update)
            if Uid and Uid ~= player_id and Uid ~= 0 then
                formattedString = "partybuffs_"..Uid.."_"

                for i = 1, 32 do
                    local current_buff = data:byte(k * 48 + 5 + 16 + i - 1) + 256 * (math.floor(data:byte(k * 48 + 5 + 8 + math.floor((i - 1) / 4)) / 4 ^ ((i - 1) % 4)) % 4)
                    if current_buff ~= 255 and current_buff ~= 0 then
                        buff_string = buff_string..current_buff..","
                    end
                end

                if #buff_string > 1 then buff_string = buff_string:sub(1, #buff_string - 1) end

                party_buffs[Uid] = formattedString..buff_string
                --log(formattedString)
            end
        end
    end

    -- Only called once so don't load the resource in memory
    function get_all_buffs()
        local formattedString = get_player_id()..";buffdata_"
        local all_buff_count = 0
        local index = get_geo_maps() -- Mapping from Maps.lua

        for id, buff in pairs(all_buffs) do
            if index[buff.id] then
                buff.en = index[buff.id]
            end
            formattedString = formattedString..buff.id..'|'..buff.en..','
            if buff.id and buff.id > all_buff_count then
                all_buff_count = buff.id
            end
        end
        formattedString = formattedString:sub(1, #formattedString - 1)
        --log(formattedString)
        return formattedString..'_'..all_buff_count
    end

    function get_party_buffs()
        return party_buffs
    end

    function get_buff(id)
        return all_buffs[id]
    end

end