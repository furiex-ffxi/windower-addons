require('tables')
require('lists')
require('logger')

local Event = require('cylibs/events/Luvent')

local Trust = {}
Trust.__index = Trust

-- Event called when trust settings are changed.
function Trust:on_trust_settings_changed()
	return self.trust_settings_changed
end

function Trust.new(action_queue, roles, trust_settings, job)
	local self = setmetatable({
		action_queue = action_queue;
		roles = roles;
		trust_settings = trust_settings;
		job = job;
		user_events = {};
		status = 0;
		battle_target = nil;
		role_blacklist = S{};
		trust_settings_changed = Event.newEvent();
		trust_modes_override = Event.newEvent();
		trust_modes_reset = Event.newEvent();
	}, Trust)

	return self
end

function Trust:init()
	for role in self.roles:it() do
		role:set_player(self.player)
		role:set_party(self.party)
		if role.on_add then
			role:on_add()
		end
	end
	self:on_init()

	self.on_party_target_change_id = self.party:on_party_target_change():addAction(
			function(_, new_target_index, old_target_index)
				if new_target_index == old_target_index then
					return
				end
				-- TODO: prune invalid actions instead of clear
				--self.action_queue:clear()
				self:job_target_change(new_target_index)
			end)
end

function Trust:destroy()
	for role in self.roles:it() do
		if role.destroy then
			role:destroy()
			role:set_player(nil)
			role:set_party(nil)
		end
	end

	self.trust_settings_changed:removeAllActions()
	self.trust_modes_override:removeAllActions()
	self.trust_modes_reset:removeAllActions()

	self:on_deinit()

	self.player:destroy()
	self.player = nil
end

function Trust:on_init()
end

function Trust:on_deinit()
end

function Trust:add_role(role)
	if self.role_blacklist:contains(role:get_type()) then
		return
	end
	self.roles:add(role)

	if role.on_add then
		role:set_player(self.player)
		role:set_party(self.party)
		role:on_add()
	end
end

function Trust:remove_role(role)
	if role.destroy then
		role:destroy()
		role:set_player(nil)
		role:set_party(nil)
	end
	self.roles = self.roles:filter(function(r) return r:get_type() ~= role:get_type() end)
end

function Trust:replace_role(role_type, new_role)
	local old_role = self:role_with_type(role_type)
	if old_role then
		self:remove_role(old_role)
	end
	self:add_role(new_role)
end

function Trust:blacklist_role(role_type)
	self.role_blacklist:add(role_type)
end

function Trust:is_blacklisted(role_type)
	return self.role_blacklist:contains(role_type)
end

function Trust:role_with_type(role_type)
	for role in self.roles:it() do
		if role:get_type() == role_type then
			return role
		end
	end
	return nil
end

function Trust:job_magic_burst(target_id, spell)
	for role in self.roles:it() do
		if role.job_magic_burst then
			role:job_magic_burst(target_id, spell)
		end
	end
end

function Trust:job_weapon_skill(weapon_skill_name)
	for role in self.roles:it() do
		if role.job_weapon_skill then
			role:job_weapon_skill(weapon_skill_name)
		end
	end
end

function Trust:job_target_change(target_index)
	for role in self.roles:it() do
		if role.target_change then
			role:target_change(target_index)
		end
	end
end

function Trust:tic(old_time, new_time)
	local tic_time = os.time()
	for role in self.roles:it() do
		role:set_last_tic_time(tic_time)
		if role.tic then
			role:tic(old_time, new_time)
		end
	end
end

function Trust:job_status_change(new_status)
	self.status = new_status
end

function Trust:set_player(player)
	self.player = player
end

function Trust:get_player()
	return self.player
end

-------
-- Returns the job for this Trust
-- @treturn Job Job for this Trust
function Trust:get_job()
	return self.job
end

function Trust:set_party(party)
	self.party = party
end

function Trust:get_party()
	return self.party
end

function Trust:get_roles()
	return self.roles
end

function Trust:set_trust_settings(trust_settings)
	local old_trust_settings = self.trust_settings
	self.trust_settings = trust_settings

	self:on_trust_settings_changed():trigger(old_trust_settings, trust_settings)
end

function Trust:get_trust_settings()
	return self.trust_settings
end

return Trust



