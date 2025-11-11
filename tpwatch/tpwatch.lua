_addon.name = 'tpwatch'
_addon.author = 'Kayte'
_addon.version = '1.0'
_addon.commands = {'tpwatch', 'tpw'}

require('lists')
require('chat')
config = require('config')
texts = require('texts')
packets = require('packets')
require('logger')

local defaults = {
	box = {
		pos = {x = 150, y = 750},
		bg = {visible = true},
		flags = {bold = true, draggable = true},
		text = {size = 12, font = 'Consolas'},
	},
	colors = {
		default = L{255, 255, 255},
		safe = L{0, 255, 0},
		caution = L{255, 255, 0},
		danger = L{255, 0, 0},
	},
	levels = {
		amount = {safe = 0, caution = 200, danger = 300},
		recast = {safe = 12, caution = 18, danger = 30},
	},
	timeout = 180,
}
local settings = config.load(defaults)
local box = texts.new(settings.box)

local absorbs = T{}
local last_absorb = 0
local last_target = {id = 0}
local resisted = -1

local function log_chat(s) windower.add_to_chat(007, 'tpwatch: ' .. s) end
local function party_chat(s) windower.chat.input('/p ' .. s) end

local function box_line(name, tp, diff)
	local tp_color = settings.colors.default
	local time_color = settings.colors.default

	if tp == resisted or tp >= settings.levels.amount.danger then
		tp_color = settings.colors.danger
	elseif tp >= settings.levels.amount.caution then
		tp_color = settings.colors.caution
	elseif tp >= settings.levels.amount.safe then
		tp_color = settings.colors.safe
	else
		tp_color = settings.colors.default
	end

	if diff >= settings.levels.recast.danger then
		time_color = settings.colors.danger
	elseif diff >= settings.levels.recast.caution then
		time_color = settings.colors.caution
	elseif diff >= settings.levels.recast.safe then
		time_color = settings.colors.safe
	else
		time_color = settings.colors.default
	end
	
	tp = tp == resisted and "Resisted!" or tp .. ' TP'
	diff = diff == 0 and "Just now" or diff .. 's ago'
	
	return '[%s] %s (%s)':format(name, tp:text_color(unpack(tp_color)), diff:text_color(unpack(time_color)))
end

local function update_box(now)
	box:clear()		
	if absorbs:empty() or not absorbs[last_target.id] or absorbs[last_target.id]:empty() then
		box:hide()
	else
		box:append("Absorb-TP Watch - " .. last_target.name)
		for data in absorbs[last_target.id]:it() do
			box:appendline(box_line(data.name, data.amount, now - data.time))
		end
		box:show()
	end
end

local function update()
	if absorbs:empty() then
		box:clear()
		return
	end
	
	local now = os.time()
	if now > last_absorb + settings.timeout then
		log_chat("No absorbs for " .. settings.timeout .. " seconds, resetting.")
		absorbs:clear()
	end
	update_box(now)
end

local function reset()
	absorbs:clear()
	update_box()
end

local function log_status(last)
	if absorbs:empty() or not absorbs[last_target.id]or absorbs[last_target.id]:empty() then
		log_chat("No absorbs currently recorded!")
		return
	end
	
	if last then
		local data = absorbs[last_target.id]:last()
		if data.amount ~= resisted then
			party_chat("%s's last Absorb-TP on %s was for %d TP.":format(data.name, last_target.name, data.amount))
		else
			party_chat("%s's last Absorb-TP on %s was resisted!":format(data.name, last_target.name))
		end
	else
		local now = os.time()
		party_chat("Party's last Absorb-TP usages on %s:":format(last_target.name))
		for data in absorbs[last_target.id]:it() do
			coroutine.sleep(1.2)
			if data.amount ~= resisted then
				party_chat("%s for %d TP %d seconds ago.":format(data.name, data.amount, now - data.time))
			else
				party_chat("%s was resisted %d seconds ago.":format(data.name, now - data.time))
			end
		end
	end
end

windower.register_event('load', function()
	last_target = windower.ffxi.get_mob_by_target('t') or {id = 0}
	update:loop(1)
end)

windower.register_event('addon command', function(...)
	local args = T{...}
	local cmd = args and args[1] or ''

    if cmd == 'reset' or cmd == 'r' then
		reset()
	elseif cmd == 'status' or cmd == 's' then
		log_status(false)
	elseif cmd == 'last' or cmd == 'l' then
		log_status(true)
	else
		log_chat("Commands are r[eset], s[tatus], and l[ast].")
    end
end)

windower.register_event('incoming chunk', function(id, original)
	--Action
	if id == 0x028 then
		local action = packets.parse('incoming', original)
		local actor = windower.ffxi.get_mob_by_id(action['Actor'])
		if not actor or not actor.in_party or not actor.in_alliance then
			return
		end
	
		--Absorb-TP only
		if action['Category'] == 4 and action['Param'] == 275 then
			local data = {}
			data.name = actor.name
			data.time = os.time()
			
			if action['Target 1 Action 1 Message'] == 454 then
				data.amount = action['Target 1 Action 1 Param']
			else
				data.amount = resisted --Resist
			end
			
			local target = action['Target 1 ID']
			if not absorbs[target] then
				absorbs[target] = L{}
			end
			
			--Replace previous
			for i = 1, absorbs[target]:length() do
				if absorbs[target][i].name == data.name then
					absorbs[target]:remove(i)
					break
				end
			end
			
			absorbs[target]:append(data)
			last_absorb = data.time
		end
	--Action Message
	elseif id == 0x029 then
		local message = packets.parse('incoming', original)

		--Defeats/Falls to the ground
		if message['Message'] == 6 or message['Message'] == 20 then
			local target = message['Target']
			if absorbs[target] then
				absorbs[target]:clear()
				absorbs[target] = nil
			end
		end
	end
end)

windower.register_event('target change', function(index)
	local new_target = windower.ffxi.get_mob_by_index(index)
	if new_target and new_target.is_npc and new_target.id ~= last_target.id then
		last_target = new_target
		update_box(os.time())
	end
end)

windower.register_event('zone change', reset)
windower.register_event('logout', reset)
