do
	local last_shot_pos = {x=0, y=0}
    local last_hover = false
    local last_hover_time = os.clock()
    local hover_shot = false
	local hover_shot_id = get_res_all_buffs():with('en','Hover Shot').id
    local hover_shot_particle = false
    local command_shot = false

    function hover_distance()
        if not get_enabled() then return end
        if not command_shot then return end
        local hovershotBuff = S(get_player_data().buffs):contains(hover_shot_id)
        if not hovershotBuff then return end
        local distance = ((last_shot_pos.x-get_server_position().x)^2 + (last_shot_pos.y-get_server_position().y)^2):sqrt()
        log('Changed Distance is: ['..distance..']')
        if last_hover then
            send_command("setkey numpad6 down; wait .6; setkey numpad6 up;")
            last_hover = false
        else
            send_command("setkey numpad4 down; wait .6; setkey numpad4 up;")
            last_hover = true
        end
        command_shot = false
    end

    function set_last_hover_time(value)
        last_hover_time = value
    end

    function set_hover_shot(value)
        hover_shot = value
    end

    function set_last_shot_pos(value)
        last_shot_pos = value
    end

    function set_hover_shot_particle(value)
        hover_shot_particle = value
    end

    function get_hover_shot_particle()
        return hover_shot_particle
    end

    function set_command_shot(value)
        command_shot = value
    end

end