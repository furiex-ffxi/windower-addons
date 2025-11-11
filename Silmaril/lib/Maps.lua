do

	--This is used to overwrite default windower resource file information

	--This remaps the Geomancy Buffs so they can be identied seperatly (Auras)
	local geo_map = 
	{
	    [539] ="Geomancy Regen",
	    [540] ="Geomancy Poison",
	    [541] ="Geomancy Refresh",
	    [580] ="Geomancy Haste",
	    [542] ="Geomancy STR Boost",
	    [543] ="Geomancy DEX Boost",
	    [544] ="Geomancy VIT Boost",
	    [545] ="Geomancy AGI Boost",
	    [546] ="Geomancy INT Boost",
	    [547] ="Geomancy MND Boost",
	    [548] ="Geomancy CHR Boost",
	    [549] ="Geomancy Attack Boost",
	    [550] ="Geomancy Defense Boost",
	    [551] ="Geomancy Magic Atk. Boost",
	    [552] ="Geomancy Magic Def. Boost",
	    [553] ="Geomancy Accuracy Boost",
	    [554] ="Geomancy Evasion Boost",
	    [555] ="Geomancy Magic Acc. Boost",
	    [556] ="Geomancy Magic Evasion Boost",
	    [557] ="Geomancy Attack Down",
	    [558] ="Geomancy Defense Down",
	    [559] ="Geomancy Magic Atk. Down",
	    [560] ="Geomancy Magic Def. Down",
	    [561] ="Geomancy Accuracy Down",
	    [562] ="Geomancy Evasion Down",
	    [563] ="Geomancy Magic Acc. Down",
	    [564] ="Geomancy Magic Evasion Down",
	    [565] ="Geomancy Slow",
	    [566] ="Geomancy Paralysis",
	    [567] ="Geomancy Weight",
	}


	--This remaps the Monster Abilities to add a buff to it if needed
	--The monster ability number is found in monster_abilities.lua
	--The buff number is found in buffs.lua
	local monster_map = 
	{
	    [2675] = 173,	-- Dark Thorn "Dread Spikes"
		[3342] = 173,	-- Dark Thorn "Dread Spikes"
		[4188] = 173,	-- Dark Thorn "Dread Spikes"
		[694] = 50,		-- "Invincible"
		[1014] = 50,	-- "Invincible"
		[2248] = 50,	-- "Invincible"
		[2379] = 50,	-- "Invincible"
		[2940] = 50,	-- "Invincible"
		[693] = 49,		-- "Perfect Dodge"
		[1013] = 49,	-- "Perfect Dodge"
		[2247] = 49,	-- "Perfect Dodge"
		[341] = 92,		-- Rhino Guard "Evasion Boost"
		[3878] = 92,	-- Rhino Guard "Evasion Boost"
		[1782] = 33,	-- Animating Wail "Haste"
		[1783] = 40,	-- Fortifying Wail "Protect"
		[2097] = 37,	-- Granite Skin "Stoneskin"
		[2103] = 37,	-- Granite Skin "Stoneskin"
		[2667] = 604,	-- Mighty Guard "Mighty Guard"
		[3220] = 33,	-- Infernal Bulwark "Haste", "Stoneskin", "Attack Boost", "Defense Boost", "Magic Attack", "Magic Defense"
		[3449] = 33,	-- Infernal Bulwark "Haste", "Stoneskin", "Attack Boost", "Defense Boost", "Magic Attack", "Magic Defense"
		[445] = 93,		-- Scissor Guard with Defense Boost
		[1592] = 93,	-- Scissor Guard with Defense Boost
		[3483] = 93,	-- Scissor Guard with Defense Boost
		[3864] = 93,	-- Scissor Guard with Defense Boost
		[448] = 37,		-- Metallic Body Stoneskin
		[1593] = 37,	-- Metallic Body Stoneskin
		[3475] = 37,	-- Metallic Body Stoneskin
		[3865] = 37,	-- Metallic Body Stoneskin
	}

	--This remaps the Abilities to add a buff to it if needed
	--The ability number is found in job_abilities.lua
	--The buff number is found in buffs.lua
	local ability_map = 
	{
		[215] = 360,	-- Penury "Penury"
		[216] = 362,	-- Celerity "Celerity"
		[217] = 364,	-- Rapture "Rapture"
	    [218] = 366,	-- Accession "Accession"
		[219] = 361,	-- Parsimony "Parsimony"
		[220] = 363,	-- Alacrity "Alacrity"
		[221] = 365,	-- Ebullience "Ebullience"
		[222] = 367,	-- Manifestation "Manifestation"
		[316] = 469,	-- Perpetuance "Perpetuance"
		[317] = 470,	-- Immanence "Immanence"
	}

	function get_geo_maps()
		return geo_map
	end

	function get_monster_maps()
		return monster_map
	end

	function get_ability_maps()
		return ability_map
	end

end