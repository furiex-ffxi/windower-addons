function commands(cmd, args)
    if cmd ~= nil then
        cmd = cmd:lower()
        log(args)
        if cmd == "start" or cmd == "on" or (cmd == "toggle" and not get_enabled()) then
            start_command(args)
        elseif cmd == "stop" or cmd == "off" or (cmd == "toggle" and get_enabled()) then
            stop_command(args)
        elseif cmd == "follow" then
            follow_command(args)
        elseif cmd == "all" then
            all_command(args)
        elseif cmd == "load" then
            load_command(args)
        elseif cmd == "reflect" then
            reflect_command(args)
        elseif cmd == 'debug' then
            debug_command() -- via Display.lua
        elseif cmd == 'info' then
            info_command() -- via Display.lua
        elseif cmd == 'display' then
            display_command() -- via Display.lua
        elseif cmd == 'reset' then
            reset_command(args)
        elseif cmd == 'sortie' then
            sortie_command(args)
        elseif cmd == 'zero' then
            zero_command()
        elseif cmd == 'protection' then
            get_protection_report()
        elseif cmd == "input" then
            input_message(args[1], args[2], args[3]) -- sm input JobAbility 99 125
        elseif cmd == "script" then
            send_packet(get_player_id()..";script")
        elseif cmd == 'mirror' then
            send_packet(get_player_id()..";mirror_request")
        end
    end
end

function start_command(args)
    if args[1] then
        local sub_command = args[1]:lower()
        if sub_command == "all" then
            que_packet("start_all")
        end
    else
        que_packet("start")
    end
end

function stop_command(args)
    if args[1] then
        local sub_command = args[1]:lower()
        if sub_command == "all" then
            que_packet("stop_all")
        end
    else
        que_packet("stop")
    end
end

function reset_command(args)
    if args and #args > 1 then
        log('Defined Reset Menu ID: ['..args[1]..'] NPC Index: ['..args[2]..']')
        npc_reset(args[1], args[2]) -- via Mirror.lua
    else
        log('Default Reset')
        npc_reset() -- via Mirror.lua
    end
end

function follow_command(args)
    if not args[1] then return end
    local sub_command = args[1]:lower()
    if sub_command == 'off' then
        que_packet("follow_off_")
    elseif sub_command == 'on' then
        que_packet("follow_on_"..args[2])
    elseif sub_command == 'toggle' then
        if get_following() then
            que_packet("follow_off_")
        else
            if args[2] then
                que_packet("follow_on_"..args[2])
            end
        end
    elseif sub_command and #sub_command > 0 then
        que_packet("follow_on_"..sub_command)
    end
end

function all_command(args)
    if not args[1] then return end
    local sub_command = args[1]:lower()
    if sub_command == 'mirror' then info("Don't do that - use sm mirror instead") end
    if sub_command == 'start' or sub_command == 'on' or (sub_command == "toggle" and not get_enabled()) then
        que_packet("start_all")
    elseif sub_command == 'off' or sub_command == 'stop' or (sub_command == "toggle" and get_enabled()) then
        que_packet("stop_all")
    elseif sub_command == 'follow' then
        if get_following() then
            local target = get_fast_follow_target()
            if target.name == get_player_name() then
                que_packet("follow_all_none")
            else
                que_packet("follow_all_")
            end
        else
            que_packet("follow_all_")
        end
    elseif sub_command == 'load' then
        local smModePath = ""
        for i = 2, #args do smModePath = smModePath..args[i].."_" end
        smModePath = smModePath:sub(1, #smModePath - 1)
        que_packet("load_all_"..smModePath)
    elseif sub_command == 'reflect' then
        que_packet("reflect_all_"..args[2])
    end
end

function load_command(args)

    local p = get_player_data()
    if not p then return end

    local smModePath = ""

    for i = 1, #args do smModePath = smModePath..args[i].."_" end

    if p.sub_job then
        que_packet("load_"..smModePath..p.main_job.."_"..p.sub_job.."_"..get_player_name())
    else
        que_packet("load_"..smModePath..p.main_job.."_"..get_player_name())
    end
end

function reflect_command(args)
    que_packet("reflect_"..args[1])
end
