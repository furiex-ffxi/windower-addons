function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Acc')
	state.HybridMode:options('Normal', 'DT')
	state.CastingMode:options('Normal', 'Resistant', 'AoE')
	state.IdleMode:options('Normal', 'NoRefresh', 'DT')
	state.Weapons:options('None', 'Naegling', 'Aeneas', 'Daybreak', 'DualWeapons', 'DualNaegling', 'DualTauret', 'DualAeolian')
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
	sets.weapons.DualWeapons = { main = "Aeneas", sub = "Fusetto +2" }
	sets.weapons.DualNaegling = { main = "Naegling", sub = "Fusetto +2" }
	sets.weapons.Naegling = { main = "Naegling", sub = "Genmei Shield" }
	sets.weapons.DualTauret = { main = "Tauret", sub = "Blurred Knife +1" }
	sets.weapons.DualAeolian = { main = "Tauret", sub = "Malevolence" }
	sets.weapons.Daybreak = { main = "Daybreak", sub = "Ammurapi Shield" }

	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }

	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
        main="Kali", --7
        head="Bunzi's Hat",
        body="Brioso Justau. +3",
        hands="Fili Manchettes +3",
        legs="Doyen Pants",
        feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
        neck={ name="Bard's Charm +2", augments={'Path: A',}},
        waist="Siegel Sash",
        left_ear="Loquac. Earring",
        right_ear="Etiolation Earring",
        left_ring="Weather. Ring",
        right_ring="Kishar Ring",
        back=gear.magic_jse_back, --10
        -- head="Volte Beret", --6
        -- body="Inyanga Jubbah +2", --14
        -- hands="Gende. Gages +1", --7
        -- legs="Volte Brais", --8
        -- feet="Volte Gaiters", --6
        -- neck="Orunmila's Torque", --5
        -- ear1="Loquac. Earring", --2
        -- ear2="Etiolation Earring", --1
        -- ring1="Weather. Ring +1", --5
        -- ring2="Kishar Ring", --4
        -- back=gear.BRD_Song_Cape, --10
        -- waist="Embla Sash", --5
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
		feet = { name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}}
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, { 
		feet="Kaykaus Boots +1", --0/7
        ear2="Mendi. Earring", --0/5
	})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { 
		main = "Daybreak", 
		sub = "Genmei Shield"
	 })

	sets.precast.FC.BardSong =  set_combine(sets.precast.FC, {
        head="Fili Calot +2", --14
        body="Brioso Justau. +3", --15
        feet="Bihu Slippers +3", --9
        neck="Loricate Torque +1",
        ear1="Odnowa Earring +1",
        ring2="Defending Ring",
	})
    
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
		main="Daybreak", 
		sub="Ammurapi Shield", 
		waist="Shinjutsu-no-Obi +1"
		}
	)
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

	sets.precast.JA.Nightingale = { feet = { name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}} }
	sets.precast.JA.Troubadour = { body = "Bihu Jstcorps +3" }
	sets.precast.JA['Soul Voice'] = { legs = "Bihu Cannions +3" }

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
        feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
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
		back = gear.melee_ws_str_back,
        })

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		range=gear.Linos_TP,
		head="Blistering Sallet +1",
		body="Ayanmo Corazza +2",
		hands="Bihu Cuffs",
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
		hands="Bihu Cuffs",
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
	sets.midcast.FastRecast = sets.precast.FC
	
    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        --body="Ros. Jaseran +1", --25
        hands=gear.Chironic_WSD_hands, --20
        --legs="Querkening Brais" --15
        neck="Loricate Torque +1", --5
        ear1="Halasz Earring", --5
        ear2="Magnetic Earring", --8
        ring2="Evanescence Ring", --5
        waist="Rumination Sash", --10
        }

	sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = { legs = "Fili Rhingrave +1" }
	sets.midcast.Carol = {hands="Mousai Gages +1"}
	sets.midcast.Etude = {head="Mousai Turban +1"}
	sets.midcast.Lullaby = { range = "Marsyas", hands="Brioso Cuffs +3" }
	sets.midcast.Lullaby.Resistant = { range = "Gjallarhorn", hands="Brioso Cuffs +3" }
	sets.midcast.Madrigal = { head = "Fili Calot +2" }
	sets.midcast.Mambo = {feet="Mou. Crackows +1"}
	sets.midcast.March = { hands = "Fili Manchettes +3" }
	sets.midcast.Mazurka = { range = "Marsyas" }
	sets.midcast.Minne = {legs="Mou. Seraweels +1"}
	sets.midcast.Minuet = { body = "Fili Hongreline +3" }
	sets.midcast.Paeon = { range = info.ExtraSongInstrument }
	sets.midcast.Threnody = {body="Mou. Manteel +1"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March, { range = "Marsyas" })
	sets.midcast['Horde Lullaby II'] = { range = "Marsyas", hands="Brioso Cuffs +3" }
	sets.midcast['Horde Lullaby II'].AoE = { range = "Daurdabla", hands="Brioso Cuffs +3" }
	sets.midcast['Horde Lullaby II'].Resistant = { range = "Gjallarhorn", hands="Brioso Cuffs +3" }
	sets.midcast['Horde Lullaby'] = { range = "Marsyas", hands="Brioso Cuffs +3" }
	sets.midcast['Horde Lullaby'].AoE = { range = "Daurdabla", hands="Brioso Cuffs +3" }
	sets.midcast['Horde Lullaby'].Resistant = { range = "Gjallarhorn", hands="Brioso Cuffs +3" }
	sets.midcast['Magic Finale'] = { range = "Gjallarhorn" }
	sets.midcast["Goblin Gavotte"] = { range = info.ExtraSongInstrument }
	sets.midcast["Goddess's Hymnus"] = { range = info.ExtraSongInstrument }
	sets.midcast["Scop's Operetta"] = { range = info.ExtraSongInstrument }
	sets.midcast["Sentinel's Scherzo"] = { feet = "Fili Cothurnes +2" }
	sets.midcast["Sheepfoe Mambo"] = { range = info.ExtraSongInstrument }

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
        main="Carnwenhan",
        range="Gjallarhorn",
        head="Fili Calot +2",
        body="Fili Hongreline +3",
        hands="Fili Manchettes +3",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        ear1="Odnowa Earring +1",
        ear2="Etiolation Earring",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        waist="Flume Belt +1",
		back = gear.magic_jse_back,
	}

	sets.midcast.SongEffect.DW = { 
		main = "Kali", 
		sub = "Kali" 
	} --Only weapons in this set. This set is overlayed onto  SongEffect

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head="Brioso Roundlet +3",
        body="Brioso Justau. +3",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        ear1="Digni. Earring",
        ear2="Regal Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2="Metamor. Ring +1",
        waist="Acuity Belt +1",
		back = gear.magic_jse_back,
	}

	sets.midcast.SongDebuff.DW = { 
		main = "Kali", 
		sub = "Kali" 
	} --Only weapons in this set. This set is overlayed onto  SongDebuff

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = set_combine(sets.midcast.SongDebuff, {
		legs="Brioso Cannions +3"
	})

	-- For Horde Lullaby maxiumum AOE range.
	sets.midcast.SongStringSkill = {
		ear1="Gersemi Earring",
		ear2="Darkside Earring",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
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
        main="Daybreak", --30
        sub="Ammurapi Shield",
        -- head="Kaykaus Mitra +1", --11
        head="Vanya Hood", --10
        body="Kaykaus Bliaut +1", --(+4)/(-6)
        hands="Kaykaus Cuffs +1", --11(+2)/(-6)
        -- legs="Kaykaus Tights +1", --11/(+2)/(-6)
        legs="Chironic Hose", --8
        feet="Kaykaus Boots +1", --11(+2)/(-12)
        neck="Incanter's Torque",
        -- ear1="Beatific Earring",
        -- ear1="Beatific Earring",
        ear2="Mendicant's Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
        back="Solemnity Cape", --7
        -- waist="Bishop's Sash",
        waist="Luminary Sash",
	}

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget +1",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
        })

	sets.Self_Healing = { neck = "Phalaina Locket", hands = "Buremte Gloves", ring2 = "Kunaji Ring",
		waist = "Gishdubar Sash" }
	sets.Cure_Received = { neck = "Phalaina Locket", hands = "Buremte Gloves", ring2 = "Kunaji Ring",
		waist = "Gishdubar Sash" }
	sets.Self_Refresh = { back = "Grapevine Cape", waist = "Gishdubar Sash" }

	sets.midcast['Enhancing Magic'] = {
        -- main="Carnwenhan",
        -- sub="Ammurapi Shield",
        head=gear.Telchine_ENH_head,
        body=gear.Telchine_ENH_body,
        hands=gear.Telchine_ENH_hands,
        legs=gear.Telchine_ENH_legs,
        feet=gear.Telchine_ENH_feet,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Fi Follet Cape +1",
        waist="Embla Sash",
	}
	
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2"})
    sets.midcast.Haste = sets.midcast['Enhancing Magic']
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget", waist="Siegel Sash"})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {waist="Emphatikos Rope"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell
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

	sets.midcast['Enfeebling Magic'] = {
        -- main="Carnwenhan",
        -- sub="Ammurapi Shield",
        head=empty;
        body="Cohort Cloak +1",
        hands="Brioso Cuffs +3",
        legs="Brioso Cannions +3",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        ear1="Digni. Earring",
        ear2="Vor Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        waist="Acuity Belt +1",
        back="Aurist's Cape +1",
        }

    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {
		main="Daybreak", 
		sub="Ammurapi Shield", 
		waist="Shinjutsu-no-Obi +1"
		}
	)

    sets.midcast.StatusRemoval = {
        head="Vanya Hood",
        body="Vanya Robe",
        legs="Aya. Cosciales +2",
        feet="Vanya Clogs",
        neck="Incanter's Torque",
        ear2="Meili Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
        waist="Bishop's Sash",
        back=gear.magic_jse_back,
        }

	sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
		hands="Hieros Mittens",
		neck="Debilis Medallion",
		ear1="Beatific Earring",
		back="Oretan. Cape +1",
		})

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
        range="Gjallarhorn",
        head="Volte Beret",
        body="Mou. Manteel +1",
        hands="Raetic Bangles +1",
        legs="Volte Brais",
        legs="Volte Gaiters",
        feet="Fili Cothurnes +2",
        neck="Bathy Choker +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back="Moonlight Cape",
        waist="Flume Belt +1",
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
		feet = "Fili Cothurnes +2"
	}

	sets.idle.DT = {
        head="Bihu Roundlet +3", --6/0
        body="Bihu Jstcorps. +3", --7/0
        hands="Raetic Bangles +1",
        legs="Brioso Cannions +3", --8/8
        feet="Inyan. Crackows +2", --0/3
        neck="Loricate Torque +1", --6/6
        ear1="Odnowa Earring +1", --3/5
        ear2="Etiolation Earring", --0/3
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring",  --10/10
        back="Moonlight Cape", --6/6
        waist="Carrier's Sash",
	}

	-- Defense sets

	sets.defense.PDT = set_combine(sets.idle.DT, {
		ring1="Gelatinous Ring +1",
	})
	sets.defense.MDT = set_combine(sets.idle.DT, {
        ear1="Odnowa Earring +1",
	})

	sets.Kiting = { feet = "Fili Cothurnes +2" }
	sets.latent_refresh = { waist = "Fucho-no-obi" }
	sets.latent_refresh_grip = { sub = "Oneiros Grip" }
	sets.TPEat = { neck = "Chrys. Torque" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	sets.engaged = {
		main="Naegling",
		sub = "Genmei Shield",
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
		back = gear.melee_jse_back,
	}

	sets.engaged.Hybrid = {
        neck="Loricate Torque +1", --6/6
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
        }

	sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
	sets.engaged.Acc = {
		main="Naegling",
		sub = "Genmei Shield",
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
		back = gear.melee_jse_back,
	}
	sets.engaged.DW = {
		main="Naegling",
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

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)

	sets.engaged.DW.Acc = {
		main="Naegling",
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
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 1)
end

state.Weapons:options('None', 'Naegling', 'Aeneas', 'DualWeapons', 'DualNaegling', 'DualTauret', 'DualAeolian', 'Daybreak')

autows_list = {
	['Naegling'] = 'Savage Blade',
	['Aeneas'] = "Rudra's Storm",
	['DualWeapons'] = "Rudra's Storm",
	['DualNaegling'] = 'Savage Blade',
	['DualTauret'] = 'Evisceration',
	['DualAeolian'] = 'Aeolian Edge'
}
