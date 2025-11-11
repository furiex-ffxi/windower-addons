do
    local sent_messages = {} -- Holds the packets that were sent
    local retry_count = 0 -- How many times a retry was conducted to poke the npc
    local message_count = 0 -- Total messages in que to mirror
    local single_mirror = true -- Determins if mirroring should be kept on after a mirror event is completed
    local action_packet = nil -- This is the packet used to poke a NPC
    local black_list = {}   -- NPC's to avoid when mirroring is turned on
    local injecting = false -- In the process of injecting packets (end users)
    local mirror_on = false -- If the player has mirroring enabled
    local mirroring = false -- If the player is in the process of building a mirror image to silmaril
    local mirror_target = nil -- NPC the interaction for (used in Display)
    local message_time = os.clock() -- Time set to figure out if the player is timming out
    local poke_time = os.clock() -- used to find when the last poke happened
    local menu_id = nil -- This is the menu that the player is interacting with
    local temp_menu_id = nil -- Used to store the active dialog (warps/doors)
    local mirror_message = nil -- Message to transmit
    local mirroring_state = '' -- this is used to notify the player of the actions
    local blacklisted = false -- Determines if the NPC is to be blacklisted
    local mirror_release = false -- Used to validate a player state change
    local mid_inject = false -- Determines if the player is mid injection incase times out or packet drops
    local block_release = false -- This is used for warp portals when the player is already in a menu (block to server the event skip)
    local force_warp = false -- used to adjust position to get response from server
    local warp_spoof = false -- Allows for atleast one player update before injecting
    local outgoing_warp = false -- Single inject to start the warp process
    local warp_message = {} -- Holds the sortie/oddy warp messages until ready
    local buy_sell = false
    local trade = false

    -- Outline of events

    -- Player starts by interactiong with a NPC by sending an action packet 0x01A with a category of 0x000.
    -- This is captured in Packets.lua and calls npc_interact(packet_in) to start the process of recording.
    -- In response to the Action packet the server send the client a 0x032/0x033/0x034 packet.  This contains the menu the NPC is displaying.
    -- Because of this the menu needs to be blocked.  This is done after the packet is processed by returning "true"


