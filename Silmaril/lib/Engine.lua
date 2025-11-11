do
    local enabled = false
    local connected = false
    local old_status = 0
    local old_menu = 0
    local auto_load = true
    local auto_load_time = os.clock()

    function main_engine()

        local engine_speed = 1/45
        local movement_speed = 1/10
        local send_speed = 1/5
        local display_speed = 1/4
        local sync_speed = 30
        local inv_speed = 2

        local now = os.clock()
        local last_request = now
        local last_sync = now
        local last_display = now
        local last_movement = now
        local last_send = now
        local last_inventory = now

	    while true do

            -- used to determine the elapsed time
            now = os.clock() 

            --check the UDP port for incoming traffic
            receive_info() 

            if not connected then
                if now - last_request > 2 then
                    -- Send the request to connect to silmaril via Connection.lua
                    request()
                    last_request = now
                end
            else

                if now - last_movement > movement_speed then

                    -- Update the player information via Player.lua
                    update_player_info()

                    -- Process player movement in Moving.lua
                    movement()

                    last_movement = now
                end

                if now - last_send > send_speed then

                    -- Send the info to Silmaril
                    send_silmaril()
                    last_send = now
                end

                -- load the initial settings
                if auto_load and now - auto_load_time > 2 then 
                    -- Auto default load settings
                    load_command("")
                    auto_load = false;
                end

                -- Update the in game display
                if now - last_display > display_speed then

                    -- call to Display.lua
                    update_display() 

                    -- call to Addons.lua
                    check_addons()

                    -- Player was generating a mirror and recieved a release packet.  Now just wait till status ~= 4
                    if get_mirror_on() and get_mirroring() then
                        local p = get_player_data()
                        local w = get_world()

                        -- Normal interactions
                        if old_status == 4 and p.status == 0 and get_mirror_release() and not get_buy_sell() then
                            -- Player is released via status change (non standard)
                            log("Mirror sequence completed via status change")
                            npc_mirror_complete()
                            clear_npc_data()
                        end

                        -- Buy/Sell interactions
                        if get_buy_sell() and old_menu and not w.menu_open then
                            log("Buy/Sell sequence completed via status change")
                            npc_mirror_complete()
                            clear_npc_data()
                        end

                        -- Trade action
                        if get_trade() and now - get_message_time() > 4 and p.status ~= 4 then
                            log("Trade sequence completed via time out")
                            npc_mirror_complete()
                            clear_npc_data()
                        end

                        if old_status == 0 and p.status == 0 and get_mirror_release() and not get_buy_sell() and not get_trade() and now - get_message_time() > 2 then
                            -- Player is released via status change (non standard)
                            log("Mirror sequence completed via poke")
                            npc_mirror_complete()
                            clear_npc_data()
                        end

                        old_status = p.status
                        old_menu = w.menu_open
                    end

                    -- Mirroring 
                    if get_injecting() then 
                        local retry_count = get_retry_count()
                        -- No poke response after the time delay
                        if now - get_poke_time() > 1.5 + retry_count * .5 and not get_mid_inject() then
                            -- There are still message so try to get a poke response
                            if get_mirror_message() then
                                if retry_count < 5 then
                                    retry_count = retry_count + 1
                                    log("Retry Poke ["..retry_count..'/5] - Time Out ('..tostring(now - get_poke_time())..')')
                                    que_packet("mirror_status_retry_"..string.format("%i",retry_count))
                                    npc_retry()
                                else
                                    log("Timed out - Unable to Poke NPC.")
                                    que_packet("mirror_status_failed")
                                    npc_reset()
                                    clear_npc_data()
                                end
                            else
                                -- Turns off injection and finishes process
                                log('End of messages reached - Detected by Engine')
                                que_packet("mirror_status_completed")
                                clear_npc_data()
                            end
                        end

                        -- Mid injection and no response so follow up with injection
                        if get_mid_inject() then
                            if now - get_message_time() > 4 then -- Likely need to retry the packet instead of progressing
                                log("Middle of injection and message time out ["..string.format("%.2f",now - get_message_time()).."]")
                                if not get_mirror_message() or #get_mirror_message() == 0 then
                                    log("Timed out and all message are sent - Consider complete and reseting.")
                                    -- Check is the player is in a menu
                                    local p = get_player_data()
                                    if p.status == 4 then
                                        log("Player is in menu - Reset before finishing")
                                        npc_reset()
                                    end
                                    clear_npc_data()
                                    que_packet("mirror_status_completed")
                                else
                                    log("Continue the injection.")
                                    npc_inject()
                                end
                            else
                                -- Don't wait for the buy/sell
                                if #get_mirror_message() == 0 and get_buy_sell() then
                                    npc_inject()
                                end
                            end

                            -- The buy was complete so cancel out of menu
                            if get_buy_sell() and not get_mirror_message() then
                                log("Reset from the menu buying")
                                npc_reset()
                                clear_npc_data()
                            end
                        end
                    end

                    last_display = now
                end

                -- Update the spells the player has
                if now - last_sync > sync_speed then 
                    get_player_spells() -- Spells.lua
                    que_packet_silent("sync") -- Request any Skillchain info
                    last_sync = now
                end

                --Update the inventory
                if now - last_inventory > inv_speed then 
                    --Item data to the Silmaril Program via World.lua
                    que_packet_silent(get_inventory())
                    last_inventory = now
                end

            end
            sleep_time(engine_speed)
        end
    end

    function get_enabled()
        return enabled
    end

    function set_enabled(value)
        enabled = value
    end

    function set_connected(value)
        log("Connected ["..tostring(value)..']')
        sync = false
        connected = value
    end

    function get_connected()
        return connected
    end

    function set_auto_load(value)
        auto_load = value
        auto_load_time = os.clock()
    end

    function get_auto_load()
        return auto_load
    end

end