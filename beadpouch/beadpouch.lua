_addon.name    = 'pouch'
_addon.author  = 'Mujihina'
_addon.version = '1.0'
_addon.command = 'pouch'
_addon.commands = {'pouch'}


require ('luau')
packets = require('packets')

local enable_mode = false
local pouch_type = ''
local bead_puches = 0
local silt_pouches = 0
local silt_pouch_id = 6391
local bead_pouch_id = 6392
local status = 0
local using = false
local pause = 0

function load()
	status = windower.ffxi.get_player().status
end

-- Show syntax
function show_syntax()
	print ('pouch: Syntax is:')
	print ('    pouch stop: Stop using pouches.')
	print ('    pouch all: Use all pouches')
	print ('    pouch silt: Use silt pouches')
	print ('    pouch beads: Use bead pouches')
end


-- Parse and process commands
function pouch_command(cmd, ...)
	if (not cmd or cmd == 'help' or cmd == 'h') then
		show_syntax()
		return
	end    
	-- stop
	if cmd == 'stop' then
		enable_mode = false
		print('pouch: stopping')
		return
	end
	
	if cmd == 'all' then
		pouch_type = 'all'
		check_inventory()
		return
	end
	if cmd == 'beads' then
		pouch_type = 'beads'
		check_inventory()
		return
	end
	if cmd == 'silt' then
		pouch_type = 'silt'
		check_inventory()
		return
	end
	show_syntax()
end

function check_inventory()
	local items = windower.ffxi.get_items()
	silt_pouches = 0
	bead_pouches = 0
	for _,item in ipairs (items['inventory']) do
		if item.id > 0 then
			-- silt pouches
			if (pouch_type == 'all'  or pouch_type == 'silt') and item.id == silt_pouch_id then
				silt_pouches = silt_pouches + item.count
			end
			-- bead pouches
			if (pouch_type == 'all'  or pouch_type == 'beads') and item.id == bead_pouch_id then
				bead_pouches = bead_pouches + item.count
			end
		end
	end
	if silt_pouches > 0 then
		print('pouch: will use %d silt pouches':format(silt_pouches))
		enable_mode = true
	end
	if bead_pouches > 0 then
		print('pouch: will use %d bead pouches':format(bead_pouches))
		enable_mode = true
	end
end

function tick()
	if not enable_mode then return end
	if using then return end

	if pause > 0 then
		pause = pause - 1
		return
	end
	-- print('tick()')
	-- silt
	if (pouch_type == 'all' or pouch_type == 'silt') and silt_pouches > 0 then	
		windower.send_command ('input /item "Silt Pouch" <me>')
		pause = 2
		silt_pouches = silt_pouches - 1
		if silt_pouches == 0 and bead_pouches == 0 then
			enable_mode = false
			print('pouch: done')
		end
		return
	end

	-- beads
	if (pouch_type == 'all' or pouch_type == 'beads') and bead_pouches > 0 then	
		windower.send_command ('input /item "Bead Pouch" <me>')
		pause = 2
		bead_pouches = bead_pouches - 1
		if silt_pouches == 0 and bead_pouches == 0 then
			enable_mode = false
			print('pouch: done')
		end
		return
	end

end

function status_change(new, old)
	status = new
end

-- Process incoming packets
function incoming_packets (id, original, modified, injected, blocked)
    if (id==0x28) then
        local p = packets.parse ('incoming', original)
        if p['Category'] == 9 then
        	using = true
        	return
        end
        if p['Category'] == 5 then
        	using = false
        	return
        end
     end
end

-- Register callbacks
windower.register_event ('load', load)
windower.register_event('addon command', pouch_command)
windower.register_event('time change', tick)
windower.register_event('status change', status_change)
windower.register_event('incoming chunk', incoming_packets)