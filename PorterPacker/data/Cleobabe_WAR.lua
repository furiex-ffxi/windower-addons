-- Kale's Gearswap to Porterpacker wrapper
-- Proof of Concept v 0.2.0
-- by Lili

character_name = 'Cleobabe'
character_job = 'WAR'

local slot_names = {
	['main'] = true,
	['sub'] = true,
	['ammo'] = true,
	['range'] = true,	
	['head'] = true,
	['body'] = true,
	['hands'] = true,
	['legs'] = true,
	['feet'] = true,
	['ear1'] = true, ['left_ear'] = true, ['lear'] = true,
	['ear2'] = true, ['right_ear'] = true, ['rear'] = true,
	['ring1'] = true, ['left_ring'] = true, ['lring'] = true,
	['ring2'] = true, ['right_ring'] = true, ['rring'] = true,
	['neck'] = true,
	['back'] = true,
	['waist'] = true,
}

local file_path = windower.addon_path .. '../gearswap/data/' .. character_name .. '/' .. character_name .. '_' .. character_job .. '_Gear.lua'

if not windower.file_exists(file_path) then
	error('no matching file found: "%s.lua"':format(file_path))
	return nil
end

function set_combine(a,b)
	if b then 
		return b 
	else
		return a
	end
end

noop_send_command = send_command

function send_command()
	return nil
end

f, err = loadfile(file_path)

if err then 
	error('can\'t load file')
	return nil
end

state = {
	['CastingMode'] = {},
	['OffenseMode'] = {},
	['IdleMode'] = {},
	['Weapons'] = {},
}

M = { ['__methods'] = { ['options'] = function() return nil end} }

setmetatable(state,M)

gear = {}
sets = {
	['weapons'] = {},
	['precast'] = {
		['FC'] = {},
		['WS'] = {},
		['JA'] = {},
	},
	['midcast'] = {},
	['idle'] = {},
	['defense'] = {},
	['buff'] = {},
	['engaged'] = {},
    ['passive'] = {},
}

f()

if type(init_gear_sets) == 'function' then
	--user_setup()
	init_gear_sets()
else
	error('cannot find init_gear_sets function, not a GS file')
	return nil
end

send_command = noop_send_command

local item_names = {}

function process_table(table)
	for k, v in pairs(table) do
		if slot_names[k] then
			if type(v) == 'table' then
				item_names[#item_names +1] = v.name
			else
				item_names[#item_names +1] = v
			end
		elseif type(v) == 'table' then
			process_table(v)
		end
	end
end

process_table(sets)

return item_names