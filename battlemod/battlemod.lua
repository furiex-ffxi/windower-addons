require 'tables'
require 'sets'
file = require 'files'
config = require 'config'
require 'strings'
res = require 'resources'
require 'actions'
require 'pack'
bit = require 'bit'
packets = require('packets')

require 'generic_helpers'
require 'parse_action_packet'
require 'statics'

_addon.version = '3.34'
_addon.name = 'BattleMod'
_addon.author = 'Byrth, SnickySnacks, Kenshi'
_addon.commands = {'bm','battlemod'}

windower.register_event('load',function()
    if debugging then windower.debug('load') end
    options_load()
end)

windower.register_event('login',function (name)
    if debugging then windower.debug('login') end
    options_load:schedule(10)
end)

windower.register_event('addon command', function(command, ...)
    if debugging then windower.debug('addon command') end
    local args = {...}
    command = command and command:lower()
    if command then
        if command:lower() == 'commamode' then
            commamode = not commamode
            windower.add_to_chat(121,'Battlemod: Comma Mode flipped! - '..tostring(commamode))
        elseif command:lower() == 'oxford' then
            oxford = not oxford
            windower.add_to_chat(121,'Battlemod: Oxford Mode flipped! - '..tostring(oxford))
        elseif command:lower() == 'targetnumber' then
            targetnumber = not targetnumber
            windower.add_to_chat(121,'Battlemod: Target Number flipped! - '..tostring(targetnumber))
        elseif command:lower() == 'condensetargetname' then
            condensetargetname = not condensetargetname
            windower.add_to_chat(121,'Battlemod: Target Name Condensation flipped! - '..tostring(condensetargetname))                                                                
        elseif command:lower() == 'swingnumber' then
            swingnumber = not swingnumber
            windower.add_to_chat(121,'Battlemod: Round Number flipped! - '..tostring(swingnumber))
        elseif command:lower() == 'sumdamage' then
            sumdamage = not sumdamage
            windower.add_to_chat(121,'Battlemod: Sum Damage flipped! - '..tostring(sumdamage))
        elseif command:lower() == 'condensecrits' then
            condensecrits = not condensecrits
            windower.add_to_chat(121,'Battlemod: Condense Crits flipped! - '..tostring(condensecrits))
        elseif command:lower() == 'cancelmulti' then
            cancelmulti = not cancelmulti
            windower.add_to_chat(121,'Battlemod: Multi-canceling flipped! - '..tostring(cancelmulti))
        elseif command:lower() == 'reload' then
            current_job = 'NONE'
            options_load()
        elseif command:lower() == 'unload' then
            windower.send_command('@lua u battlemod')
        elseif command:lower() == 'simplify' then
            simplify = not simplify
            windower.add_to_chat(121,'Battlemod: Text simplification flipped! - '..tostring(simplify))
        elseif command:lower() == 'condensedamage' then
            condensedamage = not condensedamage
            windower.add_to_chat(121,'Battlemod: Condensed Damage text flipped! - '..tostring(condensedamage))
        elseif command:lower() == 'condensetargets' then
            condensetargets = not condensetargets
            windower.add_to_chat(121,'Battlemod: Condensed Targets flipped! - '..tostring(condensetargets))
        elseif command:lower() == 'showownernames' then
            showownernames = not showownernames
            windower.add_to_chat(121,'Battlemod: Show pet owner names flipped! - '..tostring(showownernames))
        elseif command:lower() == 'crafting' then
            crafting = not crafting
            windower.add_to_chat(121,'Battlemod: Display crafting results flipped! - '..tostring(crafting))
      elseif command:lower() == 'showblocks' then
            showblocks = not showblocks
            windower.add_to_chat(121,'Battlemod: Show blocks with shield flipped! - '..tostring(showblocks))
        elseif command:lower() == 'showguards' then
            showguards = not showguards
            windower.add_to_chat(121,'Battlemod: Show guarding on hits flipped! - '..tostring(showguards))
        elseif command:lower() == 'showcritws' then
            showcritws = not showcritws
            windower.add_to_chat(121,'Battlemod: Show critical hit on ws/mob tp flipped! - '..tostring(showcritws))
        elseif command:lower() == 'showrollinfo' then
            showrollinfo = not showrollinfo
            windower.add_to_chat(121,'Battlemod: Show lucky/unlucky rolls flipped! - '..tostring(showrollinfo))
        elseif command:lower() == 'colortest' then
            local counter = 0
            local line = ''
            for n = 1, 262 do
                if not color_redundant:contains(n) and not black_colors:contains(n) then
                    if n <= 255 then
                        loc_col = string.char(0x1F, n)
                    else
                        loc_col = string.char(0x1E, n - 254)
                    end
                    line = line..loc_col..string.format('%03d ', n)
                    counter = counter + 1
                end
                if counter == 16 or n == 262 then
                    windower.add_to_chat(6, line)
                    counter = 0
                    line = ''
                end
            end
            windower.add_to_chat(122,'Colors Tested!')
        elseif command:lower() == 'help' then
            print('   :::   '.._addon.name..' ('.._addon.version..')   :::')
            print('Toggles: (* subtoggles)')
            print('           1. simplify              - Condenses battle text using custom messages ('..tostring(simplify)..')')
            print('           2. condensetargets       - Collapse similar messages with multiple targets ('..tostring(condensetargets)..')')
            print('               * targetnumber       - Toggle target number display ('..tostring(targetnumber)..')')
            print('               * condensetargetname - Toggle target name condensation ('..tostring(condensetargetname)..')')
            print('               * oxford             - Toggle use of oxford comma ('..tostring(oxford)..')')
            print('               * commamode          - Toggle comma-only mode ('..tostring(commamode)..')')
            print('           3. condensedamage        - Condenses damage messages within attack rounds ('..tostring(condensedamage)..')')
            print('               * swingnumber        - Show # of attack rounds ('..tostring(swingnumber)..')')
            print('               * sumdamage          - Sums condensed damage if true, comma-separated if false ('..tostring(sumdamage)..')')
            print('               * condensecrits      - Condenses critical hits and normal hits together ('..tostring(condensecrits)..')')
            print('           4. cancelmulti           - Cancels multiple consecutive identical lines ('..tostring(cancelmulti)..')')
            print('           5. showonernames         - Shows the name of the owner on pet messages ('..tostring(showownernames)..')')
            print('           6. crafting              - Enables early display of crafting results ('..tostring(crafting)..')')
            print('           7. showblocks            - Shows if a hit was blocked with shield ('..tostring(showblocks)..')')
            print('           8. showguards            - Shows if a hit was guarded ('..tostring(showguards)..')')
            print('           9. showcritws            - Shows if a ws or mob ability was a critical hit (shows on multihit if atleast 1 hit was a crit) ('..tostring(showcritws)..')')
            print('           10. showrollinfo         - Shows lucky/unlucky rolls ('..tostring(showrollinfo)..')')
            print('Utilities: 1. colortest             - Shows the 509 possible colors for use with the settings file')
            print('           2. reload                - Reloads settings file')
            print('           3. unload                - Unloads Battlemod')
        end
    end
end)

