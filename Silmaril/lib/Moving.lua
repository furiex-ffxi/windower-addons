do
	local autorun_target = nil
	local fast_follow_target = nil
	local autorun_type = 0
	local autorun_distance = .5
	local face_follower = false
	local move_to_exit= false
	local move_to_exit_time = os.clock()
	local following = false
	local lock_time = os.clock()
	local move_time = os.clock()
	local now = os.clock()
	local p_loc = {}

	function movement()

		-- Get the player
		local p = get_player_data()
		if not p then runstop() return end

		-- Update the player location
		p_loc = get_player_info()
		if not p_loc then return end

		if not autorun_target then return end

		now = os.clock()

		-- no input after 2 sec so stop
		if now - move_time > 2 then runstop() return end

		-- Zone time out so reset
		if now - move_to_exit_time > 5 and move_to_exit then move_to_exit = false end

		if get_injecting() then runstop() return end

		-- Silmaril not connected
		if not get_connected() then runstop() return end

		-- Turned off actions
		if not get_enabled() and not following then 
			runstop() 
			autorun_target = nil 
			return 
		end

		-- Don't move because you are in injecting
		if get_injecting() then runstop() return end

		-- Player not able to move
		if p.status ~= 0 and p.status ~=1 and p.status ~=5 and p.status ~=85 then runstop() return end

		-- Get the world data to check for zones
		local w = get_world()
		if not w then runstop() return end

		-- Assign the target
		t = autorun_target

		-- Check for IPC data
		if autorun_type ~= 3 then 
			local pt_loc = get_party_location()
			if not pt_loc then runstop() return end
			local local_player = pt_loc[t.id]
			if local_player and local_player.zone == w.zone then
				t = local_player
			end
		end

		-- Target is not followable
		if t.status ~= 0 and t.status ~= 1 and t.status ~= 5 and t.status ~= 85 then runstop() return end

		-- Enemy dead
		if t.spawn_type == 16 and t.status > 1 then runstop() end

		-- Calculate distance
		t.distance = ((p_loc.x-t.x)^2 + (p_loc.y-t.y)^2):sqrt()

		if t.distance > 50 then runstop() return end

		-- You are far enough away so stop running
		if t.distance > autorun_distance + .1 and autorun_type == 1 then runstop() return end

		-- You are within distance so stop running
		if t.distance < autorun_distance - .1 and autorun_type > 1 then runstop() return end

		-- Handle the lock on issue
		if p.target_locked and now - lock_time > .5 then 
			send_chat("/lockon")
			lock_time = now
			return
		end

		local angle = math.atan2((t.y - p_loc.y), (t.x - p_loc.x))*-1

		if autorun_type == 1 then -- run away from a target
			angle = angle + math.pi
		end

		-- Perform the movement
		player_run(angle)
	end

	-- Command to stop
	function runstop()
		if move_to_exit then return end
		autorun_type = 0
		autorun_target = nil
		player_run(false)
	end

	-- Run away #1
	function runaway(target, distance) 
		if move_to_exit then return end
		autorun_type = 1
		autorun_target = target
		autorun_distance = tonumber(distance)
		move_time = os.clock()
	end

	-- Close distance #2
	function runto(target, distance)
		if move_to_exit then return end
		autorun_type = 2
		autorun_target = target
		autorun_distance = tonumber(distance)
		move_time = os.clock()
	end

	-- Move to a specified location #3
	function runtolocation(target,distance,option)
		if move_to_exit then return end
		autorun_type = 3
		autorun_target = target
		autorun_distance = tonumber(distance)
		move_time = os.clock()

		-- Modify the target so you can just use runto()
		run_to_location = {}
	    for item in string.gmatch(option, "([^,]+)") do
            table.insert(run_to_location, item)
        end

		autorun_target.x = tonumber(run_to_location[1])
		autorun_target.y = tonumber(run_to_location[2])
		autorun_target.z = tonumber(run_to_location[3])

		-- Change from the player ID
		autorun_target.id = 0
	end

	function face_target(target, direction)
		if move_to_exit then return end

		-- Get the world data to check for zones
		local w = get_world()
		if not w then runstop() return end

		-- Update the player location
		p_loc = get_player_info()
		if not p_loc then return end

		if target.zone and target.zone ~= w.zone then return end

		local angle = 0
		if direction == "1" then -- 1 is face target
			angle = math.atan2((target.y - p_loc.y), (target.x - p_loc.x))*-1
		elseif direction == "2" then -- 2 is face away from target
			angle = math.atan2((target.y - p_loc.y), (target.x - p_loc.x))*-1 + math.pi
		elseif direction == "3" then -- 3 is match player direction
			angle = target.heading
		elseif direction == "4" then -- 4 is oppostie of player heading
			angle = target.heading + math.pi
		else
			return
		end
		player_turn(angle)
	end

	function set_fast_follow (state, target)
		if state then
			following = true
			info('\31\200[\31\05Silmaril\31\200]\31\207'..' Following: \31\06[ON]')
			fast_follow_target = target
		else
			following = false
			info('\31\200[\31\05Silmaril\31\200]\31\207'..' Following: \31\03[OFF]')
			fast_follow_target = nil
			runstop()
		end
	end

	function lockon(target, lock)
		-- Get the player
		local p = get_player_data()
		if not p then return end
		if not get_enabled() then return end
		if p.target_locked and lock == "0" then 
			send_chat("/lockon")
		elseif not p.target_locked and lock == "1" then
			if p.target_index ~= target.index then
				local inject = new_packet("incoming", 0x058, 
				{
					['Player'] = p.id,
					['Target'] = target.id,
					['Player Index'] = p.index,
				})
				inject_packet(inject)
			else
				send_chat("/lockon")
			end
		end
	end

	function zone_check(player_id, zone, player_x, player_y, player_z, type, zone_line, door_menu)

		-- Check if following is on - if not return
		if not following then return end

		if move_to_exit then return end

		if not fast_follow_target then return end

		-- Wrong member zoned so disregard
		if fast_follow_target.id ~= tonumber(player_id) then log("Wrong Player ["..player_id.."]") return end

		-- Get the world data and retun is not correct zone
		local w = get_world()
		if not w then return end
		if tonumber(w.zone) ~= tonumber(zone) then log("Wrong Zone") return end

		local distance = ((p_loc.x-player_x)^2 + (p_loc.y-player_y)^2):sqrt()

		if distance > 25 then log("You are too far to zone") return end

		-- Reset zone targets
		runstop()

		move_to_exit = true
		move_to_exit_time = os.clock()

		if w.mog_house then
			log("Mog House zone packet injected with zone line of ["..zone_line.."]")
			local packet = new_packet('outgoing', 0x05E, 
				{
					['Zone Line'] = zone_line, 
					['MH Door Menu'] = door_menu, 
					['Type'] = type
				})
			inject_packet(packet)
		else
			log('Zone Detected - turning and running towards zone')
			local angle = math.atan2((player_y - p_loc.y), (player_x - p_loc.x))*-1
			player_run(angle)
		end
	end

	function zone_completed()
		log("Zone detected - turing off [move_to_exit]")
		move_to_exit = false
	end

	function set_following(value)
		following = value
	end

	function get_fast_follow_target()
		return fast_follow_target
	end

	function get_following()
		return following
	end

	function get_autorun_target()
		if autorun_target then
			return autorun_target.id
		else
			return 0
		end
	end

	function get_autorun_type()
		return autorun_type
	end

end