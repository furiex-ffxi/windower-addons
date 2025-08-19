-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'Proc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    state.HybridMode:options('Normal', 'DT')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None', 'DWMax' }
    state.Weapons:options('Default', 'Ranged', 'RangedAcc', 'Savage', 'Onion', 'Evisceration', 'LeadenMelee', 'DualWeapons', 'DualSavageWeapons',
        'DualOnion', 'DualEvisceration', 'DualLeadenRanged', 'DualLeadenMelee', 'DualAeolian', 'DualRanged', 'DualRoll',
        'DualFermion', 'None')
    state.CompensatorMode:options('Always', '300', '1000', 'Never')

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15
    Ikenga_vest_bonus = 180  -- It is 190 at R20. Uncomment if you need to manually adjust because you are using below R20

    gear.tp_ranger_jse_back = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Damage taken-5%',}} -- needle racc to agi, and dt to pdt
    gear.snapshot_jse_back = { name = "Camulus's Mantle", augments = { '"Snapshot"+10', } }
    gear.tp_jse_back = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    gear.ranger_wsd_jse_back = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}}
    gear.magic_wsd_jse_back = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}}
    gear.str_wsd_jse_back = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

    -- Additional local binds
    send_command('bind ^` gs c cycle ElementalMode')
    send_command('bind !` gs c elemental quickdraw')

    send_command('bind ^backspace input /ja "Double-up" <me>')
    send_command('bind @backspace input /ja "Snake Eye" <me>')
    send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')

    send_command('bind ^\\ input /ja "Random Deal" <me>')
    send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
    send_command('bind ^@!\\ gs c toggle LuzafRing')
    send_command('bind @f7 gs c toggle RngHelper')
    send_command('bind !f7 gs c cycle CompensatorMode')

    send_command('bind !r gs c weapons DualSavageWeapons;gs c update')
    send_command('bind ^q gs c weapons DualAeolian;gs c update')
    send_command('bind !q gs c weapons DualLeadenRanged;gs c update')
    send_command('bind @pause roller roll')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    gear.Empy = {}
    gear.Empy.Head = "Chass. Tricorne +3"
    gear.Empy.Body = "Chasseur's Frac +3"
    gear.Empy.Hands = "Chasseur's Gants +3"
    gear.Empy.Legs = "Chas. Culottes +3"
    gear.Empy.Feet = "Chass. Bottes +3"
    
    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Triple Shot'] = { 
        head="Oshosi Mask +1", -- Missing
        body=gear.Empy.Body, --14
        hands="Lanun Gants +3", -- Triple shot becomes Quad shot
        legs="Osh. Trousers +1", 
        feet="Osh. Leggings +1", --3
    }
    sets.precast.JA['Snake Eye'] = { legs = "Lanun Trews +3" }
    sets.precast.JA['Wild Card'] = { feet = "Lanun Bottes +3" }
    sets.precast.JA['Random Deal'] = { body = "Lanun Frac +3" }
    sets.precast.FoldDoubleBust = { hands = "Lanun Gants +3" }

    sets.precast.CorsairRoll = {
		main={ name="Rostam", augments={'Path: C'}, bag="Wardrobe 2", priority=1}, -- +8 Effect and 60 sec Duration
		sub={ name="Nusku Shield", priority=2},
		range="Compensator", -- 20 sec Duration
		head="Lanun Tricorne +3", -- 50% Job ability Bonus
		hands=gear.Empy.Hands, --60 sec Duration
		legs="Desultor Tassets", --Phantomroll ability delay -5
		neck="Regal Necklace", -- 20 sec Duration
		right_ring="Luzaf's Ring", -- 16 yalm range
		back="Camulus's Mantle", -- 30 sec Duration
    }

    sets.precast.LuzafRing = { ring2 = "Luzaf's Ring" }

    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, { legs = gear.Empy.Legs })
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, { feet = gear.Empy.Feet })
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, { head = gear.Empy.Head })
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, { body = gear.Empy.Body })
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, { hands = gear.Empy.Hands })
    sets.precast.CorsairRoll["Bolter's Roll"] = {
        main={ name="Rostam", augments={'Path: C'}, bag="Wardrobe 2", priority=1}, -- +8 Effect and 60 sec Duration
    }

    sets.precast.CorsairShot = {
        ammo = gear.QDbullet,
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = gear.Empy.Legs,
        feet = gear.Empy.Feet,
        neck = "Iskur Gorget",
        left_ear = "Dedition Earring",
        right_ear = "Telos Earring",
        left_ring = "Crepuscular Ring",
        right_ring = "Lehko's Ring",
        waist = "Goading Belt",
        back = gear.ranger_wsd_jse_back,
    }

    sets.precast.CorsairShot.Damage = {
        ammo = gear.QDbullet,
        head = sets.Nyame.Head,
        body = "Lanun Frac +3",
        hands = { name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
        legs = sets.Nyame.Legs,
        feet = gear.Empy.Feet,
        neck = { name="Comm. Charm +2", augments={'Path: A',}},
        waist = "Eschan Stone",
        left_ear = "Friomisi Earring",
        right_ear = "Hecate's Earring",
        left_ring = "Acumen Ring",
        right_ring = "Dingir Ring",
    }

    sets.precast.CorsairShot.Proc = {
        ammo = gear.RAbullet,
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Genmei Earring",
        ear2 = "Sanare Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Dark Ring",
        back = "Moonlight Cape",
        waist = "Carrier's Sash",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.precast.CorsairShot['Light Shot'] = set_combine(sets.precast.CorsairShot.Damage, {}) 
    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], { 
        feet = gear.Empy.Feet, 
        right_ring="Archon Ring",
	    head="Pixie Hairpin +1",
    })

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head = "Carmine Mask +1",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = gear.herculean_waltz_body,
        hands = gear.herculean_waltz_hands,
        ring1 = "Defending Ring",
        ring2 = "Valseur's Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Dashing Subligar",
        feet = gear.herculean_waltz_feet
    }

    sets.Self_Waltz = { head = "Mummu Bonnet +2", body = "Passion Jacket", ring1 = "Asklepian Ring" }

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells

    -- ammo="Devastating Bullet",
    -- head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    -- body="Chasseur's Frac +3",
    -- hands="Chasseur's Gants +3",
    -- legs="Chas. Culottes +3",
    -- feet="Chass. Bottes +3",
    -- neck={ name="Comm. Charm +2", augments={'Path: A',}},
    -- waist="K. Kachina Belt +1",
    -- left_ear="Mani Earring",
    -- right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Crit.hit rate+4',}},
    -- left_ring="Medada's Ring",
    -- right_ring="Weather. Ring +1",
    -- back={ name="Camulus's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Damage taken-5%',}},

    sets.precast.FC = {
	    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, -- 14
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5','HP+44',}}, -- 9
		hands="Leyline Gloves",
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+7','"Fast Cast"+6',}},  -- 6
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}}, -- 8
		neck="Voltsurge Torque", -- 4
		waist="Witful Belt",
		left_ear="Loquac. Earring", -- 2
		right_ear="Etiolation Earring", -- 1
		left_ring="Prolix Ring",
		right_ring="Kishar Ring", -- 4
		back={ name="Camulus's Mantle", augments={'HP+60','HP+20','"Fast Cast"+10',}}, -- 10
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck = "Magoraga Beads", body = "Passion Jacket" })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, { ear2 = "Mendi. Earring" })

    sets.precast.RA = {
        ammo = gear.RAbullet,
		head=gear.Empy.Head, -- 0/14
        body="Ikenga's Vest", -- 9/0
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- 8/11
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}, -- 10/13
		feet="Meg. Jam. +2", -- 10/0
		left_ear={ name="Tuisto Earring", priority=2},
		right_ear={ name="Etiolation Earring", priority=1},
		left_ring="Dingir Ring",
		right_ring="Crepuscular Ring", -- 3/0
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, -- 4/0
		waist="Yemaya Belt", -- 0/5
		back=gear.snapshot_jse_back, -- 10/0
    } -- Totals 54 snapshot + 10 job gift / 43 rapid shot + 30 from traits = 64 snapshot / 73 rapid shot

    sets.precast.RA.Flurry = set_combine(sets.precast.RA, { 
        body="Laksa. Frac +4", -- 0/20
    }) --55 snapshot + 15 flurry = 70 snapshot / 93 rapid shot
    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, { 
        feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}} 
    }) -- Totals 45 snapshot + 30 flurry2 =  70 snapshot / 103 rapid shot


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = gear.WSbullet,
		head=sets.Nyame.Head,
		body=sets.Nyame.Body,
		hands=gear.Empy.Hands,
		legs=sets.Nyame.Legs,
		feet=sets.Nyame.Feet,
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
        right_ring="Epaminondas's Ring",
		back=gear.str_wsd_jse_back,
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS.Proc = set_combine(sets.engaged, {})

    sets.precast.WS.MAB = set_combine(sets.precast.WS, {
        ammo = gear.MAbullet,
        head = sets.Nyame.Head,
		feet = { name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		body = "Lanun Frac +3",
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs = sets.Nyame.Legs,
        waist = "Eschan Stone",
		left_ear = "Friomisi Earring",
		right_ear = "Crematio Earring",
		left_ring = "Dingir Ring",
        right_ring = "Epaminondas's Ring",
        back = gear.magic_wsd_jse_back,
	})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
        { head = "Carmine Mask +1", ring2 = "Rufescent Ring", legs = "Carmine Cuisses +1", feet = "Carmine Greaves +1" })

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    })
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {        
    })

    sets.precast.WS['Fast Blade II'] = set_combine(sets.precast.WS, {
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
    })

    sets.precast.WS['Fast Blade II'].Acc = set_combine(sets.precast.WS, {
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
    }) 

    sets.precast.WS['Exenterator'] = {
        ammo = gear.WSbullet,
        head = "Chass. Tricorne +3",
        body = "Chasseur's Frac +3",
        hands = { name="Gazu Bracelets +1", augments={'Path: A',}},
        legs = "Chas. Culottes +3",
        feet = "Chass. Bottes +3",
        neck = "Sanctity necklace",
        waist = "Eschan Stone",
        left_ear = "Telos Earring",
        right_ear = "Digni. Earring",
        left_ring = { name="Cacoethic Ring +1", augments={'Path: A',}},
        right_ring = "Regal ring",       
    }
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {        
    })

    --[[ 
        main  Kustawi +1 R25
        sub  Gleti's Knife R0
        ranged  Fomalhaut R15
        ammo  Hauksbok Bullet
        head  Lanun Tricorne +3
        body  Laksamana's Frac +3
        hands  Chasseur's Gants +3
        legs  Chasseur's Culottes +3
        feet  Lanun Bottes +3
        neck  Commodore Charm +2 R25
        waist  Fotia Belt
        ring1  Cornelia's ring
        ring2  Regal Ring
        back  Camulus's Mantle STR Weaponskill Damage (Ranged)
    --]]

    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
        ammo = gear.WSbullet,
        head=sets.Nyame.Head,
        body="Ikenga's Vest",
        hands=gear.Empy.Hands,
        legs=sets.Nyame.Legs,
        feet = "Lanun Bottes +3",
        neck="Fotia Gorget",
        waist = "Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        ring2 = "Regal Ring",
        right_ring="Dingir Ring",
        back=gear.ranger_wsd_jse_back,
    })
    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], { })
    sets.precast.WS['Detonator'] = set_combine(sets.precast.WS['Last Stand'], { })
    sets.precast.WS['Detonator'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, { })
    sets.precast.WS['Slug Shot'] = set_combine(sets.precast.WS['Last Stand'], { })
    sets.precast.WS['Slug Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, { })
    sets.precast.WS['Numbing Shot'] = set_combine(sets.precast.WS['Last Stand'], { })
    sets.precast.WS['Numbing Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, { })
    sets.precast.WS['Sniper Shot'] = set_combine(sets.precast.WS['Last Stand'], { })
    sets.precast.WS['Sniper Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, { })
    sets.precast.WS['Split Shot'] = set_combine(sets.precast.WS['Last Stand'], { })
    sets.precast.WS['Split Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, { })

    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS.MAB, {
		head="Pixie Hairpin +1",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		right_ring="Archon Ring",
		left_ring="Dingir Ring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        waist="Eschan Stone",
		back=gear.magic_wsd_jse_back,
	})

    sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'], { })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB, {
        right_ear="Hectate's Earring",
    })

    sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS.MAB, {
        ammo = gear.MAbullet,
        neck = "Comm. Charm +2",
        ear1 = "Crematio Earring",
        ear2 = "Friomisi Earring",
        ring1 = "Epaminondas's Ring",
        ring2 = "Dingir Ring",
        waist = "Eschan Stone",
        legs = sets.Nyame.Legs,
        feet = "Lanun Bottes +3",
        back = gear.ranger_wsd_jse_back,
    })

    sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], { })
    sets.precast.WS['Hot Shot'] = {
        ammo=gear.MAbullet,
        head=sets.Nyame.Head,
        body=sets.Nyame.Body,
        hands="Chasseur's Gants +3",
        legs=sets.Nyame.Legs,
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Fotia Gorget",
        waist="Eschan Stone",
        left_ear="Moonshade earring",
        right_ear="Friomisi Earring",
        left_ring="Dingir Ring",
        right_ring="Epaminondas's Ring",
        back=gear.magic_wsd_jse_back,
    }
    sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS['Hot Shot'], { })

    --Because omen skillchains.
    sets.precast.WS['Burning Blade'] = set_combine(sets.engaged, { })

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = {}
    sets.AccMaxTP = {}

    -- Midcast Sets
    sets.midcast.FastRecast = {
        head = "Carmine Mask +1",
        neck = "Baetyl Pendant",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        body = "Dread Jupon",
        hands = "Leyline Gloves",
        ring1 = "Kishar Ring",
        ring2 = "Lebeche Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Rawhide Trousers",
        feet = "Carmine Greaves +1"
    }

    -- Specific spells

    sets.midcast.Cure = {
        head = "Carmine Mask +1",
        neck = "Phalaina Locket",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Mendi. Earring",
        body = "Dread Jupon",
        hands = "Leyline Gloves",
        ring1 = "Janniston Ring",
        ring2 = "Lebeche Ring",
        back = "Solemnity Cape",
        waist = "Flume Belt +1",
        legs = "Carmine Cuisses +1",
        feet = "Carmine Greaves +1"
    }

    sets.midcast.Absorb = {
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
        body="Chasseur's Frac +3",
        hands="Chasseur's Gants +3",
        legs="Chas. Culottes +3",
        feet="Chass. Bottes +3",
        neck={ name="Comm. Charm +2", augments={'Path: A',}},
        waist="Null Belt",
        left_ear="Mani Earring",
        right_ear="Chas. Earring +1",
        left_ring="Medada's Ring",
        right_ring="Weather. Ring +1",
        back={ name="Camulus's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.Self_Healing = { neck = "Phalaina Locket", hands = "Buremte Gloves", ring2 = "Kunaji Ring",
        waist = "Gishdubar Sash" }
    sets.Cure_Received = { neck = "Phalaina Locket", hands = "Buremte Gloves", ring2 = "Kunaji Ring",
        waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }

    sets.midcast.Utsusemi = sets.midcast.FastRecast

    -- Ranged gear
    sets.midcast.RA = {
        ammo = gear.RAbullet,
		head="Ikenga's Hat",
		body="Ikenga's Vest",
        hands="Malignance Gloves",
        legs={ name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
		feet="Ikenga's Clogs",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Crep. Earring",
		right_ear="Chas. Earring +1",
		left_ring="Ilabrat Ring",
		right_ring="Crepuscular Ring",
        back=gear.tp_ranger_jse_back
    }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        head = gear.Empy.Head,
        body = gear.Empy.Body,
        hands = gear.Empy.Hands,
		legs= gear.Empy.Legs,
        feet = gear.Empy.Feet,
        neck = "Null Loop",
        waist = "Null Belt",
        left_ear="Crep. Earring",
        right_ear="Telos Earring",
        left_ring="Crepuscular Ring",
        right_ring={ name="Cacoethic Ring +1", augments={'Path: A',}},
        back="Null Shawl",
    })

    sets.buff['Triple Shot'] = { 
        head="Oshosi Mask +1", -- Missing
        body=gear.Empy.Body, --14
        hands="Lanun Gants +3", -- Triple shot becomes Quad shot
        legs="Osh. Trousers +1", 
        feet="Osh. Leggings +1", --3
    }

    -- Sets to return to when not performing an action.

    sets.DayIdle = {}
    sets.NightIdle = {}

    sets.buff.Doom = set_combine(sets.buff.Doom, {})

    -- Resting sets
    sets.resting = {}
    sets.BulletPouch = { waist = "Chr. Bul. Pouch" }

    -- Idle sets
    sets.idle = {
        ammo = gear.RAbullet,
		head=sets.Malignance.Head,
		body=sets.Malignance.Body,
		hands=sets.Malignance.Hands,
		legs=gear.Empy.Legs,
		feet=sets.Malignance.Feet,
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Null Belt",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
    }

    sets.idle.PDT = {
        ammo = gear.RAbullet,
		head=sets.Nyame.Head,
		body=sets.Nyame.Body,
		hands=sets.Nyame.Hands,
		legs=sets.Nyame.Legs,
		feet=sets.Nyame.Feet,
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
    }

    sets.idle.Refresh = {
        ammo = gear.RAbullet,
        head = "Null Masque",
        neck = "Loricate Torque +1",
        ear1 = "Genmei Earring",
        ear2 = "Ethereal Earring",
        body = "Mekosu. Harness",
        hands = gear.herculean_refresh_hands,
        ring1 = "Defending Ring",
        ring2 = "Dark Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Rawhide Trousers",
        feet = "Malignance Boots"
    }

    -- Defense sets
    sets.defense.PDT = {
        ammo = gear.RAbullet,
        head = sets.Nyame.Head,
        neck = "Loricate Torque +1",
        ear1 = "Genmei Earring",
        ear2 = "Tuisto Earring",
        body = sets.Nyame.Body,
        hands = sets.Nyame.Hands,
        ring1 = "Defending Ring",
        ring2 = "Warden's Ring",
        back = "Shadow Mantle",
        waist = "Flume Belt +1",
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet
    }

    sets.defense.MDT = {
        ammo = gear.RAbullet,
        head = sets.Nyame.Head,
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = sets.Nyame.Body,
        hands = sets.Nyame.Hands,
        ring1 = "Defending Ring",
        ring2 = "Shadow Ring",
        back = "Moonlight Cape",
        waist = "Carrier's Sash",
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet
    }

    sets.defense.MEVA = {
        ammo = gear.RAbullet,
        head = sets.Nyame.Head,
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = sets.Nyame.Body,
        hands = sets.Nyame.Hands,
        ring1 = "Defending Ring",
        ring2 = "Shadow Ring",
        back = "Moonlight Cape",
        waist = "Carrier's Sash",
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet
    }

    sets.Kiting = { legs = "Carmine Cuisses +1" }
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.DWMax = { ear1 = "Dudgeon Earring", ear2 = "Heartseeker Earring", body = "Adhemar Jacket +1",
        hands = "Floral Gauntlets", waist = "Reiki Yotai" }

    -- Weapons sets
    sets.weapons.Default = { main = "Naegling", sub = "Nusku Shield", range = "Fomalhaut" }
    sets.weapons.Savage = {
        main = "Naegling", 
        sub = "Nusku Shield", 
        range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}}, 
    }
    sets.weapons.Onion = {
        main = "Onion Sword III", 
        sub = "Nusku Shield", 
        range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}}, 
    }
    sets.weapons.Ranged = { 
		main={ name="Rostam", augments={'Path: A'}},
        sub = "Nusku Shield", 
        range = "Fomalhaut"
    }
    sets.weapons.RangedAcc = { 
        main = "Kustawi +1", 
        sub = "Nusku Shield", 
        range = "Fomalhaut"
    }
    sets.weapons.Evisceration = { 
        main = "Tauret", 
        sub = "Nusku Shield", 
        range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}}, 
    }
    sets.weapons.LeadenMelee = { 
		main={ name="Rostam", augments={'Path: A'}},
        sub = "Nusku Shield", 
		range="Death Penalty", 
		ammo="Living Bullet",
    }
    sets.weapons.DualWeapons = { main = "Naegling", sub = "Gleti's Knife", range = "Magnatus" }
    sets.weapons.DualSavageWeapons = { 
        main="Naegling",
		sub="Gleti's Knife",
		range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}}, 
    }
    sets.weapons.DualOnion = { 
        main="Onion Sword III",
		sub="Gleti's Knife",
		range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}}, 
    }    
    sets.weapons.DualEvisceration = { 
        main = "Tauret", 
        sub = "Gleti's Knife", 
        range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}},
    }
    sets.weapons.DualLeadenRanged = { 
		main={ name="Rostam", augments={'Path: A'}},
		sub="Kustawi +1",
		range="Death Penalty", 
		ammo="Living Bullet",
    }
    sets.weapons.DualLeadenMelee = { 
		main={ name="Rostam", augments={'Path: A'}},
        sub = "Gleti's Knife", 
        range = "Death Penalty",
        ammo="Living Bullet",
    }
    sets.weapons.DualAeolian = { 
		ammo="Living Bullet",
        main={ name="Rostam", augments={'Path: A'}},
        sub="Gleti's Knife",
		range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}},    
    }
    sets.weapons.DualRanged = {
		main={ name="Rostam", augments={'Path: A'}},
        sub="Gleti's Knife",
		range={ name="Fomalhaut", augments={'Path: A',}},
		ammo="Chrono Bullet",
    }
    sets.weapons.DualRoll = { 
		main={ name="Rostam", augments={'Path: C'}},
        sub = "Gleti's Knife", 
        range = "Compensator",
        ammo="Living Bullet",
    }
    sets.weapons.DualFermion = {
        main="Fermion Sword",
        sub="Qutrub Knife",
        range="Death Penalty",
        ammo="Living Bullet",
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group

    --[[
        main  Naegling
        sub  Demersal Degen +1 R15
        ranged  Fomalhaut R15
        ammo  Chrono Bullet
        head  Malignance Chapeau
        body  Adhemar Jacket +1 A
        hands  Adhemar Wristbands +1 A
        legs  Chasseur's Culottes +3
        feet  Herculean Boots QA
        neck  Lissome Necklace
        waist  Reiki Yotai
        ear1  Suppanomimi
        ear2  Telos Earring
        ring1  Chirich Ring +1 A
        ring2  Chirich Ring +1 B
        back  Camulus's Mantle DEX Dual Wield
    ]]
    sets.engaged = {
        head= sets.Malignance.Head,
        neck = "Iskur Gorget",
        ear1 = "Telos Earring",
        ear2 = "Dedition Earring",
        body = "Adhemar Jacket +1",
        hands = "Adhemar Wrist. +1",
		ring1="Lehko's Ring",
        ring2 = "Epona's Ring",
        waist = "Windbuffet Belt +1",
        legs = gear.Empy.Legs,
        feet = "Herculean Boots",
        back = gear.tp_jse_back,
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        hands = "Gazu Bracelets +1",
    })

    sets.engaged.DT = set_combine(sets.engaged, {
        head=sets.Malignance.Head,
        body=sets.Malignance.Body,
        hands=sets.Malignance.Hands,
        legs=gear.Empy.Legs,
        feet = sets.Malignance.Feet,
        neck="Iskur Gorget",
        waist="Sailfi Belt +1",
        left_ear = "Telos Earring",
        right_ear="Dedition Earring",
		ring1="Lehko's Ring",
        right_ring="Epona's Ring",
        back = gear.tp_jse_back,
    })

    sets.engaged.Acc.DT = {
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Ramuh Ring +1",
        back = gear.tp_jse_back,
        waist = "Olseni Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.DW = set_combine(sets.engaged, {
		ear2 = "Suppanomimi",
        waist = "Reiki Yotai",
    })

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
        hands = "Gazu Bracelets +1",
        legs = "Carmine Cuisses +1",
        waist = "Kentarch Belt +1",
    })

    sets.engaged.DW.DT = {
        head=sets.Malignance.Head,
        body=sets.Malignance.Body,
        hands=sets.Malignance.Hands,
        legs=gear.Empy.Legs,
        feet = sets.Malignance.Feet,
        neck = "Iskur Gorget",
        ear1 = "Suppanomimi",
        ear2 = "Dedition Earring",
		ring1 = "Lehko's Ring",
        ring2 = "Epona's Ring",
        back = gear.tp_jse_back,
        waist = "Reiki Yotai",
    }

    sets.engaged.DW.Acc.DT = {
        head=sets.Malignance.Head,
        body=sets.Malignance.Body,
        hands=sets.Malignance.Hands,
        legs=gear.Empy.Legs,
        feet = sets.Malignance.Feet,
        neck = "Loricate Torque +1",
        ear1 = "Suppanomimi",
        ear2 = "Telos Earring",
        ring1="Lehko's Ring",
        ring2 = "Defending Ring",
        back = gear.tp_jse_back,
        waist = "Reiki Yotai",
    }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(2, 11)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 11)
    elseif player.sub_job == 'RNG' then
        set_macro_page(9, 11)
    elseif player.sub_job == 'DRG' then
        set_macro_page(5, 11)
    else
        set_macro_page(2, 11)
    end
end

function user_job_lockstyle()
    windower.chat.input('/lockstyleset 001') 
end

autows_list = { ['Default'] = 'Savage Blade', ['Evisceration'] = 'Evisceration', ['Savage'] = 'Savage Blade',
    ['Ranged'] = 'Last Stand', ['DualWeapons'] = 'Savage Blade', ['DualSavageWeapons'] = 'Savage Blade',
    ['DualEvisceration'] = 'Evisceration', ['DualLeadenRanged'] = 'Leaden Salute', ['DualLeadenMelee'] = 'Leaden Salute',
    ['DualAeolian'] = 'Aeolian Edge', ['DualRanged'] = 'Last Stand' }
