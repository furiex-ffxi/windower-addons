-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'Proc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    state.HybridMode:options('Normal', 'DT')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None', 'DWMax' }
    state.Weapons:options('Default', 'Ranged', 'RangedAcc', 'Savage', 'Evisceration', 'LeadenMelee', 'DualWeapons', 'DualSavageWeapons',
        'DualEvisceration', 'DualLeadenRanged', 'DualLeadenMelee', 'DualAeolian', 'DualRanged', 'DualRoll',
        'DualFermion', 'None')
    state.CompensatorMode:options('Always', '300', '1000', 'Never')

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15
    --Ikenga_vest_bonus = 190  -- It is 190 at R20. Uncomment if you need to manually adjust because you are using below R20

    -- Needs more racc
    gear.tp_ranger_jse_back = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Damage taken-5%',}}
    gear.snapshot_jse_back = { name = "Camulus's Mantle", augments = { '"Snapshot"+10', } }
    gear.tp_jse_back = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    gear.ranger_wsd_jse_back = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}}
    -- needs more agi
    gear.magic_wsd_jse_back = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%','Mag. Evasion+15',}}
    gear.str_wsd_jse_back = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

    gear.Empy = {}
    gear.Empy.Head = "Chass. Tricorne +3"
    gear.Empy.Body = "Chasseur's Frac +3"
    gear.Empy.Hands = "Chasseur's Gants +3"
    gear.Empy.Legs = "Chas. Culottes +3"
    gear.Empy.Feet = "Chass. Bottes +3"

    -- Additional local binds
    send_command('bind ^` gs c cycle ElementalMode')
    send_command('bind !` gs c elemental quickdraw')

    send_command('bind ^backspace input /ja "Double-up" <me>')
    send_command('bind @backspace input /ja "Snake Eye" <me>')
    send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')

    send_command('bind ^\\\\ input /ja "Random Deal" <me>')
    send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
    send_command('bind ^@!\\\\ gs c toggle LuzafRing')
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

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Triple Shot'] = { 
        head="Oshosi Mask +1", -- Missing
        body=gear.Empy.Body, --14
        hands="Lanun Gants +3", -- Triple shot becomes Quad shot
        legs="Osh. Trousers +1", -- Missing
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

    sets.precast.CorsairShot = {
        ammo=gear.QDbullet,
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Chass. Bottes +3",
        neck="Sibyl Scarf",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Hecate's Earring",
        left_ring="Acumen Ring",
        right_ring="Dingir Ring",
        back=gear.ranger_wsd_jse_back,
    }

    sets.precast.CorsairShot.Damage = {
        ammo = gear.QDbullet,
        head = gear.herculean_nuke_head,
        neck = "Sanctity Necklace",
        ear1 = "Friomisi Earring",
        ear2 = "Crematio Earring",
        body = "Samnuha Coat",
        hands = "Leyline Gloves",
        ring1 = "Shiva Ring +1",
        ring2 = "Dingir Ring",
        back = gear.ranger_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Malignance Tights",
        feet = gear.Empy.Feet
    }

    sets.precast.CorsairShot.Proc = {
        ammo = gear.RAbullet,
        head = "Wh. Rarab Cap +1",
        neck = "Loricate Torque +1",
        ear1 = "Genmei Earring",
        ear2 = "Sanare Earring",
        body = "Emet Harness +1",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Dark Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Carmine Cuisses +1",
        feet = gear.Empy.Feet
    }

    sets.precast.CorsairShot['Light Shot'] = {
        ammo = gear.QDbullet,
        head = "Carmine Mask +1",
        neck = "Sanctity Necklace",
        ear1 = "Digni. Earring",
        ear2 = "Telos Earring",
        body = "Mummu Jacket +2",
        hands = "Leyline Gloves",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.ranger_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Malignance Tights",
        feet = "Mummu Gamash. +2"
    }

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
        body="Laksa. Frac +3", -- 18/0
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- 8/11
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}, -- 10/13
		feet="Meg. Jam. +2", -- 10/0
		-- left_ear={ name="Tuisto Earring", priority=2},
		-- right_ear={ name="Etiolation Earring", priority=1},
		left_ring="Dingir Ring",
		right_ring="Crepuscular Ring", -- 3/0
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, -- 4/0
		waist="Yemaya Belt", -- 0/5
		back=gear.snapshot_jse_back, -- 10/0
    } -- Totals 50/43

    sets.precast.RA.Flurry = set_combine(sets.precast.RA, { body="Laksa. Frac +3", }) -- Totals 45/63
    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, { feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}} }) -- Totals 35/73


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
        -- right_ring="Cornelia's ring",
        right_ring="Epaminondas's Ring",
		back=gear.str_wsd_jse_back,
    }

    sets.precast.WS.Acc = {
        head = "Carmine Mask +1",
        neck = "Combatant's Torque",
        ear1 = "Digni. Earring",
        ear2 = "Telos Earring",
        body = "Meg. Cuirie +2",
        hands = "Meg. Gloves +2",
        ring1 = "Regal Ring",
        ring2 = "Ilabrat Ring",
        back = gear.str_wsd_jse_back,
        waist = "Grunfeld Rope",
        legs = "Carmine Cuisses +1",
        feet = "Lanun Bottes +3"
    }

    sets.precast.WS.Proc = {
        head = "Carmine Mask +1",
        neck = "Combatant's Torque",
        ear1 = "Digni. Earring",
        ear2 = "Mache Earring +1",
        body = "Mummu Jacket +2",
        hands = "Floral Gauntlets",
        ring1 = "Ramuh Ring +1",
        ring2 = "Ramuh Ring +1",
        back = gear.tp_jse_back,
        waist = "Olseni Belt",
        legs = "Carmine Cuisses +1",
        feet = "Malignance Boots"
    }

    sets.precast.WS.MAB = set_combine(sets.precast.WS, {
        ammo = gear.MAbullet,
        head = "Nyame Helm",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		body="Lanun Frac +3",
        hands = "Nyame Gauntlets",
		legs="Nyame Flanchard",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Crematio Earring",
		left_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,
        { head = "Carmine Mask +1", ring2 = "Rufescent Ring", legs = "Carmine Cuisses +1", feet = "Carmine Greaves +1" })

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo = gear.WSbullet,
        head = "Mummu Bonnet +2",
        neck = "Fotia Gorget",
        ear1 = "Odr Earring",
        ear2 = "Moonshade Earring",
        body = "Mummu Jacket +2",
        hands = "Mummu Wrists +2",
        ring1 = "Mummu Ring",
        ring2 = "Begrudging Ring",
        back = gear.tp_jse_back,
        waist = "Fotia Belt",
        legs = "Mummu Kecks +2",
        feet = "Mummu Gamash. +2"
    })

    sets.precast.WS['Evisceration'].Acc = {
        ammo = gear.WSbullet,
        head = "Mummu Bonnet +2",
        neck = "Fotia Gorget",
        ear1 = "Odr Earring",
        ear2 = "Moonshade Earring",
        body = "Mummu Jacket +2",
        hands = "Mummu Wrists +2",
        ring1 = "Regal Ring",
        ring2 = "Begrudging Ring",
        back = gear.tp_jse_back,
        waist = "Fotia Belt",
        legs = "Mummu Kecks +2",
        feet = "Mummu Gamash. +2"
    }

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        
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

    sets.precast.WS['Last Stand'] = set_combine({sets.precast.WS,
        -- ammo = gear.WSbullet,
        head={ name="Nyame Helm", augments={'Path: B',}},
        body="Laksa. Frac +3",
        hands=gear.Empy.Hands,
        legs = "Chas. Cullotes +2",
        feet = "Lanun Bottes +3",
        neck="Comm. Charm +2",
        -- waist = "Fotia Belt",
        waist="Sailfi Belt +1",
        left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
        -- ring1 = "Cornelia's ring",
        left_ring="Epaminondas's Ring",
        -- ring2 = "Regal Ring",
        right_ring="Dingir Ring",
        back=gear.ranger_wsd_jse_back,
    })
    sets.precast.WS['Last Stand'].Acc = {
        ammo = gear.WSbullet,
        head = "Meghanada Visor +2",
        neck = "Iskur Gorget",
        ear1 = "Moonshade Earring",
        ear2 = "Telos Earring",
        body = "Laksa. Frac +3",
        hands = "Meg. Gloves +2",
        ring1 = "Regal Ring",
        ring2 = "Dingir Ring",
        back = gear.ranger_wsd_jse_back,
        waist = "Fotia Belt",
        legs = "Meg. Chausses +2",
        feet = "Lanun Bottes +3"
    }

    sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Detonator'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Slug Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Numbing Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Sniper Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Sniper Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Split Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Split Shot'].Acc = sets.precast.WS['Last Stand'].Acc

    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS.MAB, {
		head="Pixie Hairpin +1",
		left_ear="Friomisi Earring",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		right_ring="Archon Ring",
		left_ring="Dingir Ring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		-- waist="Orpheus's Sash",   -- Changes based off elemental function
        waist="Eschan Stone",
		back=gear.magic_wsd_jse_back,
	})

    sets.precast.WS['Leaden Salute'].Acc = {
        ammo = gear.MAbullet,
        head = "Pixie Hairpin +1",
        neck = "Comm. Charm +2",
        ear1 = "Moonshade Earring",
        ear2 = "Friomisi Earring",
        hands = "Carmine Fin. Ga. +1",
        ring1 = "Archon Ring",
        ring2 = "Dingir Ring",
        back = gear.magic_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Nyame Flanchard",
        feet = "Lanun Bottes +3"
    }

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB, {
        ammo="Animikii Bullet",
        right_ear="Hectate's Earring",
		back=gear.magic_wsd_jse_back,
		body="Lanun Frac +3",
    })

    sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS.MAB, {
        ammo = gear.MAbullet,
        neck = "Comm. Charm +2",
        ear1 = "Crematio Earring",
        ear2 = "Friomisi Earring",
        ring1 = "Epaminondas's Ring",
        ring2 = "Dingir Ring",
        back = gear.magic_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Nyame Flanchard",
        feet = "Lanun Bottes +3"
    })

    sets.precast.WS['Wildfire'].Acc = {
        ammo = gear.MAbullet,
        head = gear.herculean_nuke_head,
        neck = "Comm. Charm +2",
        ear1 = "Crematio Earring",
        ear2 = "Friomisi Earring",
        body = "Laksa. Frac +3",
        hands = "Leyline Gloves",
        ring1 = "Regal Ring",
        ring2 = "Dingir Ring",
        back = gear.magic_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Nyame Flanchard",
        feet = "Lanun Bottes +3"
    }

    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
    sets.precast.WS['Hot Shot'].Acc = sets.precast.WS['Wildfire'].Acc

    --Because omen skillchains.
    sets.precast.WS['Burning Blade'] = {
        ammo = gear.RAbullet,
        head = "Meghanada Visor +2",
        neck = "Loricate Torque +1",
        ear1 = "Genmei Earring",
        ear2 = "Sanare Earring",
        body = "Meg. Cuirie +2",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Dark Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Meg. Chausses +2",
        feet = "Meg. Jam. +2"
    }

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
		hands="Ikenga's Gloves",
		legs="Chas. Cullotes +2",
		feet="Ikenga's Clogs",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Crep. Earring",
        right_ear = "Telos Earring",
		-- right_ear="Chas. Earring +1",
		left_ring="Ilabrat Ring",
		right_ring="Crepuscular Ring",
        back=gear.tp_ranger_jse_back
    }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        head = "Malignance Chapeau",
        body = "Laksa. Frac +3",
        hands = "Malignance Gloves",
		legs="Chas. Cullotes +2",
		-- feet=gear.Empy.Feet,
        -- ring1 = "Regal Ring",
        -- legs = "Laksa. Trews +3",
        feet = "Malignance Boots"
    })

    sets.buff['Triple Shot'] = { 
        head="Oshosi Mask +1", -- Missing
        body=gear.Empy.Body, --14
        hands="Lanun Gants +3", -- Tripple shot becomes Quad shot
        legs="Osh. Trousers +1", -- Missing
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
		waist="Sailfi Belt +1",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
    }

    sets.idle.PDT = {
        ammo = gear.RAbullet,
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
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
        head = "Rawhide Mask",
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
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Genmei Earring",
        ear2 = "Tuisto Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Defending Ring",
        ring2 = "Warden's Ring",
        back = "Shadow Mantle",
        waist = "Flume Belt +1",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MDT = {
        ammo = gear.RAbullet,
        head = "Nyame Helm",
        neck = "Warder's Charm +1",
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

    sets.defense.MEVA = {
        ammo = gear.RAbullet,
        head = "Nyame Helm",
        neck = "Warder's Charm +1",
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

    sets.Kiting = { legs = "Carmine Cuisses +1" }
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.DWMax = { ear1 = "Dudgeon Earring", ear2 = "Heartseeker Earring", body = "Adhemar Jacket +1",
        hands = "Floral Gauntlets", waist = "Reiki Yotai" }

    -- Weapons sets
    sets.weapons.Default = { main = "Naegling", sub = "Nusku Shield", range = "Fomalhaut" }
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
    sets.weapons.DualEvisceration = { 
        main = "Tauret", 
        sub = "Blurred Knife +1", 
        range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}},
    }
    sets.weapons.Savage = {
        main = "Naegling", 
        sub = "Nusku Shield", 
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
        head=sets.Malignance.Head,
        neck = "Iskur Gorget",
        ear1 = "Telos Earring",
        ear2 = "Dedition Earring",
        body = "Adhemar Jacket +1",
        hands = "Adhemar Wrist. +1",
		ring1="Lehko's Ring",
        ring2 = "Epona's Ring",
        back = gear.tp_jse_back,
        waist = "Windbuffet Belt +1",
        legs = gear.Empy.Legs,
        feet = "Herculean Boots"
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
        left_ear="Crep. Earring",
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
    if player.equipment.main == nil or player.equipment.main == 'empty' then
        windower.chat.input('/lockstyleset 001')
    elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
        if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Sword/Nothing.
            windower.chat.input('/lockstyleset 001')
        elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Sword/Shield
            windower.chat.input('/lockstyleset 002')
        elseif res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
            windower.chat.input('/lockstyleset 003')
        elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
            windower.chat.input('/lockstyleset 001')
        else
            windower.chat.input('/lockstyleset 001')                       --Catchall just in case something's weird.
        end
    elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
        if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Dagger/Nothing.
            windower.chat.input('/lockstyleset 001')
        elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Dagger/Shield
            windower.chat.input('/lockstyleset 002')
        elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
            windower.chat.input('/lockstyleset 004')
        else
            windower.chat.input('/lockstyleset 001') --Catchall just in case something's weird.
        end
    end
end

autows_list = { ['Default'] = 'Savage Blade', ['Evisceration'] = 'Evisceration', ['Savage'] = 'Savage Blade',
    ['Ranged'] = 'Last Stand', ['DualWeapons'] = 'Savage Blade', ['DualSavageWeapons'] = 'Savage Blade',
    ['DualEvisceration'] = 'Evisceration', ['DualLeadenRanged'] = 'Leaden Salute', ['DualLeadenMelee'] = 'Leaden Salute',
    ['DualAeolian'] = 'Aeolian Edge', ['DualRanged'] = 'Last Stand' }
