_addon.name = 'pearljam'
_addon.author = 'Kayte'
_addon.version = '0.2'

local broken = {'Ahalee', 'Rihalhee', 'Ahaleemule', 'Spearmintmule', 'Fuzzyrazor'}

windower.register_event('chat message', function(message, sender, mode, gm)
    if mode ~= 5 and mode ~= 27 then
        return
    end

    for i = 1, #broken do
        if sender == broken[i] then
            coroutine.sleep(math.random(2, 5)) -- comment this line out for instant kicks
            windower.chat.input('/breaklinkpearl ' .. sender)
        end
    end
end)
