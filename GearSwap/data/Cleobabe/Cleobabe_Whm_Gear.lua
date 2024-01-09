-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant', 'SIRD', 'DT')
	state.IdleMode:options('Normal', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'DualWeapons', 'MeleeWeapons')
	state.WeaponskillMode:options('Normal', 'Fodder')

	gear.obi_cure_waist = "Austerity Belt +1"
	gear.obi_cure_back = "Alaunus's Cape"

	gear.obi_nuke_waist = "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Yamabuki-no-Obi"
	gear.obi_nuke_back = "Toro Cape"

	gear.af = {}
	gear.af.head = "Theophany Cap +2"
	gear.af.body = "Theo. Bliaut +2"
	gear.af.hands = "Theophany Mitts +2"
	gear.af.legs = "Theo. Pant. +2"
	gear.af.feet = "Theo. Duckbills +2"

	gear.relic = {}
	gear.relic.head = "Piety Cap +3"
	gear.relic.body = "Piety Bliaut +3"
	gear.relic.hands = "Piety Mitts +3"
	gear.relic.legs = "Piety Pantaln. +3"
	gear.relic.feet = "Piety Duckbills +3"

	gear.empy = {}
	gear.empy.head = "Ebers Cap +2"
	gear.empy.body = "Ebers Bliaut +2"
	gear.empy.hands = "Ebers Mitts +2"
	gear.empy.legs = "Ebers Pant. +2"
	gear.empy.feet = "Ebers Duckbills +2"

	-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.MeleeWeapons = { main = "Daybreak", sub = "Ammurapi Shield" }
	sets.weapons.DualWeapons = { main = "Daybreak", sub = "Nehushtan" }

	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }

	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
		main = "Mpaca's Staff", -- 5
		sub = "Clerisy Strap +1", -- 3 
		ammo = "Impatiens", -- 2 QM
		head = gear.empy.head, -- 10
		neck = "Clr. Torque +2", -- 8
		ear1 = "Enchntr. Earring +1", -- 2
		ear2 = "Malignance Earring", -- 4
		body = "Inyanga Jubbah +2", -- 14
		hands = "Volte Gloves", -- 6
		ring1 = "Kishar Ring", -- 4
		ring2 = "Lebeche Ring", -- 2 QM
		back = "Alaunus's Cape", -- 10
		waist = "Witful Belt", -- 3/3 QM
		legs = "Ayanmo Cosciales +2", -- 6
		feet = "Regal Pumps +1"  -- 4
	} -- 79 FC / 7 QM

	sets.precast.FC.DT = set_combine(sets.precast.FC, {
		head = "Bunzi's Hat",
	})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
	})

	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		head = gear.relic.head,
		feet = "Hygieia Clogs +1"
	})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact = set_combine(sets.precast.FC, { head = empty, body = "Twilight Cloak" })

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Genmei Shield" })

	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = { body = gear.relic.body }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head = "Bunzi's Hat",
		ear1 = "Roundel Earring",
		body = gear.relic.body,
		hands = "Telchine Gloves",
		waist = "Chaac Belt",
		back = "Aurist's Cape +1"
	}

	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo = "Hasty Pinion +1",
		head = "Aya. Zucchetto +2",
		neck = "Combatant's Torque",
		ear1 = "Mache Earring +1",
		ear2 = "Telos Earring",
		body = "Ayanmo Corazza +2",
		hands = "Aya. Manopolas +2",
		ring1 = "Petrov Ring",
		Ring2 = "Ilabrat Ring",
		back = "Moonlight Cape",
		waist = "Olseni Belt",
		legs = "Aya. Cosciales +2",
		feet = "Aya. Gambieras +2"
	}

	sets.precast.WS.Fodder = {
		ammo = "Hasty Pinion +1",
		head = "Aya. Zucchetto +2",
		neck = "Asperity Necklace",
		ear1 = "Cessance Earring",
		ear2 = "Brutal Earring",
		body = "Ayanmo Corazza +2",
		hands = "Aya. Manopolas +2",
		ring1 = "Petrov Ring",
		Ring2 = "Ilabrat Ring",
		back = "Moonlight Cape",
		waist = "Windbuffet Belt +1",
		legs = "Aya. Cosciales +2",
		feet = "Aya. Gambieras +2"
	}

	sets.precast.WS.Dagan = {
		ammo = "Ghastly Tathlum +1",
		head = "Pixie Hairpin +1",
		neck = "Sanctity Necklace",
		ear1 = "Etiolation Earring",
		ear2 = "Moonshade Earring",
		body = "Kaykaus Bliaut",
		hands = "Regal Cuffs",
		ring1 = "Mephitas's Ring +1",
		ring2 = "Mephitas's Ring",
		back = "Aurist's Cape +1",
		waist = "Fotia Belt",
		legs = "Nyame Flanchard",
		feet = gear.af.feet
	}

	sets.MaxTP = { ear1 = "Cessance Earring", ear2 = "Brutal Earring" }
	sets.MaxTP.Dagan = { ear1 = "Etiolation Earring", ear2 = "Evans Earring" }

	--sets.precast.WS['Flash Nova'] = {}

	--sets.precast.WS['Mystic Boon'] = {}

	-- Midcast Sets

	sets.Kiting = { feet = "Herald's Gaiters" }
	sets.latent_refresh = { waist = "Fucho-no-obi" }
	sets.latent_refresh_grip = { sub = "Oneiros Grip" }
	sets.TPEat = { neck = "Chrys. Torque" }
	sets.DayIdle = {}
	sets.NightIdle = { back = "Umbra Cape" }
	sets.TreasureHunter = set_combine(sets.TreasureHunter, { feet = gear.chironic_treasure_feet })

	--Situational sets: Gear that is equipped on certain targets
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
	sets.Self_Refresh = { back = "Grapevine Cape", waist = "Gishdubar Sash", feet = "Inspirited Boots" }

	-- Conserve Mp set for spells that don't need anything else, for set_combine.

	sets.ConserveMP = {
		-- main = gear.grioavolr_fc_staff,
		-- sub = "Umbra Strap",
		ammo = "Hasty Pinion +1",
		head = "Vanya Hood",
		neck = "Incanter's Torque",
		ear1 = "Gifted Earring",
		ear2 = "Gwati Earring",
		body = "Vedic Coat",
		hands = "Fanatic Gloves",
		ring1 = "Kishar Ring",
		ring2 = "Prolix Ring",
		back = "Solemnity Cape",
		waist = "Austerity Belt +1",
		-- legs = "Vanya Slops",
		legs = "Theurigst's Slacks",
		feet = "Medium's Sabots"
	}

	sets.midcast.Teleport = sets.ConserveMP

	-- Gear for Magic Burst mode.
	sets.MagicBurst = {
		main = gear.grioavolr_nuke_staff,
		sub = "Enki Strap",
		neck = "Mizu. Kubikazari",
		ring1 = "Mujin Band",
		ring2 = "Locus Ring"
	}

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {
		-- main = gear.grioavolr_fc_staff,
		main = "Mpaca's Staff",
		sub = "Clerisy Strap +1",
		-- ammo = "Hasty Pinion +1",
		ammo = "Impatiens",
		head = "Bunzi's Hat", -- 6 Haste, 10 FC
		ear1 = "Enchntr. Earring +1", -- 2 FC
		body = "Inyanga Jubbah +2", -- 2 Haste, 14 FC
		hands = "Fanatic Gloves", -- 3 Haste, 2 FC
		feet = "Regal Pumps +1",  -- 3 Haste, 7 FC
		waist = "Channeler's Stone", -- 2 FC
		ring2 = "Prolix Ring",  -- 2 FC
	})

	-- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast

	sets.midcast.Cure = {
		main = "Raetic Rod +1",
		sub = "Sors Shield",
		ammo = "Pemphredo Tathlum",
		head = gear.af.head,
		neck = "Cleric's Torque +2",
		-- ear1 = "Regal Earring",
		-- ear2 = "Glorious Earring",
		ear1 = "Mendicant's Earring",
		ear2 = "Ebers Earring +1",
		body = gear.af.body,
		hands = gear.af.hands,
		legs = gear.empy.legs,
		ring1 = "Lebeche Ring",
		ring2 = "Mephitas's Ring",
		back = "Alaunus's Cape",
		waist = "Luminary Sash",
		feet = "Kaykaus Boots"
	}

	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {
		ammo = "Pemphredo Tathlum",
		head = gear.af.head,
		neck = "Incanter's Torque",
		body = gear.empy.body,
		waist = "Luminary Sash",
		feet = "Kaykaus Boots"
	})

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {
		main = "Chatoyant Staff",
		sub = "Curatio Grip",
		ammo = "Esper Stone +1",
		head = gear.af.head,
		neck = "Incanter's Torque",
		ear1 = "Nourish. Earring +1",
		body = "Kaykaus Bliaut",
		back = "Twilight Cape",
		waist = "Hachirin-no-Obi",
		feet = "Kaykaus Boots"
	})

	sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.Cure, {
		main = "Chatoyant Staff",
		sub = "Curatio Grip",
		ammo = "Esper Stone +1",
		head = gear.af.head,
		neck = "Incanter's Torque",
		body = gear.empy.body,
		waist = "Hachirin-no-Obi",
		feet = "Kaykaus Boots"
	})

	sets.midcast.LightDayCureSolace = set_combine(sets.midcast.Cure, {
		ammo = "Pemphredo Tathlum",
		head = gear.af.head,
		neck = "Incanter's Torque",
		body = gear.empy.body,
		waist = "Hachirin-no-Obi",
		feet = "Kaykaus Boots"
	})

	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {
		ammo = "Pemphredo Tathlum",
		head = gear.af.head,
		neck = "Incanter's Torque",
		ear1 = "Nourish. Earring +1",
		body = gear.af.body,
		back = "Twilight Cape",
		waist = "Hachirin-no-Obi",
		feet = "Kaykaus Boots"
	})

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
		ammo = "Pemphredo Tathlum",
		head = gear.af.head,
		neck = "Incanter's Torque",
		body = gear.af.body,
		waist = "Luminary Sash",
		feet = "Kaykaus Boots"
	})

	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Cure, {
		main = "Chatoyant Staff",
		sub = "Curatio Grip",
		ammo = "Esper Stone +1",
		head = gear.af.head,
		neck = "Incanter's Torque",
		ear1 = "Nourish. Earring +1",
		body = "Kaykaus Bliaut",
		back = "Twilight Cape",
		waist = "Hachirin-no-Obi",
		feet = "Kaykaus Boots"
	})

	sets.midcast.LightDayCuraga = set_combine(sets.midcast.Cure, {
		sub = "Sors Shield",
		ammo = "Pemphredo Tathlum",
		head = gear.af.head,
		neck = "Incanter's Torque",
		ear1 = "Nourish. Earring +1",
		body = gear.af.body,
		back = "Twilight Cape",
		waist = "Hachirin-no-Obi",
		feet = "Kaykaus Boots"
	})

	sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {
		sub = "Genmei Shield",
		ammo = "Staunch Tathlum +1",
		head = gear.af.head,
		neck = "Loricate Torque +1",
		ear1 = "Nourish. Earring +1",
		body = "Nyame Mail",
		ring1 = "Defending Ring",
		waist = "Luminary Sash",
		feet = "Nyame Sollerets"
	})

	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = {
		ammo = "Pemphredo Tathlum",
		head = gear.af.head,
		neck = "Incanter's Torque",
		ear1 = "Regal Earring",
		body = gear.af.body,
		hands = "Kaykaus Cuffs",
		back = "Alaunus's Cape",
		waist = "Luminary Sash",
		feet = "Kaykaus Boots"
	}

	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, { body = gear.empy.body })
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure,
		{ body = gear.empy.body, waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure,
		{ body = gear.empy.body, waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, { waist = "Hachirin-no-Obi" })

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, { body = gear.empy.body })
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT,
		{ body = gear.empy.body, waist = "Hachirin-no-Obi" })
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT,
		{ body = gear.empy.body, waist = "Hachirin-no-Obi" })
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})

	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, { body = gear.empy.body })
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT,
		{ body = gear.empy.body, waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT,
		{ body = gear.empy.body, waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, { waist = "Hachirin-no-Obi" })

	sets.midcast.Cursna = {
		main = "Yagrush",
		sub = "Clemency Grip",
		ammo = "Hasty Pinion +1",
		head = gear.empy.head,
		neck = "Debilis Medallion",
		ear1 = "Meili Earring",
		ear2 = "Malignance Earring",
		body = gear.empy.body,
		hands = "Fanatic Gloves",
		ring1 = "Haoma's Ring",
		ring2 = "Menelaus's Ring",
		back = "Alaunus's Cape",
		waist = "Witful Belt",
		legs = gear.af.legs,
		feet = "Vanya Clogs"
	}

	sets.midcast.StatusRemoval = {
		main = "Yagrush",
		ammo = "Hasty Pinion +1",
		head = gear.empy.head,
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Malignance Earring",
		body = "Inyanga Jubbah +2",
		hands = "Fanatic Gloves",
		ring1 = "Kishar Ring",
		ring2 = "Prolix Ring",
		back = "Swith Cape +1",
		waist = "Witful Belt",
		legs = gear.empy.legs,
		feet = "Regal Pumps +1"
	}

	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, { neck = "Cleric's Torque +2" })

	-- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {
		main = gear.gada_enhancing_club,
		sub = "Ammurapi Shield",
		ammo = "Hasty Pinion +1",
		neck = "Incanter's Torque",
		ear1 = "Andoaa Earring",
		ear2 = "Gifted Earring",
		head = "Telchine Cap",
		body = "Telchine Chas.",
		hands = "Telchine Gloves",
		legs = "Telchine Braconi",
		feet = "Telchine Pigaches",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Perimede Cape",
		waist = "Embla Sash",
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],
		{ neck = "Nodens Gorget", ear2 = "Earthcry Earring", waist = "Siegel Sash", legs = "Shedir Seraweels" })

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], { feet = gear.empy.feet })

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
		{
			main = "Vadose Rod",
			sub = "Ammurapi Shield",
			hands = "Regal Cuffs",
			waist = "Emphatikos Rope",
			legs = "Shedir Seraweels"
		})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],
		{ 
			body = gear.relic.body,
			hands = gear.empy.hands, 
			legs = gear.af.legs, 
		})

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'],
		{
			ring2 = "Sheltered Ring",
			feet = gear.relic.feet,
			ear1 = "Gifted Earring",
			waist = "Sekhmet Corset"
		})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],
		{
			ring2 = "Sheltered Ring",
			feet = gear.relic.feet,
			ear1 = "Gifted Earring",
			waist = "Sekhmet Corset"
		})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'],
		{
			ring2 = "Sheltered Ring",
			legs = gear.relic.legs,
			ear1 = "Gifted Earring",
			waist = "Sekhmet Corset"
		})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],
		{
			ring2 = "Sheltered Ring",
			legs = gear.relic.legs,
			ear1 = "Gifted Earring",
			waist = "Sekhmet Corset"
		})

	sets.midcast.BarElement = {
		main = "Beneficus",
		sub = "Ammurapi Shield",
		ammo = "Staunch Tathlum +1",
		head = gear.empy.head,
		neck = "Incanter's Torque",
		ear1 = "Andoaa Earring",
		ear2 = "Gifted Earring",
		body = gear.empy.body,
		hands = gear.empy.hands,
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Alaunus's Cape",
		waist = "Olympus Sash",
		legs = gear.relic.legs,
		feet = gear.empy.feet
	}

	sets.midcast.Impact = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = empty,
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = "Twilight Cloak",
		hands = gear.chironic_enfeeble_hands,
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Toro Cape",
		waist = "Acuity Belt +1",
		legs = "Chironic Hose",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast['Elemental Magic'] = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = "Bunzi's Hat",
		neck = "Baetyl Pendant",
		ear1 = "Regal Earring",
		ear2 = "Friomisi Earring",
		body = "Witching Robe",
		hands = gear.chironic_enfeeble_hands,
		ring1 = "Shiva Ring +1",
		ring2 = "Freke Ring",
		back = "Toro Cape",
		waist = gear.ElementalObi,
		legs = "Chironic Hose",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast['Elemental Magic'].Resistant = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = "C. Palug Crown",
		neck = "Sanctity Necklace",
		ear1 = "Regal Earring",
		ear2 = "Crematio Earring",
		body = "Witching Robe",
		hands = gear.chironic_enfeeble_hands,
		ring1 = "Metamor. Ring +1",
		ring2 = "Freke Ring",
		back = "Toro Cape",
		waist = "Yamabuki-no-Obi",
		legs = "Chironic Hose",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast['Divine Magic'] = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = "C. Palug Crown",
		neck = "Incanter's Torque",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = "Inyanga Jubbah +2",
		hands = "Fanatic Gloves",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Luminary Sash",
		legs = "Chironic Hose",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast.Holy = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = "C. Palug Crown",
		neck = "Baetyl Pendant",
		ear1 = "Regal Earring",
		ear2 = "Friomisi Earring",
		body = "Witching Robe",
		hands = gear.chironic_enfeeble_hands,
		ring1 = "Metamor. Ring +1",
		ring2 = "Freke Ring",
		back = "Toro Cape",
		waist = gear.ElementalObi,
		legs = "Gyve Trousers",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast['Dark Magic'] = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = "Bunzi's Hat",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = "Inyanga Jubbah +2",
		hands = gear.chironic_enfeeble_hands,
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Acuity Belt +1",
		legs = "Chironic Hose",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast.Drain = {
		main = "Rubicundity",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = "Inyanga Jubbah +2",
		hands = gear.chironic_enfeeble_hands,
		ring1 = "Evanescence Ring",
		ring2 = "Archon Ring",
		back = "Aurist's Cape +1",
		waist = "Fucho-no-obi",
		legs = "Chironic Hose",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast.Drain.Resistant = {
		main = "Rubicundity",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = "Bunzi's Hat",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = "Chironic Doublet",
		hands = gear.chironic_enfeeble_hands,
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Fucho-no-obi",
		legs = "Chironic Hose",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {
		-- main = gear.grioavolr_fc_staff,
		sub = "Clerisy Strap +1",
		ammo = "Hasty Pinion +1",
		head = "Bunzi's Hat",
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Malignance Earring",
		body = "Inyanga Jubbah +2",
		hands = "Fanatic Gloves",
		ring1 = "Kishar Ring",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Witful Belt",
		legs = "Lengo Pants",
		feet = "Regal Pumps +1"
	}

	sets.midcast.Stun.Resistant = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = "Bunzi's Hat",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = "Inyanga Jubbah +2",
		hands = "Fanatic Gloves",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Acuity Belt +1",
		legs = "Chironic Hose",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast.Dispel = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = "Bunzi's Hat",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = "Inyanga Jubbah +2",
		hands = "Fanatic Gloves",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Acuity Belt +1",
		legs = "Chironic Hose",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, { main = "Daybreak", sub = "Ammurapi Shield" })

	sets.midcast['Enfeebling Magic'] = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = "Befouled Crown",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = gear.af.body,
		hands = "Regal Cuffs",
		ring1 = "Kishar Ring",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Obstin. Sash",
		legs = "Chironic Hose",
		feet = "Uk'uxkaj Boots"
	}

	sets.midcast['Enfeebling Magic'].Resistant = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = "Befouled Crown",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = gear.af.body,
		hands = gear.af.hands,
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Aurist's Cape +1",
		waist = "Luminary Sash",
		legs = "Chironic Hose",
		feet = gear.af.feet
	}

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Enfeebling Magic']

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], { waist = "Acuity Belt +1" })
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
		{ waist = "Acuity Belt +1" })

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], { back = "Alaunus's Cape" })
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
		back =
		"Alaunus's Cape"
	})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {
		main = "Chatoyant Staff",
		sub = "Oneiros Grip",
		ammo = "Homiliary",
		head = "Befouled Crown",
		neck = "Chrys. Torque",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = gear.empy.body,
		hands = gear.chironic_refresh_hands,
		ring1 = "Defending Ring",
		ring2 = "Dark Ring",
		back = "Umbra Cape",
		waist = "Fucho-no-obi",
		legs = "Assid. Pants +1",
		feet = gear.chironic_refresh_feet
	}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		main = "Mpaca's Staff",
		sub = "Clerisy Strap +1",
		-- sub = "Umbra Strap",
		-- ammo = "Homiliary",
		ammo = "Hydrocera",
		head = "Befouled Crown",
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = gear.empy.body,
		hands = "Volte Gloves",
		ring1 = "Stikini Ring +1",
		ring2 = "Shneddick Ring",
		back = "Moonlight Cape",
		waist = "Carrier's Sash",
		legs = "Assid. Pants +1",
		feet = gear.chironic_refresh_feet
	}

	sets.idle.PDT = set_combine(sets.idle, {
		main = "Malignance Pole",
		sub = "Clerisy Strap +1",
		-- sub = "Umbra Strap",
		ammo = "Homiliary",
		head = "Nyame Helm",
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = "Witching Robe",
		hands = gear.chironic_refresh_hands,
		ring1 = "Defending Ring",
		ring2 = "Stikini Ring +1",
		back = "Moonlight Cape",
		waist = "Carrier's Sash",
		legs = "Assid. Pants +1",
		feet = gear.chironic_refresh_feet
	})

	sets.idle.MDT = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Homiliary",
		head = "Nyame Helm",
		neck = "Warder's Charm +1",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Defending Ring",
		ring2 = "Fortified Ring",
		back = "Moonlight Cape",
		waist = "Platinum Moogle Belt",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}

	-- Defense sets

	sets.defense.PDT = {
		main = "Mafic Cudgel",
		sub = "Genmei Shield",
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Odnowa Earring +1",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Defending Ring",
		ring2 = "Gelatinous Ring +1",
		back = "Shadow Mantle",
		waist = "Carrier's Sash",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}

	sets.defense.MDT = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Warder's Charm +1",
		ear1 = "Etiolation Earring",
		ear2 = "Odnowa Earring +1",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Shadow Ring",
		ring2 = "Fortified Ring",
		back = "Moonlight Cape",
		waist = "Carrier's Sash",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}

	sets.defense.MEVA = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Warder's Charm +1",
		ear1 = "Etiolation Earring",
		ear2 = "Odnowa Earring +1",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Purity Ring",
		ring2 = "Vengeful Ring",
		back = "Aurist's Cape +1",
		waist = "Carrier's Sash",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Basic set for if no TP weapon is defined.
	-- sets.engaged = {
	-- 	ammo = "Staunch Tathlum +1",
	-- 	head = "Aya. Zucchetto +2",
	-- 	neck = "Asperity Necklace",
	-- 	ear1 = "Cessance Earring",
	-- 	ear2 = "Brutal Earring",
	-- 	body = "Ayanmo Corazza +2",
	-- 	hands = "Aya. Manopolas +2",
	-- 	ring1 = "Petrov Ring",
	-- 	Ring2 = "Ilabrat Ring",
	-- 	back = "Moonlight Cape",
	-- 	waist = "Windbuffet Belt +1",
	-- 	legs = "Aya. Cosciales +2",
	-- 	feet = "Battlecast Gaiters"
	-- }
	sets.engaged = {
		ammo = "Amar Cluster",
		head = "Nyame Helm",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets",
		neck = "Combatant's Torque",
		waist = "Famine Sash",
		left_ear = "Cessance Earring",
		right_ear = "Ethereal Earring",
		left_ring = "Warp Ring",
		right_ring = "Petrov Ring",
		back = "Aptitude Mantle",
	}


	sets.engaged.Acc = {
		ammo = "Hasty Pinion +1",
		head = "Aya. Zucchetto +2",
		neck = "Combatant's Torque",
		ear1 = "Telos Earring",
		ear2 = "Brutal Earring",
		body = "Ayanmo Corazza +2",
		hands = "Aya. Manopolas +2",
		ring1 = "Petrov Ring",
		Ring2 = "Ilabrat Ring",
		back = "Moonlight Cape",
		waist = "Olseni Belt",
		legs = "Aya. Cosciales +2",
		feet = "Aya. Gambieras +2"
	}

	sets.engaged.DW = {
		ammo = "Staunch Tathlum +1",
		head = "Aya. Zucchetto +2",
		neck = "Asperity Necklace",
		ear1 = "Telos Earring",
		ear2 = "Suppanomimi",
		body = "Ayanmo Corazza +2",
		hands = "Aya. Manopolas +2",
		ring1 = "Petrov Ring",
		Ring2 = "Ilabrat Ring",
		back = "Moonlight Cape",
		waist = "Shetal Stone",
		legs = "Aya. Cosciales +2",
		feet = "Battlecast Gaiters"
	}

	sets.engaged.DW.Acc = {
		ammo = "Hasty Pinion +1",
		head = "Aya. Zucchetto +2",
		neck = "Combatant's Torque",
		ear1 = "Telos Earring",
		ear2 = "Suppanomimi",
		body = "Ayanmo Corazza +2",
		hands = "Aya. Manopolas +2",
		ring1 = "Petrov Ring",
		Ring2 = "Ilabrat Ring",
		back = "Moonlight Cape",
		waist = "Shetal Stone",
		legs = "Aya. Cosciales +2",
		feet = "Aya. Gambieras +2"
	}

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = { hands = gear.empy.heads, back = "Mending Cape" }

	sets.HPDown = {
		head = "Pixie Hairpin +1",
		ear1 = "Mendicant's Earring",
		ear2 = "Evans Earring",
		body = "Zendik Robe",
		hands = "Hieros Mittens",
		ring1 = "Mephitas's Ring +1",
		ring2 = "Mephitas's Ring",
		back = "Swith Cape +1",
		waist = "Carrier's Sash",
		legs = "Shedir Seraweels",
		feet = ""
	}

	sets.HPCure = {
		main = "Queller Rod",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = "Nyame Helm",
		neck = "Nodens Gorget",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = "Kaykaus Bliaut",
		hands = "Kaykaus Cuffs",
		ring1 = "Kunaji Ring",
		ring2 = "Meridian Ring",
		back = "Alaunus's Cape",
		waist = "Eschan Stone",
		legs = gear.empy.legs,
		feet = "Kaykaus Boots"
	}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 6)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 002')
end

autows_list = { ['DualWeapons'] = 'Realmrazer', ['MeleeWeapons'] = 'Realmrazer' }
