function user_job_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Tank','TankMagic','Normal')
    state.WeaponskillMode:options('Match','Normal', 'Acc')
    state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None','AbsorbMP')
    state.PhysicalDefenseMode:options('PDT_HP','PDT','PDT_Reraise')
    state.MagicalDefenseMode:options('MDT_HP','MDT','MDT_Reraise')
	state.ResistDefenseMode:options('MEVA_HP','MEVA')
	state.IdleMode:options('Tank','MDT','Normal')
	state.Weapons:options('None','BurtAegis','BurtDuban','NaeglingBlurred','ClubOchain','Staff')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}
	
	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^pause gs c toggle AutoRuneMode')
	send_command('bind ^q gs c set IdleMode Kiting')
	send_command('bind !q gs c set IdleMode PDT')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
    gear.jse_fc_back = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
    gear.jse_block_back = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}}
	gear.jse_cure_back = { name="Rudianos's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Cure" potency +10%','Spell interruption rate down-10%',}}
    gear.jse_enmity_back = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Spell interruption rate down-10%',}}
    gear.jse_str_back = { name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.jse_def_back = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','DEF+50',}}

    sets.Enmity = {
        ammo="Sapience Orb",
        head={ name="Loess Barbuta +1", augments={'Path: A',}},
        body="Rev. Surcoat +3",
        hands={ name="Cab. Gauntlets +3", augments={'Enhances "Chivalry" effect',}},
        legs={ name="Cab. Breeches +3", augments={'Enhances "Invincible" effect',}},
        feet="Chev. Sabatons +3",
        neck="Moonlight Necklace",
        waist="Audumbla Sash",
        left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        right_ear="Cryptic Earring",
        left_ring="Gelatinous Ring +1",
        right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
        back=gear.jse_cure_back,
    }
            
    sets.Enmity.SIRD = {
        ammo="Staunch Tathlum +1",
        head={ name="Loess Barbuta +1", augments={'Path: A',},priority=1},
        body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
        -- body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        legs="Founder's Hose",
        feet="Odyssean Greaves",
        neck="Moonlight Necklace",
        waist="Audumbla Sash",
        left_ear="Tuisto Earring",
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring="Gelatinous Ring +1",
        right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
        -- back=gear.jse_enmity_back,
        back=gear.jse_fc_back
    }
            
    sets.Enmity.DT = {
        ammo="Staunch Tathlum +1",
        head={ name="Loess Barbuta +1", augments={'Path: A',},priority=1},
        body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
        -- body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        legs="Founder's Hose",
        feet="Odyssean Greaves",
        neck="Moonlight Necklace",
        waist="Audumbla Sash",
        left_ear="Tuisto Earring",
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring="Gelatinous Ring +1",
        right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
        back=gear.jse_enmity_back,
    }
            
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs={ name="Cab. Breeches +3", augments={'Enhances "Invincible" effect',}},})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +3",})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet={ name="Cab. Leggings +3", augments={'Enhances "Guardian" effect',}},})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{head={ name="Cab. Coronet +3", augments={'Enhances "Iron Will" effect',}},}) 
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}},})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{ feet="Chev. Sabatons +3", })
    sets.precast.JA['Majesty'] = set_combine(sets.Enmity)
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {
        head="Rev. Coronet +2",
        body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}},}
    ) 
	
    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{legs={ name="Cab. Breeches +3", augments={'Enhances "Invincible" effect',}},})
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{feet="Rev. Leggings +3",})
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{feet={ name="Cab. Leggings +3", augments={'Enhances "Guardian" effect',}},})
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{head={ name="Cab. Coronet +3", augments={'Enhances "Iron Will" effect',}},})
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}},})
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{feet="Chev. Sabatons +3",})
    sets.precast.JA['Majesty'] = set_combine(sets.Enmity)
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {head="Rev. Coronet +2",
    body={ name="Cab. Surcoat +3", augments={'Enhances "Fealty" effect',}},})
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        ammo="Staunch Tathlum +1",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Cab. Gauntlets +3", augments={'Enhances "Chivalry" effect',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Kgt. Beads +2", augments={'Path: A',}},
        waist="Luminary Sash",
        left_ear="Tuisto Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring="Gelatinous Ring +1",
        right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        back=gear.jse_cure_back,
    }
            
    sets.precast.JA['Chivalry'].DT = {
        ammo="Staunch Tathlum +1",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Cab. Gauntlets +3", augments={'Enhances "Chivalry" effect',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Kgt. Beads +2", augments={'Path: A',}},
        waist="Luminary Sash",
        left_ear="Tuisto Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring="Gelatinous Ring +1",
        right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        back=gear.jse_cure_back,
    }

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +3"})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {hands="Cab. Gauntlets +3"})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    -- sets.precast.Waltz = {ammo="Aurgelmir Orb +1",
	-- 	head="Nyame Helm",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
	-- 	body="Rev. Surcoat +3",hands="Regal Gauntlets",ring1="Asklepian Ring",ring2="Valseur's Ring",
	-- 	back="Moonlight Cape",waist="Chaac Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
        
    -- Don't need any special gear for Healing Waltz.
    -- sets.precast.Waltz['Healing Waltz'] = {}
    
    -- sets.precast.Step = {ammo="Aurgelmir Orb +1",
    --     head="Carmine Mask +1",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
    --     body="Flamma Korazin +2",hands="Regal Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
    --     back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Flam. Gambieras +2"}
		
	-- sets.precast.JA['Violent Flourish'] = {ammo="Aurgelmir Orb +1",
    --     head="Flam. Zucchetto +2",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
    --     body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring1="Defending Ring",ring2="Stikini Ring +1",
    --     back="Ground. Mantle +1",waist="Olseni Belt",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        ammo="Sapience Orb",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body={ name="Rev. Surcoat +3",priority=1},
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
        feet="Chev. Sabatons +3",
        neck="Orunmila's Torque",
        waist="Plat. Mog. Belt",
        -- waist="Oneiros Belt",
        left_ear="Tuisto Earring",
        right_ear="Loquac. Earring",
        left_ring="Gelatinous Ring +1",
        right_ring="Kishar Ring",
        back=gear.jse_fc_back,
    }
		
    sets.precast.FC.DT = {
        ammo="Sapience Orb",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body={ name="Rev. Surcoat +3",priority=1},
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
        feet="Chev. Sabatons +3",
        neck="Orunmila's Torque",
        waist="Plat. Mog. Belt",
        -- waist="Oneiros Belt",
        left_ear="Tuisto Earring",
        right_ear="Loquac. Earring",
        left_ring="Gelatinous Ring +1",
        right_ring="Kishar Ring",
        back=gear.jse_fc_back,
    }
            
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC['Enhancing Magic'].DT = set_combine(sets.precast.FC.DT, {waist="Siegel Sash"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
		
    sets.precast.WS.DT = {}

    sets.precast.WS.Acc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ammo="Staunch Tathlum +1",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Kgt. Beads +2", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Tuisto Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Gelatinous Ring +1",
        right_ring="Moonlight Ring",
        back=gear.jse_str_back,}
    )
    
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	sets.precast.WS['Flat Blade'] = {}

    sets.precast.WS['Sanguine Blade'] = {}

    sets.precast.WS['Atonement'] = {
        ammo="Sapience Orb",
        head={ name="Loess Barbuta +1", augments={'Path: A',}},
        body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
        -- body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        feet="Chev. Sabatons +3",
        neck="Moonlight Necklace",
        waist="Creed Baudrier",
        left_ear="Tuisto Earring",
        right_ear="Cryptic Earring",
        left_ring="Apeile Ring",
        right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
        back=gear.jse_enmity_back,
    }

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {
        ammo="Sapience Orb",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body={ name="Rev. Surcoat +3",priority=1},
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
        feet="Chev. Sabatons +3",
        neck="Orunmila's Torque",
        waist="Oneiros Belt",
        left_ear="Tuisto Earring",
        right_ear="Loquac. Earring",
        left_ring="Gelatinous Ring +1",
        right_ring="Kishar Ring",
        back=gear.jse_fc_back,
    }
		
	sets.midcast.FastRecast.DT = {
        ammo="Sapience Orb",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body={ name="Rev. Surcoat +3",priority=1},
        hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
        feet="Chev. Sabatons +3",
        neck="Orunmila's Torque",
        waist="Oneiros Belt",
        left_ear="Tuisto Earring",
        right_ear="Loquac. Earring",
        left_ring="Gelatinous Ring +1",
        right_ring="Kishar Ring",
        back=gear.jse_fc_back,
    }

    sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {
        ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",
        body="Adamantite Armor",
        hands="Chev. Gauntlets +3",
        -- hands="Regal Gauntlets",
        legs={ name="Cab. Breeches +3", augments={'Enhances "Invincible" effect',}},
        feet="Odyssean Greaves",
        neck="Moonlight Necklace",
        waist="Plat. Mog. Belt",
        left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        right_ear="Chev. Earring +1",
        left_ring="Gelatinous Ring +1",
        right_ring="Eihwaz Ring",
        back=gear.jse_cure_back,
    }
            
    sets.midcast.Cure.SIRD = {
        ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",
        body="Chev. Cuirass +3",
        hands="Chev. Gauntlets +3",
        -- hands="Regal Gauntlets",
        legs="Founder's Hose",
        feet="Odyssean Greaves",
        neck="Moonlight Necklace",
        waist="Plat. Mog. Belt",
        left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        right_ear="Chev. Earring +1",
        left_ring="Gelatinous Ring +1",
        right_ring="Eihwaz Ring",
        back=gear.jse_cure_back,
    }

    sets.midcast.Raise = sets.midcast.Cure.SIRD
            
    sets.midcast.Cure.DT = {
        ammo="Staunch Tathlum +1",
        head={ name="Loess Barbuta +1", augments={'Path: A',},priority=1},
        body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
        -- body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        legs="Founder's Hose",
        feet="Odyssean Greaves",
        neck="Moonlight Necklace",
        waist="Creed Baudrier",
        left_ear="Knightly Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring={ name="Moonlight Ring",priority=1},
        right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
        back=gear.jse_cure_back,
    }
		
    sets.midcast.Reprisal = {
        ammo="Sapience Orb",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body="Shab. Cuirass +1",
        hands="Regal Gauntlets",
        legs="Founder's Hose",
        feet="Odyssean Greaves",
        neck="Moonlight Necklace",
        waist="Audumbla Sash",
        left_ear= {name="Tuisto Earring",priority=1},
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',},priority=1},
        left_ring="Gelatinous Ring +1",
        right_ring="Moonlight Ring",
        back=gear.jse_fc_back,
    }

	sets.Self_Healing = {
        ammo="Staunch Tathlum +1",
        head={ name="Loess Barbuta +1", augments={'Path: A',},priority=1},
        body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
        -- body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        legs="Founder's Hose",
        feet="Odyssean Greaves",
        neck="Moonlight Necklace",
        waist="Creed Baudrier",
        left_ear="Knightly Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring={ name="Moonlight Ring",priority=1},
        right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
        back=gear.jse_cure_back,
    }
            
	sets.Self_Healing.SIRD = {
        ammo="Staunch Tathlum +1",
        head={ name="Loess Barbuta +1", augments={'Path: A',},priority=1},
        body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
        -- body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        legs="Founder's Hose",
        feet="Odyssean Greaves",
        neck="Moonlight Necklace",
        waist="Creed Baudrier",
        left_ear="Knightly Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring={ name="Moonlight Ring",priority=1},
        right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
        back=gear.jse_cure_back,
}
		
	sets.Self_Healing.DT = {
        ammo="Staunch Tathlum +1",
        head={ name="Loess Barbuta +1", augments={'Path: A',},priority=1},
        body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
        -- body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        legs="Founder's Hose",
        feet="Odyssean Greaves",
        neck="Moonlight Necklace",
        waist="Creed Baudrier",
        left_ear="Knightly Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring={ name="Moonlight Ring",priority=1},
        right_ring={ name="Apeile Ring +1", augments={'Path: A',}},
        back=gear.jse_cure_back,
    }

	sets.Cure_Received = {}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = {
        ammo="Sapience Orb",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body="Shab. Cuirass +1",
        hands={ name="Regal Gauntlets",priority=1},
        legs="Founder's Hose",
        feet="Odyssean Greaves",
        neck="Moonlight Necklace",
        waist="Audumbla Sash",
        left_ear={ name="Tuisto Earring",priority=1},
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',},priority=1},
        left_ring="Gelatinous Ring +1",
        right_ring={ name="Moonlight Ring",priority=1},
        back=gear.jse_fc_back,
    }
            
    sets.midcast['Enhancing Magic'].SIRD = {
        ammo="Sapience Orb",
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body="Shab. Cuirass +1",
        hands={ name="Regal Gauntlets",priority=1},
        legs="Founder's Hose",
        feet="Odyssean Greaves",
        neck="Moonlight Necklace",
        waist="Audumbla Sash",
        left_ear={ name="Tuisto Earring",priority=1},
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',},priority=1},
        left_ring="Gelatinous Ring +1",
        right_ring={ name="Moonlight Ring",priority=1},
        back=gear.jse_fc_back,
    }

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    -- should be Srivatsa
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {sub="Duban",ring2="Sheltered Ring"}) 
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
        ammo="Staunch Tathlum +1",
        head={ name="Yorium Barbuta", augments={'DEF+22','Spell interruption rate down -10%','Phalanx +3',}},
        body={ name="Yorium Cuirass", augments={'DEF+23','Spell interruption rate down -10%','Phalanx +3',}},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
        feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        neck="Moonlight Necklace",
        waist="Audumbla Sash",
        left_ear="Mimir Earring",
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring="Stikini Ring +1",
        right_ring="Gelatinous Ring +1",
        back="Weard Mantle"
    })
        
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {
        ammo="Staunch Tathlum +1",
        head={ name="Yorium Barbuta", augments={'DEF+22','Spell interruption rate down -10%','Phalanx +3',}},
        body={ name="Yorium Cuirass", augments={'DEF+23','Spell interruption rate down -10%','Phalanx +3',}},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',},priority=1},
        feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        neck="Moonlight Necklace",
        waist="Audumbla Sash",
        left_ear="Knightly Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring="Gelatinous Ring +1",
        right_ring={ name="Moonlight Ring",priority=1},
        back="Weard Mantle"
    })
	
    sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {
        ammo="Staunch Tathlum +1",
        head={ name="Yorium Barbuta", augments={'DEF+22','Spell interruption rate down -10%','Phalanx +3',}},
        body={ name="Yorium Cuirass", augments={'DEF+23','Spell interruption rate down -10%','Phalanx +3',}},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',},priority=1},
        feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=1},
        neck="Moonlight Necklace",
        waist="Audumbla Sash",
        left_ear="Knightly Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring="Gelatinous Ring +1",
        right_ring={ name="Moonlight Ring",priority=1},
        back="Weard Mantle",
    })	
        
    sets.Phalanx_Received = {
        ammo="Staunch Tathlum +1",
        head={ name="Yorium Barbuta", augments={'DEF+22','Spell interruption rate down -10%','Phalanx +3',}},
        body={ name="Yorium Cuirass", augments={'DEF+23','Spell interruption rate down -10%','Phalanx +3',}},
        hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
        feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
        neck="Moonlight Necklace",
        waist="Audumbla Sash",
        left_ear="Knightly Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring="Gelatinous Ring +1",
        right_ring="Moonlight Ring",
        back="Weard Mantle"
    }
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {}

    -- Idle sets
    sets.idle = {
        main={ name="Moralltach", augments={'Path: C',},priority=1},
        sub="Duban",
        ammo="Staunch Tathlum +1",
        head={ name="Odyssean Helm", augments={'Mag. Acc.+3','"Mag.Atk.Bns."+20','"Refresh"+2','Accuracy+1 Attack+1',}},
        body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
        hands="Chev. Gauntlets +3",
        -- hands={ name="Regal Gauntlets",priority=1},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',},priority=1},
        feet={ name="Sakpata's Leggings", augments={'Path: A',}},
        neck="Coatl Gorget +1",
        waist="Audumbla Sash",
        left_ear="Tuisto Earring",
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',},priority=1},
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring +1",
        back=gear.jse_def_back,
    }
	
    sets.idle.MDT = {
        main="Burtgang",
        sub="Aegis",
        ammo="Brigantia Pebble",
        head={ name="Sakpata's Helm", augments={'Path: A',}},
        body={ name="Sakpata's Plate", augments={'Path: A',}},
        hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',},priority=1},
        feet={ name="Sakpata's Leggings", augments={'Path: A',},priority=1},
        neck={ name="Kgt. Beads +2", augments={'Path: A',},priority=1},
        waist="Flume Belt +1",
        left_ear={ name="Tuisto Earring",priority=1},
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',},priority=1},
        left_ring="Gelatinous Ring +1",
        right_ring="Fortified Ring",
        back=gear.jse_def_back,
    }

	sets.idle.Tank = {
        main="Burtgang",
        sub={ name="Duban",priority=1},
        -- ammo="Brigantia Pebble",
        head={ name="Sakpata's Helm", augments={'Path: A',}},
        body={ name="Sakpata's Plate", augments={'Path: A',}},
        hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',},priority=1},
        feet={ name="Sakpata's Leggings", augments={'Path: A',}},
        neck="Loricate Torque +1",
        -- neck={ name="Kgt. Beads +2", augments={'Path: A',},priority=1},
        waist="Flume Belt +1",
        left_ear={ name="Tuisto Earring",priority=1},
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',},priority=1},
        left_ring="Gelatinous Ring +1",
        right_ring="Fortified Ring",
        back=gear.jse_def_back,
    }

    sets.idle.Town = {
        body = "Sacro Breastplate"
    }
		

	sets.Kiting = { ring2 = "Shneddick Ring" }
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.latent_regen = {ring1="Apeile Ring +1",ring2="Apeile Ring"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {waist="Flume Belt +1",}
	sets.passive.AbsorbMP = {waist="Flume Belt +1",}
    sets.MP_Knockback = {}
    sets.Twilight = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.BurtAegis = {main="Burtgang",sub="Aegis",}
	sets.weapons.BurtDuban = {main="Burtgang",sub="Duban",}
	sets.weapons.NaeglingBlurred = {main="Naegling",sub="Blurred Shield +1",}
	sets.weapons.ClubOchain = {}
	sets.weapons.DualWeapons = {}
	sets.weapons.Staff = {main="Malignance Pole",sub="Umbra Strap",}
    
    sets.defense.Block = {}
		
	sets.defense.PDT = {}
		
    sets.defense.PDT_HP = {}
		
	sets.defense.MDT = {}
		
    sets.defense.MDT_HP = {}

	sets.defense.MEVA = {}
		
    sets.defense.MEVA_HP = {}
		
    sets.defense.PDT_Reraise = set_combine(sets.defense.PDT_HP,{})
    sets.defense.MDT_Reraise = set_combine(sets.defense.MDT_HP,{})
		
	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged.Tank = {
        main="Burtgang",
        sub= {name="Duban",priority=1},
        ammo="Staunch Tathlum +1",
        head="Chev. Armet +3",
        body={ name="Sakpata's Plate", augments={'Path: A',}},
        hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
        legs="Chev. Cuisses +3",
        feet={ name="Sakpata's Leggings", augments={'Path: A',}},
        neck="Moonlight Necklace",
        waist="Goading Belt",
        left_ear="Cryptic Earring",
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring="Moonlight Ring",
        right_ring="Fortified Ring",
        back=gear.jse_cure_back,
    }
		
	sets.engaged.TankMagic = {
        main="Burtgang",
        sub="Aegis",
        ammo="Brigantia Pebble",
        head={ name="Sakpata's Helm", augments={'Path: A',}},
        body={ name="Sakpata's Plate", augments={'Path: A',}},
        hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
        legs={ name="Sakpata's Cuisses", augments={'Path: A',},priority=1},
        feet={ name="Sakpata's Leggings", augments={'Path: A',}},
        -- neck={ name="Kgt. Beads +2", augments={'Path: A',},priority=1},
        neck="Loricate Torque +1",
        waist="Asklepian Belt",
        left_ear={ name="Tuisto Earring",priority=1},
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',},priority=1},
        left_ring="Gelatinous Ring +1",
        right_ring={ name="Moonlight Ring",priority=1},
        back=gear.jse_block_back,
    }
            
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
    sets.buff.Cover = {body="Cab. Surcoat +3"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'RUN' then
        set_macro_page(9, 4)
    elseif player.sub_job == 'RDM' then
        set_macro_page(6, 4)
    elseif player.sub_job == 'BLU' then
        set_macro_page(8, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4) --War/Etc
    end
end