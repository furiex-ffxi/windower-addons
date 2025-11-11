do
    -- List of supported addons
    function check_addons()
        -- Sortie Addon
        sortie_engine()
        -- TP Party Addon
        insight_engine()
        -- Augmenation Addon
        augmentation_engine()
    end

    function addon_commands(message)

        if message[3] == "silmaril" then
            local sm_display = get_sm_window()

            -- Display window
            if message[4] == 'True' then
                display_command(true)
            else
                display_command(false)
            end

            sm_display:pos_x(tonumber(message[5]))
            sm_display:pos_y(tonumber(message[6]))

            -- In game info
            if message[7] == 'True' then
                info_command(true)
            else
                info_command(false)
            end

            set_sm_window(sm_display)

            local npc_display = get_npc_window()
            npc_display:pos_x(tonumber(message[8]))
            npc_display:pos_y(tonumber(message[9]))
            set_npc_window(npc_display)

            local result_display = get_result_window()
            result_display:pos_x(tonumber(message[8]))
            result_display:pos_y(tonumber(message[9]))
            set_result_window(result_display)

        elseif message[3] == "sortie" then
            -- Specific Command
            if message[4] == "command" then
                sortie_command_input(message)
            else
                -- Display window
                if message[4] == 'True' then
                    set_sortie_display(true)
                else
                    set_sortie_display(false)
                end
                local window = get_sortie_window()
                window:pos_x(tonumber(message[5]))
                window:pos_y(tonumber(message[6]))
                set_sortie_window(window)
            end

        elseif message[3] == "insight" then
            -- Display window
            if message[4] == 'True' then
                set_insight_enabled(true)
            else
                set_insight_enabled(false)
            end

        elseif message[3] == "augmentation" then
            local settings = get_augmentation_settings()

            settings.trade_item = message[5]
            settings.trade_material = message[6]
            settings.augment_1 = message[7]:lower()
            settings.augment_2 = message[8]:lower()
            settings.augment_3 = message[9]:lower()

            settings.watch_value_1 = tonumber(message[10])
            if settings.watch_value_1 == 0 then settings.watch_value_1 = nil end
            if settings.augment_1 == "" then settings.watch_value_1 = nil end

            settings.watch_value_2 = tonumber(message[11])
            if settings.watch_value_2 == 0 then settings.watch_value_2 = nil end
            if settings.augment_2 == "" then settings.watch_value_2 = nil end

            settings.watch_value_3 = tonumber(message[12])
            if settings.watch_value_3 == 0 then settings.watch_value_3 = nil end
            if settings.augment_3 == "" then settings.watch_value_3 = nil end

            settings.mode = message[13]
            settings.delay = tonumber(message[14])

            if settings.delay and settings.delay < 1 and settings.mode ~= "Geas Fete" then
                settings.delay = 1
            end

            if message[15] == 'True' then
                settings.augment_mode = 'or'
            else
                settings.augment_mode = 'and'
            end

            settings.style = message[16]

            set_augmentation_settings(settings)

            if message[4] == 'True' then
                start_augmentation()
            else
                stop_augmentation()
            end
        end

    end

end
