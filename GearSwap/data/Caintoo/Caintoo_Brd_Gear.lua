function user_job_setup()
	-- Options: Override default values
    state.UnlockWeapons = M(true, 'Unlock Weapons')
	state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DT')
    state.CastingMode:options('Normal','Resistant','AoE')
    state.IdleMode:options('Normal','NoRefresh','DT')
	state.Weapons:options('None','Naegling','Aeneas','DualWeapons','DualNaegling','DualTauret','DualAeolian')
	-- Whether to use Carn (or song daggers in general) under a certain threshhold even when weapons are locked.
	state.CarnMode = M{'Always','300','1000','Never'}

	gear.melee_jse_back = {name="Intarabus's Cape",augments={'Accuracy+20 Attack+20'}}
	gear.magic_jse_back = {name="Intarabus's Cape",augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}}
	gear.idle_jse_back = {name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+8',}}
	
	gear.af_head		=	"Brioso Roundlet +1"
    gear.af_body		=	"Brioso Just. +1"
    gear.af_hands		=	"Brioso Cuffs +1"
    gear.af_legs		=	"Brioso Cann. +1"
    gear.af_feet		=	"Brioso Slippers +1"
	
	gear.relic_head		=	"Bihu Roundlet +1"
    gear.relic_body		=	"Bihu Jstcorps +1"
    gear.relic_hands 	=	"Bihu Cuffs +1"
    gear.relic_legs		=	"Bihu Cannions +1"
    gear.relic_feet		=	"Bihu Slippers +1"
	
	gear.empy_head		=	"Fili Calot +3"
    gear.empy_body		=	"Fili Hongreline +3"
    gear.empy_hands		=	"Fili Manchettes +3"
    gear.empy_legs		=	"Fili Rhingrave +3"
    gear.empy_feet		=	"Fili Cothurnes +3"

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = "Daurdabla"
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
	send_command('bind ^numpad7 input //sing on')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas",sub="Genmei Shield"}
	sets.weapons.DualWeapons = {main="Aeneas",sub="Blurred Knife +1"}
	sets.weapons.DualNaegling = {main="Naegling",sub="Blurred Knife +1"}
	sets.weapons.Naegling = {main="Naegling",sub="Genmei Shield"}
	sets.weapons.DualTauret = {main="Tauret",sub="Blurred Knife +1"}
	sets.weapons.DualAeolian = {main="Tauret",sub="Malevolence"}

    sets.buff.Sublimation = {
		--waist="Embla Sash"
	}
    sets.buff.DTSublimation = {
		--waist="Embla Sash"
	}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
		head="Bunzi's Hat",
		--neck="Voltsurge Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",
		hands="Gende. Gages +1",
		ring1="Weather. Ring",
		--ring2="Kishar Ring",
		back=gear.idle_jse_back,
		waist="Witful Belt",
		legs="Kaykaus Tights +1",
		feet=gear.empy_feet
	}
		
	sets.precast.FC.DT = {
		head="Bunzi's Hat",
		--neck="Voltsurge Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",
		hands="Gende. Gages +1",
		ring1="Weather. Ring",
		--ring2="Kishar Ring",
		back=gear.idle_jse_back,
		waist="Witful Belt",
		legs="Kaykaus Tights +1",
		feet=gear.empy_feet
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
		--main="Daybreak",
		sub="Genmei Shield"
	})
	
	sets.precast.FC.BardSong = {
		--main=gear.grioavolr_fc_staff,
		--sub="Clerisy Strap +1",
		range="Gjallarhorn",
		--ammo=empty,
		head=gear.empy_head,
		--neck="Loricate Torque +1",
		ear1="Enchntr. Earring +1",
		ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",
		hands="Gende. Gages +1",
		ring1="Weather. Ring",
		--ring2="Kishar Ring",
		back=gear.idle_jse_back,
		waist="Witful Belt",
		legs="Kaykaus Tights +1",
		feet=gear.empy_feet
	}

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC.Lullaby = {range="Marsyas"}
	sets.precast.FC.Lullaby.Resistant = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby II'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Gjallarhorn"}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Gjallarhorn"}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet=gear.relic_feet}
	sets.precast.JA.Troubadour = {body=gear.relic_body}
	sets.precast.JA['Soul Voice'] = {legs=gear.relic_legs}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		--ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",
		--neck="Caro Necklace",
		--ear1="Moonshade Earring",
		--ear2="Mache Earring +1",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		--ring1="Ramuh Ring +1",
		--ring2="Ilabrat Ring",
		--back=gear.melee_jse_back,
		--waist="Grunfeld Rope",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2"
	}
		
	sets.precast.WS.Acc = {
		--ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",
		--neck="Combatant's Torque",
		--ear1="Moonshade Earring",
		--ear2="Mache Earring +1",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		--ring1="Ramuh Ring +1",
		--ring2="Ilabrat Ring",
		--back=gear.melee_jse_back,
		--waist="Olseni Belt",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2"
	}
		
	sets.precast.WS['Savage Blade'] = {
		--ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",
		--neck="Caro Necklace",
		--ear1="Moonshade Earring",
		--ear2="Ishvara Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		--ring1="Rufescent Ring",
		--ring2="Epaminondas's Ring",
		--back=gear.melee_jse_back,
		--waist="Sailfi Belt +1",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2"
	}
		
	sets.precast.WS['Aeolian Edge'] = {
		--ammo="Aurgelmir Orb +1",
		--head="Cath Palug Crown",
		--neck="Baetyl Pendant",
		--ear1="Moonshade Earring",
		--ear2="Friomisi Earring",
		--body="Chironic Doublet",
		--hands=gear.chironic_enfeeble_hands,
		ring1="Metamorph Ring +1",
		--ring2="Shiva Ring +1",
		--back=gear.melee_jse_back,
		--waist="Refoccilation Stone",
		--legs="Gyve Trousers",
		--feet=gear.chironic_nuke_feet
	}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	--sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring",}
	--sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {
		--main=gear.grioavolr_fc_staff,
		--sub="Clerisy Strap +1",
		--ammo="Hasty Pinion +1",
		head="Bunzi's Hat",
		--neck="Voltsurge Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",
		hands="Gende. Gages +1",
		ring1="Weather. Ring",
		--ring2="Kishar Ring",
		--back=gear.magic_jse_back,
		waist="Witful Belt",
		legs="Kaykaus Tights +1",
		feet=gear.empy_feet
	}
	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {legs=gear.empy_legs}
	sets.midcast.Lullaby = {range="Marsyas"}
	sets.midcast.Lullaby.Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'] = {range="Marsyas"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby'].AoE = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby II'] = {range="Marsyas"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Gjallarhorn"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Gjallarhorn"}
	sets.midcast.Madrigal = {feet=gear.empy_feet}
	sets.midcast.Prelude = {feet=gear.empy_feet}
	sets.midcast.March = {}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {}
	sets.midcast.Minne = {legs="Mousai Seraweels +1"}
	sets.midcast.Carol = {hands="Mousai Gages +1"}
	sets.midcast["Sentinel's Scherzo"] = {feet=gear.empy_feet}
	sets.midcast['Magic Finale'] = {range="Gjallarhorn"}
	sets.midcast.Mazurka = {range="Marsyas"}
	sets.midcast.Mambo = {feet="Mousai Crackows +1"}
	sets.midcast.Etude = {head="Mousai Turban +1"}
	sets.midcast.Threnody = {head="Mousai Manteel +1"}
	sets.midcast['Scop\'s Operetta'] = sets.precast.FC.Daurdabla
	sets.midcast['Goblin Gavotte'] = sets.precast.FC.Daurdabla
	sets.midcast['Sheepfoe Mambo'] = sets.precast.FC.Daurdabla
	
	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
		--main="Kali",
		sub="Genmei Shield",
		range="Gjallarhorn",
		--ammo=empty,
		head=gear.empy_head,
		neck="Mnbw. Whistle +1",
		ear1="Enchntr. Earring +1",
		ear2="Loquac. Earring",
		body=gear.empy_body,
		hands=gear.empy_hands,
		ring1={name="Stikini Ring +1",bag="wardrobe1"},
		ring2={name="Stikini Ring +1",bag="wardrobe2"},
		--back=gear.magic_jse_back,
		--waist="Kobo Obi",
		legs="Inyanga Shalwar +2",
		feet=gear.af_feet
	}
		
	sets.midcast.SongEffect.DW = {main="Kali",sub="Kali"} --Only weapons in this set. This set is overlayed onto SongEffect

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {
		--main="Kali",
		--sub="Ammurapi Shield",
		range="Marsyas",
		--ammo=empty,
		head="Inyanga Tiara +2",
		neck="Mnbw. Whistle +1",
		--ear1="Regal Earring",
		ear2="Digni. Earring",
		body=gear.empy_body,
		hands="Inyan. Dastanas +2",
		ring1="Metamorph Ring +1",
		ring2="Stikini Ring +1",
		--back=gear.magic_jse_back,
		waist="Acuity Belt +1",
		legs="Inyanga Shalwar +2",
		feet=gear.af_feet
	}
		
	sets.midcast.SongDebuff.DW = {main="Kali",sub="Kali"} --Only weapons in this set. This set is overlayed onto SongDebuff

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {
		--main="Daybreak",
		--sub="Ammurapi Shield",
		--range="Gjallarhorn",
		--ammo=empty,
		head="Inyanga Tiara +2",
		neck="Mnbw. Whistle +1",
		--ear1="Regal Earring",
		--ear2="Digni. Earring",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		ring1="Metamorph Ring +1",
		ring2="Stikini Ring +1",
		--back=gear.magic_jse_back,
		waist="Acuity Belt +1",
		legs="Inyanga Shalwar +2",
		feet="Aya. Gambieras +2"
	}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {
		--main=gear.grioavolr_fc_staff,
		--sub="Clerisy Strap +1",
		--range="Gjallarhorn",
		--ammo=empty,
		head="Bunzi's Hat",
		--neck="Voltsurge Torque",
		ear1="Enchntr. Earring +1",
		ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",
		hands="Gendewitha Gages +1",
		--ring1="Kishar Ring",
		--ring2="Prolix Ring",
		--back=gear.magic_jse_back,
		--waist="Witful Belt",
		legs=gear.empy_legs,
		feet="Aya. Gambieras +2"
	}
		
	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {
		--main="Serenity",
		--sub="Curatio Grip",
		--ammo="Pemphredo Tathlum",
        head="Kaykaus Mitra +1",
		--neck="Reti Pendant",
		--ear1="Calamitous Earring",
		ear2="Magnetic Earring",
        body="Kaykaus Bliaut +1",
		hands="Kaykaus Cuffs +1",
		ring1="Stikini Ring +1",
		ring2="Mephitas's Ring +1",
        --back="Aurist's Cape +1",
		--waist="Shinjutsu-no-Obi +1",
		legs="Kaykaus Tights +1",
		feet="Kaykaus Boots +1"
	}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {
		--neck="Phalaina Locket",
		--hands="Buremte Gloves",
		ring2="Kunaji Ring",
		waist="Gishdubar Sash"
	}
	sets.Cure_Received = {
		--neck="Phalaina Locket",
		--hands="Buremte Gloves",
		ring2="Kunaji Ring",
		waist="Gishdubar Sash"
	}
	sets.Self_Refresh = {
		--back="Grapevine Cape",
		waist="Gishdubar Sash"
	}
	sets.midcast['Enhancing Magic'] = {
		--main="Serenity",
		--sub="Fulcio Grip",
		--ammo="Hasty Pinion +1",
		--head="Telchine Cap",
		--neck="Voltsurge Torque",
		--ear1="Andoaa Earring",
		--ear2="Gifted Earring",
		--body="Telchine Chas.",
		--hands="Telchine Gloves",
		--ring1="Stikini Ring +1",
		--ring2="Stikini Ring +1",
		--back=gear.magic_jse_back,
		--waist="Embla Sash",
		--legs="Telchine Braconi",
		--feet="Telchine Pigaches"
	}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		--neck="Nodens Gorget",
		--ear2="Earthcry Earring",
		--waist="Siegel Sash",
		--legs="Shedir Seraweels"
	})
		
	sets.midcast['Elemental Magic'] = {
		--main="Daybreak",
		--sub="Ammurapi Shield",
		--ammo="Ghastly Tathlum +1",
		--head="C. Palug Crown",
		--neck="Sanctity Necklace",
		--ear1="Friomisi Earring",
		--ear2="Crematio Earring",
		--body="Chironic Doublet",
		--hands="Volte Gloves",
		--ring1="Shiva Ring +1",
		--ring2="Shiva Ring +1",
		--back="Toro Cape",
		--waist="Sekhmet Corset",
		--legs="Gyve Trousers",
		--feet=gear.chironic_nuke_feet
	}
		
	sets.midcast['Elemental Magic'].Resistant = {}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {
		neck="Debilis Medallion",
		--hands="Hieros Mittens",
		--back="Oretan. Cape +1",
		ring1="Haoma's Ring",
		--ring2="Menelaus's Ring",
		waist="Witful Belt",
		--feet="Vanya Clogs"
	})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {
		--main=gear.grioavolr_fc_staff,
		--sub="Clemency Grip"
	})

	-- Resting sets
	sets.resting = {
		--main="Chatoyant Staff",
		--sub="Umbra Strap",
		ammo="Staunch Tathlum +1",
		--head=empty,
		--neck="Loricate Torque +1",
		--ear1="Etiolation Earring",
		--ear2="Ethereal Earring",
		--body="Respite Cloak",
		--hands=gear.chironic_refresh_hands,
		--ring1="Defending Ring",
		--ring2="Dark Ring",
		--back="Umbra Cape",
		waist="Flume Belt +1",
		--legs="Assid. Pants +1",
		--feet=gear.chironic_refresh_feet
	}
	
	sets.idle = {
		--main="Ipetam",
		sub="Genmei Shield",
		--range="Staunch Tathlum +1",
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		neck="Bard's Charm +2",
		ear1="Eabani Earring",
		--ear2="Etiolation Earring",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		ring1={name="Stikini Ring +1",bag="wardrobe1"},
		ring2={name="Stikini Ring +1",bag="wardrobe2"},
		back=gear.idle_jse_back,
		waist="Carrier's Sash",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots"
	}
		
	sets.idle.NoRefresh = {
		--main="Daybreak",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		--head="Nyame Helm",
		--neck="Loricate Torque +1",
		--ear1="Etiolation Earring",
		--ear2="Sanare Earring",
		--body="Nyame Mail",
		--hands="Nyame Gauntlets",
		--ring1="Defending Ring",
		--ring2="Shadow Ring",
		back=gear.idle_jse_back,
		waist="Carrier's Sash",
		--legs="Nyame Flanchard",
		feet=gear.empy_feet
	}

	sets.idle.DT = {
		--main="Daybreak",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		--head="Nyame Helm",
		--neck="Loricate Torque +1",
		--ear1="Etiolation Earring",
		--ear2="Sanare Earring",
		--body="Nyame Mail",
		--hands="Nyame Gauntlets",
		--ring1="Defending Ring",
		--ring2="Shadow Ring",
		back=gear.idle_jse_back,
		waist="Carrier's Sash",
		--legs="Nyame Flanchard",
		--feet="Nyame Sollerets"
	}
	
	-- Defense sets

	sets.defense.PDT = {
		--main="Terra's Staff", 
		--sub="Umbra Strap",
		ammo="Staunch Tathlum +1",
		--head="Nyame Helm",
		--neck="Loricate Torque +1",
		--ear1="Etiolation Earring",
		--ear2="Sanare Earring",
		--body="Nyame Mail",
		--hands="Nyame Gauntlets",
		--ring1="Defending Ring",
		--ring2="Shadow Ring",
		--back="Moonlight Cape",
		waist="Carrier's Sash",
		--legs="Nyame Flanchard",
		--feet="Nyame Sollerets"
	}

	sets.defense.MDT = {
		--main="Terra's Staff", 
		--sub="Umbra Strap",
		ammo="Staunch Tathlum +1",
		--head="Nyame Helm",
		--neck="Loricate Torque +1",
		--ear1="Etiolation Earring",
		--ear2="Sanare Earring",
		--body="Nyame Mail",
		--hands="Nyame Gauntlets",
		--ring1="Defending Ring",
		--ring2="Shadow Ring",
		--back="Moonlight Cape",
		waist="Carrier's Sash",
		--legs="Nyame Flanchard",
		--feet="Nyame Sollerets"
	}

	sets.Kiting = {feet=gear.empy_feet}
	sets.latent_refresh = {
		--waist="Fucho-no-obi"
	}
	sets.latent_refresh_grip = {
		--sub="Oneiros Grip"
	}
	sets.TPEat = {
		--neck="Chrys. Torque"
	}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {
		--ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",
		neck="Bard's Charm +2",
		ear1="Eabani Earring",
		ear2="Brutal Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		--ring1="Petrov Ring",
		--ring2="Chirich Ring +1",
		--back=gear.melee_jse_back,
		waist="Reiki Yotai",
		legs="Jokushu Haidate",
		feet="Aya. Gambieras +2",
	}
	
	sets.engaged.DT = {}
	sets.engaged.Acc = {}
	sets.engaged.DW = {}
	sets.engaged.DW.DT = {}
	sets.engaged.DW.Acc = {}
	sets.engaged.DW.Acc.DT = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 1)
end

state.Weapons:options('None','Naegling','Aeneas','DualWeapons','DualNaegling','DualTauret','DualAeolian')

autows_list = {['Naegling']='Savage Blade',['Aeneas']="Rudra's Storm",['DualWeapons']="Rudra's Storm",['DualNaegling']='Savage Blade',['DualTauret']='Evisceration',
     ['DualAeolian']='Aeolian Edge'}

send_command('wait 10;input /lockstyleset 1')