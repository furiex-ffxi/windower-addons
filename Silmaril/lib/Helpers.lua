function log (msg)
	if get_debug_state() then print(80, msg) end
end

function info (msg)
	if get_info_state() then print(5, msg) end
end

function print(mode, msg)
	if msg == nil then
		send_to_chat(mode,'Value is Nil')
	elseif type(msg) == "table" then
		for index, value in pairs(msg) do
			if type(value) == "table" then
				for index2, value2 in pairs(value) do
					if type(value2) == "table" then
						for index3, value3 in pairs(value2) do
							if type(value3) == "table" then
								for index4, value4 in pairs(value3) do
									send_to_chat(mode,'---- ['..tostring(index)..'] ['..tostring(index2)..'] ['..tostring(index3)..'] ['..tostring(index4)..'] '..tostring(value4)..' ----')
								end
							else
								send_to_chat(mode,'---- ['..tostring(index)..'] ['..tostring(index2)..'] ['..tostring(index3)..'] '..tostring(value3)..' ----')
							end
						end
					else
						send_to_chat(mode,'---- ['..tostring(index)..'] ['..tostring(index2)..'] '..tostring(value2)..' ----')
					end
				end
			else
				send_to_chat(mode,'---- ['..tostring(index)..'] '..tostring(value)..' ----')
			end
		end
	elseif type(msg) == "number" then
		send_to_chat(mode,tostring(msg))
	elseif type(msg) == "string" then
		send_to_chat(mode,msg)
	elseif type(msg) == "boolean" then
		send_to_chat(mode,tostring(msg))
	else
		send_to_chat(mode,'Unknown Message')
	end
end

function echo (msg)
    if msg == nil then
        send_to_chat(80,'---- Value is Nil ----')
    elseif type(msg) == "table" then
        for index, value in ipairs(msg) do
            command = '/echo '..value..''
            send_chat(command)
            send_ipc('silmaril message '..value)
        end
    elseif type(msg) == "number" then  
        command = '/echo '..tostring(msg)..''
        send_chat(command)
        send_ipc('silmaril message '..tostring(msg))
    elseif type(msg) == "string" then
        command = '/echo '..msg..''
        send_chat(command)
        send_ipc('silmaril message '..msg)
    elseif type(msg) == "boolean" then
        command = '/echo '..tostring(msg)..''
        send_chat(command)
        send_ipc('silmaril message '..tostring(msg))
    else
        send_to_chat(80,'---- Unknown Echo Message ----')
    end
end

function packet_log(packet, direction)
    if not packet then return end
    for index, item in pairs(packet) do
        if not string.find(tostring(index), "_") then
            log('Packet '..direction..': ['..tostring(index)..'] ['..tostring(item)..']')
        end
    end
end

function packet_log_full(packet, direction)
    if not packet then return end
    for index, item in pairs(packet) do
       log('Packet '..direction..': ['..tostring(index)..'] ['..tostring(item)..']')
    end
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- Use for procession targets with advanced tables
function targets_table(targets)
    local formattedString = ''
    for type, target in pairs(targets) do
        formattedString = formattedString..type..'$'
    end    
    formattedString = formattedString:sub(1, #formattedString - 1)
    return formattedString
end

function string_to_date(timeToConvert)
    -- Assuming a date pattern like: yyyy-mm-ddThh:mm:ss

    local pattern = "(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)"
    local runyear, runmonth, runday, runhour, runminute, runseconds = timeToConvert:match(pattern)
    local convertedTimestamp = os.time({year = runyear, month = runmonth, day = runday, hour = runhour, min = runminute, sec = runseconds})

    --log(convertedTimestamp)
    --log(os.date("!%c",convertedTimestamp))
    return convertedTimestamp
end

function GetCardinalForAngle(angle)
    local direction = ""
    if angle then
        if angle >= 337.5 or angle < 22.5 then
            direction = "E"
        elseif angle >= 22.5 and angle < 67.5 then
            direction = "NE"
        elseif angle >= 67.5 and angle < 112.5 then
            direction = "N"
        elseif angle >= 112.5 and angle < 157.5 then
            direction = "NW"
        elseif angle >= 157.5 and angle < 202.5 then
            direction = "W"
        elseif angle >= 202.5 and angle < 247.5 then
            direction = "SW"
        elseif angle >= 247.5 and angle < 292.5 then
            direction = "S"
        elseif angle >= 292.5 and angle < 337.5 then
            direction = "SE"
        end
    end
    return string.format("%2s", direction)
end

function AngleBetween(x, y)
    local p = get_player_info()
    if x and y and p then
        local dx = x - p.x
        local dy = y - p.y
        local theta = math.atan2(dy, dx)
        theta = theta * 180 / math.pi
        if(theta < 0) then
            theta = theta + 360
        end
        return theta    
    end
    return 0
end

function firstToUpper(str)
    local capitalizedString = str:gsub("(%a)(%w*)", function(firstLetter, restOfString)
        return string.upper(firstLetter) .. restOfString:lower()
    end)
    return capitalizedString
end