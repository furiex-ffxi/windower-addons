function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options("Normal")
	state.CastingMode:options("Normal", "Resistant", "Fodder", "Proc")
	state.IdleMode:options("Normal", "DT")
	state.PhysicalDefenseMode:options("PDT", "NukeLock", "GeoLock", "PetPDT")
	state.MagicalDefenseMode:options("MDT", "NukeLock")
	state.ResistDefenseMode:options("MEVA")
	state.Weapons:options("None", "Idris", "Maxentius", "DualWeapons")

	gear.nuke_jse_back = {
		name = "Nantosuelta's Cape",
		augments = {"INT+20", "Mag. Acc+20 /Mag. Dmg.+20", "INT+10", '"Mag.Atk.Bns."+10', "Phys. dmg. taken-10%"}
	}
	gear.idle_jse_back = {
		name = "Nantosuelta's Cape",
		augments = {"HP+60", "Eva.+20 /Mag. Eva.+20", "Mag. Evasion+10", 'Pet: "Regen"+10', 'Pet: "Regen"+5'}
	}
	gear.tp_jse_back = {
		name = "Nantosuelta's Cape",
		augments = {"DEX+20", "Accuracy+20 Attack+20", "Accuracy+10", '"Dbl.Atk."+10', "Phys. dmg. taken-10%"}
	}

	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = gear.nuke_jse_back
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = gear.nuke_jse_back
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	autoindi = "Haste"
	autogeo = "Frailty"

	-- Additional local binds
	send_command("bind ^` gs c cycle ElementalMode")
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command("bind @f8 gs c toggle AutoNukeMode")
	send_command("bind @` gs c cycle MagicBurstMode")
	send_command("bind @f10 gs c cycle RecoverMode")
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind ^delete input /ma "Aspir III" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')

	indi_duration = 290

	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------
	af = {}
	af.Head = "Geo. Galero +4"
	af.Body = "Geo. Tunic +4"
	af.Hands = "Geo. Mitaines +4"
	af.Legs = "Geo. Pants +4"
	af.Feet = "Geo. Sandals +4"

	relic = {}
	relic.Head = "Bagua Galero +4"
	relic.Body = "Bagua Tunic +4"
	relic.Hands = "Bagua Mitaines +4"
	relic.Legs = "Bagua Pants +4"
	relic.Feet = "Bagua Sandals +4"

	empy = {}
	empy.Head = "Azimuth Hood +2"
	empy.Body = "Azimuth Coat +2"
	empy.Hands = "Azimuth Gloves +2"
	empy.Legs = "Azimuth Tights +2"
	empy.Feet = "Azimuth Gaiters +2"

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body = relic.Body}
	sets.precast.JA["Life Cycle"] = {body = af.Body, back = gear.idle_jse_back}
	sets.precast.JA["Radial Arcana"] = {feet = relic.Feet}
	sets.precast.JA["Mending Halation"] = {legs = relic.Legs}
	sets.precast.JA["Full Circle"] = {head = empy.Head, hands = relic.Hands}

	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {
		-- main = gear.gada_indi_club, 
		neck = "Incanter's Torque",
		back = gear.idle_jse_back,
		legs = relic.Legs,
		feet = empy.Feet
	}

	-- Relic hat for Blaze of Glory HP increase.
	sets.buff["Blaze of Glory"] = {
		head = relic.Head
	}

	-- Fast cast sets for spells

	sets.precast.FC = {
		range = "Dunna", -- 3
		-- head = "Amalric Coif +1", -- 11
		neck = "Baetyl Pendant", --4
		-- ear1 = "Loquac. Earring", -- 2
		ear2 = "Malignance Earring", -- 4
		body = "Zendik Robe", -- 13
		hands = "Agwu's Gages", -- 6
		ring1 = "Kishar Ring", -- 4
		-- ring2 = "Prolix Ring", -- 2
		back = "Fi Follet Cape", -- 10
		-- waist = "Witful Belt", -- 3 / 3 QM
		legs = af.Legs, -- 15
		feet = "Volte Gaiters" -- 6
	} -- 80 FC

	sets.precast.FC["Elemental Magic"] =
		set_combine(
		sets.precast.FC,
		{
			hands = relic.Hands, -- 14
			ring2 = "Defending Ring",
			feet = "Nyame Sollerets"
		}
	) -- 80

	sets.Self_Healing = {
		neck = "Phalaina Locket",
		ring1 = "Kunaji Ring",
		ring2 = "Asklepian Ring",
		waist = "Gishdubar Sash"
	}
	sets.Cure_Received = {
		neck = "Phalaina Locket",
		ring1 = "Kunaji Ring",
		ring2 = "Asklepian Ring",
		waist = "Gishdubar Sash"
	}
	sets.Self_Refresh = {back = "Grapevine Cape", waist = "Gishdubar Sash", feet = "Inspirited Boots"}

	sets.precast.FC["Enhancing Magic"] = set_combine(sets.precast.FC, {waist = "Siegel Sash"})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC["Enhancing Magic"], {})

	sets.precast.FC.Impact = {
		range = "Dunna",
		head = empty,
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Malignance Earring",
		body = "Crepuscular Cloak",
		hands = "Volte Gloves",
		ring1 = "Kishar Ring",
		ring2 = "Lebeche Ring",
		back = "Lifestream Cape",
		waist = "Witful Belt",
		legs = af.Legs,
		feet = "Regal Pumps +1"
	}

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main = "Daybreak", sub = "Ammurapi Shield"})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head = sets.Nyame.Head,
		neck = "Rep. Plat. Medal",
		body = sets.Nyame.Body,
		hands = sets.Nyame.Hands,
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet,
		waist = "Prosilio Belt +1",
		left_ear = {name = "Moonshade Earring", augments = {"Accuracy+4", "TP Bonus +250"}},
		right_ear = "Ishvara Earring",
		left_ring = "Epaminondas's Ring",
		right_ring = "Karieyh Ring",
		back = gear.nuke_jse_back
	}

	sets.precast.WS["Black Halo"] =
		set_combine(
		sets.precast.WS,
		{
			right_ring = "Metamor. Ring +1",
			back = "Aurist's Cape +1"
		}
	)

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	sets.midcast.Geomancy = {
		main = "Idris",
		sub = "Genmei Shield",
		range = "Dunna",
		head = empy.Head,
		neck = "Bagua Charm +2",
		-- ear1 = "Calamitous Earring",
		ear2 = "Azimuth Earring",
		body = "Zendik Robe",
		-- body = "Vedic Coat",
		hands = empy.Hands,
		ring1 = "Murky Ring",
		ring2 = "Mephitas's Ring +1",
		back = gear.idle_jse_back,
		-- waist = "Austerity Belt +1",
		legs = "Lengo Pants",
		feet = empy.Feet
	}

	-- --Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi =
		set_combine(
		sets.midcast.Geomancy,
		{
			back = "Lifestream Cape",
			legs = relic.Legs
		}
	)

	sets.midcast.Cure = {
		main = "Daybreak",
		sub = "Sors Shield",
		-- ammo = "Hasty Pinion +1",
		head = "Vanya Hood",
		neck = "Incanter's Torque",
		ear1 = "Gifted Earring",
		ear2 = "Mendi. Earring",
		body = "Zendik Robe",
		hands = "Telchine Gloves",
		ring1 = "Janniston Ring",
		-- ring2 = "Menelaus's Ring",
		back = "Tempered Cape +1",
		waist = "Witful Belt",
		legs = af.Legs,
		feet = "Vanya Clogs"
	}

	sets.midcast.LightWeatherCure = {
		-- main = "Chatoyant Staff",
		-- sub = "Curatio Grip",
		-- ammo = "Hasty Pinion +1",
		head = "Amalric Coif +1",
		neck = "Phalaina Locket",
		ear1 = "Gifted Earring",
		ear2 = "Etiolation Earring",
		body = "Vrikodara Jupon",
		hands = "Telchine Gloves",
		ring1 = "Janniston Ring",
		ring2 = "Menelaus's Ring",
		back = "Twilight Cape",
		waist = "Hachirin-no-Obi",
		legs = af.Legs,
		feet = "Vanya Clogs"
	}

	--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = {
		main = "Daybreak",
		sub = "Sors Shield",
		-- ammo = "Hasty Pinion +1",
		head = "Amalric Coif +1",
		neck = "Incanter's Torque",
		ear1 = "Gifted Earring",
		ear2 = "Etiolation Earring",
		body = "Zendik Robe",
		hands = "Telchine Gloves",
		ring1 = "Janniston Ring",
		ring2 = "Lebeche Ring",
		back = "Twilight Cape",
		waist = "Hachirin-no-Obi",
		legs = af.Legs,
		feet = "Vanya Clogs"
	}

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {main = "Daybreak", sub = "Sors Shield"})

	sets.midcast.Cursna =
		set_combine(
		sets.midcast.Cure,
		{
			neck = "Debilis Medallion",
			hands = "Hieros Mittens",
			back = "Oretan. Cape +1",
			ring1 = "Haoma's Ring",
			ring2 = "Menelaus's Ring",
			waist = "Witful Belt",
			feet = "Vanya Clogs"
		}
	)

	sets.midcast.StatusRemoval =
		set_combine(
		sets.midcast.FastRecast,
		{
			main = gear.grioavolr_fc_staff,
			sub = "Clemency Grip"
		}
	)

	sets.midcast["Elemental Magic"] = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = "Ea Hat +1",
		body = empy.Body,
		hands = "Agwu's Gages",
		legs = "Agwu's Slops",
		feet = "Agwu's Pigaches",
		neck = "Sibyl Scarf",
		waist = "Sacro Cord",
		left_ear = "Malignance Earring",
		right_ear = "Azimuth Earring +2",
		left_ring = "Freke Ring",
		right_ring = "Metamor. Ring +1",
		back = gear.nuke_jse_back
	}

	-- sets.midcast['Elemental Magic'].Resistant = sets.midcast['Elemental Magic']
	-- sets.midcast['Elemental Magic'].Proc = sets.midcast['Elemental Magic']
	-- sets.midcast['Elemental Magic'].Fodder = sets.midcast['Elemental Magic']
	-- sets.midcast['Elemental Magic'].HighTierNuke = sets.midcast['Elemental Magic']
	-- sets.midcast['Elemental Magic'].HighTierNuke.Resistant = sets.midcast['Elemental Magic']
	-- sets.midcast['Elemental Magic'].HighTierNuke.Fodder = sets.midcast['Elemental Magic']

	sets.midcast["Dark Magic"] = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		range = "Dunna",
		head = "Agwu's Cap",
		neck = "Bagua Charm +2",
		ear1 = "Malignance Earring",
		ear2 = "Azimuth Earring +2",
		body = "Agwu's Robe",
		hands = "Agwu's Gages",
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Acuity Belt +1",
		legs = relic.Legs,
		feet = "Agwu's Pigaches"
	}

	sets.midcast.Drain = {
		main = "Rubicundity",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = "Pixie Hairpin +1",
		neck = "Erra Pendant",
		ear1 = "Malignance Earring",
		ear2 = "Azimuth Earring +2",
		body = af.Body,
		hands = "Agwu's Gages",
		ring1 = "Archon Ring",
		ring2 = "Evanescence Ring",
		back = "Aurist's Cape +1",
		waist = "Fucho-no-obi",
		legs = empy.Legs,
		feet = "Agwu's Pigaches"
	}

	sets.midcast.Aspir = {
		main = "Rubicundity",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = "Pixie Hairpin +1",
		neck = "Erra Pendant",
		ear1 = "Malignance Earring",
		ear2 = "Azimuth Earring +2",
		body = af.Body,
		hands = "Agwu's Gages",
		ring1 = "Archon Ring",
		ring2 = "Evanescence Ring",
		back = "Aurist's Cape +1",
		waist = "Fucho-no-obi",
		legs = empy.Legs,
		feet = "Agwu's Pigaches"
	}

	sets.midcast.Stun = set_combine(sets.midcast["Dark Magic"], {})
	sets.midcast.Stun.Resistant = set_combine(sets.midcast["Dark Magic"], {})

	sets.midcast.Impact = {
		main = "Idris",
		sub = "Ammurapi Shield",
		range = "Dunna",
		head = empty,
		body = "Crepuscular Cloak",
		neck = "Bagua Charm +2",
		ear1 = "Malignance Earring",
		ear2 = "Azimuth Earring +2",
		hands = empy.Hands,
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Acuity Belt +1",
		legs = empy.Legs,
		feet = empy.Feet
	}

	sets.midcast.Dispel = {
		main = "Idris",
		sub = "Ammurapi Shield",
		range = "Dunna",
		head = empy.Head,
		body = empy.Body,
		neck = "Bagua Charm +2",
		ear1 = "Malignance Earring",
		ear2 = "Azimuth Earring +2",
		hands = empy.Hands,
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Acuity Belt +1",
		legs = empy.Legs,
		feet = empy.Feet
	}

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main = "Daybreak", sub = "Ammurapi Shield"})

	sets.midcast["Enfeebling Magic"] = {
		head = empy.Head,
		body = empy.Body,
		neck = "Bagua Charm +2",
		ear1 = "Malignance Earring",
		ear2 = "Azimuth Earring +2",
		hands = "Regal Cuffs",
		ring1 = "Metamor. Ring +1",
		ring2 = "Kishar Ring",
		back = "Aurist's Cape +1",
		waist = "Acuity Belt +1",
		legs = empy.Legs,
		feet = empy.Feet
	}
	sets.midcast["Enfeebling Magic"].Resistant = set_combine(sets.midcast["Enfeebling Magic"], {})

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast["Enfeebling Magic"], {legs = "Agwu's Slops"})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast.ElementalEnfeeble, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast["Enfeebling Magic"], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast.IntEnfeebles, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast["Enfeebling Magic"], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast.MndEnfeebles, {})

	sets.midcast.Dia = set_combine(sets.midcast["Enfeebling Magic"], sets.TreasureHunter)
	sets.midcast["Dia II"] = set_combine(sets.midcast["Enfeebling Magic"], sets.TreasureHunter)

	sets.midcast.Bio = set_combine(sets.midcast["Enfeebling Magic"], sets.TreasureHunter)
	sets.midcast["Bio II"] = set_combine(sets.midcast["Enfeebling Magic"], sets.TreasureHunter)

	sets.midcast["Divine Magic"] = set_combine(sets.midcast["Enfeebling Magic"], {})

	sets.midcast["Enhancing Magic"] = {
		main = gear.gada_enhancing_club,
		sub = "Ammurapi Shield",
		range = "Dunna",
		head = "Telchine Cap",
		neck = "Incanter's Torque",
		ear1 = "Andoaa Earring",
		ear2 = "Gifted Earring",
		body = "Telchine Chas.",
		hands = "Telchine Gloves",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Fi Follet Cape +1",
		waist = "Embla Sash",
		legs = "Telchine Braconi",
		feet = "Telchine Pigaches"
	}

	sets.midcast.Stoneskin =
		set_combine(
		sets.midcast["Enhancing Magic"],
		{neck = "Nodens Gorget", ear2 = "Earthcry Earring", waist = "Siegel Sash", legs = "Shedir Seraweels"}
	)

	sets.midcast.Refresh = set_combine(sets.midcast["Enhancing Magic"], {head = "Amalric Coif +1"})

	sets.midcast.Aquaveil =
		set_combine(
		sets.midcast["Enhancing Magic"],
		{
			main = "Vadose Rod",
			sub = "Ammurapi Shield",
			head = "Amalric Coif +1",
			hands = "Regal Cuffs",
			waist = "Emphatikos Rope",
			legs = "Shedir Seraweels"
		}
	)

	sets.midcast.BarElement = set_combine(sets.precast.FC["Enhancing Magic"], {legs = "Shedir Seraweels"})

	sets.midcast.Protect = set_combine(sets.midcast["Enhancing Magic"], {ring2 = "Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast["Enhancing Magic"], {ring2 = "Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast["Enhancing Magic"], {ring2 = "Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast["Enhancing Magic"], {ring2 = "Sheltered Ring"})

	-- --------------------------------------
	-- -- Idle/resting/defense/etc sets
	-- --------------------------------------

	-- -- Resting sets
	sets.resting = {}

	-- -- Idle sets

	sets.idle = {
		range = "Dunna",
		neck = "Bagua Charm +2",
		ear1 = "Odnowa Earring +1",
		ear2 = "Azimuth Earring +2",
		head = "Volte Beret",
		body = empy.Body,
		hands = relic.Hands,
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet,
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.idle_jse_back,
		waist = "Plat. Mog. Belt"
	}

	sets.idle.DT =
		set_combine(
		sets.idle,
		{
			left_ring = "Murky Ring",
			back = gear.nuke_jse_back
		}
	)

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet =
		set_combine(
		sets.idle,
		{
			head = empy.Head,
			hands = af.Hands,
			ring1 = "Stikini Ring +1",
			ring2 = "Stikini Ring +1",
			back = gear.idle_jse_back,
			-- waist = "Isa Belt",
			feet = relic.Feet
		}
	)

	sets.idle.DT.Pet =
		set_combine(
		sets.idle.Pet,
		{
			main = "Idris",
			sub = "Genmei Shield",
			body = "Nyame Mail",
			legs = "Nyame Flanchard",
			feet = "Nyame Sollerets"
		}
	)

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
	sets.idle.DT.Indi = set_combine(sets.idle.DT, {})
	sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {})

	sets.idle.Weak =
		set_combine(
		sets.idle.DT,
		{
			back = "Moonlight Cape"
		}
	)

	-- Defense sets

	sets.defense.PDT = set_combine(sets.idle.DT, {})

	sets.defense.MDT = set_combine(sets.idle.DT, {})

	sets.defense.MEVA = set_combine(sets.idle.DT, {})

	sets.defense.PetPDT = sets.idle.DT.Pet

	sets.defense.NukeLock = sets.midcast["Elemental Magic"]

	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = {feet = af.Feet}
	sets.latent_refresh = {waist = "Fucho-no-obi"}
	sets.latent_refresh_grip = {sub = "Oneiros Grip"}
	sets.TPEat = {neck = "Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet = gear.merlinic_treasure_feet})

	sets.HPDown = {
		head = "Pixie Hairpin +1",
		ear1 = "Mendicant's Earring",
		ear2 = "Evans Earring",
		body = "Jhakri Robe +2",
		hands = "Jhakri Cuffs +2",
		ring1 = "Mephitas's Ring +1",
		ring2 = "Mephitas's Ring",
		back = "Swith Cape +1",
		legs = "Shedir Seraweels",
		feet = "Jhakri Pigaches +2"
	}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {
		main = "Maxentius",
		sub = "Ammurapi Shield",
		range = "Dunna",
		head = "Blistering Sallet +1",
		neck = "Combatant's Torque",
		ear1 = "Cessance Earring",
		ear2 = "Telos Earring",
		body = sets.Nyame.Body,
		hands = "Gazu Bracelets +1",
		ring1 = "Petrov Ring",
		ring2 = "Lehko's Ring",
		back = gear.tp_jse_back,
		waist = "Goading Belt",
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet
	}

	sets.engaged.DW = {}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	-- Gear that converts elemental damage done to recover MP.
	sets.RecoverMP = {body = "Seidr Cotehardie"}

	-- Gear for Magic Burst mode.
	sets.MagicBurst = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = "Ea Hat +1",
		body = empy.Body,
		hands = "Agwu's Gages",
		legs = "Agwu's Slops",
		feet = "Agwu's Pigaches",
		neck = "Sibyl Scarf",
		waist = "Acuity Belt +1",
		left_ear = "Malignance Earring",
		right_ear = "Azimuth Earring +2",
		left_ring = "Freke Ring",
		right_ring = "Metamor. Ring +1",
		back = gear.nuke_jse_back
	}
	sets.ResistantMagicBurst = sets.MagicBurst

	sets.buff.Sublimation = {waist = "Embla Sash"}
	sets.buff.DTSublimation = {waist = "Embla Sash"}

	-- Weapons sets
	sets.weapons.Idris = {main = "Idris", sub = "Ammurapi Shield"}
	sets.weapons.Maxentius = {main = "Maxentius", sub = "Ammurapi Shield"}
	sets.weapons.DualWeapons = {main = "Idris", sub = "C. Palug Hammer"}
end

function user_job_lockstyle()
	windower.chat.input("/lockstyleset 005")
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(4, 10)
end
