function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
	state.IdleMode:options('Normal', 'PDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Idris', 'Maxentius', 'DualWeapons')

	gear.nuke_jse_back = { name = "Nantosuelta's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', '"Mag.Atk.Bns."+10' } }
	gear.idle_jse_back = { name = "Nantosuelta's Cape", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Pet: "Regen"+10' } }

	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = gear.nuke_jse_back
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = gear.nuke_jse_back
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	autoindi = "Haste"
	autogeo = "Frailty"

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
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
	af.Head = "Geo. Galero +2"
	af.Body = "Geomancy Tunic +2"
	af.Hands = "Geo. Mitaines +3"
	af.Legs = "Geomancy Pants +3"
	af.Feet = "Geo. Sandals +3"

	relic = {}
	relic.Head = "Bagua Galero +3"
	relic.Body = "Bagua Tunic +3"
	relic.Hands = "Bagua Mitaines +3"
	relic.Legs = "Bagua Pants +3"
	relic.Feet = "Bagua Sandals +3"

	empy = {}
	empy.Head = "Azimuth Hood +2"
	empy.Body = "Azimuth Coat +2"
	empy.Hands = "Azimuth Gloves +2"
	empy.Legs = "Azimuth Tights +2"
	empy.Feet = "Azimuth Gaiters +2"

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = { body = relic.Body }
	sets.precast.JA['Life Cycle'] = { body = af.Body, back = gear.idle_jse_back }
	sets.precast.JA['Radial Arcana'] = { feet = relic.Feet }
	sets.precast.JA['Mending Halation'] = { legs = relic.Legs }
	sets.precast.JA['Full Circle'] = { head = empy.Head, hands = relic.Hands }

	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {
		main = gear.gada_indi_club,
		neck = "Incanter's Torque", 
		back = gear.idle_jse_back, 
		legs = relic.Legs, 
		feet = empy.Feet 
	}

	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {
		head = relic.Head,
	}

	-- Fast cast sets for spells

	sets.precast.FC = {
		-- main = gear.grioavolr_fc_staff, -- 11
		-- sub = "Clerisy Strap +1", -- 3
		main = "C. Palug Hammer", -- 7
		sub = "Genmei Shield",
		-- range = "Dunna", -- 3
		-- ammo = empty,
		head = "C. Palug Crown", -- 8
        neck = "Baetyl Pendant", --4
		ear1 = "Loquac. Earring", -- 2
		ear2 = "Malignance Earring", -- 4
		-- body = "Zendik Robe",
		body = "Volte Doublet", -- 10
		hands = "Volte Gloves", -- 6
		ring1 = "Kishar Ring", -- 4
		ring2 = "Lebeche Ring", -- 2 QM
		back = "Fi Follet Cape", -- 10
		waist = "Witful Belt", -- 3 / 3 QM
		legs = af.Legs, -- 13 
		feet = "Regal Pumps +1" -- 7
	} -- 81

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, { 
	})

	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,
		{ ear2 = "Malignance Earring", hands = relic.Hands })

	sets.precast.FC.Cure = set_combine(sets.precast.FC, { 
		-- main = "Serenity", 
		-- sub = "Clerisy Strap +1" 
	})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.Self_Healing = { neck = "Phalaina Locket", ring1 = "Kunaji Ring", ring2 = "Asklepian Ring", waist =
	"Gishdubar Sash" }
	sets.Cure_Received = { neck = "Phalaina Locket", ring1 = "Kunaji Ring", ring2 = "Asklepian Ring", waist =
	"Gishdubar Sash" }
	sets.Self_Refresh = { back = "Grapevine Cape", waist = "Gishdubar Sash", feet = "Inspirited Boots" }

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = {
		-- ammo = "Impatiens",
		head = empty,
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Malignance Earring",
		body = "Twilight Cloak",
		hands = "Volte Gloves",
		ring1 = "Kishar Ring",
		ring2 = "Lebeche Ring",
		back = "Lifestream Cape",
		waist = "Witful Belt",
		legs = af.Legs,
		feet = "Regal Pumps +1"
	}

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Genmei Shield" })

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head = sets.Nyame.Head,
		ammo = "Oshasha's Treatise",
		range = empty,
		neck = "Combatant's Torque",
		body = sets.Nyame.Body,        
		hands = sets.Nyame.Hands,
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet,
		waist =	"Sailfi Belt +1",
		left_ear = { name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear =	"Ishvara Earring",
		left_ring = "Epaminondas's Ring",
		right_ring = "Karieyh Ring",
		-- back = RDMCape.MACC,
	}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {

	})

	sets.midcast.Geomancy = {
		main = "Idris",
		sub = "Genmei Shield",
		-- range = "Dunna",
		-- ammo = empty,
		head = "Vanya Hood",
		neck = "Bagua Charm +2",
		ear1 = "Gifted Earring",
		ear2 = "Malignance Earring",
		-- body = "Vedic Coat",
		body = "Gyve Doublet",
		hands = af.Hands,
		ring1 = "Defending Ring",
		ring2 = "Dark Ring",
		back = "Solemnity Cape",
		waist = "Austerity Belt +1",
		-- legs = "Vanya Slops",
		legs = "Lengo Pants",
		-- feet = "Medium's Sabots"
		feet = "Merlinic Crackows"
	}


	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy,
		{ 
			neck = "Incanter's Torque", 
			back = gear.idle_jse_back, 
			legs = relic.Legs, 
			feet = empy.Feet 
		})

	sets.midcast.Cure = {
		main = "Daybreak",
		sub = "Sors Shield",
		-- ammo = "Hasty Pinion +1",
		head = "Vanya Hood",
		-- neck = "Incanter's Torque",
		neck = "Deviant Necklace",
		ear1 = "Gifted Earring",
		ear2 = "Etiolation Earring",
		body = "Zendik Robe",
		hands = "Telchine Gloves",
		ring1 = "Janniston Ring",
		ring2 = "Menelaus's Ring",
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

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, { main = "Daybreak", sub = "Sors Shield" })

	sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
		neck = "Debilis Medallion",
		hands = "Hieros Mittens",
		back = "Oretan. Cape +1",
		ring1 = "Haoma's Ring",
		ring2 = "Menelaus's Ring",
		waist = "Witful Belt",
		feet = "Vanya Clogs"
	})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, { main = gear.grioavolr_fc_staff, sub =
	"Clemency Grip" })

	sets.midcast['Elemental Magic'] = {
		-- main = "Daybreak",
		-- sub = "Ammurapi Shield",
		-- ammo = "Ghastly Tathlum +1",
		-- head = gear.merlinic_nuke_head,
		-- neck = "Saevus Pendant +1",
		-- ear1 = "Crematio Earring",
		-- ear2 = "Friomisi Earring",
		-- body = gear.merlinic_nuke_body,
		-- hands = "Mallquis Cuffs +2",
		-- ring1 = "Shiva Ring +1",
		-- ring2 = "Freke Ring",
		-- back = gear.nuke_jse_back,
		-- waist = gear.ElementalObi,
		-- legs = "Merlinic Shalwar",
		-- feet = "Amalric Nails +1",
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = empy.Head,
		body = empy.Body,
		hands = empy.Hands,
		legs = empy.Legs,
		feet = empy.Feet,
		neck = "Mizu. Kubikazari",
		waist = { name="Acuity Belt +1", augments={'Path: A',}},
		left_ear = "Friomisi Earring",
		right_ear = "Azimuth Earring +2",
		left_ring = "Stikini Ring +1",
		right_ring = "Stikini Ring +1",
		back = "Aurist's Cape +1",
	}

	sets.midcast['Elemental Magic'].Resistant = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		-- ammo = "Pemphredo Tathlum",
		head = gear.merlinic_nuke_head,
		neck = "Sanctity Necklace",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = gear.merlinic_nuke_body,
		hands = "Mallquis Cuffs +2",
		ring1 = "Shiva Ring +1",
		ring2 = "Freke Ring",
		back = gear.nuke_jse_back,
		waist = "Yamabuki-no-Obi",
		legs = "Merlinic Shalwar",
		feet = "Amalric Nails +1"
	}

	sets.midcast['Elemental Magic'].Proc = {
		main = empty,
		sub = empty,
		-- ammo = "Impatiens",
		head = "Vanya Hood",
		neck = "Loricate Torque +1",
		ear1 = "Gifted Earring",
		ear2 = "Loquac. Earring",
		body = "Seidr Cotehardie",
		hands = "Regal Cuffs",
		ring1 = "Kishar Ring",
		ring2 = "Prolix Ring",
		back = "Swith Cape +1",
		waist = "Witful Belt",
		legs = "Assid. Pants +1",
		feet = "Regal Pumps +1"
	}

	sets.midcast['Elemental Magic'].Fodder = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = gear.merlinic_nuke_head,
		neck = "Saevus Pendant +1",
		ear1 = "Crematio Earring",
		ear2 = "Friomisi Earring",
		body = gear.merlinic_nuke_body,
		hands = "Mallquis Cuffs +2",
		ring1 = "Shiva Ring +1",
		ring2 = "Freke Ring",
		back = gear.nuke_jse_back,
		waist = gear.ElementalObi,
		legs = "Merlinic Shalwar",
		feet = "Amalric Nails +1"
	}

	sets.midcast['Elemental Magic'].HighTierNuke = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		-- ammo = "Pemphredo Tathlum",
		head = gear.merlinic_nuke_head,
		neck = "Baetyl Pendant",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = gear.merlinic_nuke_body,
		hands = "Amalric Gages +1",
		ring1 = "Metamor. Ring +1",
		ring2 = "Freke Ring",
		back = gear.nuke_jse_back,
		waist = gear.ElementalObi,
		legs = "Merlinic Shalwar",
		feet = "Amalric Nails +1"
	}

	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		-- ammo = "Pemphredo Tathlum",
		head = gear.merlinic_nuke_head,
		neck = "Sanctity Necklace",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = gear.merlinic_nuke_body,
		hands = "Amalric Gages +1",
		ring1 = "Metamor. Ring +1",
		ring2 = "Freke Ring",
		back = gear.nuke_jse_back,
		waist = "Yamabuki-no-Obi",
		legs = "Merlinic Shalwar",
		feet = "Amalric Nails +1"
	}

	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		-- ammo = "Pemphredo Tathlum",
		head = gear.merlinic_nuke_head,
		neck = "Saevus Pendant +1",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = gear.merlinic_nuke_body,
		hands = "Amalric Gages +1",
		ring1 = "Metamor. Ring +1",
		ring2 = "Freke Ring",
		back = gear.nuke_jse_back,
		waist = gear.ElementalObi,
		legs = "Merlinic Shalwar",
		feet = "Amalric Nails +1"
	}

	sets.midcast['Dark Magic'] = {
		main = "Rubicundity",
		sub = "Ammurapi Shield",
		-- ammo = "Pemphredo Tathlum",
		head = gear.merlinic_nuke_head,
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = gear.merlinic_nuke_body,
		hands = "Amalric Gages +1",
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Yamabuki-no-Obi",
		legs = "Merlinic Shalwar",
		feet = gear.merlinic_aspir_feet
	}

	sets.midcast.Drain = {
		main = "Rubicundity",
		sub = "Ammurapi Shield",
		-- ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = gear.merlinic_nuke_body,
		hands = "Amalric Gages +1",
		ring1 = "Archon Ring",
		ring2 = "Evanescence Ring",
		back = gear.nuke_jse_back,
		waist = "Fucho-no-obi",
		legs = "Merlinic Shalwar",
		feet = gear.merlinic_aspir_feet
	}

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = {
		-- main = gear.grioavolr_fc_staff,
		-- sub = "Clerisy Strap +1",
		-- ammo = "Hasty Pinion +1",
		head = "Amalric Coif +1",
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Malignance Earring",
		body = "Zendik Robe",
		hands = "Volte Gloves",
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Lifestream Cape",
		waist = "Witful Belt",
		legs = "Psycloth Lappas",
		feet = "Regal Pumps +1"
	}

	sets.midcast.Stun.Resistant = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		-- ammo = "Pemphredo Tathlum",
		head = "Amalric Coif +1",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = "Zendik Robe",
		hands = "Amalric Gages +1",
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Acuity Belt +1",
		legs = "Merlinic Shalwar",
		feet = gear.merlinic_aspir_feet
	}

	sets.midcast.Impact = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		-- ammo = "Pemphredo Tathlum",
		head = empty,
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = "Twilight Cloak",
		hands = "Regal Cuffs",
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Acuity Belt +1",
		legs = "Merlinic Shalwar",
		feet = "Amalric Nails +1"
	}

	sets.midcast.Dispel = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		-- ammo = "Pemphredo Tathlum",
		head = "Amalric Coif +1",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = "Zendik Robe",
		hands = "Amalric Gages +1",
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Acuity Belt +1",
		legs = "Merlinic Shalwar",
		feet = gear.merlinic_aspir_feet
	}

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, { main = "Daybreak", sub = "Ammurapi Shield" })

	sets.midcast['Enfeebling Magic'] = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		-- ammo = "Pemphredo Tathlum",
		-- head = "Befouled Crown",
		head = empy.Head,
		body = empy.Body,
		hands = "Regal Cuffs",
		legs = empy.Legs,
		feet = empy.Feet,
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Azimuth Earring +2",
		-- body = gear.merlinic_nuke_body,
		-- hands = "Regal Cuffs",
		ring1 = "Kishar Ring",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Luminary Sash",
		-- legs = "Psycloth Lappas",
		-- feet = "Uk'uxkaj Boots"
	}

	sets.midcast['Enfeebling Magic'].Resistant = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		-- ammo = "Pemphredo Tathlum",
		head = "Befouled Crown",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = gear.merlinic_nuke_body,
		hands = "Regal Cuffs",
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Luminary Sash",
		legs = "Psycloth Lappas",
		feet = "Skaoi Boots"
	}

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'],
		{ head = "Amalric Coif +1", ear2 = "Malignance Earring", waist = "Acuity Belt +1" })
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
		{ head = "Amalric Coif +1", ear2 = "Malignance Earring", waist = "Acuity Belt +1" })

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'],
		{ head = "Amalric Coif +1", ear2 = "Malignance Earring", waist = "Acuity Belt +1" })
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
		{ head = "Amalric Coif +1", ear2 = "Malignance Earring", waist = "Acuity Belt +1" })

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], { 
		-- range = empty, 
		ring2 = "Stikini Ring +1" 
	})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, { 
		-- range = empty, 
		ring2 = "Stikini Ring +1" 
	})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], { ring1 = "Stikini Ring +1" })

	sets.midcast['Enhancing Magic'] = {
		main = gear.gada_enhancing_club,
		sub = "Ammurapi Shield",
		-- ammo = "Hasty Pinion +1",
		head = "Telchine Cap",
		neck = "Incanter's Torque",
		ear1 = "Andoaa Earring",
		ear2 = "Gifted Earring",
		body = "Telchine Chas.",
		hands = "Telchine Gloves",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Perimede Cape",
		waist = "Embla Sash",
		legs = "Telchine Braconi",
		feet = "Telchine Pigaches"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],
		{ neck = "Nodens Gorget", ear2 = "Earthcry Earring", waist = "Siegel Sash", legs = "Shedir Seraweels" })

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], { head = "Amalric Coif +1" })

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
		{ main = "Vadose Rod", sub = "Genmei Shield", head = "Amalric Coif +1", hands = "Regal Cuffs", waist =
		"Emphatikos Rope", legs = "Shedir Seraweels" })

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], { legs = "Shedir Seraweels" })

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'],
		{ ring2 = "Sheltered Ring", ear1 = "Gifted Earring", ear2 = "Malignance Earring", waist = "Sekhmet Corset" })
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],
		{ ring2 = "Sheltered Ring", ear1 = "Gifted Earring", ear2 = "Malignance Earring", waist = "Sekhmet Corset" })
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'],
		{ ring2 = "Sheltered Ring", ear1 = "Gifted Earring", ear2 = "Malignance Earring", waist = "Sekhmet Corset" })
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],
		{ ring2 = "Sheltered Ring", ear1 = "Gifted Earring", ear2 = "Malignance Earring", waist = "Sekhmet Corset" })

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets
	sets.resting = {
		main = "Chatoyant Staff",
		sub = "Oneiros Grip",
		head = "Befouled Crown",
		neck = "Chrys. Torque",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = "Jhakri Robe +2",
		hands = gear.merlinic_refresh_hands,
		ring1 = "Defending Ring",
		ring2 = "Dark Ring",
		back = "Umbra Cape",
		legs = "Assid. Pants +1",
		feet = gear.merlinic_refresh_feet
	}

	-- Idle sets

	sets.idle = {
		main = "Idris",
		sub = "Genmei Shield",
		range = empty,
		ammo = "Staunch Tathlum +1",
		neck = "Loricate Torque +1",
		ear1 = "Odnowa Earring +1",
		ear2 = "Ethereal Earring",
		head = "Volte Beret",
		body = "Azimuth Coat +2",
		hands = relic.Hands,
		legs = "Volte Brais",
		feet = "Volte Gaiters",
		ring1 = "Defending Ring",
		ring2 = "Stikini Ring +1",
		back = "Moonlight Cape",
		waist = "Plat. Mog. Belt",
	}

	sets.idle.PDT = set_combine(sets.idle, {
		ring1 = "Defending Ring",
		ring2 = "Shadow Ring",
		back = "Shadow Mantle",
		waist = "Carrier's Sash",
		head = sets.Nyame.Head,
		body = sets.Nyame.Body,
		hands = sets.Nyame.Hands,
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet,
	})

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = {
		main = "Idris",
		sub = "Genmei Shield",
		-- range = "Dunna",
		-- ammo = empty,
		head = empy.Head,
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Odnowa Earring +1",
		body = empy.Body,
		hands = af.Hands,
		ring1 = "Defending Ring",
		ring2 = "Stikini Ring +1",
		back = gear.idle_jse_back,
		waist = "Isa Belt",
		legs = gear.Legs,
		feet = relic.Feet
	}

	sets.idle.PDT.Pet = set_combine(sets.idle.Pet, {
		legs = "Nyame Flanchard",	
	})

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {})
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

	sets.idle.Weak = {
		main = "Bolelabunga",
		sub = "Genmei Shield",
		ammo = "Staunch Tathlum +1",
		head = "Befouled Crown",
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = "Jhakri Robe +2",
		hands = gear.merlinic_refresh_hands,
		ring1 = "Defending Ring",
		ring2 = "Dark Ring",
		back = "Umbra Cape",
		waist = "Carrier's Sash",
		legs = "Assid. Pants +1",
		feet = empy.Feet
	}

	-- Defense sets

	sets.defense.PDT = set_combine(sets.idle.PDT, {	
	})

	sets.defense.MDT = set_combine(sets.idle.PDT, {	
	})

	sets.defense.MEVA = set_combine(sets.idle.PDT, {	
	})

	sets.defense.PetPDT = sets.idle.PDT.Pet

	sets.defense.NukeLock = sets.midcast['Elemental Magic']

	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = { feet = af.Feet }
	sets.latent_refresh = { waist = "Fucho-no-obi" }
	sets.latent_refresh_grip = { sub = "Oneiros Grip" }
	sets.TPEat = { neck = "Chrys. Torque" }
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, { feet = gear.merlinic_treasure_feet })

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
		ammo = "Staunch Tathlum +1",
		head = "Blistering Sallet +1",
		-- head = empy.Head,
		neck = "Combatant's Torque",
		ear1 = "Crep. Earring",
		ear2 = "Telos Earring",
		body = empy.Body,
		hands = "Gazu Bracelets +1",
		ring1 = "Petrov Ring",
		ring2 = "Lehko's Ring",
		back = "Moonlight Cape",
		waist = "Eschan Stone",
		legs = empy.Legs,
		feet = "Battlecast Gaiters"
	}

	sets.engaged.DW = {
		-- ammo = "Hasty Pinion +1",
		head = "Befouled Crown",
		neck = "Asperity Necklace",
		ear1 = "Dudgeon Earring",
		ear2 = "Heartseeker Earring",
		body = "Jhakri Robe +2",
		hands = "Regal Cuffs",
		ring1 = "Ramuh Ring +1",
		ring2 = "Ramuh Ring +1",
		back = "Moonlight Cape",
		waist = "Witful Belt",
		legs = "Assid. Pants +1",
		feet = "Battlecast Gaiters"
	}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = { body = "Seidr Cotehardie" }

	-- Gear for Magic Burst mode.
	sets.MagicBurst = { 
		-- main = gear.grioavolr_nuke_staff, 
		-- sub = "Alber Strap", 
		range = empty,
		ammo = "Ghastly Tathlum +1",
		head = empy.Head, 
		neck = "Mizu. Kubikazari", 
		hands = empy.Hands,
		body = empy.Body, 
		waist = "Refoccilation Stone",
		earring1 = "Malignance Earring",
		earring2 = "Friomisi Earring",
		ring1 = "Mujin Band", 
		ring2 = "Freke Ring",
		legs = empy.Legs, 
		feet = "Jhakri Pigaches +2" 
	}
	sets.ResistantMagicBurst = { main = gear.grioavolr_nuke_staff, sub = "Enki Strap", head = "Ea Hat +1", neck =
	"Mizu. Kubikazari", body = "Ea Houppe. +1", ring1 = "Mujin Band", legs = "Ea Slops +1", feet = "Jhakri Pigaches +2" }

	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }

	-- Weapons sets
	sets.weapons.Idris = { main = 'Idris', sub = 'Genmei Shield' }
	sets.weapons.Maxentius = { main = 'Maxentius', sub = 'Genmei Shield' }
	sets.weapons.DualWeapons = { main = 'Maxentius', sub = 'Nehushtan' }
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 005')
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(4, 10)
end
