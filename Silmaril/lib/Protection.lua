do

    local protection = false -- State of protection
    local anon_names = false -- State of anon
    local dressup = false -- Determines if dressup should be reloaded
    local dressup_enable = false

    local name_cache = {} -- Real-to-Fake name cache
    local reverse_name_cache = {} -- Fake-to-Real name cache
    
    local ls_cache = {} -- Real-to-Fake LS cache
    local reverse_ls_cache = {} -- Fake-to-Real LS cache

    local anon_cache = {} -- Real-to-Fake other players cache
    local reverse_anon_cache = {} -- Fake-to-Real other players cache

    local in_filtered_packets = {
        [0x009] = {['name_field'] = 'Name',                 ['id_field'] = false,               }, -- Check notifications and a lots other things.
        [0x00A] = {['name_field'] = 'Player Name',          ['id_field'] = 'Player',            }, -- Zone update
        [0x00D] = {['name_field'] = 'Character Name',       ['id_field'] = 'Player',            }, -- PC Update
        [0x017] = {['name_field'] = 'Sender Name',          ['id_field'] = false,               }, -- Incoming Chat
        [0x0DD] = {['name_field'] = 'Name',                 ['id_field'] = 'ID',                }, -- Party Member Udpate
        [0x0DC] = {['name_field'] = 'Inviter Name',         ['id_field'] = 'Inviter ID',        }, -- Party Invite
        [0x0E2] = {['name_field'] = 'Name',                 ['id_field'] = 'ID',                }, -- Char Info
        [0x027] = {['name_field'] = 'Player Name',          ['id_field'] = 'Player',            }, -- String Message
        [0x070] = {['name_field'] = 'Player Name',          ['id_field'] = false,               }, -- Others Synth Result
        [0x078] = {['name_field'] = 'Proposer Name',        ['id_field'] = 'Proposer ID',       }, -- Proposal
        [0x079] = {['name_field'] = 'Proposer Name',        ['id_field'] = false,               }, -- Proposal Update
        [0x0CA] = {['name_field'] = 'Player Name',          ['id_field'] = false,               }, -- Bazaar Message
        [0x0CC] = {['name_field'] = 'Player Name',          ['id_field'] = false,               }, -- LS Message
        [0x0DC] = {['name_field'] = 'Inviter Name',         ['id_field'] = false,               }, -- Party Invite
        [0x106] = {['name_field'] = 'Name',                 ['id_field'] = false,               }, -- Bazaar Seller Info Packet
        [0x107] = {['name_field'] = 'Name',                 ['id_field'] = false,               }, -- Bazaar closed
        [0x108] = {['name_field'] = 'Name',                 ['id_field'] = 'ID',                }, -- Bazaar visitor
        [0x109] = {['name_field'] = 'Buyer Name',           ['id_field'] = 'Buyer ID',          }, -- Bazaar Purchase Info Packet
        [0x10A] = {['name_field'] = 'Buyer Name',           ['id_field'] = false,               }, -- Bazaar Buyer Info Packet
    }

    local out_filtered_packets = {
        [0x077] = {['name_field'] = 'Target Name',          ['id_field'] = false,           }, -- Party Leader
        [0x0B6] = {['name_field'] = 'Target Name',          ['id_field'] = false,           }, -- Tell    
    }

    local ls_enc = {
        charset = T('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ':split()):update({
            [0] = '`',
            [60] = 0:char(),
            [63] = 0:char(),
        }),
        bits = 6,
        terminator = function(str)
            return (#str % 4 == 2 and 60 or 63):binary()
        end}

    syllabize = function()
        local vowels = { 'a', 'e', 'i', 'o', 'u'}
        local consonants = { 'b', 'd', 'g', 'h', 'j', 'k', 'm', 'n', 'r', 's', 't', 'w', 'z' }
        local cypher = {}    
        local s = S{}
        local i = 0
        repeat
            local k = consonants[math.random(1,#consonants)] .. vowels[math.random(1,#vowels)]
            if not s[k] then 
                s:add(k)
                cypher['%X':format(i)] = k
                i = i+1
            end
        until i > 15
        return function (number)
            local number = '%X':format(number)
            local r = ''
            for i = #number,1,-1 do
                r = r..cypher[number:sub(i,i)]
            end
            return r
        end end()

    -- Processes the incoming packets - called direct
    function protection_in(id, data, modified)
        
        -- Protection is off so return unchanged packet
        if not protection then return end

        -- The packet is part of the filtered so change it
        if in_filtered_packets[id] then return process_in(id, modified) end

        -- /check results.
        if id == 0x0C9 then 
            local packet = parse_packet('incoming', modified)
            if packet['Linkshell'] then
                packet['Linkshell'] = ls_names(packet['Linkshell'])
            end
            return build_packet(packet)
        end

        -- Item Drop/Lot
        if id == 0x0D3 then
            local packet = parse_packet('incoming', modified)
            packet['Highest Lotter Name'] = names_in(packet['Highest Lotter Name'],id, packet)
            packet['Current Lotter Name'] = names_in(packet['Current Lotter Name'],id, packet)
            return build_packet(packet)
        end

        -- Item Updates
        if id == 0x020 then 
            local packet = parse_packet('incoming', modified)
            -- linkshell/pearlsack/linkpearl
            if packet.Item >= 513 and packet.Item <= 528 then
                packet.extdata = packet.ExtData
                packet.id = packet.Item
                local raw_data = extdata.decode(packet)
                if raw_data.status_id ~= 0 then
                    local name = ls_names(raw_data.name)
                    local encoded_name = name:encode(ls_enc)
                    packet.ExtData = packet.extdata:sub(0,6)..'b4b4b4b4':pack(raw_data.r, raw_data.g, raw_data.b, packet.extdata:unpack('b8', 8, 4))..packet.extdata:sub(9,9)..encoded_name
                    return build_packet(packet)
                end
            end
        end
    end

    function process_in(id, data)

        local packet = parse_packet('incoming',data)
        local name_field = in_filtered_packets[id].name_field
        local original_name = packet[name_field]

        -- Nothing to change
        if original_name == '' then return data end

        -- The original name couldn't be found so return normal
        if not original_name then return data end

        if id == 0x0E2 then
            if tostring(packet['ID']) ~= get_player_id() then return true end
        end

        -- PC Update
        if id == 0x00D then
            if packet['Update Name'] and packet['Update Name'] ~= "" then
                packet['Update Name'] = names_in(packet['Update Name'],id, packet)
                --log('PC Update ['..tostring(packet['Character Name'])..'] needed changed to ['..names_in(original_name, id, packet)..']')
            end
        end

        -- LS update
        if id == 0x0CC then
            local old_name = packet['Linkshell']
            packet['Message'] = 'Nothing to see here. Move along!'
            packet['Linkshell'] = ls_names(packet['Linkshell'])
        end

        -- Default swaps
        packet[name_field] = names_in(original_name, id, packet)
        return build_packet(packet)
    end

    function names_in(name, id, packet)

        -- Null
        if not name then return name end

        -- Empty String
        if name == '' then return name end

        -- Not a name
        if type(name) == "boolean" then return name end

        --Pre-defined
        if name_cache[name] then return name_cache[name] end

        -- Dont randomize the names if not enabled
        if not anon then return name end

        -- randomized already built
        if anon_cache[name] then return anon_cache[name] end

        -- See if you can construct a new packet based name - incoming packet
        if not in_filtered_packets[id] or not in_filtered_packets[id].id_field then log('Unable to find id_field in ['..id..']') return '' end
        local id_value = packet[in_filtered_packets[id].id_field]

        -- Make a new random name
        if id_value then return random_name(name, id_value) end

        -- Create a basic new name
        local new_name = ''
        repeat
            for i = 1,#name do
                new_name = new_name .. string.char(math.random(97,122))
            end
        until not reverse_anon_cache[new_name]
        anon_cache[name] = new_name
        reverse_anon_cache[new_name] = name
        return new_name
    end

    -- Processes the outgoing packets - called direct
    function protection_out(id, data, modified)

        -- Protection is not enabled
        if not protection then return end

        -- Party commands
        if id == 0x077 then

            -- Find the party name that is 16 bytes starting at 0x05
            local old_name = ''
            for i =1,16 do
                local char = modified:unpack('C', 0x4+i) 
                -- if the value is not blank - convert the decimal to a character and append to the string
                if char ~= 0 then old_name = old_name..string.char(char) end
            end

            -- Look up the reverse name
            if reverse_name_cache[old_name] or reverse_anon_cache[name] then

                new_name = reverse_name_cache[old_name]

                if not new_name then log('Using anon cache') new_name = reverse_anon_cache[name] end

                -- Handy way to split the string to a table of bytes
                local name_table = {new_name:byte(1,#new_name)}

                -- fill the table if not used to 16 bytes
                for i = #name_table + 1, 16 do name_table[i] = 0 end

                -- take the new name and convert to bytes
                local new_packet = ''
                for i = 1, 16 do new_packet = new_packet..'C':pack(name_table[i]) end

                -- splice in the new name to the existing packet
                new_packet = modified:sub(0x00, 0x4)..new_packet..modified:sub(0x15, 0x17)

                return new_packet
            end
        end

        if id == 0x0B6 then return process_out(id, modified) end

    end

    function process_out(id, data)
        local packet = parse_packet('outgoing',data)
        local name_field = out_filtered_packets[id].name_field
        local original_name = packet[name_field]

        -- Nothing to change
        if original_name == '' then return data end

        -- The original name couldn't be found so return normal
        if not original_name then return data end

        -- Default swaps
        packet[name_field] = names_out(original_name, id, packet)
        log('Changed out Packet ['..id..'] from ['..original_name..'] to ['..packet[name_field]..']')

        return build_packet(packet)
    end

    function names_out(name, id, packet)
        -- Not a name
        if type(name) == "boolean" then return name end

        --Pre-defined
        if reverse_name_cache[name] then log('found reverse ['..reverse_name_cache[name]..']') return reverse_name_cache[name] end

        -- Dont randomize the names if not enabled
        if not anon then return name end

        -- randomized already built
        if reverse_anon_cache[name] then log('found reverse anon ['..reverse_name_cache[name]..']') return reverse_anon_cache[name] end

        -- See if you can construct a new packet based name - incoming packet
        local id_value = packet[out_filtered_packets[id].id_field]

        -- Make a new random name
        if id_value then return random_name(name, id_value) end

        -- Create a basic new name
        local new_name = ''
        repeat
            for i = 1,#name do
                new_name = new_name .. string.char(math.random(97,122))
            end
        until not anon_cache[new_name]
        reverse_anon_cache[name] = new_name
        anon_cache[new_name] = name

        return new_name
    end

    function random_name(name, id)
        local l = #name
        local max_len = l+3-(l-1)%4
        local new_name = syllabize(id):sub(1,max_len):gsub("^%l", string.upper)
        anon_cache[name] = new_name
        reverse_anon_cache[new_name] = name
        --log("New Name ["..new_name.."] created from ["..name..'] constraint of ['..max_len..']')
        return new_name
    end

    -- Returns the real LS name
    function ls_names(name)

        -- Normalize the string
        name = name:gsub('%W','')

        -- Returns the fake LS name
        if ls_cache[name] then return ls_cache[name] end

        -- Returns the real LS name
        if reverse_ls_cache[name] then return reverse_ls_cache[name] end

        -- Creates a anon LS name
        reverse_ls_cache[name] = random_ls_name()
        return reverse_ls_cache[name]
    end

    function random_ls_name()
        local ls_name = ""
        local    colors = { 'Yellow', 'Green', 'Purple', 'Rose', 'Azure', 'Red', 'Violet', 'Blue', 
                            'Alabaster', 'Amber', 'Black', 'Bronze', 'Carmine', 'Charcoal', 'Copper', 'Crimson', 'Desert', 
                            'Emerald', 'Iron', 'Heliotrope', 'Honeydew', 'Iceberg', 'Indigo', 'Ivory', 
                            'Lemon', 'Liberty', 'Lilac', 'Mauve', 'Mint', 'Peachy', 'Platinum', 'Saffron', 'Shamrock',
                            'Snow', 'Teal', 'Tomato', 'Vanilla', 'Xanthic', 'PolkaDot', 'Rainbow', 
                            'Lime', 'Golden', 'Cerise', 'Pink', 'Bicolor', 'Scarlet', 'Blonde', 'Evergreen', }
        local   animals = { 'Rats', 'Oxen', 'Tigers', 'Rabbits', 'Dragons', 'Snakes', 'Horses', 'Goats', 'Monkeys', 'Roosters', 'Dogs', 'Pigs',
                            'Antelopes', 'Deer', 'Salmons', 'Cats', 'Spiders', 'Bats', 'Bugbears', }
        -- Create a random LS name
        repeat
            ls_name = colors[math.random(1,#colors)] .. animals[math.random(1,#animals)]
        until not reverse_ls_cache[ls_name]
        --log("New LS ["..ls_name.."] created")
        return ls_name
    end

    function get_name_cache()
        return name_cache
    end

    function set_name_cache(value)
        name_cache = value
    end

    function set_reverse_name_cache(value)
        reverse_name_cache = value
    end

    function get_reverse_name_cache()
        return reverse_name_cache
    end

    function set_ls_cache(value)
        ls_cache = value
    end

    function set_reverse_ls_cache(value)
        reverse_ls_cache = value
    end

    function set_protection(value)
        if value == 'True' then
            if not protection then
                protection = true
                send_to_chat(1, ('\31\200[\31\05Silmaril\31\200]\31\207'..' Protection: \31\06[ON]'))
                if dressup_enable then dressup = true end
                info("Please zone to finish protection.")
            end
        else
            if protection then
                protection = false
                send_to_chat(1, ('\31\200[\31\05Silmaril\31\200]\31\207'..' Following: \31\03[OFF]'))
                if dressup_enable then dressup = true end
                info("Please zone to finish protection.")
            end
        end
    end

    function get_protection()
        return protection
    end

    function get_dressup()
        return dressup
    end

    function set_dressup(value)
        dressup = value
    end

    function set_dressup_enable(value)
        if value == "True" then
            dressup_enable = true
        else
            dressup_enable = false
        end
    end

    function set_anon(value)
        if value == "True" then
            anon = true
        else
            anon = false
        end
    end

    function get_protection_report()
        log('Name Cache')
        log(name_cache)
        log('Reverse Name Cache')
        log(reverse_name_cache)
    end

end