windower.register_event('incoming text',function (original, modified, color, color_m, blocked)
    if debugging then windower.debug('incoming text') end
    local redcol = color%256
    
    if redcol == 121 and cancelmulti then
        a,z = string.find(original,'Equipment changed')
        
        if a and not block_equip then
            flip_block_equip:schedule(1)
            block_equip = true
        elseif a and block_equip then
            modified = true
        end
    elseif redcol == 123 and cancelmulti then
        a,z = string.find(original,'You were unable to change your equipped items')
        b,z = string.find(original,'You cannot use that command while viewing the chat log')
        c,z = string.find(original,'You must close the currently open window to use that command')
        
        if (a or b or c) and not block_cannot then
            flip_block_cannot:schedule(1)
            block_cannot = true
        elseif (a or b or c) and block_cannot then
            modified = true
        end
    end
    if block_modes:contains(color) then
        local endline = string.char(0x7F, 0x31)
        local item = string.char(0x1E)
        if not bm_message(original) then
            if original:endswith(endline) then --allow add_to_chat messages with the modes we blocking
                return true
            end
        elseif original:endswith(endline) and string.find(original, item) then --block items action messages
            return true
        end
    elseif color == 191 then
        local endline = string.char(0x7F, 0x31)
        if original:endswith(endline) and string.find(original, 'effect wears off.') then --deduplication blocking fix
            local status = string.match(original, '\'s (.+) effect wears off') or string.match(original, '\' (.+) effect wears off')
            if antideduplication_table[status] and string.find(original, antideduplication_table[status].message) then
                packet_inject(antideduplication_table[status].packet_table)
                return true
            end
        elseif string.find(original, 'dummy'..endline) then --block sideeffect of setting the message to 0 in injected 0x029 packet
            return true
        end
    end
    
    return modified, color_m
end)

