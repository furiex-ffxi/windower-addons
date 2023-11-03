---------------------------
-- Action representing a job ability
-- @class module
-- @name JobAbility

local Action = require('cylibs/actions/action')
local JobAbility = setmetatable({}, {__index = Action })
JobAbility.__index = JobAbility
JobAbility.__eq = JobAbility.is_equal
JobAbility.__class = "JobAbility"

function JobAbility.new(x, y, z, job_ability_name, target_index)
    local conditions = L{
        NotCondition.new(L{InMogHouseCondition.new()}, true),
        JobAbilityRecastReadyCondition.new(job_ability_name)
    }

    local self = setmetatable(Action.new(x, y, z, target_index, conditions), JobAbility)

    self.job_ability_name = job_ability_name

    self:debug_log_create(self:gettype())

    return self
end

function JobAbility:destroy()
    Action.destroy(self)

    self:debug_log_destroy(self:gettype())
end

function JobAbility:perform()
    if self.target_index == nil then
        windower.chat.input('/%s':format(self.job_ability_name))
    else
        local target = windower.ffxi.get_mob_by_index(self.target_index)
        if target then
            windower.chat.input('/'..self.job_ability_name..' '..target.id)
        end
    end

    coroutine.sleep(1)

    self:complete(true)
end

function JobAbility:get_job_ability_name()
    return self.job_ability_name
end

function JobAbility:gettype()
    return "jobabilityaction"
end

function JobAbility:getidentifier()
    return self.job_ability_name
end

function JobAbility:getrawdata()
    local res = {}

    res.jobability = {}
    res.jobability.x = self.x
    res.jobability.y = self.y
    res.jobability.z = self.z
    res.jobability.job_ability_name = self:get_job_ability_name()

    return res
end

function JobAbility:copy()
    return JobAbility.new(self:get_position()[1], self:get_position()[2], self:get_position()[3], self:get_job_ability_name())
end

function JobAbility:is_equal(action)
    if action == nil then return false end

    return self:gettype() == action:gettype() and self:get_job_ability_name() == action:get_job_ability_name()
end

function JobAbility:tostring()
    local target = windower.ffxi.get_mob_by_index(self.target_index or windower.ffxi.get_player().index)
    return self:get_job_ability_name()..' → '..target.name
end

function JobAbility:debug_string()
    return "JobAbility: %s":format(self:get_job_ability_name())
end

return JobAbility