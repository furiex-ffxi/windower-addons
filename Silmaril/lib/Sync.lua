do
    local delay_time = .5
    local statuses = {}
    local zones = {}
    local jobs = {}
    local job_traits = {}
    local all_weather = {}
    local elements = {}
    local days = {}

    -- Called from Connection.lua
    function initialize()

        -- Make sure the player is logged in
        while not validate_load() do sleep_time(1) end

        -- Player is now loaded and can progress

        -- Do a first time read on the player
        update_player_info()

        -- gets the spells the player can use via Spells.lua
        get_player_spells()

        -- Set a random time to offset the players
        random_delay(get_player_id())

        -- sleep a random duration
        sleep_time(delay_time)
    end

    function validate_load()

        -- Direct call to game memory for initial load
        local player = get_player()
        if not player then return false end

        local player_info = get_mob_by_id(player.id)
        if not player_info then return false end

        local world = get_info()
        if not world then return false end

        return true
    end

    function random_delay(id)
        math.randomseed(os.time() + id)
        math.random()
        math.random()
        math.random()
        delay_time = math.random(1, 5000) / 10000
    end

    function sync_data(type)
        if type == 'spells' then
            send_packet(get_all_spells()) -- Spells.lua
        elseif type == 'abilities' then
            send_packet(get_all_abilities()) -- Abilities.lua
        elseif type == 'buffs' then
            send_packet(get_all_buffs()) -- Buffs.lua
        elseif type == 'weaponskills' then
            send_packet(get_all_weaponskills()) -- Weaponskills.lua
        elseif type == 'jobs' then
            send_packet(get_all_jobs())
        elseif type == 'traits' then
            send_packet(get_all_traits())
        elseif type == 'status' then
            send_packet(get_all_status())
        elseif type == 'zones' then
            send_packet(get_all_zones())
        elseif type == 'cities' then
            send_packet(get_all_cities())
        elseif type == 'weather' then
            send_packet(get_all_weather())
        elseif type == 'day' then
            send_packet(get_all_day())
        elseif type == 'monster' then
            send_packet(get_all_monster_abilities())
        elseif type == 'monster2' then
            send_packet(get_all_monster_abilities2())
        elseif type == 'monster3' then
            send_packet(get_all_monster_abilities3())
        end
        -- Speed up the sync process so send a follow up request
        request()
    end

    function get_all_jobs()
        local formattedString = get_player_id()..";jobdata_"
        local all_jobs_count = 0
        jobs = get_res_all_jobs()
        for id, job in pairs(jobs) do
            formattedString = formattedString..job.id..'|'..job.en..'|'..job.ens..','
            if job.id and tonumber(job.id) > tonumber(all_jobs_count) then
                all_jobs_count = job.id
            end
        end
        formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_jobs_count
        --log(formattedString)
        return formattedString
    end

    function get_all_traits()
        local formattedString = get_player_id()..";traitdata_"
        local all_traits_count = 0
        job_traits = get_res_all_job_traits()
        for id, trait in pairs(job_traits) do
            formattedString = formattedString..trait.id..'|'..trait.en..','
            if trait.id and tonumber(trait.id) > tonumber(all_traits_count) then
                all_traits_count = trait.id
            end
        end
        formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_traits_count
        --log(formattedString)
        return formattedString
    end

    function get_all_status()
        local formattedString = get_player_id()..";statusdata_"
        local all_status_count = 0
        statuses = get_res_all_statuses()
        for id, status in pairs(statuses) do
            formattedString = formattedString..status.id..'|'..status.en..','
            if status.id and tonumber(status.id) > tonumber(all_status_count) then
                all_status_count = status.id
            end
        end
        formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_status_count
        --log(formattedString)
        return formattedString
    end

    function get_all_zones()
        local formattedString = get_player_id()..";zonedata_"
        local all_zone_count = 0
        zones = get_res_all_zones()
        for id, zone in pairs(zones) do
            local can_pet = false
            if zone.can_pet then
                can_pet = true
            end
            formattedString = formattedString..zone.id..'|'..zone.en..'|'..tostring(can_pet)..','
            if zone.id and tonumber(zone.id) > tonumber(all_zone_count) then
                all_zone_count = zone.id
            end
        end
        formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_zone_count
        --log(formattedString)
        return formattedString
    end

    function get_all_cities()
        local formattedString = get_player_id()..";citydata_"
        local all_city_count = 0
        -- City areas for town gear and behavior.
        local Cities = {"Ru'Lude Gardens","Upper Jeuno","Lower Jeuno","Port Jeuno","Port Windurst","Windurst Waters","Windurst Woods","Windurst Walls","Heavens Tower","Port San d'Oria","Northern San d'Oria",
	    "Southern San d'Oria","Chateau d'Oraguille","Port Bastok","Bastok Markets","Bastok Mines","Metalworks","Aht Urhgan Whitegate","The Colosseum","Tavnazian Safehold","Nashmau","Selbina",
	    "Mhaura","Rabao","Norg","Kazham","Eastern Adoulin","Western Adoulin","Celennia Memorial Library","Mog Garden","Leafallia"}
    
        for id, city in pairs(Cities) do
            formattedString = formattedString..city..','
            all_city_count = all_city_count + 1
        end
        formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_city_count
        --log(formattedString)
        return formattedString
    end

    function get_all_weather()
        local formattedString = get_player_id()..";weatherdata_"
        local all_weather_count = 0
        all_weather = get_res_all_weather()
        elements = get_res_all_elements()
        for id, weather in pairs(all_weather) do
            formattedString = formattedString..weather.id..'|'..weather.en..'|'..elements[weather.element].en..'|'..weather.intensity..','
            if weather.id and tonumber(weather.id) > tonumber(all_weather_count) then
                all_weather_count = weather.id
            end
        end
        formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_weather_count
        --log(formattedString)
        return formattedString
    end

    function get_all_day()
        local formattedString = get_player_id()..";daydata_"
        local all_day_count = 0
        local days = get_res_all_days()
        elements = get_res_all_elements()
        for id, day in pairs(days) do
            formattedString = formattedString..day.id..'|'..day.en..'|'..elements[day.element].en..','
            if day.id and tonumber(day.id) > tonumber(all_day_count) then
                all_day_count = day.id
            end
        end
        formattedString = formattedString:sub(1, #formattedString - 1)..'_'..all_day_count
        --log(formattedString)
        return formattedString
    end

    function get_delay_time()
        return delay_time
    end

    function get_zone(value)
       return zones[value]
    end

end