function bm_message(original)
    local check = string.char(0x1E)
    local check2 = string.char(0x1F)
    if string.find(original, check) or string.find(original, check2) then
        return true
    end
end

function flip_block_equip()
    block_equip = not block_equip
end

function flip_block_cannot()
    block_cannot = not block_cannot
end

function options_load()
    if windower.ffxi.get_player() then
        Self = windower.ffxi.get_player()
    end
    if not windower.dir_exists(windower.addon_path..'data\\') then
        windower.create_dir(windower.addon_path..'data\\')
    end
    if not windower.dir_exists(windower.addon_path..'data\\filters\\') then
        windower.create_dir(windower.addon_path..'data\\filters\\')
    end
     
    local settingsFile = file.new('data\\settings.xml',true)
    local filterFile=file.new('data\\filters\\filters.xml',true)
    local colorsFile=file.new('data\\colors.xml',true)
    
    if not file.exists('data\\settings.xml') then
        settingsFile:write(default_settings)
        print('Default settings xml file created')
    end
    
    local settingtab = config.load('data\\settings.xml',default_settings_table)
    config.save(settingtab)
    
    for i,v in pairs(settingtab) do
        _G[i] = v
    end
    
    if not file.exists('data\\filters\\filters.xml') then
        filterFile:write(default_filters)
        print('Default filters xml file created')
    end
    local tempplayer = windower.ffxi.get_player()
    if tempplayer then
        if tempplayer.main_job ~= 'NONE' then
            filterload(tempplayer.main_job)
        elseif windower.ffxi.get_mob_by_id(tempplayer.id)['race'] == 0 then
            filterload('MON')
        else
            filterload('DEFAULT')
        end
    else
        filterload('DEFAULT')
    end
    if not file.exists('data\\colors.xml') then
        colorsFile:write(default_colors)
        print('Default colors xml file created')
    end
    local colortab = config.load('data\\colors.xml',default_color_table)
    config.save(colortab)
    for i,v in pairs(colortab) do
        color_arr[i] = colconv(v,i)
    end
end

function filterload(job)
    if current_job == job then return end
    if file.exists('data\\filters\\filters-'..job..'.xml') then
        default_filt = false
        filter = config.load('data\\filters\\filters-'..job..'.xml',default_filter_table,false)
        --config.save(filter)
        windower.add_to_chat(4,'Loaded '..job..' Battlemod filters')
    elseif not default_filt then
        default_filt = true
        filter = config.load('data\\filters\\filters.xml',default_filter_table,false)
        --config.save(filter)
        windower.add_to_chat(4,'Loaded default Battlemod filters')
    end
    current_job = job
end

ActionPacket.open_listener(parse_action_packet)

