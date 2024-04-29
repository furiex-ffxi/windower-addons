function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
	state.IdleMode:options('Normal', 'PDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Mpaca', 'Maxentius', 'Ternion', 'Daybreak', 'DualWeapons')

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
	gear.af = {
		Head = "Geo. Galero +2",
		Body = "Geomancy Tunic +2",
		Hands = "Geo. Mitaines +3",
		Legs = "Geomancy Pants +3",
		Feet = "Geo. Sandals +3",
	}

	gear.relic = {
		Head = "Bagua Galero +3",
		Body = "Bagua Tunic +3",
		Hands = "Bagua Mitaines +3",
		Legs = "Bagua Pants +3",
		Feet = "Bagua Sandals +3",
	}

	gear.empy = {
		Head = "Azimuth Hood +2",
		Body = "Azimuth Coat +2",
		Hands = "Azimuth Gloves +2",
		Legs = "Azimuth Tights +2",
		Feet = "Azimuth Gaiters +2",
	}

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = { body = gear.relic.Body }
	sets.precast.JA['Life Cycle'] = { body = gear.af.Body, back = gear.idle_jse_back }
	sets.precast.JA['Radial Arcana'] = { feet = gear.relic.Feet }
	sets.precast.JA['Mending Halation'] = { legs = gear.relic.Legs }
	sets.precast.JA['Full Circle'] = { head = gear.empy.Head, hands = gear.relic.Hand }

	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}

	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {}

	-- Fast cast sets for spells

	sets.precast.FC = {
		main = "Mpaca's Staff",
		sub = "Clerisy Strap +1",
		ammo = "Impatiens",
		head = "C. Palug Crown",
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Malignance Earring",
		-- body = "Zendik Robe",
		body = "Shango Robe",
		hands = "Volte Gloves",
		ring1 = "Kishar Ring",
		ring2 = "Lebeche Ring",
		back = "Perimede Cape",
		waist = "Witful Belt",
		legs = gear.af.Legs,
		feet = "Regal Pumps +1"
	}

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, { range = "Dunna", ammo = empty })

	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,
		{ ear2 = "Malignance Earring", hands = gear.relic.Hand })

	sets.precast.FC.Cure = set_combine(sets.precast.FC, { main = "Serenity", sub = "Clerisy Strap +1" })

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.Self_Healing = { neck = "Phalaina Locket", ring1 = "Kunaji Ring", ring2 = "Asklepian Ring", waist =
	"Gishdubar Sash" }
	sets.Cure_Received = { neck = "Phalaina Locket", ring1 = "Kunaji Ring", ring2 = "Asklepian Ring", waist =
	"Gishdubar Sash" }
	sets.Self_Refresh = { back = "Grapevine Cape", waist = "Gishdubar Sash", feet = "Inspirited Boots" }

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = {
		ammo = "Impatiens",
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
		legs = gear.af.Legs,
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

	sets.precast.WS['Cataclysm'] = {
		head = sets.Nyame.Head,
		ammo = "Oshasha's Treatise",
		range = empty,
		neck = "Baetyl Pendant",
		body = sets.Nyame.Body,        
		hands = sets.Nyame.Hands,
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet,
		waist =	"Eschan Stone",
		left_ear = { name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear =	"Ishvara Earring",
		left_ring = "Epaminondas's Ring",
		right_ring = "Karieyh Ring",
		-- back = RDMCape.MACC,
	}

	sets.precast.WS['Aeolian Edge'] = {
		head = sets.Nyame.Head,
		ammo = "Oshasha's Treatise",
		range = empty,
		neck = "Baetyl Pendant",
		body = sets.Nyame.Body,        
		hands = sets.Nyame.Hands,
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet,
		waist =	"Eschan Stone",
		left_ear = { name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear =	"Ishvara Earring",
		left_ring = "Epaminondas's Ring",
		right_ring = "Karieyh Ring",
		-- back = RDMCape.MACC,
	}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = {
		main = gear.grioavolr_fc_staff,
		sub = "Clerisy Strap +1",
		head = "Amalric Coif +1",
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Malignance Earring",
		body = "Zendik Robe",
		hands = "Volte Gloves",
		ring1 = "Kishar Ring",
		ring2 = "Prolix Ring",
		back = "Lifestream Cape",
		waist = "Witful Belt",
		legs = gear.af.Legs,
		feet = "Regal Pumps +1"
	}

	sets.midcast.Geomancy = {
		main = "Solstice",
		sub = "Genmei Shield",
		range = "Dunna",
		head = "Vanya Hood",
		neck = "Bagua Charm +2",
		ear1 = "Gifted Earring",
		ear2 = "Malignance Earring",
		body = "Vedic Coat",
		hands = gear.af.Hands,
		ring1 = "Defending Ring",
		ring2 = "Dark Ring",
		back = "Solemnity Cape",
		waist = "Austerity Belt +1",
		legs = "Vanya Slops",
		feet = "Medium's Sabots"
	}


	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy,
		{ back = gear.idle_jse_back, legs = gear.relic.Legs, feet = gear.empy.Feet })

	sets.midcast.Cure = {
		main = "Daybreak",
		sub = "Sors Shield",
		ammo = "Hasty Pinion +1",
		head = "Amalric Coif +1",
		neck = "Incanter's Torque",
		ear1 = "Gifted Earring",
		ear2 = "Etiolation Earring",
		body = "Zendik Robe",
		hands = "Telchine Gloves",
		ring1 = "Janniston Ring",
		ring2 = "Menelaus's Ring",
		back = "Tempered Cape +1",
		waist = "Witful Belt",
		legs = gear.af.Legs,
		feet = "Vanya Clogs"
	}

	sets.midcast.LightWeatherCure = {
		main = "Chatoyant Staff",
		sub = "Curatio Grip",
		ammo = "Hasty Pinion +1",
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
		legs = gear.af.Legs,
		feet = "Vanya Clogs"
	}

	--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = {
		main = gear.gada_healing_club,
		sub = "Sors Shield",
		ammo = "Hasty Pinion +1",
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
		legs = gear.af.Legs,
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
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = empy.Head,
		body = empy.Body,
		hands = empy.Hands,
		legs = empy.Legs,
		feet = empy.Feet,
		neck = "Mizu. Kubikazari",
		waist = "Acuity Belt +1",
		left_ear = "Friomisi Earring",
		right_ear = "Azimuth Earring",
		left_ring = "Stikini Ring +1",
		right_ring = "Stikini Ring +1",
		back = "Aurist's Cape +1",
	}

	sets.midcast['Elemental Magic'].Resistant = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
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
		ammo = "Impatiens",
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
		ammo = "Pemphredo Tathlum",
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
		ammo = "Pemphredo Tathlum",
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
		ammo = "Pemphredo Tathlum",
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
		ammo = "Pemphredo Tathlum",
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
		ammo = "Pemphredo Tathlum",
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
		main = gear.grioavolr_fc_staff,
		sub = "Clerisy Strap +1",
		ammo = "Hasty Pinion +1",
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
		ammo = "Pemphredo Tathlum",
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
		ammo = "Pemphredo Tathlum",
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
		ammo = "Pemphredo Tathlum",
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
		ammo = "Pemphredo Tathlum",
		head = "Befouled Crown",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = gear.merlinic_nuke_body,
		hands = "Regal Cuffs",
		ring1 = "Kishar Ring",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Luminary Sash",
		legs = "Psycloth Lappas",
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

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], { range = empty, ring1 = "Stikini Ring +1" })
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
		{ range = empty, ring1 = "Stikini Ring +1" })

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], { ring1 = "Stikini Ring +1" })

	sets.midcast['Enhancing Magic'] = {
		main = gear.gada_enhancing_club,
		sub = "Ammurapi Shield",
		ammo = "Hasty Pinion +1",
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
		main = "Mpaca's Staff",
		sub = "Umbra Strap",
		-- ammo = "Homiliary",
		ammo = "Staunch Tathlum +1",
		head = "Befouled Crown",
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = gear.empy.Body,
		hands = "Volte Gloves",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Moonlight Cape",
		waist = "Carrier's Sash",
		legs = "Volte Brais",
		feet = "Volte Gaiters"
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
		-- ring1 = "Defending Ring",
		ring1 = "Gelatinous Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Moonlight Cape",
		waist = "Carrier's Sash",
	})

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = {
		main = "Sucellus",
		sub = "Genmei Shield",
		range = "Dunna",
		head = gear.empy.Head,
		neck = "Loricate Torque +1",
		ear1 = "Handler's Earring",
		ear2 = "Handler's Earring +1",
		body = "Jhakri Robe +2",
		hands = gear.af.Hands,
		ring1 = "Defending Ring",
		ring2 = "Dark Ring",
		back = gear.idle_jse_back,
		waist = "Isa Belt",
		legs = "Psycloth Lappas",
		feet = gear.relic.Feet
	}

	sets.idle.PDT.Pet = {
		main = "Malignance Pole",
		sub = "Umbra Strap",
		range = "Dunna",
		head = gear.empy.Head,
		neck = "Loricate Torque +1",
		ear1 = "Handler's Earring",
		ear2 = "Handler's Earring +1",
		body = "Jhakri Robe +2",
		hands = gear.af.Hands,
		ring1 = "Defending Ring",
		ring2 = "Dark Ring",
		back = gear.idle_jse_back,
		waist = "Isa Belt",
		legs = "Nyame Flanchard",
		feet = gear.relic.Feet
	}

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
		feet = gear.empy.Feet
	}

	-- Defense sets

	sets.defense.PDT = {
		main = "Malignance Pole",
		sub = "Umbra Strap",
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Handler's Earring +1",
		body = "Mallquis Saio +2",
		hands = "Nyame Gauntlets",
		ring1 = "Defending Ring",
		ring2 = "Dark Ring",
		back = "Umbra Cape",
		waist = "Carrier's Sash",
		legs = "Nyame Flanchard",
		feet = gear.empy.Feet
	}

	sets.defense.MDT = {
		main = "Malignance Pole",
		sub = "Umbra Strap",
		ammo = "Staunch Tathlum +1",
		head = gear.empy.Head,
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Handler's Earring +1",
		body = "Mallquis Saio +2",
		hands = "Nyame Gauntlets",
		ring1 = "Defending Ring",
		ring2 = "Dark Ring",
		back = "Umbra Cape",
		waist = "Carrier's Sash",
		legs = "Nyame Flanchard",
		feet = gear.empy.Feet
	}

	sets.defense.MEVA = {
		main = "Malignance Pole",
		sub = "Enki Strap",
		ammo = "Staunch Tathlum +1",
		head = gear.empy.Head,
		neck = "Warder's Charm +1",
		ear1 = "Etiolation Earring",
		ear2 = "Sanare Earring",
		body = gear.merlinic_nuke_body,
		hands = "Telchine Gloves",
		ring1 = "Vengeful Ring",
		Ring2 = "Purity Ring",
		back = gear.idle_jse_back,
		waist = "Luminary Sash",
		legs = "Telchine Braconi",
		feet = gear.empy.Feet
	}

	sets.defense.PetPDT = sets.idle.PDT.Pet

	sets.defense.NukeLock = sets.midcast['Elemental Magic']

	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = { 
		feet = "Herald's Gaiters", 
		ring1 = "Shneddick Ring"
	}
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
		ammo = "Amar Cluster",
		head = "Blistering Sallet +1",
		neck = "Combatant's Torque",
		ear1 = "Cessance Earring",
		ear2 = "Crep. Earring",
		body = gear.empy.Body,
		hands = "Gazu Bracelets +1",
		ring1 = "Petrov Ring",
		ring2 = "Cacoethic Ring",
		back = "Moonlight Cape",
		waist = "Eschan Stone",
		legs = gear.empy.Legs,
		feet = "Battlecast Gaiters"
	}

	sets.engaged.DW = {
		ammo = "Hasty Pinion +1",
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
		head = gear.empy.Head, 
		neck = "Mizu. Kubikazari", 
		hands = gear.empy.Hands,
		body = gear.empy.Body, 
		waist = "Refoccilation Stone",
		earring1 = "Malignance Earring",
		earring2 = "Azimuth Earring",
		-- earring2 = "Friomisi Earring",
		ring1 = "Mujin Band", 
		ring2 = "Freke Ring",
		legs = gear.empy.Legs, 
		feet = gear.empy.Feet,
	}
	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }

	-- Weapons sets
	sets.weapons.Mpaca = { main = "Mpaca's Staff", sub = 'Umbra Strap' }
	sets.weapons.Maxentius = { main = 'Maxentius', sub = 'Genmei Shield' }
	sets.weapons.Ternion = { main = 'Ternion Dagger +1', sub = 'Genmei Shield' }
	sets.weapons.Daybreak = { main = 'Daybreak', sub = 'Genmei Shield' }
	sets.weapons.DualWeapons = { main = 'Maxentius', sub = 'Nehushtan' }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(4, 10)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 003')
end
