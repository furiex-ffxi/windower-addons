do
    local all_items = get_res_all_items() -- Store the resource information in a table
    local formattedString = "items_"

    local ninja_tools = {
        ["Chonofuda"] = "Toolbag (Cho)",
        ["Furusumi"] = "Toolbag (Furu)",
        ["Hiraishin"] = "Toolbag (Hira)",
        ["Inoshishinofuda"] = "Toolbag (Ino)",
        ["Jinko"] = "Toolbag (Jinko)",
        ["Jusatsu"] = "Toolbag (Jusa)",
        ["Kabenro"] = "Toolbag (Kaben)",
        ["Kaginawa"] = "Toolbag (Kagi)",
        ["Kawahori-Ogi"] = "Toolbag (Kawa)",
        ["Kodoku"] = "Toolbag (Kodo)",
        ["Makibishi"] = "Toolbag (Maki)",
        ["Mizu-Deppo"] = "Toolbag (Mizu)",
        ["Mokujin"] = "Toolbag (Moku)",
        ["Ranka"] = "Toolbag (Ranka)",
        ["Ryuno"] = "Toolbag (Ryuno)",
        ["Sairui-Ran"] = "Toolbag (Sai)",
        ["Sanjaku-Tenugui"] = "Toolbag (Sanja)",
        ["Shihei"] = "Toolbag (Shihe)",
        ["Shikanofuda"] = "Toolbag (Shika)",
        ["Shinobi-Tabi"] = "Toolbag (Shino)",
        ["Soshi"] = "Toolbag (Soshi)",
        ["Tsurara"] = "Toolbag (Tsura)",
        ["Uchitake"]= "Toolbag (Uchi)" 
    }

    local ninja_tool_bag = {
        ["Toolbag (Cho)"] = "Chonofuda",
        ["Toolbag (Furu)"] = "Furusumi",
        ["Toolbag (Hira)"] = "Hiraishin",
        ["Toolbag (Ino)"] = "Inoshishinofuda",
        ["Toolbag (Jinko)"] = "Jinko",
        ["Toolbag (Jusa)"] = "Jusatsu",
        ["Toolbag (Kaben)"] = "Kabenro",
        ["Toolbag (Kagi)"] = "Kaginawa",
        ["Toolbag (Kawa)"] = "Kawahori-Ogi",
        ["Toolbag (Kodo)"] = "Kodoku",
        ["Toolbag (Maki)"] = "Makibishi",
        ["Toolbag (Mizu)"] = "Mizu-Deppo",
        ["Toolbag (Moku)"] = "Mokujin",
        ["Toolbag (Ranka)"] = "Ranka",
        ["Toolbag (Ryuno)"] = "Ryuno",
        ["Toolbag (Sai)"] = "Sairui-Ran",
        ["Toolbag (Sanja)"] = "Sanjaku-Tenugui",
        ["Toolbag (Shihe)"] = "Shihei",
        ["Toolbag (Shika)"] = "Shikanofuda",
        ["Toolbag (Shino)"] = "Shinobi-Tabi",
        ["Toolbag (Soshi)"] = "Soshi",
        ["Toolbag (Tsura)"] = "Tsurara",
        ["Toolbag (Uchi)"]= "Uchitake"
    }

    local cards = {
        ["Trump Card"] = "Trump Card Case",
        ["Fire Card"] = "Fire Card Case",
        ["Ice Card"] = "Ice Card Case",
        ["Wind Card"] = "Wind Card Case",
        ["Earth Card"] = "Earth Card Case",
        ["Thunder Card"] = "Thunder Card Case",
        ["Water Card"] = "Water Card Case",
        ["Light Card"] = "Light Card Case",
        ["Dark Card"] = "Dark Card Case",
    }

    local cases = {
        ["Trump Card Case"] = "Trump Card",
        ["Fire Card Case"] = "Fire Card",
        ["Ice Card Case"] = "Ice Card",
        ["Wind Card Case"] = "Wind Card",
        ["Earth Card Case"] = "Earth Card",
        ["Thunder Card Case"] = "Thunder Card",
        ["Water Card Case"] = "Water Card",
        ["Light Card Case"] = "Light Card",
        ["Dark CardCase"] = "Dark Card",
    }

    local medicine = {
        ["Remedy"] = "",
        ["Echo Drops"] = "",
        ["Holy Water"] = "",
        ["Panacea"] = "",
        ["Antidote"] = "",
        ["Eye Drops"] = "",
    }

    local potions = {
        ["Potion"] = "",
        ["Hi-Potion"] = "",
        ["X-Potion"] = "",
        ["Max-Potion"] = "",
        ["Ether"] = "",
        ["Hi-Ether"] = "",
        ["Super Ether"] = "",
        ["Pro-Ether"] = "",
        ["Hi-Elixir"] = "",
        ["Elixir"] = "",
        ["Vile Elixir"] = "",
        ["Vile Elixir +1"] = "",
    }

    local weapons = {
        ["Thr. Tomahawk"] = "",
        ["Angon"] = "",
        ["Automat. Oil"] = "",
        ["Automat. Oil +1"] = "",
        ["Automat. Oil +2"] = "",
        ["Automat. Oil +3"] = "",
    }

    function get_inventory()
        formattedString = "items_"

        -- Inventory
        local items = get_items(0)
        if not items then return formattedString end
        for b,v in ipairs(items) do
            if v.id > 0 then
                local item = all_items[v.id]
                -- All usable items
                if item then
                    local item_name = item.en
                    -- Expendables
                    if weapons[item_name] then
                            formattedString = formattedString..item_name..'\\'..string.format("%i",v.id)..'\\'..string.format("%i",v.count)..'\\'
                        ..string.format("%i",v.slot)..'\\Weapon\\'..string.format("%i",item.stack)..'\\0\\0|'
                    elseif item.ammo_type ~= nil and item.ammo_type ~= "Bait" then
                            formattedString = formattedString..item_name..'\\'..string.format("%i",v.id)..'\\'..string.format("%i",v.count)..'\\'
                        ..string.format("%i",v.slot)..'\\Ammo\\'..string.format("%i",item.stack)..'\\0\\0|'
                    elseif ninja_tools[item_name] then
                           formattedString = formattedString..item_name..'\\'..string.format("%i",v.id)..'\\'..string.format("%i",v.count)..'\\'
                        ..string.format("%i",v.slot)..'\\Tool\\'..string.format("%i",item.stack)..'\\0\\'..ninja_tools[item_name]..'|'
                    elseif ninja_tool_bag[item_name] then
                           formattedString = formattedString..item_name..'\\'..string.format("%i",v.id)..'\\'..string.format("%i",v.count)..'\\'
                        ..string.format("%i",v.slot)..'\\Tool Bag\\'..string.format("%i",item.stack)..'\\0\\'..ninja_tool_bag[item_name]..'|'
                    elseif cases[item_name] then
                           formattedString = formattedString..item_name..'\\'..string.format("%i",v.id)..'\\'..string.format("%i",v.count)..'\\'
                        ..string.format("%i",v.slot)..'\\Case\\'..string.format("%i",item.stack)..'\\0\\'..cases[item_name]..'|'
                    elseif cards[item_name] then
                           formattedString = formattedString..item_name..'\\'..string.format("%i",v.id)..'\\'..string.format("%i",v.count)..'\\'
                        ..string.format("%i",v.slot)..'\\Cards\\'..string.format("%i",item.stack)..'\\0\\'..cards[item_name]..'|'

                    -- Consumables
                    elseif item["category"] == "Usable" then
                        local type = "Item"
                        if item.flags["Usable inside Mog Garden"] and not item.flags["No Auction"] and not item.flags["Rare"] and not item.flags["Exclusive"] then
                            type = "Food"
                        elseif medicine[item_name] then
                            type = "Medicine"
                        elseif potions[item_name] then
                            type = "Potion"
                        end
                        formattedString = formattedString..item_name..'\\'..string.format("%i",v.id)..'\\'..string.format("%i",v.count)..'\\'
                        ..string.format("%i",v.slot)..'\\'..type..'\\'..string.format("%i",item.stack)..'\\'..string.format("%i",item.cast_time)..'\\0|'
                    end
                end
            end
        end

        --Wardrobe
        get_expendables(8)
        --Wardrobe 2
        get_expendables(10)
        --Wardrobe 3
        get_expendables(11)
        --Wardrobe 4
        get_expendables(12)
        --Wardrobe 5
        get_expendables(13)
        --Wardrobe 6
        get_expendables(14)
        --Wardrobe 7
        get_expendables(15)
        --Wardrobe 8
        get_expendables(16)

        formattedString = formattedString:sub(1, #formattedString - 1)
        --log(formattedString)
        return formattedString
    end

    function get_expendables(bag)
        local items = get_items(bag)
        if items then
            for b,v in ipairs(items) do
                if v.id > 0 then
                    local item = all_items[v.id]
                    if item then
                        local item_name = item.en
                        if item_name == "Thr. Tomahawk" or item_name == "Angon" then
                              formattedString = formattedString..item_name..'\\'..string.format("%i",v.id)..'\\'..string.format("%i",v.count)..'\\'
                            ..string.format("%i",v.slot)..'\\Weapon\\'..string.format("%i",item.stack)..'\\0\\0|'
                        elseif item.ammo_type ~= nil and item.ammo_type ~= "Bait" then
                              formattedString = formattedString..item_name..'\\'..string.format("%i",v.id)..'\\'..string.format("%i",v.count)..'\\'
                            ..string.format("%i",v.slot)..'\\Ammo\\'..string.format("%i",item.stack)..'\\0\\0|'
                        end
                    end
                end
            end
        end
    end

    function get_item(id)
        return all_items[id]
    end

end