windower.register_event('incoming chunk',function (id,original,modified,is_injected,is_blocked)
    if debugging then windower.debug('incoming chunk '..id) end
    
------- ITEM QUANTITY -------
    if id == 0x020 and parse_quantity then
        --local packet = packets.parse('incoming', original)
        local item = original:unpack('H',0x0D)
        local count = original:unpack('I',0x05)
        if item == 0 then return end
        if item_quantity.id == item then
            item_quantity.count = count..' '
        end

------- NOUNS AND PLURAL ENTITIES -------    
    elseif id == 0x00E then
        local mob_id = original:unpack('I',0x05)
        local mask = original:unpack('C',0x0B)
        local chat_info = original:unpack('C',0x28)
        if bit.band(mask,4) == 4 then
            if bit.band(chat_info,32) == 0 and not common_nouns:contains(mob_id) then
                table.insert(common_nouns, mob_id)
            elseif bit.band(chat_info,64) == 64 and not plural_entities:contains(mob_id) then
                table.insert(plural_entities, mob_id)
            elseif bit.band(chat_info,64) == 0 and plural_entities:contains(mob_id) then --Gears can change their grammatical number when they lose 2 gear?
                for i, v in pairs(plural_entities) do
                    if v == mob_id then
                        table.remove(plural_entities, i)
                        break
                    end
                end
            end
        end
    elseif id == 0x00B then --Reset tables on Zoning
        common_nouns = T{}
        plural_entities = T{}
        
------- ACTION MESSAGE -------
    elseif id == 0x29 then
        local am = {}
        am.actor_id = original:unpack('I',0x05)
        am.target_id = original:unpack('I',0x09)
        am.param_1 = original:unpack('I',0x0D)
        am.param_2 = original:unpack('I',0x11)
        --am.param_2 = original:unpack('H',0x11)%2^9 -- First 7 bits
        --am.param_3 = math.floor(original:unpack('I',0x11)/2^5) -- Rest
        am.actor_index = original:unpack('H',0x15)
        am.target_index = original:unpack('H',0x17)
        am.message_id = original:unpack('H',0x19)
        --am.message_id = original:unpack('H',0x19)%2^15 -- Cut off the most significant bit
        
        local actor = player_info(am.actor_id)
        local target = player_info(am.target_id)
        local actor_article = common_nouns:contains(am.actor_id) and 'The ' or ''
        local target_article = common_nouns:contains(am.target_id) and 'The ' or ''
        targets_condensed = false
        
        -- Filter these messages
        if not check_filter(actor,target,0,am.message_id) then return true end
        
        if not actor or not target then -- If the actor or target table is nil, ignore the packet
        elseif am.message_id == 800 then -- Spirit bond message
            local status = color_it(res.buffs[am.param_1][language],color_arr.statuscol)
            local targ = color_it(target.name or '',color_arr[target.owner or target.type])
            local number = am.param_2
            local color = color_filt(res.action_messages[am.message_id].color, am.target_id==Self.id)
            if simplify then
                local msg = line_noactor
                    :gsub('${abil}',status or '')
                    :gsub('${target}',targ)
                    :gsub('${numb}',number or '')
                windower.add_to_chat(color, msg)
            else
                local msg = res.action_messages[am.message_id][language]
                msg = grammatical_number_fix(msg, number, am.message_id)
                if plural_entities:contains(am.actor_id) then
                    msg = plural_actor(msg, am.message_id)
                end
                if plural_entities:contains(am.target_id) then
                    msg = plural_target(msg, am.message_id)
                end
                local msg = clean_msg(msg
                    :gsub('${status}',status or '')
                    :gsub('${target}',target_article..targ)
                    :gsub('${number}',number or ''), am.message_id)
                windower.add_to_chat(color, msg)
            end
        elseif (am.message_id == 206 or am.message_id == 204) and condensetargets then -- Wears off and is no longer messages
            -- Condenses across multiple packets
            local status
            local lang = log_form_messages:contains(am.message_id) and 'english_log' or language
            
            if not is_injected and am.message_id == 206 then
                local outstr = res.action_messages[am.message_id][language]
            
                if plural_entities:contains(am.actor_id) then
                    outstr = plural_actor(outstr, am.message_id)
                end
                if plural_entities:contains(am.target_id) then
                    outstr = plural_target(outstr, am.message_id)
                end
            
                antideduplication(outstr, am)
            end
            
            if enfeebling:contains(am.param_1) and res.buffs[am.param_1] then
                status = color_it(res.buffs[am.param_1][lang],color_arr.enfeebcol)
            elseif color_arr.statuscol == rcol then
                status = color_it(res.buffs[am.param_1][lang],string.char(0x1F,191))
            else
                status = color_it(res.buffs[am.param_1][lang],color_arr.statuscol)
            end
            
            if not multi_actor[status] then multi_actor[status] = player_info(am.actor_id) end
            if not multi_msg[status] then multi_msg[status] = am.message_id end
            
            if not multi_targs[status] and not stat_ignore:contains(am.param_1) then
                multi_targs[status] = {}
                multi_targs[status][1] = target
                multi_packet:schedule(0.5, status)
            elseif not (stat_ignore:contains(am.param_1)) then
                multi_targs[status][#multi_targs[status]+1] = target
            else
            -- This handles the stat_ignore values, which are things like Utsusemi,
            -- Sneak, Invis, etc. that you don't want to see on a delay
                multi_targs[status] = {}
                multi_targs[status][1] = target
                multi_packet(status)
            end
            if is_injected then
                local parsed = packets.parse('incoming', original)
                parsed['Message'] = 0
                local rebuilt = packets.build(parsed)
                return rebuilt
            end
            am.message_id = false
        elseif passed_messages:contains(am.message_id) then
            local item,status,spell,skill,number,number2
            local outstr = res.action_messages[am.message_id][language]
            local color = color_filt(res.action_messages[am.message_id].color, am.actor_id==Self.id)
            if plural_entities:contains(am.actor_id) then
                outstr = plural_actor(outstr, am.message_id)
            end
            if plural_entities:contains(am.target_id) then
                outstr = plural_target(outstr, am.message_id)
            end
            
            if am.message_id == 206 and not is_injected then antideduplication(outstr, am) end
            
            local fields = fieldsearch(outstr)
            
            if fields.status then
                if log_form_messages:contains(am.message_id) then
                    status = res.buffs[am.param_1].english_log
                else
                    status = nf(res.buffs[am.param_1],language)
                end
                if enfeebling:contains(am.param_1) then
                    status = color_it(status,color_arr.enfeebcol)
                else
                    status = color_it(status,color_arr.statuscol)
                end
            end
            
            if fields.spell then
                if not res.spells[am.param_1] then
                    return false
                end
                spell = nf(res.spells[am.param_1],language)
            end
            
            if fields.item then
                if not res.items[am.param_1] then
                    return false
                end
                item = nf(res.items[am.param_1],'english_log')
            end
            
            if fields.number then
                number = am.param_1
            end
            
            if fields.number2 then
                number2 = am.param_2
            end
            
            if fields.skill and res.skills[am.param_1] then
                skill = res.skills[am.param_1][language]:lower()
            end
            
            if am.message_id > 169 and am.message_id <179 then
                if am.param_1 > 2147483647 then
                    skill = 'to be level -1 ('..ratings_arr[am.param_2-63]..')'
                else
                    skill = 'to be level '..am.param_1..' ('..ratings_arr[am.param_2-63]..')'
                end
            end
            outstr = (clean_msg(outstr
                :gsub('${actor}\'s',actor_article..color_it(actor.name or '',color_arr[actor.owner or actor.type])..'\'s'..actor.owner_name)
                :gsub('${actor}',actor_article..color_it(actor.name or '',color_arr[actor.owner or actor.type])..actor.owner_name)
                :gsub('${status}',status or '')
                :gsub('${item}',color_it(item or '',color_arr.itemcol))
                :gsub('${target}\'s',target_article..color_it(target.name or '',color_arr[target.owner or target.type])..'\'s'..target.owner_name)
                :gsub('${target}',target_article..color_it(target.name or '',color_arr[target.owner or target.type])..target.owner_name)
                :gsub('${spell}',color_it(spell or '',color_arr.spellcol))
                :gsub('${skill}',color_it(skill or '',color_arr.abilcol))
                :gsub('${number}',number or '')
                :gsub('${number2}',number2 or '')
                :gsub('${skill}',skill or '')
                :gsub('${lb}','\7'), am.message_id))
            windower.add_to_chat(color,outstr)
            if am.message_id == 206 and is_injected then 
                local parsed = packets.parse('incoming', original)
                parsed['Message'] = 0
                local rebuilt = packets.build(parsed)
                return rebuilt
            end
            am.message_id = false
        elseif debugging and res.action_messages[am.message_id] then 
        -- 38 is the Skill Up message, which (interestingly) uses all the number params.
        -- 202 is the Time Remaining message, which (interestingly) uses all the number params.
            print('debug_EAM#'..am.message_id..': '..res.action_messages[am.message_id][language]..' '..am.param_1..'   '..am.param_2)
        elseif debugging then
            print('debug_EAM#'..am.message_id..': '..'Unknown'..' '..am.param_1..'   '..am.param_2)
        end
        if not am.message_id then
            return true
        end

------------ SYNTHESIS ANIMATION --------------
    elseif id == 0x030 and crafting then
        if windower.ffxi.get_player().id == original:unpack('I',5) or windower.ffxi.get_mob_by_target('t') and windower.ffxi.get_mob_by_target('t').id == original:unpack('I',5) then
            local crafter_name = (windower.ffxi.get_player().id == original:unpack('I',5) and windower.ffxi.get_player().name) or windower.ffxi.get_mob_by_target('t').name
            local result = original:byte(13)
            if result == 0 then
                windower.add_to_chat(8,' ------------- NQ Synthesis ('..crafter_name..') -------------')
            elseif result == 1 then
                windower.add_to_chat(8,' ---------------- Break ('..crafter_name..') -----------------')
            elseif result == 2 then
                windower.add_to_chat(8,' ------------- HQ Synthesis ('..crafter_name..') -------------')
            else
                windower.add_to_chat(8,'Craftmod: Unhandled result '..tostring(result))
            end
        end
    elseif id == 0x06F and crafting then
        if original:byte(5) == 0 or original:byte(5) == 12 then
            local result = original:byte(6)
            if result == 1 then
                windower.add_to_chat(8,' -------------- HQ Tier 1! --------------')
            elseif result == 2 then
                windower.add_to_chat(8,' -------------- HQ Tier 2! --------------')
            elseif result == 3 then
                windower.add_to_chat(8,' -------------- HQ Tier 3! --------------')
            end
        end
        
    ------------- JOB INFO ----------------
    elseif id == 0x01B then
        filterload(res.jobs[original:byte(9)][language..'_short'])
    end
end)

function multi_packet(...)
    local ind = table.concat({...},' ')
    local targets = assemble_targets(multi_actor[ind],multi_targs[ind],0,multi_msg[ind])
    local outstr = targets_condensed and plural_target(res.action_messages[multi_msg[ind]][language], multi_msg[ind]) or res.action_messages[multi_msg[ind]][language]
    outstr = clean_msg(outstr
        :gsub('${target}\'s',targets)
        :gsub('${target}',targets)
        :gsub('${status}',ind), multi_msg[ind])
    windower.add_to_chat(res.action_messages[multi_msg[ind]].color,outstr)
    multi_targs[ind] = nil
    multi_msg[ind] = nil
    multi_actor[ind] = nil
end

function antideduplication(msg, data)
    local status = res.buffs[data.param_1].en
    local actor = player_info(data.actor_id)
    local target = player_info(data.target_id)
    local target_article = common_nouns:contains(data.target_id) and 'The ' or ''
    msg = (clean_msg(msg
        :gsub('${status}',status)
        :gsub('${target}\'s',target_article..target.name ..'\'s')
        :gsub('${target}',target_article..target.name)))
    antideduplication_table[status] = {message = msg, packet_table = data}
end

function packet_inject(data)
    packets.inject(packets.new('incoming', 0x029, {
            ['Actor'] = data.actor_id,
            ['Target'] = data.target_id,
            ['Param 1'] = data.param_1,
            ['Param 2'] = data.param_2,
            ['Actor Index'] = data.actor_index,
            ['Target Index'] = data.target_index,
            ['Message'] = 206,
            ['_unknown1'] = 0
            }))
end
