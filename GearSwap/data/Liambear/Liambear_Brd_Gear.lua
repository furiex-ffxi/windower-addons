function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Acc')
	state.HybridMode:options('Normal', 'DT')
	state.CastingMode:options('Normal', 'Resistant', 'AoE')
	state.IdleMode:options('Normal', 'NoRefresh', 'DT')
	state.Weapons:options('None', 'Naegling', 'Aeneas', 'DualWeapons', 'DualNaegling', 'DualTauret', 'DualAeolian')
	-- Whether to use Carn (or song daggers in general) under a certain threshhold even when weapons are locked.
	state.CarnMode = M { 'Always', '300', '1000', 'Never' }

	gear.melee_jse_back = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.melee_ws_str_back = { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.melee_ws_dex_back = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	gear.magic_jse_back = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}


	-- Adjust this if using the Terpander (new +song instrument)
	info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
	info.ExtraSongs = 2

	-- Set this to false if you don't want to use custom timers.
	state.UseCustomTimers = M(false, 'Use Custom Timers')

	-- Additional local binds
	send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !r gs c weapons None;gs c update')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')
	send_command('bind !f7 gs c cycle CarnMode')

	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Aeneas = { main = "Aeneas", sub = "Genmei Shield" }
	sets.weapons.DualWeapons = { main = "Aeneas", sub = "Blurred Knife +1" }
	sets.weapons.DualNaegling = { main = "Naegling", sub = "Blurred Knife +1" }
	sets.weapons.Naegling = { main = "Naegling", sub = "Genmei Shield" }
	sets.weapons.DualTauret = { main = "Tauret", sub = "Blurred Knife +1" }
	sets.weapons.DualAeolian = { main = "Tauret", sub = "Malevolence" }

	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }

	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
        main="Kali", --7
		ammo = "Impatiens",
		head = "Bunzi's Hat",
        neck={ name="Bard's Charm +2", augments={'Path: A',}},
        ear1="Loquac. Earring",
        ear2="Etiolation Earring",
        body="Brioso Justau. +3",
        hands="Fili Manchettes +1",
		ring1="Weather. Ring",
        ring2="Kishar Ring",
		back = gear.magic_jse_back,
		waist = "Witful Belt",
        legs="Doyen Pants",
        feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
	}

	sets.precast.FC.DT = {
		main = gear.grioavolr_fc_staff,
		sub = "Clerisy Strap +1",
		ammo = "Impatiens",
		head = "Bunzi's Hat",
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Loquac. Earring",
		body = "Inyanga Jubbah +2",
		hands = "Leyline Gloves",
		ring1 = "Kishar Ring",
		ring2 = "Lebeche Ring",
		back = gear.magic_jse_back,
		waist = "Witful Belt",
		legs = "Aya. Cosciales +2",
		feet = "Bihu Slippers +1"
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, { feet = "Vanya Clogs" })

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Genmei Shield" })

	sets.precast.FC.BardSong =  set_combine(sets.precast.FC, {
        head="Fili Calot +1", --14
        body="Brioso Justau. +3", --15
        feet="Bihu Slippers +3", --9
	})

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong, { range = "Marsyas" })
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong, { range = "Gjallarhorn" })
	sets.precast.FC.Lullaby = { range = "Marsyas" }
	sets.precast.FC.Lullaby.Resistant = { range = "Gjallarhorn" }
	sets.precast.FC['Horde Lullaby'] = { range = "Marsyas" }
	sets.precast.FC['Horde Lullaby'].Resistant = { range = "Gjallarhorn" }
	sets.precast.FC['Horde Lullaby'].AoE = { range = "Gjallarhorn" }
	sets.precast.FC['Horde Lullaby II'] = { range = "Marsyas" }
	sets.precast.FC['Horde Lullaby II'].Resistant = { range = "Gjallarhorn" }
	sets.precast.FC['Horde Lullaby II'].AoE = { range = "Gjallarhorn" }

	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong, { range = "Marsyas" })
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong, { range = "Marsyas" })

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, { range = info.ExtraSongInstrument })
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla

	-- Precast sets to enhance JAs

	sets.precast.JA.Nightingale = { feet = "Bihu Slippers +1" }
	sets.precast.JA.Troubadour = { body = "Bihu Jstcorps +1" }
	sets.precast.JA['Soul Voice'] = { legs = "Bihu Cannions +1" }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range=gear.Linos_WS,
        head=gear.Chironic_WSD_head,
        body="Bihu Jstcorps. +3",
        hands=gear.Chironic_WSD_hands,
        legs="Bihu Cannions +3",
        feet="Bihu Slippers +3",
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back=gear.melee_ws_str_back,
        waist="Fotia Belt",
        }

	sets.precast.WS.Acc = {
		ammo = "Aurgelmir Orb +1",
		head = "Aya. Zucchetto +2",
		neck = "Combatant's Torque",
		ear1 = "Moonshade Earring",
		ear2 = "Mache Earring +1",
		body = "Ayanmo Corazza +2",
		hands = "Aya. Manopolas +2",
		ring1 = "Ramuh Ring +1",
		ring2 = "Ilabrat Ring",
		back = gear.melee_ws_str_back,
		waist = "Olseni Belt",
		legs = "Aya. Cosciales +2",
		feet = "Aya. Gambieras +2"
	}

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        head=empty;
        body="Cohort Cloak +1",
        legs="Kaykaus Tights +1",
        feet="Volte Gaiters",
        neck="Baetyl Pendant",
        ring2="Shiva Ring +1",
        ear1="Friomisi Earring",
        back="Argocham. Mantle",
        waist="Orpheus's Sash",
        })

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        range={ name="Linos", augments={'Accuracy+12 Attack+12','Weapon skill damage +2%','DEX+8',}},
		ammo=empty,
		head="Lustratio Cap +1",
		body="Bihu Jstcorps. +3",
		hands="Lustr. Mittens +1",
		legs="Lustr. Subligar +1",
		feet="Lustra. Leggings +1",
		neck="Bard's Charm +2",
		waist="Kentarch Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Chirich Ring +1",
		right_ring="Ilabrat Ring",
        })

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		range=gear.Linos_TP,
		head="Blistering Sallet +1",
		body="Ayanmo Corazza +2",
		hands="Bihu Cuffs +3",
		legs="Zoar Subligar +1",
		feet="Lustra. Leggings +1",
		ear1="Brutal Earring",
		ring1="Begrudging Ring",
		back=gear.melee_ws_dex_back,
		})

	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		range=gear.Linos_TP,
		head="Bihu Roundlet +3",
		body="Bihu Jstcorps. +3",
		hands="Bihu Cuffs +3",
		ear1="Brutal Earring",
		ring1="Shukuyu Ring",
		back=gear.melee_ws_dex_back,
		})

	sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
		neck="Bard's Charm +2",
		ear2="Regal Earring",
		ring2="Metamor. Ring +1",
		waist="Grunfeld Rope",
		})

	sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
        range={ name="Linos", augments={'Accuracy+12 Attack+12','Weapon skill damage +2%','DEX+8',}},
		ammo=empty,
		head="Lustratio Cap +1",
		body="Bihu Jstcorps. +3",
		hands="Lustr. Mittens +1",
		legs="Lustr. Subligar +1",
		feet="Lustra. Leggings +1",
		neck="Bard's Charm +2",
		waist="Kentarch Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Chirich Ring +1",
		right_ring="Ilabrat Ring",
		back=gear.melee_ws_dex_back,
	})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = { ear1 = "Ishvara Earring", ear2 = "Telos Earring", }
	sets.AccMaxTP = { ear1 = "Mache Earring +1", ear2 = "Telos Earring" }

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {
		main = gear.grioavolr_fc_staff,
		sub = "Clerisy Strap +1",
		ammo = "Hasty Pinion +1",
		head = "Bunzi's Hat",
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Loquac. Earring",
		body = "Inyanga Jubbah +2",
		hands = "Leyline Gloves",
		ring1 = "Kishar Ring",
		ring2 = "Lebeche Ring",
		back = gear.magic_jse_back,
		waist = "Witful Belt",
		legs = "Aya. Cosciales +2",
		feet = "Bihu Slippers +1"
	}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = { legs = "Fili Rhingrave +1" }
	sets.midcast.Lullaby = { range = "Marsyas" }
	sets.midcast.Lullaby.Resistant = { range = "Gjallarhorn" }
	sets.midcast['Horde Lullaby'] = { range = "Marsyas" }
	sets.midcast['Horde Lullaby'].Resistant = { range = "Gjallarhorn" }
	sets.midcast['Horde Lullaby'].AoE = { range = "Gjallarhorn" }
	sets.midcast['Horde Lullaby II'] = { range = "Marsyas" }
	sets.midcast['Horde Lullaby II'].Resistant = { range = "Gjallarhorn" }
	sets.midcast['Horde Lullaby II'].AoE = { range = "Gjallarhorn" }
	sets.midcast["Goddess's Hymnus"] = { range = info.ExtraSongInstrument }
	sets.midcast["Scop's Operetta"] = { range = info.ExtraSongInstrument }
	sets.midcast["Sheepfoe Mambo"] = { range = info.ExtraSongInstrument }
	sets.midcast["Goblin Gavotte"] = { range = info.ExtraSongInstrument }
	sets.midcast.Madrigal = { head = "Fili Calot +1" }
	sets.midcast.Paeon = { range = info.ExtraSongInstrument }
	sets.midcast.March = { hands = "Fili Manchettes +1" }
	sets.midcast['Honor March'] = set_combine(sets.midcast.March, { range = "Marsyas" })
	sets.midcast.Minuet = { body = "Fili Hongreline +1" }
	sets.midcast.Minne = {}
	sets.midcast.Carol = {}
	sets.midcast["Sentinel's Scherzo"] = { feet = "Fili Cothurnes +1" }
	sets.midcast['Magic Finale'] = { range = "Gjallarhorn" }
	sets.midcast.Mazurka = { range = "Marsyas" }

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
		main = "Kali",
		sub = "Genmei Shield",
		range = "Gjallarhorn",
		ammo = empty,
		head = "Fili Calot +1",
		neck = "Mnbw. Whistle +1",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Loquac. Earring",
		body = "Fili Hongreline +1",
		hands = "Fili Manchettes +1",
		ring1 = "Stikini Ring",
		ring2 = "Stikini Ring",
		back = gear.magic_jse_back,
		waist = "Kobo Obi",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
	}

	sets.midcast.SongEffect.DW = { main = "Kali", sub = "Kali" } --Only weapons in this set. This set is overlayed onto  SongEffect

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {
		main = "Kali",
		sub = "Ammurapi Shield",
		range = "Marsyas",
		ammo = empty,
		head = "Inyanga Tiara +2",
		neck = "Mnbw. Whistle +1",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = "Fili Hongreline +1",
		hands = "Inyan. Dastanas +2",
		ring1 = "Metamorph Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.magic_jse_back,
		waist = "Acuity Belt +1",
		legs = "Inyanga Shalwar +2",
		feet = "Brioso Slippers +2"
	}

	sets.midcast.SongDebuff.DW = { main = "Kali", sub = "Kali" } --Only weapons in this set. This set is overlayed onto  SongDebuff

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		range = "Gjallarhorn",
		ammo = empty,
		head = "Inyanga Tiara +2",
		neck = "Mnbw. Whistle +1",
		ear1 = "Regal Earring",
		ear2 = "Digni. Earring",
		body = "Inyanga Jubbah +2",
		hands = "Inyan. Dastanas +2",
		ring1 = "Metamorph Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.magic_jse_back,
		waist = "Acuity Belt +1",
		legs = "Inyanga Shalwar +2",
		feet = "Aya. Gambieras +2"
	}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {
		main = gear.grioavolr_fc_staff,
		sub = "Clerisy Strap +1",
		range = "Gjallarhorn",
		ammo = empty,
		head = "Bunzi's Hat",
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Loquac. Earring",
		body = "Inyanga Jubbah +2",
		hands = "Gendewitha Gages +1",
		ring1 = "Kishar Ring",
		ring2 = "Prolix Ring",
		back = gear.magic_jse_back,
		waist = "Witful Belt",
		legs = "Fili Rhingrave +1",
		feet = "Aya. Gambieras +2"
	}

	-- Cast spell with normal gear, except using Daurdabla instead
	sets.midcast.Daurdabla = { range = info.ExtraSongInstrument }

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
	sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, { range = info.ExtraSongInstrument })

	-- Other general spells and classes.
	sets.midcast.Cure = {
		main = "Serenity",
		sub = "Curatio Grip",
		ammo = "Pemphredo Tathlum",
		head = "Gende. Caubeen +1",
		neck = "Incanter's Torque",
		ear1 = "Gifted Earring",
		ear2 = "Mendi. Earring",
		body = "Kaykaus Bliaut",
		hands = "Kaykaus Cuffs",
		ring1 = "Janniston Ring",
		ring2 = "Menelaus's Ring",
		back = "Tempered Cape +1",
		waist = "Luminary Sash",
		legs = "Carmine Cuisses +1",
		feet = "Kaykaus Boots"
	}

	sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Healing = { neck = "Phalaina Locket", hands = "Buremte Gloves", ring2 = "Kunaji Ring",
		waist = "Gishdubar Sash" }
	sets.Cure_Received = { neck = "Phalaina Locket", hands = "Buremte Gloves", ring2 = "Kunaji Ring",
		waist = "Gishdubar Sash" }
	sets.Self_Refresh = { back = "Grapevine Cape", waist = "Gishdubar Sash" }

	sets.midcast['Enhancing Magic'] = {
		main = "Serenity",
		sub = "Fulcio Grip",
		ammo = "Hasty Pinion +1",
		head = "Telchine Cap",
		neck = "Voltsurge Torque",
		ear1 = "Andoaa Earring",
		ear2 = "Gifted Earring",
		body = "Telchine Chas.",
		hands = "Telchine Gloves",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.magic_jse_back,
		waist = "Embla Sash",
		legs = "Telchine Braconi",
		feet = "Telchine Pigaches"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],
	{ neck = "Nodens Gorget", ear2 = "Earthcry Earring", waist = "Siegel Sash", legs = "Shedir Seraweels" })

	sets.midcast['Elemental Magic'] = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = "C. Palug Crown",
		neck = "Sanctity Necklace",
		ear1 = "Friomisi Earring",
		ear2 = "Crematio Earring",
		body = "Chironic Doublet",
		hands = "Volte Gloves",
		ring1 = "Shiva Ring +1",
		ring2 = "Shiva Ring +1",
		back = "Toro Cape",
		waist = "Sekhmet Corset",
		legs = "Gyve Trousers",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast['Elemental Magic'].Resistant = {
		main = "Daybreak",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = "C. Palug Crown",
		neck = "Sanctity Necklace",
		ear1 = "Friomisi Earring",
		ear2 = "Crematio Earring",
		body = "Chironic Doublet",
		hands = "Volte Gloves",
		ring1 = "Shiva Ring +1",
		ring2 = "Shiva Ring +1",
		back = "Toro Cape",
		waist = "Yamabuki-no-Obi",
		legs = "Gyve Trousers",
		feet = gear.chironic_nuke_feet
	}

	sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
		neck = "Debilis Medallion",
		hands = "Hieros Mittens",
		back = "Oretan. Cape +1",
		ring1 = "Haoma's Ring",
		ring2 = "Menelaus's Ring",
		waist = "Witful Belt",
		feet = "Vanya Clogs"
	})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, { main = gear.grioavolr_fc_staff,
		sub = "Clemency Grip" })

	-- Resting sets
	sets.resting = {
		main = "Chatoyant Staff",
		sub = "Umbra Strap",
		ammo = "Staunch Tathlum +1",
		-- head = empty,
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = "Respite Cloak",
		hands = gear.chironic_refresh_hands,
		ring1 = "Defending Ring",
		ring2 = "Dark Ring",
		back = "Umbra Cape",
		waist = "Flume Belt +1",
		legs = "Assid. Pants +1",
		feet = gear.chironic_refresh_feet
	}

	sets.idle = {
		main = "Mpaca's Staff",
		sub = "Umbra Strap",
		ammo = "Staunch Tathlum +1",
		-- head = empty,
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = "Respite Cloak",
		hands = gear.chironic_refresh_hands,
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Umbra Cape",
		waist = "Flume Belt +1",
		legs = "Assid. Pants +1",
		feet = gear.chironic_refresh_feet
	}

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
		back = "Moonlight Cape",
		waist = "Carrier's Sash",
		legs = "Nyame Flanchard",
		feet = "Fili Cothurnes +1"
	}

	sets.idle.DT = {
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
		back = "Moonlight Cape",
		waist = "Carrier's Sash",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}

	-- Defense sets

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

	sets.Kiting = { feet = "Fili Cothurnes +1" }
	sets.latent_refresh = { waist = "Fucho-no-obi" }
	sets.latent_refresh_grip = { sub = "Oneiros Grip" }
	sets.TPEat = { neck = "Chrys. Torque" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	sets.engaged = {
		main = "Aeneas",
		sub = "Genmei Shield",
		ammo = "Aurgelmir Orb +1",
		head = "Aya. Zucchetto +2",
		neck = "Asperity Necklace",
		ear1 = "Cessance Earring",
		ear2 = "Brutal Earring",
		body = "Ayanmo Corazza +2",
		hands = "Aya. Manopolas +2",
		ring1 = "Petrov Ring",
		ring2 = "Ilabrat Ring",
		back = gear.melee_jse_back,
		waist = "Windbuffet Belt +1",
		legs = "Aya. Cosciales +2",
		feet = "Battlecast Gaiters"
	}
	sets.engaged.DT = {
		main = "Aeneas",
		sub = "Genmei Shield",
		ammo = "Aurgelmir Orb +1",
		head = "Nyame Helm",
		neck = "Loricate Torque +1",
		ear1 = "Cessance Earring",
		ear2 = "Brutal Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Petrov Ring",
		ring2 = "Ilabrat Ring",
		back = gear.melee_jse_back,
		waist = "Windbuffet Belt +1",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}
	sets.engaged.Acc = {
		main = "Aeneas",
		sub = "Genmei Shield",
		ammo = "Aurgelmir Orb +1",
		head = "Aya. Zucchetto +2",
		neck = "Combatant's Torque",
		ear1 = "Digni. Earring",
		ear2 = "Telos Earring",
		body = "Ayanmo Corazza +2",
		hands = "Aya. Manopolas +2",
		ring1 = "Ramuh Ring +1",
		ring2 = "Ilabrat Ring",
		back = gear.melee_jse_back,
		waist = "Olseni Belt",
		legs = "Aya. Cosciales +2",
		feet = "Aya. Gambieras +2"
	}
	sets.engaged.DW = {
		main="Aeneas",
		sub="Fusetto +2",
        range={ name="Linos", augments={'Accuracy+14 Attack+14','"Dbl.Atk."+3','Quadruple Attack +3',}},
		ammo=empty,
		head="Aya. Zucchetto +2",
		body="Ashera Harness",
		hands="Bunzi's Gloves",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Bard's Charm +2",
		waist="Reiki Yotai",
		left_ear="Digni. Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},

	}
	sets.engaged.DW.DT = {
		main = "Aeneas",
		sub = "Blurred Knife +1",
		ammo = "Aurgelmir Orb +1",
		head = "Nyame Helm",
		neck = "Loricate Torque +1",
		ear1 = "Suppanomimi",
		ear2 = "Brutal Earring",
		body = "Nyame Mail",
		hands = "Nyame Gauntlets",
		ring1 = "Petrov Ring",
		ring2 = "Ilabrat Ring",
		back = gear.melee_jse_back,
		waist = "Reiki Yotai",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}
	sets.engaged.DW.Acc = {
		main="Aeneas",
		sub="Fusetto +2",
        range={ name="Linos", augments={'Accuracy+14 Attack+14','"Dbl.Atk."+3','Quadruple Attack +3',}},
		ammo=empty,
		head="Aya. Zucchetto +2",
		body="Ashera Harness",
		hands="Bunzi's Gloves",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Bard's Charm +2",
		waist="Reiki Yotai",
		left_ear="Digni. Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring +1",
		right_ring="Chirich Ring +1",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	sets.engaged.DW.Acc.DT = {
		main = "Aeneas",
		sub = "Blurred Knife +1",
		ammo = "Aurgelmir Orb +1",
		head = "Nyame Helm",
		neck = "Combatant's Torque",
		ear1 = "Suppanomimi",
		ear2 = "Telos Earring",
		body = "Ayanmo Corazza +2",
		hands = "Nyame Gauntlets",
		ring1 = "Defending Ring",
		ring2 = "Ilabrat Ring",
		back = gear.melee_jse_back,
		waist = "Reiki Yotai",
		legs = "Nyame Flanchard",
		feet = "Nyame Sollerets"
	}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 1)
end

state.Weapons:options('None', 'Naegling', 'Aeneas', 'DualWeapons', 'DualNaegling', 'DualTauret', 'DualAeolian')

autows_list = {
	['Naegling'] = 'Savage Blade',
	['Aeneas'] = "Rudra's Storm",
	['DualWeapons'] = "Rudra's Storm",
	['DualNaegling'] = 'Savage Blade',
	['DualTauret'] = 'Evisceration',
	['DualAeolian'] = 'Aeolian Edge'
}
