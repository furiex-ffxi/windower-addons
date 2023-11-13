---------------------------
-- Condition base class.
-- @class module
-- @name Condition
local serializer_util = require('cylibs/util/serializer_util')

local Condition = {}
Condition.__index = Condition

Condition.Operator = {}
Condition.Operator.Equals = "=="
Condition.Operator.GreaterThan = ">"
Condition.Operator.GreaterThanOrEqualTo = ">="
Condition.Operator.LessThan = "<"
Condition.Operator.LessThanOrEqualTo = "<="

-------
-- Default initializer for a condition.
-- @tparam number target_index (optional) Target index, will override target_index passed into is_satisfied
-- @treturn Condition A condition
function Condition.new(target_index)
    local self = setmetatable({
        target_index = target_index;
    }, Condition)

    return self
end

function Condition:destroy()
end

function Condition:is_satisfied(target_index)
    return true
end

function Condition:eval(arg1, arg2, operator)
    if operator == Condition.Operator.Equals then
        return arg1 == arg2
    elseif operator == Condition.Operator.GreaterThan then
        return arg1 > arg2
    elseif operator == Condition.Operator.GreaterThanOrEqualTo then
        return arg1 >= arg2
    elseif operator == Condition.Operator.LessThan then
        return arg1 < arg2
    elseif operator == Condition.Operator.LessThanOrEqualTo then
        return arg1 <= arg2
    else
        return false
    end
end

function Condition:set_target_index(target_index)
    self.target_index = target_index
end

function Condition:get_target_index()
    return self.target_index
end

function Condition:tostring()
    return "condition"
end

function Condition:serialize()
    return "Condition.new(" .. serializer_util.serialize_args() .. ")"
end

return Condition



