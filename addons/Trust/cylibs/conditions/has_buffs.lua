---------------------------
-- Condition checking whether the player has the given buffs.
-- @class module
-- @name HasBuffsCondition

local buff_util = require('cylibs/util/buff_util')
local serializer_util = require('cylibs/util/serializer_util')

local Condition = require('cylibs/conditions/condition')
local HasBuffsCondition = setmetatable({}, { __index = Condition })
HasBuffsCondition.__index = HasBuffsCondition

function HasBuffsCondition.new(buff_names, require_all)
    local self = setmetatable(Condition.new(windower.ffxi.get_player().index), HasBuffsCondition)
    self.buff_names = buff_names -- save arg for serializer
    self.buff_ids = buff_names:map(function(buff_name) return buff_util.buff_id(buff_name)  end)
    self.require_all = require_all
    return self
end

function HasBuffsCondition:is_satisfied(target_index)
    local target = windower.ffxi.get_mob_by_index(target_index)
    if target and target.index == windower.ffxi.get_player().index then
        local player_buff_ids = L(windower.ffxi.get_player().buffs)
        for buff_id in self.buff_ids:it() do
            local is_buff_active = buff_util.is_buff_active(buff_id, player_buff_ids)
            if self.require_all then
                if not is_buff_active then
                    return false
                end
            else
                if is_buff_active then
                    return true
                end
            end
        end
    end
    if self.require_all then
        return true
    else
        return false
    end
end

function HasBuffsCondition:tostring()
    return "HasBuffsCondition"
end

function HasBuffsCondition:serialize()
    return "HasBuffsCondition.new(" .. serializer_util.serialize_args(self.buff_names, self.require_all) .. ")"
end

return HasBuffsCondition




