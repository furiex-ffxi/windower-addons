--[[Copyright © 2019, Cyrite

Path v1.0.0

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of <addon name> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <your name> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name = 'Path'
_addon.author = 'Cyrite'
_addon.version = '1.0.0'
_addon.command = 'path'

require('action')
require('wait')
require('chat')
require('lists')
require('coroutine')
require('queues')
require('sets')
require('logger')
require('tables')
require('sets')
require('strings')
require('actions')
require('vectors')
require('lists')

local packets = require('packets')
local res = require('resources')
local math = require('math')
local WalkAction = require('walk')

config = require('config')

defaults = {}
defaults.walkspeed = 5
defaults.interval= 1
defaults.paths = {}
defaults.paths.palborough = {}
defaults.paths.palborough.zoneid = 143
defaults.paths.palborough.repeatdelay = 5
defaults.paths.palborough.points = T{}

settings = config.load(defaults)

local state = {
	[0] = 'Idle',
    [1] = 'Running',
    [2] = 'Stuck',
    [3] = 'Paused',
    [4] = 'Resetting',
    [5] = 'Recording',
}

local transitions = {
	['Idle'] = L{
		state[1],
		state[2],
		state[3],
	},
	['Running'] = L{
		state[0],
		state[2],
		state[3],
	},
	['Stuck'] = L{
		state[0],
		state[1],
		state[3],
	},
	['Paused'] = L{
		state[0],
		state[5],
	},
	['Resetting'] = L{
		state[3],
	},
	['Recording'] = L{
		state[3],
	}
}

local current_state = state[3] -- Paused
local current_state_enter_timestamp = nil

-- Forward delcared functions

local transition_to_state
local replay_actions
local index_of_closest_action
local direction_to_point

local handlers = {}
local actions = L{}
local current_index = 1
local zone_id = nil
local player_rotation = 0
local doors = T{}
local repeat_delay = 5

-- State

local function did_transition_to_state(new_state, old_state)
	notice("Transitioned from %s to %s":format(old_state, new_state))

	if new_state == state[0] then -- Idle
		transition_to_state(state[1])

	elseif new_state == state[1] then   -- Running
		local start_index = index_of_closest_action()
		
		if start_index then
			notice("start index: %d":format(start_index))

			current_index = start_index

			perform_action(actions[current_index], 0)
		else
			transition_to_state(state[3])
		end

	elseif new_state == state[2] then   -- Stuck
		windower.ffxi.run(false)

	elseif new_state == state[3] then   -- Paused
		windower.ffxi.run(false)

	elseif new_state == state[4] then   -- Resetting
		actions = L{}
		current_index = 1

		transition_to_state(state[3])

	elseif new_state == state[5] then  -- Recording
		notice("Recording")
	else
		error("Invalid state %s":format(new_state))
	end

end

function transition_to_state(new_state)
	coroutine.sleep(0.5)

	if transitions[current_state]:contains(new_state) then
		local old_state = current_state
		current_state = new_state
		current_state_enter_timestamp = os.time()

		did_transition_to_state(new_state, old_state)
		return true
	end
	return false
end

local function get_time_in_current_state()
	if not current_state_enter_timestamp then
		return 0
	else
		return os.time() - current_state_enter_timestamp
	end
end

-- Math

function direction_to_point(X,Y)
	local X = X - windower.ffxi.get_mob_by_id(windower.ffxi.get_player().id).x
	local Y = Y - windower.ffxi.get_mob_by_id(windower.ffxi.get_player().id).y
	local H = math.atan2(X,Y)
	return H - 1.5708
end

local function get_player_position()
	local player = windower.ffxi.get_mob_by_id(windower.ffxi.get_player().id)

	local v = vector.zero(3)

	v[1] = player.x
	v[2] = player.y
	v[3] = player.z

	return v
end

local function distance(v1, v2)
	if not v1 or not v2 then
		return 0
	end

	return math.sqrt((v1[1]-v2[1])^2+(v1[2]-v2[2])^2+(v1[3]-v2[3])^2)
end

function index_of_closest_action()
	if actions:empty() then
		return nil
	end

	local min_distance = math.huge
	local index = 1

	for i, action in pairs(actions) do
		if tonumber(i) ~= nil then
			local dist = distance(get_player_position(), action:get_position())
    		if dist < min_distance then
    			min_distance = dist
    			index = i
    		end
		end
    end
    return index
end

-- Helpers

local function resume()
	transition_to_state(state[0]) -- Idle
end

local function pause()
	transition_to_state(state[3]) -- Paused
end

-- Actions

function perform_action(action)
	if current_state == 'Paused' or current_state == 'Resetting' then
		return
	end

	--notice("Performing action %s":format(action:tostring()))

	local completion = function(success)
		if success then
			coroutine.schedule(perform_next_action, 0.0)
		else
			transition_to_state(state[2]) -- Stuck
		end
	end

	action:perform(completion)
end

function perform_next_action()
	if current_state == 'Paused' or current_state == 'Resetting' then
		return
	end

	current_index = current_index + 1

	if not actions:empty() and current_index <= actions:length() then
		local action = actions[current_index]
		if action then
			perform_action(action)
		else
			transition_to_state(state[3]) -- Paused
		end
	else
		notice("Finished all actions, repeating in "..repeat_delay..".")

		windower.ffxi.run(false)

		actions = actions:reverse()
		current_index = 1

		coroutine.schedule(perform_next_action, repeat_delay)
	end
end

function replay_actions()
	if not actions:empty() then
		local start_index = index_of_closest_action()

		notice("Start index: %d":format(start_index))

		local action = actions[start_index]

		local dist = distance(get_player_position(), action:get_position())
		if dist > 16 then
			error("You are too far from the path")
			transition_to_state(state[3]) -- Paused
		else
			transition_to_state(state[0]) -- Idle
		end
	end
end

local function record_point()
	if current_state ~= 'Recording' then
		return
	end

	local p = get_player_position()

	local t = T{}

	t['x'] = p[1]
	t['y'] = p[2]
	t['z'] = p[3]

	local action = WalkAction(t)
	actions:append(action)

	notice("Appending %s":format(action:tostring()))

	coroutine.schedule(record_point, settings.interval)
end

local function begin_recording()
	if not actions:empty() then
		error("Usage: path clear, path record")
		return false
	end

	transition_to_state(state[5]) -- Recording

	notice("Started recording")

	record_point()
end

local function stop_recording()
	if current_state ~= 'Recording' then
		error("Usage: path record, path stop")
		return
	end

	actions = actions:reverse()

	transition_to_state(state[3]) -- Paused

	notice("Stopped recording")
end


-- Handlers

local function handle_record()
	transition_to_state(state[3]) -- Paused

	begin_recording()	
end

local function handle_stop()
	stop_recording()
end

local function handle_replay()
	if current_state ~= 'Paused' then
		error("Usage: path record, path stop, path replay")
		return
	end

	replay_actions()
end

local function handle_pause()
	pause()
end

local function handle_resume()
	resume()
end

local function handle_clear()
	transition_to_state(state[4]) -- Resetting
end

local function handle_save(name)
	if name == 'default' or not name then
        error('Invalid path name')
        return
    end

    transition_to_state(state[3]) -- Paused

    local savedpath = T{}
    local points = T{}

    for i=1, path:length(),1 do
    	local p = path[i]
    	if p then 
    		points[i] = {}
    		points[i].x = p[1]
    		points[i].y = p[2]
    		points[i].z = p[3]
    	end
    end

    local repeatdelay = 20
	local doors = T{}

    if settings.paths[name] ~= nil then
    	repeatdelay = settings.paths[name].repeatdelay or 20
    	doors = settings.paths[name].doors or T{}
    end

    savedpath.zoneid = windower.ffxi.get_info().zone
    savedpath.repeatdelay = repeatdelay	
    savedpath.points = points
    savedpath.doors = doors

    settings.paths[name] = savedpath

    config.save(settings)

    notice('Path '..name..' saved.')
end

local function handle_load(name)
	if not settings.paths[name] then
		notice('Unable to find path named '..name..'.')
	else
		local zone_id = tonumber(settings.paths[name].zoneid)
		if not zone_id or zone_id ~= windower.ffxi.get_info().zone then
			notice("Path "..name.." does not match this zone")
			return
		end

		transition_to_state(state[4]) -- Resetting

		local new_actions = L{}

		local points = settings.paths[name].points

		-- Init with zeroes
		for i=1,points:length(),1 do
			new_actions:append(0)
		end

		if points then
			for k, p in pairs(points) do
				local index = tonumber(k)
				if index then
					new_actions[index] = WalkAction.new(p.x, p.y, p.z)
				end
			end
		end

		actions = new_actions
		
		repeat_delay = settings.paths[name].repeatdelay or 20

		notice("Loaded path "..name.."")
	end
end


-- Register Handlers

handlers['record'] = handle_record
handlers['stop'] = handle_stop
handlers['replay'] = handle_replay
handlers['pause'] = handle_pause
handlers['resume'] = handle_resume
handlers['clear'] = handle_clear
handlers['save'] = handle_save
handlers['load'] = handle_load


local function handle_command(cmd, ...)
    local cmd = cmd or 'help'
    if handlers[cmd] then
        local msg = handlers[cmd](unpack({...}))
        if msg then
            error(msg)
        end
    else
        error("Unknown command %s":format(cmd))
    end
end

windower.register_event('addon command', handle_command)
windower.register_event('zone_change', function(new_id, old_id)
	transition_to_state(state[4])
	zone_id = new_id
end)
windower.register_event('outgoing chunk', function(id, data)
    if id == 0x015 then
        local p = packets.parse('outgoing', data)

        if p['Rotation'] then
			player_rotation = p['Rotation']
		end
	end
end)


