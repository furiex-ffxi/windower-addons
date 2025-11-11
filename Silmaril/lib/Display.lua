do
	local settings = { debug = false, info = true, npc = true, display = true, }
	local status_time = nil
	local gears = {' | ',' / ',' - ',' \\\\ '}
	local gear = 1

	-- Default Text Boxes settings

	-- Silmaril UI box
	local sm_display = texts.new("",{
		text={size=10,font='Consolas',red=255,green=255,blue=255,alpha=255},
		pos={x=0,y=0},
		bg={visible=true,red=0,green=0,blue=0,alpha=125},})

	-- NPC Mirror UI Box
	local sm_npc= texts.new("",{
		text={size=14,font='Consolas',red=255,green=255,blue=255,alpha=255},
		pos={x=0,y=0},
		bg={visible=true,red=255,green=0,blue=0,alpha=90},})

	-- Mirroring Results
	local sm_result= texts.new("",{
		text={size=14,font='Consolas',red=255,green=255,blue=255,alpha=255},
		pos={x=0,y=0},
		bg={visible=true,red=255,green=0,blue=0,alpha=125},})

	-- Debug Window
	local sm_debug = texts.new("",{ 
		text={size=10,font='Consolas',red=255,green=255,blue=255,alpha=255}, 
		pos={x=0,y=0}, 
		bg={visible=false,red=0,green=0,blue=0,alpha=125},})

	function zero_command()
		sm_display:pos_x(0)
		sm_display:pos_y(0)
	end

	function update_display()
		-- used to fade the mirror screen
        mirror_fade() 

        -- Main UI window
        if settings.display and (get_enabled() or get_following() or get_mirror_on()) then
            sm_display:show()
            sm_display:text(display_box_refresh())
        else
            sm_display:hide()
        end

        -- Debug window
        if settings.debug then
			sm_debug:show()
            sm_debug:text(debug_box_refresh())
        else
            sm_debug:hide()
        end

        -- Mirroring Window
        if get_mirroring() or get_injecting() then
            sm_npc:text(npc_box_refresh())
            sm_npc:show()
        else
            sm_npc:hide()
        end
    end

	-- Used to show if Silmaril is running
	function display_box_refresh()
		local pt_loc = get_party_location()
		local p_loc = get_player_info()
		local w = get_world()
		local maxWidth = 23

		gear_update()

		lines = T{}
		local gear_string = gears[gear]
		if not gear_string then gear_string = "" end
		lines:insert(' Silmaril...'..string.format('[%s]',gear_string):lpad(' ',maxWidth - 15 + string.len(gears[gear])))

		if get_mirror_on() and get_following() then
			sm_display:bg_color(255,0,255)
			lines:insert(' [Following] [Mirroring]')
		elseif get_following() then
			lines:insert('       [Following]')
			sm_display:bg_color(0,0,255)
		elseif get_mirror_on() then
			lines:insert('       [Mirroring]')
			sm_display:bg_color(255,0,0)
		else
			lines:insert('')
			sm_display:bg_color(0,0,0)
		end

		for index, member in pairs(pt_loc) do
			if member.zone == w.zone and p_loc and tostring(member.id) ~= get_player_id() then
				local delta = {x = member.x - p_loc.x, y = member.y - p_loc.y}
				local distance = math.sqrt(delta.x^2 + delta.y^2)
				lines:insert('  '..member.name..string.format('[%3.1f]',distance):lpad(' ',maxWidth - string.len(member.name) - 2)..'  ')
			end
		end
		lines:insert('')
		local maxWidth = math.max(1, table.reduce(lines, function(a, b) return math.max(a, #b) end, '1'))
		for i,line in ipairs(lines) do lines[i] = lines[i]:rpad(' ', maxWidth - string.len(gears[gear])) end
		sm_display:text(lines:concat('\n'))
	end

	-- Used to help debug issues 
	function debug_box_refresh()
		local maxWidth = 20 -- 20 chacaters long
		local target = get_mirror_target()
		local target_index = 'nil'
		if target and target.index then
			target_index = target.index
		end
		lines = T{}
		sm_debug:text()
		lines:insert('Enabled'..string.format('[%s]',tostring(get_enabled())):lpad(' ',13))
		lines:insert('Following'..string.format('[%s]',tostring(get_following())):lpad(' ',11))
		lines:insert('Injecting'..string.format('[%s]',tostring(get_injecting())):lpad(' ',11))
		lines:insert('Mirroring'..string.format('[%s]',tostring(get_mirroring())):lpad(' ',11))
		lines:insert('Mirror Menu'..string.format('[%s]',tostring(get_menu_id())):lpad(' ',9))
		lines:insert('Mirror Target'..string.format('[%s]',tostring(target_index)):lpad(' ',7))
		lines:insert('Protection'..string.format('[%s]',tostring(get_protection())):lpad(' ',10))
		lines:insert('Delay'..string.format('[%.4f]',get_delay_time()):lpad(' ',15))
		for i,line in ipairs(lines) do lines[i] = ' '..lines[i]:rpad(' ', maxWidth)..' ' end
		sm_debug:text(lines:concat('\n'))
	end

	-- Used to show when a player is begining a Mirror
	function npc_box_refresh()
		local target = get_mirror_target()
		local state = get_mirroring_state()
		if target and target.name then
			lines = T{}
			lines:insert('')
			lines:insert(string.format("%-40s",string.format("Mirroring Actions"):lpad(' ',29)))
			lines:insert(string.format("%-40s",string.format('[%s]',target.name):lpad(' ',21 + #target.name/2)))
			lines:insert(string.format("%-40s",string.format('[%s]',state):lpad(' ',21 + #state/2)))
			lines:insert('')
			lines:insert('')
			sm_npc:text(lines:concat('\n'))
		end
	end

	-- Displays the current status of the mirroring action
	function npc_box_status(mirror_players)
		if mirror_players then
			sm_result:bg_color(255,0,0)
			sm_result:show()
			lines = T{}
			lines:insert('')
			lines:insert(string.format("%-40s",string.format("Mirroring Results"):lpad(' ',29)))
			lines:insert('')
			local completed = 0
			local count = 0
			for index, item in pairs(mirror_players) do
				local result = index..' - '..item
				count = count + 1
				lines:insert(string.format("%-40s",string.format('[%s]',result):lpad(' ',21 + #result/2)))
				if item == "Completed" then
					completed = completed + 1
				end
			end
			if completed == count then
				sm_result:bg_color(0,255,0)
			end
			lines:insert('')
			lines:insert('')
			sm_result:text(lines:concat('\n'))
		else
			sm_npc:hide()
		end
	end

	function gear_update()
		gear = gear + 1
		if gear > 4 then
			gear = 1
		end
	end

	function mirror_fade()
		if status_time then
			local opacity = 1
			local fade_duration = 2
			local fade = 6
			local diff = os.clock() - status_time
			local alpha = 110
			if diff < fade then
				opacity = 1
			elseif diff < fade + fade_duration then
				opacity = 1 - (diff-fade) / fade_duration
			else
				opacity = 0
			end
			sm_result:bg_alpha(opacity*alpha)
			sm_result:alpha(opacity*alpha*2)
		else
			sm_result:hide()
		end
	end

	function sm_result_hide()
		status_time = nil
	end

	function get_debug_state()
		return settings.debug
	end

	function get_info_state()
		return settings.info
	end

	function debug_command()
        if settings.debug then
            settings.debug = false
			send_to_chat(80,'------- Debugging [OFF] -------')
		else
			settings.debug = true
			send_to_chat(80,'------- Debugging [ON]  -------')
		end
	end

	function info_command(value)
		if value ~= nil then
			if value then
				settings.info = true
			else
				settings.info = false
			end
		else
			if settings.info then
				settings.info = false
				send_to_chat(80,'------- Info [OFF] -------')
			else
				settings.info = true
				send_to_chat(80,'------- Info [ON]  -------')
			end
		end
	end

	function display_command(value)
		if value ~= nil then
			if value then
				settings.display = true
			else
				settings.display = false
			end
		else
			if settings.display then
				settings.display = false
				send_to_chat(80,'------- Display [OFF] -------')
			else
				settings.display = true
				send_to_chat(80,'------- Display [ON]  -------')
			end
		end
	end

	function set_status_time()
		if not status_time then
			log('Status Time set for NPC Results')
			status_time = os.clock()
		end
	end

	function get_sm_window()
		return sm_display
	end

	function set_sm_window(value)
		sm_display = value
	end

	function get_npc_window()
		return sm_npc
	end

	function set_npc_window(value)
		sm_npc = value
	end

	function get_result_window()
		return sm_result
	end

	function set_result_window(value)
		sm_result = value
	end

end