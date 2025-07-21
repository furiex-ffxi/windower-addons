function user_job_setup()
	-- Options: Override default values
	state.UnlockWeapons = M(true, "Unlock Weapons")
	state.OffenseMode:options("Normal", "Acc")
	state.HybridMode:options("Normal", "DT")
	state.CastingMode:options("Normal", "Duration", "Resistant")
	state.IdleMode:options("Normal", "PDT", "NoRefresh")
	state.Weapons:options(
		"None",
		"Naegling",
		"Aeneas",
		"Carnwenhan",
		"Mpu",
		"Twash",
		"Xoanon",
		"Qutrub",
		"DualCarnwenhan",
		"DualMpu",
		"DualWeapons",
		"DualNaegling",
		"DualNaeglingAcc",
		"DualTwash",
		"DualAeolian",
		"DualFermion"
	)
	-- Whether to use Carn (or song daggers in general) under a certain threshhold even when weapons are locked.
	state.CarnMode = M {"Always", "300", "1000", "Never"}

	-- Adjust this if using the Terpander (new +song instrument)
	info.ExtraSongInstrument = "Loughnashade"
	-- How many extra songs we can keep from Daurdabla/Terpander
	info.ExtraSongs = 2

	-- Set this to false if you don't want to use custom timers.
	state.UseCustomTimers = M(false, "Use Custom Timers")

	-- Additional local binds
	send_command("bind ^` gs c cycle ExtraSongsMode")
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command("bind @` gs c cycle MagicBurstMode")
	send_command("bind @f10 gs c cycle RecoverMode")
	send_command("bind @f8 gs c toggle AutoNukeMode")
	send_command("bind !r gs c weapons DualNaegling;gs c update;gs c set unlockweapons true")
	send_command("bind !q gs c weapons DualCarnwenhan;gs c update;gs c set unlockweapons true")
	send_command("bind ^q gs c weapons None;gs c update;gs c set unlockweapons true")
	send_command("bind !f7 gs c cycle CarnMode")
	send_command("bind ^numpad7 input //sing on")

	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	gear.fc_jse_back = {
		name = "Intarabus's Cape",
		augments = {"CHR+20", "Mag. Acc+20 /Mag. Dmg.+20", "CHR+10", '"Fast Cast"+10', "Phys. dmg. taken-10%"}
	}
	gear.str_wsd_jse_back = {
		name = "Intarabus's Cape",
		augments = {"STR+20", "Accuracy+20 Attack+20", "STR+10", "Weapon skill damage +10%", "Phys. dmg. taken-10%"}
	}
	gear.dex_wsd_jse_back = gear.str_wsd_jse_back
	 -- { name = "Intarabus's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
	gear.chr_wsd_jse_back = gear.str_wsd_jse_back -- { name = "Intarabus's Cape", augments = { 'CHR+20', 'Accuracy+20 Attack+20', 'CHR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
	gear.int_wsd_jse_back = gear.str_wsd_jse_back -- { name = "Intarabus's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
	gear.tp_jse_back = {
		name = "Intarabus's Cape",
		augments = {"DEX+20", "Accuracy+20 Attack+20", "Accuracy+10", '"Dbl.Atk."+10', "Phys. dmg. taken-10%"}
	}

	gear.af_head = "Brioso Roundlet +3"
	gear.af_body = "Brioso Justau. +3"
	gear.af_hands = "Brioso Cuffs +3"
	gear.af_legs = "Brioso Cannions +3"
	gear.af_feet = "Brioso Slippers +3"

	gear.relic_head = "Bihu Roundlet +3"
	gear.relic_body = "Bihu Jstcorps. +3"
	gear.relic_hands = "Bihu Cuffs +3"
	gear.relic_legs = "Bihu Cannions +3"
	gear.relic_feet = "Bihu Slippers +3"

	gear.empy_head = "Fili Calot +3"
	gear.empy_body = "Fili Hongreline +3"
	gear.empy_hands = "Fili Manchettes +3"
	gear.empy_legs = "Fili Rhingrave +3"
	gear.empy_feet = "Fili Cothurnes +3"

	-- Weapons sets
	sets.weapons.Naegling = {main = "Naegling", sub = "Genmei Shield"}
	sets.weapons.Aeneas = {main = "Aeneas", sub = "Genmei Shield"}
	sets.weapons.Carnwenhan = {main = "Carnwenhan", sub = "Genmei Shield"}
	sets.weapons.Mpu = {main = "Mpu Gandring", sub = "Genmei Shield"}
	sets.weapons.Twash = {main = "Twashtar", sub = "Genmei Shield"}
	sets.weapons.Naegling = {main = "Naegling", sub = "Genmei Shield"}
	sets.weapons.Xoanon = {main = "Xoanon", sub = "Enki Strap"}
	sets.weapons.Qutrub = {main = "Qutrub Knife", sub = "Genmei Shield"}
	sets.weapons.DualCarnwenhan = {main = "Carnwenhan", sub = "Fusetto +3"}
	sets.weapons.DualWeapons = {main = "Kartika", sub = "Gleti's Knife"} -- Aenas
	sets.weapons.DualMpu = {main = "Mpu Gandring", sub = "Fusetto +3"}
	sets.weapons.DualNaegling = {main = "Naegling", sub = "Fusetto +3"}
	sets.weapons.DualNaeglingAcc = {main = "Naegling", sub = "Gleti's Knife"}
	sets.weapons.DualTwash = {main = "Twashtar", sub = "Fusetto +3"}
	sets.weapons.DualAeolian = {main = "Tauret", sub = "Malevolence"}
    sets.weapons.DualFermion = {main="Fermion Sword", sub="Hedron Dagger"}

	sets.buff.Sublimation = {
		waist = "Embla Sash"
	}
	sets.buff.DTSublimation = {
		waist = "Embla Sash"
	}

	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
		head = "Volte Beret",
		body = "Inyanga Jubbah +2",
		hands = "Volte Gloves",
		legs = "Volte Brais",
		feet = gear.empy_feet,
		-- neck = "Orunmila's Torque",
		neck = "Baetyl Pendant",
		waist = "Embla Sash",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Etiolation Earring",
		ring1 = "Kishar Ring",
		ring2 = "Gelationus Ring +1",
		back = "Fi Follet Cape +1"
	}

	sets.precast.FC.DT = {
		head = "Bunzi's Hat",
		neck = "Baetyl Pendant",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Loquac. Earring",
		body = "Inyanga Jubbah +2",
		hands = "Gende. Gages +1",
		ring1 = "Kishar Ring",
		ring2 = "Gelationus Ring +1",
		back = gear.idle_jse_back,
		waist = "Witful Belt",
		legs = "Kaykaus Tights +1",
		feet = gear.empy_feet
	}

	sets.precast.FC.Cure =
		set_combine(
		sets.precast.FC,
		{
			feet = "Kaykaus Boots +1", --0/7
			ear2 = "Mendi. Earring" --0/5
		}
	)

	sets.precast.FC["Enhancing Magic"] = set_combine(sets.precast.FC, {waist = "Siegel Sash"})

	sets.precast.FC.Dispelga =
		set_combine(sets.precast.FC, {main = "Daybreak", sub = "Ammurapi Shield", waist = "Shinjutsu-no-Obi +1"})

	sets.precast.FC.BardSong =
		set_combine(
		sets.precast.FC,
		{
			--main="Kali",
			--range="Gjallarhorn",
			head = gear.empy_head, --14
			body = gear.af_body, --15
			feet = gear.relic_feet --9
		}
	)

	sets.precast.FC["Honor March"] = set_combine(sets.precast.FC.BardSong, {range = "Marsyas"})
	sets.precast.FC["Aria of Passion"] =
		set_combine(
		sets.precast.FC,
		{
			range = "Loughnashade"
		}
	)

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range = info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla

	-- Precast sets to enhance JAs

	sets.precast.JA.Nightingale = {feet = gear.relic_feet}
	sets.precast.JA.Troubadour = {body = gear.relic_body}
	sets.precast.JA["Soul Voice"] = {legs = gear.relic_legs}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		range = {name = "Linos", augments = {"Attack+20", "Weapon skill damage +3%", "STR+6 CHR+6"}},
		head = sets.Nyame.Head,
		body = {name = gear.relic_body, augments = {'Enhances "Troubadour" effect'}},
		hands = sets.Nyame.Hands,
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet,
		neck = {name = "Bard's Charm +2", augments = {"Path: A"}},
		waist = "Fotia Belt",
		ear1 = "Moonshade Earring",
		ear2 = "Ishvara Earring",
		ring1 = "Ilabrat Ring",
		ring2 = "Cornelia's Ring",
		back = gear.str_wsd_jse_back
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Evisceration"] =
		set_combine(
		sets.precast.WS,
		{
			head = {name = "Blistering Sallet +1", augments = {"Path: A"}},
			body = gear.relic_body,
			neck = "Fotia Gorget",
			ear1 = "Moonshade Earring",
			ear2 = "Mache Earring +1",
			ring1 = {name = "Cacoethic Ring +1", augments = {"Path: A"}},
			ring2 = "Ilabrat Ring",
			waist = "Fotia Belt",
			leg = "Zoar Subligar +1",
			back = gear.dex_wsd_jse_back
		}
	)

	sets.precast.WS["Mordant Rime"] =
		set_combine(
		sets.precast.WS,
		{
			body = sets.Nyame.Body,
			ear1 = "Regal Earring",
			ear2 = "Enchntr. Earring +1", -- Fili Earring +2
			waist = {name = "Sailfi Belt +1", augments = {"Path: A"}},
			ring1 = "Epaminondas's Ring",
			ring2 = {name = "Metamor. Ring +1", augments = {"Path: A"}},
			back = gear.chr_wsd_jse_back
		}
	)

	sets.precast.WS["Ruthless Stroke"] =
		set_combine(
		sets.precast.WS,
		{
			range = {name = "Linos", augments = {"Accuracy+15 Attack+15", "Weapon skill damage +3%", "DEX+8"}},
			body = sets.Nyame.Body,
			ear1 = "Moonshade Earring",
			ear2 = "Mache Earring +1",
			waist = {name = "Kentarch Belt +1", augments = {"Path: A"}},
			ring1 = "Epaminondas's Ring",
			ring2 = "Ilabrat Ring",
			back = gear.dex_wsd_jse_back
		}
	)

	sets.precast.WS["Rudra's Storm"] =
		set_combine(
		sets.precast.WS,
		{
			range = {name = "Linos", augments = {"Accuracy+15 Attack+15", "Weapon skill damage +3%", "DEX+8"}},
			waist = "Kentarch Belt +1",
			ring1 = "Ilabrat Ring",
			back = gear.dex_wsd_jse_back
		}
	)

	sets.precast.WS["Aeolian Edge"] =
		set_combine(
		sets.precast.WS,
		{
			body = sets.Nyame.Body,
			waist = "Orpheus's Sash",
			neck = "Sibyl Scarf",
			ear1 = "Moonshade Earring",
			ear2 = "Regal Earring",
			ring1 = "Epaminondas's Ring",
			ring2 = {name = "Metamor. Ring +1", augments = {"Path: A"}},
			back = gear.int_wsd_jse_back
		}
	)

	sets.precast.WS["Savage Blade"] =
		set_combine(
		sets.precast.WS,
		{
			body = sets.Nyame.Body,
			waist = "Sailfi Belt +1",
			ring1 = "Epaminondas's Ring",
			ring2 = "Sroda Ring"
		}
	)

	sets.precast.WS["Exenterator"] = set_combine(sets.precast.WS, {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	--sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring",}
	sets.AccMaxTP = {ear1 = "Mache Earring +1", ear2 = "Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = sets.precast.FC

	sets.midcast.SpellInterrupt = {
		ammo = "Staunch Tathlum +1", --11
		--body="Ros. Jaseran +1", --25
		hands = gear.Chironic_WSD_hands, --20
		--legs="Querkening Brais" --15
		neck = "Loricate Torque +1", --5
		ear1 = "Halasz Earring", --5
		ear2 = "Magnetic Earring", --8
		ring2 = "Evanescence Ring", --5
		waist = "Rumination Sash" --10
	}

	sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
		main = "Carnwenhan",
		sub = "Ammurapi Shield",
		range = "Loughnashade",
		ammo = empty,
		head = gear.empy_head,
		body = gear.empy_body,
		hands = gear.empy_hands,
		legs = "Inyanga Shalwar +2",
		feet = gear.af_feet,
		neck = "Mnbw. Whistle +1",
		waist = "Flume Belt +1",
		ear1 = {name = "Odnowa Earring +1", augments = {"Path: A"}},
		ear2 = "Genmei Earring",
		ring1 = "Defending Ring",
		ring2 = {name = "Gelatinous Ring +1", augments = {"Path: A"}},
		back = gear.tp_jse_back
	}

	sets.midcast.SongEffect.DW = {
		main = "Carnwenhan",
		sub = "Kali"
	} --Only weapons in this set. This set is overlayed onto SongEffect

	sets.midcast.SongDebuff = {
		head = gear.af_head,
		body = gear.empy_body,
		hands = gear.af_hands,
		legs = "Inyanga Shalwar +2",
		feet = gear.af_feet,
		neck = "Mnbw. Whistle +1",
		ear1 = "Regal Earring",
		ear2 = "Fili Earring +1",
		ring1 = "Metamor. Ring +1",
		ring2 = {name = "Stikini Ring +1", bag = "wardrobe2"},
		waist = "Null Belt",
		back = "Null Shawl"
	}

	sets.midcast.SongDebuff.DW = {} --Only weapons in this set. This set is overlayed onto SongDebuff

	sets.midcast.SongDebuff.DW.Duration = {
		main = "Carnwenhan",
		sub = "Kali"
	} --Only weapons in this set. This set is overlayed onto SongDebuff

	sets.midcast.SongDebuff.DW.Resistant = {
		main = "Carnwenhan",
		sub = "Kali"
	} --Only weapons in this set. This set is overlayed onto SongDebuff

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff.Duration =
		set_combine(
		sets.midcast.SongDebuff,
		{
			main = "Carnwenhan",
			sub = "Ammurapi Shield",
			range = "Gjallarhorn",
			ammo = empty
		}
	)

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant =
		set_combine(
		sets.midcast.SongDebuff,
		{
			main = "Daybreak",
			sub = "Ammurapi Shield",
			range = "Gjallarhorn",
			ammo = empty
		}
	)

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {
		--main=gear.grioavolr_fc_staff,
		--sub="Clerisy Strap +1",
		head = "Bunzi's Hat",
		neck = "Baetyl Pendant",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Loquac. Earring",
		body = "Inyanga Jubbah +2",
		hands = "Gendewitha Gages +1",
		ring1 = "Kishar Ring",
		ring2 = {name = "Gelatinous Ring +1", augments = {"Path: A"}},
		back = "Fi Follet Cape +1",
		waist = "Witful Belt",
		legs = gear.empy_legs,
		feet = gear.empy_feet
	}

	-- Cast spell with normal gear, except using Daurdabla instead
	sets.midcast.Daurdabla = {range = info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
	sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range = info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {
		main = "Daybreak", --30
		sub = "Ammurapi Shield",
		head = "Kaykaus Mitra +1",
		body = "Kaykaus Bliaut +1",
		hands = "Kaykaus Cuffs +1",
		legs = "Kaykaus Tights +1",
		feet = "Kaykaus Boots +1",
		neck = "Incanter's Torque",
		waist = "Luminary Sash",
		ear1 = "Mendi. Earring",
		ear2 = "Meili Earring",
		ring1 = {name = "Stikini Ring +1", bag = "wardrobe"},
		ring2 = {name = "Stikini Ring +1", bag = "wardrobe2"},
		back = "Solemnity Cape"
	}

	sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Healing = {
		--neck="Phalaina Locket",
		--hands="Buremte Gloves",
		ring2 = "Kunaji Ring",
		waist = "Gishdubar Sash"
	}
	sets.Cure_Received = {
		--neck="Phalaina Locket",
		--hands="Buremte Gloves",
		ring2 = "Kunaji Ring",
		waist = "Gishdubar Sash"
	}
	sets.Self_Refresh = {
		--back="Grapevine Cape",
		waist = "Gishdubar Sash"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast["Enhancing Magic"], {})

	sets.midcast["Elemental Magic"] = {}

	sets.midcast["Elemental Magic"].Resistant = {}

	sets.midcast.Cursna =
		set_combine(
		sets.midcast.StatusRemoval,
		{
			hands = "Hieros Mittens",
			neck = "Debilis Medallion",
			ear1 = "Beatific Earring",
			back = "Oretan. Cape +1"
		}
	)

	sets.midcast["Enhancing Magic"] = {
		main = "Carnwenhan",
		sub = "Ammurapi Shield",
		head = {name = "Telchine Cap", augments = {"Enh. Mag. eff. dur. +10"}},
		body = {name = "Telchine Chas.", augments = {"Enh. Mag. eff. dur. +9"}},
		hands = {name = "Telchine Gloves", augments = {"Enh. Mag. eff. dur. +9"}},
		legs = {name = "Telchine Braconi", augments = {"Enh. Mag. eff. dur. +10"}},
		feet = {name = "Telchine Pigaches", augments = {"Enh. Mag. eff. dur. +9"}},
		neck = "Incanter's Torque",
		ear1 = "Mimir Earring",
		ear2 = "Andoaa Earring",
		ring1 = {name = "Stikini Ring +1", bag = "wardrobe2"},
		ring2 = {name = "Stikini Ring +1", bag = "wardrobe3"},
		back = "Fi Follet Cape +1",
		waist = "Embla Sash"
	}

	sets.midcast.Regen = set_combine(sets.midcast["Enhancing Magic"], {head = "Inyanga Tiara +2"})
	sets.midcast.Haste = sets.midcast["Enhancing Magic"]
	sets.midcast.Refresh =
		set_combine(
		sets.midcast["Enhancing Magic"],
		{
			waist = "Gishdubar Sash",
			back = "Grapevine Cape"
		}
	)
	sets.midcast.Stoneskin = set_combine(sets.midcast["Enhancing Magic"], {neck = "Nodens Gorget", waist = "Siegel Sash"})
	sets.midcast.Aquaveil = set_combine(sets.midcast["Enhancing Magic"], {waist = "Emphatikos Rope"})
	sets.midcast.Protect = set_combine(sets.midcast["Enhancing Magic"], {ring2 = "Sheltered Ring"})
	sets.midcast.Protectra = sets.midcast.Protect
	sets.midcast.Shell = sets.midcast.Protect
	sets.midcast.Shellra = sets.midcast.Shell

	sets.midcast.StatusRemoval =
		set_combine(
		sets.midcast.FastRecast,
		{
			head = "Vanya Hood",
			body = "Vanya Robe",
			legs = "Aya. Cosciales +2",
			feet = "Vanya Clogs",
			neck = "Incanter's Torque",
			ear2 = "Meili Earring",
			ring1 = "Menelaus's Ring",
			ring2 = "Haoma's Ring",
			back = gear.BRD_Song_Cape,
			waist = "Bishop's Sash"
		}
	)

	sets.midcast["Enfeebling Magic"] = {
		main = "Carnwenhan",
		sub = "Ammurapi Shield",
		head = "C. Palug Crown",
		body = "Inyanga Jubbah +2",
		hands = "Inyan. Dastanas +2",
		legs = "Inyanga Shalwar +2",
		feet = gear.af_feet,
		neck = "Mnbw. Whistle +1",
		ear1 = "Digni. Earring",
		ear2 = "Vor Earring",
		ring1 = "Kishar Ring",
		ring2 = "Metamor. Ring +1",
		waist = "Acuity Belt +1",
		back = "Aurist's Cape +1"
	}

	sets.midcast.Dispelga =
		set_combine(
		sets.midcast["Enfeebling Magic"],
		{main = "Daybreak", sub = "Ammurapi Shield", waist = "Shinjutsu-no-Obi +1"}
	)

	-- Gear to enhance certain classes of songs
	sets.midcast.Lullaby = {}
	sets.midcast.Lullaby.Resistant = {range = "Gjallarhorn"}
	sets.midcast.Lullaby.Duration = set_combine(sets.midcast.Lullaby, {})
	sets.midcast.Ballad = {legs = gear.empy_legs}
	sets.midcast.Minne = {legs = "Mousai Seraweels +1"}
	sets.midcast.Carol = {hands = "Mousai Gages +1"}
	sets.midcast.Etude = {head = "Mousai Turban +1"}
	sets.midcast.Mambo = {feet = "Mousai Crackows +1"}
	sets.midcast.Threnody = {body = "Mousai Manteels +1"}

	sets.midcast["Horde Lullaby"] = {
		main = "Carnwenhan",
		sub = "Ammurapi Shield",
		range = "Daurdabla"
	}
	-- sets.midcast['Horde Lullaby'].Resistant = sets.midcast['Horde Lullaby']
	-- sets.midcast['Horde Lullaby'].Duration = sets.midcast['Horde Lullaby']
	sets.midcast["Horde Lullaby II"] = {
		main = "Carnwenhan",
		sub = "Ammurapi Shield",
		range = "Daurdabla",
		-- range = "Blurred Harp +1",
		hands = "Inyan. Dastanas +2",
		feet = gear.relic_feet,
		ear1 = "Gersemi Earring"
	}
	sets.midcast.Madrigal = {head = gear.empy_head}
	sets.midcast.Mambo = {feet = "Mou. Crackows +1"}
	sets.midcast.March = {hands = gear.empy_hands}
	sets.midcast["Honor March"] = set_combine(sets.midcast.March, {range = "Marsyas"})
	sets.midcast["Aria of Passion"] = {
		range = "Loughnashade"
	}
	sets.midcast.Minne = {legs = "Mou. Seraweels +1"}
	sets.midcast.Minuet = {body = gear.empy_body}
	sets.midcast.Prelude = {feet = gear.empy_feet}
	sets.midcast.Threnody = {body = "Mou. Manteel +1"}
	sets.midcast["Adventurer's Dirge"] = {range = "Marsyas", hands = gear.relic_hands}
	sets.midcast["Foe Sirvente"] = {head = gear.relic_head}
	sets.midcast["Magic Finale"] = {legs = gear.empy_legs}
	sets.midcast["Sentinel's Scherzo"] = {feet = gear.empy_feet}
	sets.midcast["Chocobo Mazurka"] = {range = "Marsyas"}

	sets.midcast["Army's Paeon"] = sets.midcast.DaurdablaDummy
	sets.midcast["Army's Paeon II"] = sets.midcast.DaurdablaDummy
	sets.midcast["Army's Paeon III"] = sets.midcast.DaurdablaDummy
	sets.midcast["Scop's Operetta"] = sets.midcast.DaurdablaDummy
	sets.midcast["Goblin Gavotte"] = sets.midcast.DaurdablaDummy
	sets.midcast["Sheepfoe Mambo"] = sets.midcast.DaurdablaDummy
	------

	-- Resting sets
	sets.resting = {
		--main="Chatoyant Staff",
		--sub="Umbra Strap",
		ammo = "Staunch Tathlum +1",
		--head=empty,
		--neck="Loricate Torque +1",
		--ear1="Etiolation Earring",
		--ear2="Ethereal Earring",
		--body="Respite Cloak",
		--hands=gear.chironic_refresh_hands,
		--ring1="Defending Ring",
		--ring2="Dark Ring",
		--back="Umbra Cape",
		waist = "Flume Belt +1"
		--legs="Assid. Pants +1",
		--feet=gear.chironic_refresh_feet
	}

	sets.idle = {
		range = "Loughnashade",
		head = "Null Masque",
		body = "Adamantite Armor",
		hands = sets.Nyame.Hands,
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet,
		neck = "Warder's Charm +1",
		waist = "Null Belt",
		ear1 = "Eabani Earring",
		ear2 = "Etiolation Earring",
		ring1 = "Karieyh Ring",
		ring2 = "Fortified Ring",
		back = "Null Shawl"
	}

	sets.idle.Refresh =
		set_combine(
		sets.idle,
		{
			head = gear.empy_head,
			body = "Ashera Harness",
			hands = gear.empy_hands,
			legs = gear.af_legs,
			feet = gear.empy_feet,
			neck = "Warder's Charm +1",
			waist = "Plat. Mog. Belt",
			ear1 = "Eabani Earring",
			ear2 = "Etiolation Earring",
			ring1 = "Defending Ring",
			ring2 = "Stikini Ring +1",
			back = gear.tp_jse_back
		}
	)

	sets.idle.NoRefresh = {
		main = "Daybreak",
		sub = "Genmei Shield",
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Sanare Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Defending Ring",
		ring2 = "Shadow Ring",
		back = gear.idle_jse_back,
		waist = "Carrier's Sash",
		legs = "Nyame Flanchard",
		feet = gear.empy_feet
	}

	sets.idle.PDT = {
		main = "Daybreak",
		sub = "Genmei Shield",
		ammo = "Staunch Tathlum +1",
		head = "Null Masque",
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Sanare Earring",
		body = "Adamantite Armor",
		hands = "Nyame Gauntlets",
		ring1 = "Defending Ring",
		ring2 = "Shadow Ring",
		back = gear.idle_jse_back,
		waist = "Carrier's Sash",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}

	-- Defense sets
	sets.enmity =
		set_combine(
		sets.idle,
		{
			main = "Mafic Cudgel",
			sub = "Genmei Shield",
			ammo = "Sapience Orb",
			head = "Halitus Helm",
			neck = "Unmoving Collar +1",
			ear1 = "Trux Earring",
			ear2 = "Cryptic Earring",
			body = "Emet Harness +1",
			ring1 = "Supershear Ring",
			ring2 = "Pernicious Ring",
			back = "Reiki Cloak",
			waist = "Trance Belt",
			legs = "Zoar Subligar +1"
		}
	)
	sets.midcast["Foe Requiem"] = sets.enmity
	sets.midcast["Foe Requiem II"] = sets.enmity
	sets.midcast["Foe Requiem III"] = sets.enmity

	sets.defense.PDT = {
		main = "Terra's Staff",
		sub = "Umbra Strap",
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Sanare Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Defending Ring",
		ring2 = "Shadow Ring",
		back = "Moonlight Cape",
		waist = "Carrier's Sash",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}

	sets.defense.MDT = {
		main = "Terra's Staff",
		sub = "Umbra Strap",
		ammo = "Staunch Tathlum +1",
		head = "Nyame Helm",
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Sanare Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Defending Ring",
		ring2 = "Shadow Ring",
		back = "Moonlight Cape",
		waist = "Carrier's Sash",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}

	sets.Kiting = {feet = gear.empy_feet}
	sets.latent_refresh = {
		waist = "Fucho-no-obi"
	}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	sets.engaged = {
		range = {name = "Linos", augments = {"Accuracy+15 Attack+15", '"Store TP"+4', "Quadruple Attack +3"}},
		head = "Bunzi's Hat",
		body = "Ashera Harness",
		hands = "Bunzi's Gloves",
		legs = "Volte Tights",
		feet = {name = "Nyame Sollerets", augments = {"Path: B"}},
		neck = {name = "Bard's Charm +2", augments = {"Path: A"}},
		waist = {name = "Sailfi Belt +1", augments = {"Path: A"}},
		ear1 = "Telos Earring",
		ear2 = "Cessance Earring",
		ring1 = "Chirich Ring +1",
		ring2 = "Lehko's Ring",
		back = gear.tp_jse_back
	}

	sets.engaged.DT =
		set_combine(
		sets.engaged,
		{
			ring1 = "Moonlight Ring",
			feet = {name = "Nyame Sollerets", augments = {"Path: B"}}
		}
	)

	-- 1383 eva, 1530 def
	-- Current best set: PDT:-35,  MDT:-50
	-- 	  main  Naegling
	--     sub  Crepuscular Knife
	--  ranged  Linos STP QA
	--    ammo  Empty
	--    head  Blistering Sallet +1 R15
	--    body  Ashera Harness
	--   hands  Bunzi's Gloves R0
	--    legs  Volte Tights
	--    feet  Volte Spats
	--    neck  Bard's Charm +2 R25
	--   waist  Reiki Yotai
	--    ear1  Brutal Earring
	--    ear2  Dedition Earring
	--   ring1  Moonlight Ring A
	--   ring2  Moonlight Ring B
	--    back  Intarabus's Cape DEX Dual Wield
	sets.engaged.Acc =
		set_combine(
		sets.engaged,
		{
			head = "Blistering Sallet +1",
			hands = "Gazu Bracelets +1",
			ear1 = "Telos Earring",
			ear2 = "Digni. Earring"
		}
	)
	sets.engaged.DW =
		set_combine(
		sets.engaged,
		{
			ear1 = "Eabani Earring",
			waist = "Reiki Yotai"
		}
	)
	-- sets.engaged.DW.DT = set_combine(sets.engaged.DW)
	sets.engaged.DW.Acc =
		set_combine(
		sets.engaged.DW,
		{
			head = "Blistering Sallet +1",
			hands = "Gazu Bracelets +1",
			ear2 = "Eabani Earring",
			waist = "Reiki Yotai"
		}
	)
	-- sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW)

	sets.buff.Doom = {
		neck = "Nicander's Necklace", --20
		ring1 = {name = "Eshmun's Ring", bag = "wardrobe3"}, --20
		ring2 = {name = "Eshmun's Ring", bag = "wardrobe4"}, --20
		waist = "Gishdubar Sash" --10
	}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 2)
end

autows_list = {
	["Naegling"] = "Savage Blade",
	["Aeneas"] = "Rudra's Storm",
	["DualWeapons"] = "Rudra's Storm",
	["DualNaegling"] = "Savage Blade",
	["DualNaeglingAcc"] = "Savage Blade",
	["DualTauret"] = "Evisceration",
	["DualAeolian"] = "Aeolian Edge"
}

function user_job_lockstyle()
	windower.chat.input("/lockstyleset 006")
end