-----------------------------------------------------------------------
------------------------- MIRRORER SECTION ----------------------------
-----------------------------------------------------------------------


    -- This packet is generated when a player starts an interaction with NPC and mirroring is enabled (outgoing to server)
    function npc_mirror_start(packet_out)

        -- Used to look up NPC for blacklist
        local npc = get_mob_by_id(packet_out['Target'])
        if not npc then log("Couldn't get target ["..string.format("%i",packet_out['Target']).."]") return end

        log('valid_target ['..tostring(npc.valid_target)..']')
        log('is_npc ['..tostring(npc.is_npc)..']')
        log('entity_type ['..tostring(npc.entity_type)..']')

        local w = get_world()
        if not w then return end

        if w.mog_house and npc.name == 'Moogle' then return end

        if tostring(npc.id) == get_player_id() and not temp_menu_id then 
            log('Cancel due to self') 
            return 
        end

        -- Check for a black listed NPC
        for index, item in ipairs(black_list) do
            if npc.name == item.name then
                if w.zone == tonumber(item.zone) or tonumber(item.zone) == 0 then
                    if npc.index == tonumber(item.index) or tonumber(item.index) == 0 then
                        blacklisted = true
                    end
                end
            end
        end

        mirror_target = npc
        mirror_target.zone = w.zone

        --Send the info to silmaril to notify a sequence is starting
        if not blacklisted then
            mirroring_state = "Recording"
            mirroring = true
            message_time = os.clock()
            que_packet('mirror_interact') -- used to clear a buffer in Silmaril
            if not trade then
                log('NPC Interaction Starting for '..npc.name..' [Dialog]')
                packet_log(packet_out, "in")
            end
        else
            log("Blacklisted NPC")
            trade = false
        end
    end

    -- 0x05B
    -- This function sends the menu selection of the player to silmaril to build the menu transactions
    function npc_out_dialog(packet_out)
        if not mirror_target then return end
        if blacklisted then log("Blacklisted NPC") return end
        log('Recording Dialog [0x05B]')

        que_packet('mirror_dialog_0x05B,'..
            packet_out['Target']..','..
            packet_out['Option Index']..','..
            packet_out['_unknown1']..','..
            packet_out['Target Index']..','..
            tostring(packet_out['Automated Message'])..','..
            packet_out['_unknown2']..','..
            packet_out['Zone']..','..
            packet_out['Menu ID'])

        packet_log(packet_out, "out")
        message_time = os.clock()
    end

    -- 0x05C
    -- This function is for a warp request to silmaril
    function npc_out_warp(packet_out)
        if not mirror_target then return end
        if blacklisted then log("Blacklisted NPC") return end
        log('Recording Warp [0x05C]')

        que_packet('mirror_warp_0x05C,'..
            packet_out['X']..','..
            packet_out['Y']..','..
            packet_out['Z']..','..
            packet_out['Target ID']..','..
            packet_out['_unknown1']..','..
            packet_out['Zone']..','..
            packet_out['Menu ID']..','..
            packet_out['Target Index']..','..
            packet_out['_unknown2']..','..
            packet_out['Rotation'])

        packet_log(packet_out, "out")
        message_time = os.clock()
    end

    -- 0x036
    -- This functin is for trading
    function npc_out_trade(packet_out, formattedString)

        if not packet_out then return end
        if not mirror_target then return end
        if blacklisted then return end

        -- Send the trade info
        log('Mirroring Trade [0x036]')
        que_packet('mirror_trade_0x036|'..
            packet_out['Target']..'|'..
            packet_out['Target Index']..'|'..
            packet_out['_unknown1']..'|'..
            packet_out['_unknown2']..'|'..
            formattedString)

        message_time = os.clock()
        packet_log(packet_out, 'out')
    end

    -- 0x083
    -- This functin is for buy/sell items
    function npc_out_buy(packet_out)

        if not packet_out then return end
        if not mirror_target then return end
        if blacklisted then return end

        log('Mirroring Buy [0x083]')
        que_packet('mirror_buy_0x083,'..
            packet_out['Count']..','..
            packet_out['_unknown2']..','..
            packet_out['Shop Slot']..','..
            packet_out['_unknown3']..','..
            packet_out['_unknown4']..','..
            mirror_target.id..','..
            mirror_target.index)

        message_time = os.clock()
        packet_log(packet_out, 'out')
    end

    -- Once a NPC interaction is completed the server then send a 0x037 packets with the player state change (4 -> 0)
    function npc_mirror_complete()
        if not mirror_target then log("No Target Found") return end

        que_packet('mirror_send_'..
            string.format("%i",mirror_target.id)..','..
            string.format("%i",mirror_target.index)..','..
            string.format("%.2f",mirror_target.x)..','..
            string.format("%.2f",mirror_target.y)..','..
            string.format("%.2f",mirror_target.z)..','..
            string.format("%i",mirror_target.zone)..','..
            mirror_target.name)

        log('NPC interaction completed')
        mirroring = false
        if single_mirror then mirror_on = false end
    end


