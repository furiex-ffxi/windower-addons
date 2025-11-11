function send_silmaril()

    reset_packet_buffs() -- Remove any old buffs held in Packets.lua

    --Begin updates via a heartbeat check
    local packet_data = get_player_id()..';heartbeat'

    --Player status from Player.lua
    packet_data = packet_data..';'..send_player_update()

    --Party data via Party.Lua
    for index, value in pairs(get_party_data()) do
        packet_data = packet_data..';'..value
    end

    --Party Buffs via Buffs.lua
    for index, value in pairs(get_party_buffs()) do
        packet_data = packet_data..';'..value
    end

    --Player buffs from Player.lua
    packet_data = packet_data..';'..get_player_buffs()

    --Job ability recasts vis Abilities.lua
    packet_data = packet_data..';'..get_abilities_recast()

    --Spell recasts to the Silmaril Program
    packet_data = packet_data..';'..get_spell_recast()

    --Trust recasts to the Silmaril Program
    packet_data = packet_data..';'..get_trust_recast()

    --World data to the Silmaril Program via World.lua
    packet_data = packet_data..';'..get_world_data()

    --Enemy data to the Silmaril Program via World.lua
    packet_data = packet_data..';'..get_enemy_data()

    --NPC data to the Silmaril Program via World.lua
    packet_data = packet_data..';'..get_npc_data()

    -- Process the qued action from the last update_player
    for index, value in pairs(get_action_packets()) do
        packet_data = packet_data..';'..value
    end

    --Process the information and generate a response
    packet_data = packet_data..';action'

    --Send the built string using send_update to not log the big messages
    send_packet(packet_data)

    reset_action_packets()
end