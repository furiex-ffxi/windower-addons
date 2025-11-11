do
    local packets = require 'packets'

    packets.raw_fields.incoming[0x009] = 
    L{
        {ctype='data[17]',              label='_dummy1'},                -- 70
        {ctype='char*',                 label='Name'},                   -- 74
    }

    local res = require 'resources'

    -- Regester Events

    function windower_hook()

	    --Commands recieved and sent to addon
        windower.register_event('addon command', function(input, ...)
            log('Input Log ['..input..']')
            local args = L{...}
            commands(input, args)
        end)

        -- Begin the sync process
        windower.register_event('load', function()
            connect() -- Start process of connecting via the Connection.lua
        end)

        -- Used to track incoming information
        windower.register_event('incoming chunk', function (id, data, modified, injected, blocked)
            -- process the packets via Packets.lua
            local block_message = message_in(id, data)

            -- Block this incoming packet
            if block_message then return true end

            -- Process packet via Protection.lua
            return protection_in(id, data, modified)
        end)

        -- Used to track outgoing information
        windower.register_event('outgoing chunk', function (id, data, modified, injected, blocked)

            -- process the packets via Packets.lua
            local block_message, built_message = message_out(id, data)

            --Block this outgoing packet
            if block_message then return true end

            --A built message was created
            if built_message then return built_message end

            -- Process packet via Protection.lua
            return protection_out(id, data, modified)
        end)

        --IPC messaging between characters for fast data transfer
        windower.register_event('ipc message', function(msg)
            IPC_Action(msg)
        end)

        -- Used to reload profiles and sync
        windower.register_event('job change', function()
            get_player_info() -- Called in Player.lua
            get_player_spells() -- Called in Spells.lua
            set_auto_load(true) -- Called in Engine.lua
        end)

        windower.register_event('logout', function()
            send_packet(get_player_id()..";reset")
            set_connected(false)
            clear_party_location()
        end)

        windower.register_event('unload', function()
            send_packet(get_player_id()..";reset")
            set_connected(false)
            clear_party_location()
        end)

        windower.register_event('chat message', function(message,sender,mode,gm)
            if get_protection() and get_name_cache()[sender] then sender = get_name_cache()[sender] end
            if mode == 3 then sender = sender..'>>' end
            que_packet('chat_'..mode..'_'..sender..'_'..from_shift_jis(message))
	    end)

    end

    function windower_auto_trans(msg) 
        return windower.convert_auto_trans(msg)
    end

    -- Resources

    function get_res_all_job_abilities()
	    return res.job_abilities
    end

    function get_res_all_buffs()
	    return res.buffs
    end

    function get_res_all_jobs()
	    return res.jobs
    end

    function get_res_all_job_traits()
	    return res.job_traits
    end

    function get_res_all_statuses()
	    return res.statuses
    end

    function get_res_all_zones()
	    return res.zones
    end

    function get_res_all_weather()
	    return res.weather
    end

    function get_res_all_days()
	    return res.days
    end

    function get_res_all_elements()
	    return res.elements
    end

    function get_res_all_skills()
	    return res.skills
    end

    function get_res_all_items()
	    return res.items
    end

    function get_res_all_spells()
	    return res.spells
    end

    function get_res_all_weaponskills()
	    return res.weapon_skills
    end

    function get_res_all_monster_abilities()
	    return res.monster_abilities
    end

    -- Game Data

    function get_abilities()
	    return windower.ffxi.get_abilities()
    end

    function get_player()
	    return windower.ffxi.get_player()
    end

    function get_party()
	    return windower.ffxi.get_party()
    end

    function get_info()
	    return windower.ffxi.get_info()
    end

    function get_spell_recasts()
	    return windower.ffxi.get_spell_recasts()
    end

    function get_spells()
	    return windower.ffxi.get_spells()
    end

    function get_ability_recasts()
	    return windower.ffxi.get_ability_recasts()
    end

    function get_mob_by_id(value)
        if not value then return end
        local mob = windower.ffxi.get_mob_by_id(value)
        if not mob then return end
        -- Round to two digits
        mob.x = round(mob.x, 2)
        mob.y = round(mob.y, 2)
        mob.z = round(mob.z, 2)
        mob.heading = round(mob.heading, 2)
	    return mob
    end

    function get_mob_by_index(value)
        if not value then return end
        local mob = windower.ffxi.get_mob_by_index(value)
        if not mob then return end
        -- Round to two digits
        mob.x = round(mob.x, 2)
        mob.y = round(mob.y, 2)
        mob.z = round(mob.z, 2)
        mob.heading = round(mob.heading, 2)
	    return mob
    end

    function get_mob_array()
	    return windower.ffxi.get_mob_array()
    end

    function get_items(value)
        if value then 
            return windower.ffxi.get_items(value)
        else
            return windower.ffxi.get_items()
        end
    end

    function get_screen_size_x()
        return windower.get_windower_settings().ui_x_res
    end

    function get_screen_size_y()
        return windower.get_windower_settings().ui_y_res
    end

    -- FFXI Game commands

    function player_run(value)
        windower.ffxi.run(value)
    end

    function player_turn(value)
        windower.ffxi.turn(value)
    end

    -- Misc commands

    function send_command(value)
	    windower.send_command(value)
    end

    function send_chat(value)
	    windower.chat.input(value)
    end

    function send_to_chat(color, value)
        windower.add_to_chat(color, value)
    end

    function send_ipc(value)
	    windower.send_ipc_message(value)
    end

    function is_japanese()
        local is_japanese = false
        if windower.ffxi.get_info().language:lower() == "japanese" then is_japanese = true end
        return is_japanese
    end

    function from_shift_jis(value)
        return windower.from_shift_jis(value)
    end

    function to_shift_jis(value)
        return windower.to_shift_jis(value)
    end

    -- Packet specific calls

    function parse_action_packet(data)
        return windower.packets.parse_action(data)
    end

    function cancel_buff(value)
        windower.packets.inject_outgoing(0xF1,string.char(0xF1,0x04,0,0,string.format("%i",value)%256,math.floor(string.format("%i",value)/256),0,0))
    end

    -- these represent the bits
    -- 8 bits in a byte
    local sizes = {
        ['unsigned char']   =  8,
        ['unsigned short']  = 16,
        ['unsigned int']    = 32,
        ['unsigned long']   = 64,
        ['signed char']     =  8,
        ['signed short']    = 16,
        ['signed int']      = 32,
        ['signed long']     = 64,
        ['char']            =  8,
        ['short']           = 16,
        ['int']             = 32,
        ['long']            = 64,
        ['bool']            =  8,
        ['float']           = 32,
        ['double']          = 64,
        ['data']            =  8,
        ['bit']             =  1,
        ['boolbit']         =  1,
    }


    --  Type identifiers as declared in lpack.c
    --  Windower uses an adjusted set of identifiers
    --  This is marked where applicable
    --  local pack_ids = {}
    --  pack_ids['bit']             = 'b'   -- Windower exclusive
    --  pack_ids['boolbit']         = 'q'   -- Windower exclusive
    --  pack_ids['bool']            = 'B'   -- Windower exclusive
    --  pack_ids['unsigned char']   = 'C'   -- Originally 'b', replaced by 'bit' for Windower
    --  pack_ids['unsigned short']  = 'H'
    --  pack_ids['unsigned int']    = 'I'
    --  pack_ids['unsigned long']   = 'L'
    --  pack_ids['signed char']     = 'c'
    --  pack_ids['signed short']    = 'h'
    --  pack_ids['signed int']      = 'i'
    --  pack_ids['signed long']     = 'L'
    --  pack_ids['char']            = 'c'
    --  pack_ids['short']           = 'h'
    --  pack_ids['int']             = 'i'
    --  pack_ids['long']            = 'l'
    --  pack_ids['float']           = 'f'
    --  pack_ids['double']          = 'd'
    --  pack_ids['data']            = 'A'



    function cancel_menu(value)
        windower.packets.inject_incoming(0x052, 'ICHC':pack(0,2,value,0))
    end

    function mirror_reset(value)
        windower.packets.inject_incoming(0x052, 'ICHC':pack(0,2,value,0)) -- Event Skip
        windower.packets.inject_incoming(0x052, string.char(0,0,0,0,0,0,0,0)) -- Standard Release
        windower.packets.inject_incoming(0x052, string.char(0,0,0,0,1,0,0,0)) -- Event Relase
    end

    -- Packet library

    function inject_packet(value)
	    packets.inject(value)
    end

    function inject_packet_outgoing(id, value)
        windower.packets.inject_outgoing(id, value)
    end

    function new_packet(dir, id, values, ...)
	    return packets.new(dir, id, values, ...)
    end

    function build_packet(value)
        return packets.build(value)
    end

    function parse_packet(dir, data)
        return packets.parse(dir, data)
    end

    -- Core lua

    function sleep_time(value)
        coroutine.sleep(value)
    end

end