-----------------------------------------------------------------------
------------------------- INJECTOR SECTION ----------------------------
-----------------------------------------------------------------------


    -- Called by Silmaril to start a mirror sequence
    -- Build the message que for when server asks for it.
    -- Only send the action packet here
    function npc_build_message(target, message)

        local w = get_world()
        if not w then return end

        local p = get_player_data()
        if not p then return end

        mirror_target = target
        mirror_target.zone = w.zone

        -- Builds the messages into a table
        mirror_message = {}
        for item in string.gmatch(message, "([^|]+)") do
            table.insert(mirror_message, item)
        end

        if #mirror_message < 1 then return end

        -- Set the message count
        message_count = #mirror_message
        log('Messasge count is ['..message_count..']')

        -- Cancel the dialog you are currently in
        if p.status == 4 then
            if temp_menu_id then
                block_release = true
                log('Sending Menu Cancel')
                cancel_menu(temp_menu_id)
                return
            else
                log('Player is already in a menu - Mirroring Failed')
                que_packet("mirror_status_failed")
                return
            end
        end

        -- Parse the first message
        local packet_out = {}
        for item in string.gmatch(mirror_message[1], "([^,]+)") do
            table.insert(packet_out, item)
        end

        if packet_out[1] == "0x05B" or packet_out[1] == "0x05C" or packet_out[1] == "0x083" or message == "Poke" then -- Dialog
            
            -- Build the action packet
            action_packet = new_packet('outgoing', 0x01A, 
            {
                ['Target'] = mirror_target.id,
                ['Target Index'] = mirror_target.index,
                ['Category'] = 0x00,
                ['Param'] = 0 
            })

            -- Start the interation
            log('Initial NPC Poke')

            injecting = true
            inject_packet(action_packet)
            poke_time = os.clock()
            packet_log(action_packet, 'out')
            mirroring_state = "Injecting [0x01A]"

        elseif packet_out[1] == "0x036" then
            -- Don't inject the action packet and start injection
            mirroring_state = "Trading..."
            injecting = true
            npc_inject()
        else
            log("Unknown Message")
        end
    end

    -- Called if an event release is not detected
    function npc_retry()
        if not injecting then return end
        if mid_inject then return end

        local w = get_world()
        if not w then return end

        if not action_packet then 
            injecting = false 
            force_warp = false
            return 
        end

        -- Try a retry packet injection
        retry_count = retry_count + 1

        -- Turn off injecting if exceeded retry count
        if retry_count > 5 then 
            npc_reset()
            injecting = false
            force_warp = false
        end

        -- inject the packet
        inject_packet(action_packet)
        poke_time = os.clock()
        packet_log(action_packet, 'out')
        mirroring_state = "Injecting [0x01A] - Retry ["..string.format("%i",retry_count)..']'
    end

    -- Once a 0x032/0x033/0x034 Packet is recieved from the initial Action always first 0x05B Packet sent
    -- Once a follow up 0x05C is recieved send the next dialog reqest/warp
    function npc_inject()
        mid_inject = true
        if not injecting then return end
        if not mirror_message then return end

        -- End of messages so reset
        if not mirror_message or #mirror_message == 0 then
            log('End of messages reached')

            if buy_sell then
                log("Buy sell finish")
                local packet = new_packet('outgoing', 0x05B, 
                {
                    ['Target'] = mirror_target.id,
                    ['Option Index'] = 0,
                    ['_unknown1'] = 16384,
                    ['Target Index'] = mirror_target.index,
                    ['Automated Message'] = false,
                    ['_unknown2'] = '0',
                    ['Zone'] = mirror_target.zone,
                    ['Menu ID'] = menu_id
                })

                inject_packet(packet)
                packet_log(packet, 'out')
            end

            que_packet("mirror_status_completed")
            clear_npc_data()
            return 
        end

        local packet_out = {}
		for item in string.gmatch(mirror_message[1], "([^,]+)") do
            table.insert(packet_out, item)
        end

        local message_type = ''
        local packet = {}

        -- Standard Menu Choice
        if packet_out[1] == "0x05B" then

            local message_menu = tonumber(packet_out[9])

            -- Check for correct menu unless it originates from the player
            if menu_id ~= tonumber(packet_out[9]) and not trade then
                if packet_out[2] ~= get_player_id() then
                    info('Menu Mis-Match')
                    reset_player(packet_out[9])
                end
            end

            message_type = '[0x05B]'
            local automated = false
            if packet_out[6] == 'true' then automated = true end

            packet = new_packet('outgoing', 0x05B, 
            {
                ['Target'] = tonumber(packet_out[2]),
                ['Option Index'] = tonumber(packet_out[3]),
                ['_unknown1'] = tonumber(packet_out[4]),
                ['Target Index'] = tonumber(packet_out[5]),
                ['Automated Message'] = automated,
                ['_unknown2'] = packet_out[7],
                ['Zone'] = tonumber(packet_out[8]),
                ['Menu ID'] = message_menu,
            })

            -- If a menu ID was not assigned from incoming interact assign it here
            if not menu_id then 
                log('Setting Menu ID from packet - Non standard') 
                menu_id = tonumber(packet_out[9]) 
            end

        -- Warp Request
        elseif packet_out[1] == "0x05C" then

            -- Warp does not match
            if menu_id ~= tonumber(packet_out[8]) then
                info('Warp Mis-Match')
                reset_player(packet_out[8])
                return
            end

            message_type = '[0x05C]'
            packet = new_packet('outgoing', 0x05C, 
            {
                ['X'] = tonumber(packet_out[2]),
                ['Y'] = tonumber(packet_out[3]),
                ['Z'] = tonumber(packet_out[4]),
                ['Target ID'] = tonumber(packet_out[5]),
                ['_unknown1'] = tonumber(packet_out[6]),
                ['Zone'] = tonumber(packet_out[7]),
                ['Menu ID'] = tonumber(packet_out[8]),
                ['Target Index'] = tonumber(packet_out[9]),
                ['_unknown2'] = packet_out[10],
                ['Rotation'] = packet_out[11],
            })

            -- If a menu ID was not assigned from incoming interact assign it here
            if not menu_id then 
                log('Setting Menu ID from packet - Non standard') 
                menu_id = tonumber(packet_out[8]) 
            end

        -- Buy/Trade?
        elseif packet_out[1] == "0x083" then
            buy_sell = true
            message_type = '[0x083]'
            packet = new_packet('outgoing', 0x083, 
            {
                ['Count'] = tonumber(packet_out[2]),
                ['_unknown2'] = tonumber(packet_out[3]),
                ['Shop Slot'] = tonumber(packet_out[4]),
                ['_unknown3'] = tonumber(packet_out[5]),
                ['_unknown4'] = tonumber(packet_out[6]),
            })

        -- Trade
        elseif packet_out[1] == "0x036" then
            -- Doesn't require a poke
            message_type = '[0x036]'
            trade = true
            packet = build_trade_packet(mirror_target, mirror_message)
            if not packet then log('Trade packet not built') clear_npc_data() return end

        else
            echo("Unknown Packet Detected!!!! - Player ["..get_player_name().."] cannot mirror.")
            que_packet("mirror_status_failed")
            return
        end

        inject_packet(packet)
        message_time = os.clock()
        packet_log(packet, 'out')
        table.insert(sent_messages, packet)
        table.remove(mirror_message,1)
        mirroring_state = 'Injecting '..message_type..' ('..#sent_messages..' of '..message_count..')'
        log(mirroring_state)
    end

    -- Called when the server has sent a NPC Release
    function npc_in_release(packet_in)
        if not injecting then return end
        if packet_in['Type'] == 0x00 then
            log('Received [Standard] release was a type ['..interaction_type..']')
            -- No messages left to send so consider it done
            if not mirror_message or mirror_message[1] == "Poke" then 
                que_packet("mirror_status_completed")
                clear_npc_data()
            elseif buy_sell then
                -- Continue the injection
                npc_inject()
            end
        elseif packet_in['Type'] == 0x01 then
            log('Received [Event] release was a type ['..interaction_type..']')
            if not mirror_message or #mirror_message == 0 then 
                -- Sucessful Event release
                que_packet("mirror_status_completed")
                clear_npc_data()
            else
                -- Continue the injection
                npc_inject()
            end
        -- Something prevented the injection
        elseif packet_in['Type'] == 0x02 then
            log('Received [Event Skip] release was a type ['..interaction_type..']')
            que_packet("mirror_status_failed")
            clear_npc_data()
        elseif packet_in['Type'] == 0x03 then
            log('Received [String] completed source was a type ['..interaction_type..']')
            que_packet("mirror_status_completed")
            clear_npc_data()
        elseif packet_in['Type'] == 0x04 then
            log('Received [Fishing] release was a type ['..interaction_type..']')
            que_packet("mirror_status_completed")
            clear_npc_data()
        end
    end

    -- Builds the trade packet to send
    function build_trade_packet(target, mirror_message)
        local packet_out = {}
        local items = get_items(0)
        local items_found = 0
        local items_used = {}

        for item in string.gmatch(mirror_message[1], "([^,]+)") do
            table.insert(packet_out, item)
        end

        local total_items = tonumber(packet_out[2])

        -- Build the trade packet
        local trade_packet = new_packet('outgoing', 0x036, 
        {
            ['Target'] = mirror_target.id,
            ['Target Index'] = mirror_target.index,
            ['Number of Items'] = total_items,
            ['_unknown1'] = tonumber(packet_out[3]),
            ['_unknown2'] = tonumber(packet_out[4]),
        })

        local index = 2
        for i=1, trade_packet['Number of Items'] do

            -- split the item message
            local item_out = {}
            for trade_item in string.gmatch(packet_out[index + i], "([^\\]+)") do
                table.insert(item_out, tonumber(trade_item))
            end

            -- Need to look up inventory to see if present - zero is gil
            if item_out[1] ~= 0 then
               -- Loop through the bag to try to find the items
               for i=1, #items do
                   -- Correct Item ID found
                   if items[i].id == item_out[1] and not items_used[i] then
                       -- Check if the quanity is enough
                       if items[i].count >= item_out[2] then
                           log('Item found at position ['..i..']')
                           item_out[1] = i
                           items_found = items_found + 1
                           items_used[i] = true
                           i = #items
                       end
                   end
               end
            else
                local all_items = get_items()
                if item_out[2] > all_items['gil'] then
                    echo("Not enough Gil to trade!!!! - Player ["..get_player_name().."] cannot mirror the trade.")
                    que_packet("mirror_status_failed")
                    return
                else
                    log('Gil check ok')
                    items_found = items_found + 1
                end
            end

            trade_packet['Item Index '..string.format("%i",i)] = item_out[1]
            trade_packet['Item Count '..string.format("%i",i)] = item_out[2]
        end

        if items_found == total_items then
            log('All Items was found')
            return trade_packet
        else
            echo("Not all items found!!!! - Player ["..get_player_name().."] cannot mirror the trade.")
            que_packet("mirror_status_failed")
            return false
        end
    end


    -----------------------------------------------------------------------
    -------------------------- HELPER SECTION -----------------------------
    -----------------------------------------------------------------------


    function reset_player(value)
        if not menu_id then return end
        echo("Incorrect Menu Detected!!!!")
        echo("Player ["..get_player_name().."] cannot mirror Menu ["..value.."] because Menu is ["..menu_id.."]).")
        log("Player Menu ["..string.format("%i",menu_id)..'] and Mirror Menu ['..value..']')
        que_packet("mirror_status_failed")
        retry_count = 0
        npc_reset()
    end

    function npc_reset(menu, index)
        injecting = false

        -- Set the menu ID if passed
        if menu then 
            log('Set Menu ID from command ['..menu..']')
            menu_id = menu 
        elseif not menu_id and temp_menu_id then 
            log('Set Menu ID from Temp Menu ID ['..temp_menu_id..']')
            menu_id = temp_menu_id
            temp_menu_id = nil
        elseif menu_id then
            log('Menu ID ['..menu_id..']')
        else
            log("Had to abort reset - No menu ID detected")
            return
        end

        -- Set the target if passed
        if index then 
            mirror_target = get_mob_by_index(index)
            if mirror_target then
                log('Set Mirror Target from command ['..index..']')
                mirror_target.zone = get_world().zone
            else
                log("Had to abort reset - No Mirror Target detected")
                return
            end
        elseif mirror_target then
            log('Target Index ['..mirror_target.index..']')
        else
            log('Aborting - No NPC Index detected')
            return
        end

        log('Silmaril Reset - 0x05B Packet (Constructed)')
        local packet = new_packet('outgoing', 0x05B, 
        {
            ['Target'] = mirror_target.id,
            ['Option Index'] = 0,
            ['_unknown1'] = 16384,
            ['Target Index'] = mirror_target.index,
            ['Automated Message'] = false,
            ['_unknown2'] = '0',
            ['Zone'] = mirror_target.zone,
            ['Menu ID'] = menu_id
        })

        inject_packet(packet)
        packet_log(packet, 'out')

        -- Reset via Windower/Ashita
        mirror_reset(menu_id)

        if menu_id and temp_menu_id then
            log('Try the temp menu recorded ['..temp_menu_id..']')
            menu_id = nil
            npc_reset()
        end
    end

    function npc_mirror_state(state)
        if state == "True" then
            single_mirror = true
        else
            single_mirror = false
        end
    end

    -- Used to reset the mirror states
    function clear_npc_data()
        log("Clearing NPC packet information")
        injecting = false
        retry_count = 0
        sent_messages = {}
        warp_message = {}
        mirroring_state = ""
        message_count = 0
        action_packet = nil
        mirroring = false
        mirror_message = nil
        interaction_type = ''
        mirror_release = false
        blacklisted = false
        mid_inject = false
        block_release = false
        force_warp = false
        outgoing_warp = false
        warp_spoof = false
        buy_sell = false
        trade = false
        npc_box_status()
        sm_result_hide()
    end

    -- Table of blacklisted NPC from silmaril
    function add_black_list(list)
        black_list = {}
        -- split to each message
        for items in string.gmatch(list, "([^|]+)") do
            -- split each message further
            local list_item = {}
            for item in string.gmatch(items, "([^,]+)") do
                table.insert(list_item, item)
            end
            local parsed = {name = list_item[1], zone = list_item[2], index = list_item[3]}
            table.insert(black_list, parsed)
            --log('Name ['..parsed.Name..'] Zone ['..parsed.Zone..'] Index ['..parsed.Index..']')
        end
    end

    function get_injecting()
        return injecting
    end

    function set_injecting(value)
        injecting = value
    end

    function get_mirror_on()
        return mirror_on
    end

    function set_mirror_on(value)
        mirror_on = value
    end

    function get_mirroring()
        return mirroring
    end

    function set_mirroring(value)
        mirroring = value
    end

    function get_message_time()
        return message_time
    end

    function get_mirror_target()
       return mirror_target
    end

    function set_mirror_target(value)
        mirror_target = value
    end

    function get_blacklisted()
        return blacklisted
    end

    function get_mirroring_state()
        return mirroring_state
    end

    function get_menu_id()
        return menu_id
    end

    function set_temp_menu_id(value)
        temp_menu_id = tonumber(value)
    end

    function set_menu_id(value)
        menu_id = tonumber(value)
        que_packet("mirror_menu_"..value)
    end

    function get_mirror_message()
        return mirror_message
    end

    function get_retry_count()
        return retry_count
    end

    function get_current_menu()
        return current_menu
    end

    function set_current_menu(value)
        log("Updated the current menu")
        current_menu = value
    end

    function set_interaction_type(value)
        interaction_type = value
    end

    function set_mirror_release(value)
        mirror_release = value
    end

    function get_mirror_release()
        return mirror_release
    end

    function get_mid_inject()
        return mid_inject
    end

    function get_block_release()
        return block_release
    end

    function set_block_release(value)
        block_release = value
    end

    function get_poke_time()
        return poke_time
    end

    -- Modifies the 0x015 packet
    function set_force_warp(value)
        force_warp = value
    end

    function get_force_warp()
        return force_warp
    end

    -- Starts the process via the 0x015 packet
    function set_outgoing_warp(value)
        outgoing_warp = value
    end

    function get_outgoing_warp()
        return outgoing_warp
    end
    
    -- Causes first 0x015 to be released and modified before forcing
    function get_warp_spoof()
        return warp_spoof
    end

    function set_warp_spoof(value)
        warp_spoof = value
    end

    -- holds the message to reflect
    function get_warp_message()
        return warp_message
    end

    -- sets the warp message to be used after the position updates
    function set_warp_message(value)
        warp_message = value
    end

    function get_buy_sell()
        return buy_sell
    end

    function set_buy_sell(value)
        buy_sell = value
    end

    function get_trade()
        return trade
    end

    function set_trade(value)
        trade = value
    end

end