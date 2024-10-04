-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'Proc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    state.HybridMode:options('Normal', 'DT')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None', 'DWMax' }
    state.Weapons:options('Default', 'Ranged', 'Savage', 'Evisceration', 'DualWeapons', 'DualSavageWeapons',
        'DualEvisceration', 'DualLeadenRanged', 'DualLeadenMelee', 'DualAeolian', 'DualLeadenMeleeAcc', 'DualRanged',
        'DualProcWeapons', 'None')
    state.CompensatorMode:options('Always', '300', '1000', 'Never')

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Chrono Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15
    --Ikenga_vest_bonus = 190  -- It is 190 at R20. Uncomment if you need to manually adjust because you are using below R20

    gear.tp_ranger_jse_back = { name = "Camulus's Mantle",
        augments = { 'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'Rng.Acc.+10', '"Store TP"+10', } }
    gear.snapshot_jse_back = { name = "Camulus's Mantle", augments = { '"Snapshot"+10', } }
    gear.tp_jse_back = { name = "Camulus's Mantle",
        augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dual Wield"+10', 'Phys. dmg. taken-10%' } }
    gear.ranger_wsd_jse_back = { name = "Camulus's Mantle",
        augments = { 'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', 'Weapon skill damage +10%', } }
    gear.magic_wsd_jse_back = { name = "Camulus's Mantle", 
        augments = { 'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',} }
    gear.str_wsd_jse_back = { name = "Camulus's Mantle",
        augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', } }

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
    gear.Empy = {}
    gear.Empy.Head = "Chass. Tricorne +2"
    gear.Empy.Body = "Chasseur's Frac +2"
    gear.Empy.Hands = "Chasseur's Gants +2"
    gear.Empy.Legs = "Chas. Culottes +2"
    gear.Empy.Feet = "Chass. Bottes +2"

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Triple Shot'] = { body = gear.Empy.Body }
    sets.precast.JA['Snake Eye'] = { legs = "Lanun Trews +3" }
    sets.precast.JA['Wild Card'] = { feet = "Lanun Bottes +3" }
    sets.precast.JA['Random Deal'] = { body = "Lanun Frac +3" }
    sets.precast.FoldDoubleBust = { hands = "Lanun Gants +3" }

    sets.precast.CorsairRoll = {
        main = "Rostam",
        range = "Compensator",
        head = "Lanun Tricorne +3",
        neck = "Regal Necklace",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = "Lanun Frac +3",
        hands = "Chasseur's Gants +2",
        ring1 = "Defending Ring",
        ring2 = "Dark Ring",
        back = gear.tp_jse_back,
        waist = "Flume Belt +1",
        legs = "Desultor Tassets",
        feet = "Malignance Boots"
    }

    sets.precast.LuzafRing = { ring2 = "Luzaf's Ring" }

    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, { legs = "Chas. Culottes +1" })
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, { feet = "Chass. Bottes +1" })
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, { head = "Chass. Tricorne +2" })
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, { body = gear.Empy.Body })
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, { hands = "Chasseur's Gants +2" })

    sets.precast.CorsairShot = {
        ammo = gear.QDbullet,
        head = gear.herculean_nuke_head,
        neck = "Iskur Gorget",
        ear1 = "Dedition Earring",
        ear2 = "Telos Earring",
        body = "Mummu Jacket +2",
        hands = "Adhemar Wristbands +1",
        ring1 = "Crepuscular Ring",
        ring2 = "Dingir Ring",
        back = gear.tp_ranger_jse_back,
        waist = "Goading Belt",
        legs = "Chas. Culottes +1",
        feet = "Carmine Greaves +1"
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
        feet = "Chass. Bottes +1"
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
        feet = "Chass. Bottes +1"
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

    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], { feet =
    "Chass. Bottes +1" })

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
		-- back=gear.snapshot_jse_back, -- 10/0
    } -- Totals 50/43

    sets.precast.RA.Flurry = set_combine(sets.precast.RA, { body="Laksa. Frac +3", }) -- Totals 45/63
    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, { feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}} }) -- Totals 35/73


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = gear.WSbullet,
		head=sets.Nyame.Head,
		body=sets.Nyame.Body,
		-- hands=gear.Empy.Hands,
		hands=sets.Nyame.Hands,
		legs=sets.Nyame.Legs,
		feet=sets.Nyame.Feet,
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
        right_ring="Epaminondas's Ring",
        back=gear.magic_wsd_jse_back,
		-- back=gear.str_wsd_jse_back,
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

    sets.precast.WS['Evisceration'] = {
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
    }

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
        neck = "Rep. Plat. Medal"
    })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        neck = "Rep. Plat. Medal"        
    })

    sets.precast.WS['Last Stand'] = {
        ammo=gear.RAbullet,
        head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
        -- body="Ikenga's Vest",
        hands="Chasseur's Gants +2",
        body = sets.Nyame.Body,
        legs = sets.Nyame.Legs,
        feet = { name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = { name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear = "Ishvara Earring",
        left_ring = "Regal Ring",
        right_ring = "Dingir Ring",
        back = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Damage taken-5%',}},
    }

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
    })

    sets.precast.WS['Split Shot'] = {
        ammo = gear.WSbullet,
        head = "Meghanada Visor +2",
        neck = "Comm. Charm +2",
        ear1 = "Moonshade Earring",
        ear2 = "Telos Earring",
        body = "Laksa. Frac +1",
        hands = "Meg. Gloves +2",
        ring1 = "Regal Ring",
        ring2 = "Dingir Ring",
        back = gear.ranger_wsd_jse_back,
        waist = "Fotia Belt",
        legs = "Meg. Chausses +2",
        feet = "Lanun Bottes +3"
    }

    sets.precast.WS['Split Shot'].Acc = {
        ammo = gear.WSbullet,
        head = "Meghanada Visor +2",
        neck = "Comm. Charm +2",
        ear1 = "Moonshade Earring",
        ear2 = "Telos Earring",
        body = "Laksa. Frac +1",
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
        waist="Eschan Stone",
		back=gear.magic_wsd_jse_back,
	})

    sets.precast.WS['Leaden Salute'].Acc = {
        ammo = gear.MAbullet,
        head = "Pixie Hairpin +1",
        neck = "Comm. Charm +2",
        ear1 = "Moonshade Earring",
        ear2 = "Friomisi Earring",
        body = "Laksa. Frac +1",
        hands = "Carmine Fin. Ga. +1",
        ring1 = "Archon Ring",
        ring2 = "Dingir Ring",
        back = gear.magic_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Nyame Flanchard",
        feet = "Lanun Bottes +3"
    }

    sets.precast.WS['Aeolian Edge'] = {
        ammo = "Animikii Bullet",
        head = gear.herculean_nuke_head,
        neck = "Baetyl Pendant",
        ear1 = "Moonshade Earring",
        ear2 = "Friomisi Earring",
        body = "Laksa. Frac +1",
        hands = "Carmine Fin. Ga. +1",
        ring1 = "Metamor. Ring +1",
        ring2 = "Dingir Ring",
        back = gear.magic_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Nyame Flanchard",
        feet = "Lanun Bottes +3"
    }

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
        head = "Nyame Helm",
        neck = "Comm. Charm +2",
        ear1 = "Crematio Earring",
        ear2 = "Friomisi Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Regal Ring",
        ring2 = "Dingir Ring",
        back = gear.magic_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
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
        head = "Malignance Chapeau",
        neck = "Iskur Gorget",
        ear1 = "Enervating Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Crepuscular Ring",
        ring2 = "Ilabrat Ring",
        back = gear.tp_ranger_jse_back,
        waist = "Yemaya Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.midcast.RA.Acc = {
        ammo = gear.RAbullet,
        head = "Malignance Chapeau",
        neck = "Iskur Gorget",
        ear1 = "Enervating Earring",
        ear2 = "Telos Earring",
        body = "Laksa. Frac +1",
        hands = "Malignance Gloves",
        ring1 = "Regal Ring",
        ring2 = "Ilabrat Ring",
        back = gear.tp_ranger_jse_back,
        waist = "Yemaya Belt",
        legs = "Laksa. Trews +1",
        feet = "Malignance Boots"
    }

    sets.buff['Triple Shot'] = { body = gear.Empy.Body }

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
    sets.weapons.Default = { main = "Qutrub Knife", sub = "Nusku Shield", range = "Anarchy +2" }
    sets.weapons.Ranged = { main = "Qutrub Knife", sub = "Nusku Shield", range = "Anarchy +2" }
    sets.weapons.Evisceration = { main = "Tauret", sub = "Nusku Shield", range = "Anarchy +2" }
    sets.weapons.DualWeapons = { main = "Naegling", sub = "Gleti's Knife", range = "Magnatus" }
    sets.weapons.DualSavageWeapons = { main = "Naegling", sub = "Gleti's Knife", range = "Anarchy +2" }
    sets.weapons.DualEvisceration = { main = "Tauret", sub = "Blurred Knife +1", range = "Anarchy +2" }
    sets.weapons.Savage = { main = "Naegling", sub = "Nusku Shield", range = "Anarchy +2" }
    sets.weapons.DualLeadenRanged = { main = "Tauret", sub = "Gleti's Knife", range = "Fomalhaut" }
    sets.weapons.DualLeadenMelee = { main = "Tauret", sub = "Gleti's Knife", range = "Fomalhaut" }
    sets.weapons.DualAeolian = { main = "Rostam", sub = "Tauret", range = "Anarchy +2" }
    sets.weapons.DualLeadenMeleeAcc = { main = "Tauret", sub = "Gleti's Knife", range = "Fomalhaut" }
    sets.weapons.DualRanged = { main = "Qutrub Knife", sub = "Gleti's Knife", range = "Anarchy +2" }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        head = sets.Malignance.Head,
        neck = "Iskur Gorget",
        ear1 = "Telos Earring",
        ear2 = "Dedition Earring",
        body = sets.Malignance.Body,
        hands = sets.Malignance.Hands,
        ring1 = "Petrov Ring",
        ring2 = "Ilabrat Ring",
        back = gear.tp_jse_back,
        waist = "Sailfi Belt +1",
        legs = "Samnuha Tights",
        feet = sets.Malignance.Feet        
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        hands = "Gazu Bracelets +1",
    })

    sets.engaged.DT = set_combine(sets.engaged, {
        head=sets.Malignance.Head,
        hands=sets.Malignance.Hands,
        legs=gear.Empy.Legs,
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
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Suppanomimi",
        ear2 = "Brutal Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Epona's Ring",
        back = gear.tp_jse_back,
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.DW.Acc.DT = {
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Suppanomimi",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Ramuh Ring +1",
        back = gear.tp_jse_back,
        waist = "Reiki Yotai",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
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
    windower.chat.input('/lockstyleset')
    -- if player.equipment.main == nil or player.equipment.main == 'empty' then
    --     windower.chat.input('/lockstyleset 001')
    -- elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
    --     if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Sword/Nothing.
    --         windower.chat.input('/lockstyleset 001')
    --     elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Sword/Shield
    --         windower.chat.input('/lockstyleset 002')
    --     elseif res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
    --         windower.chat.input('/lockstyleset 003')
    --     elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
    --         windower.chat.input('/lockstyleset 001')
    --     else
    --         windower.chat.input('/lockstyleset 001')                       --Catchall just in case something's weird.
    --     end
    -- elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
    --     if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Dagger/Nothing.
    --         windower.chat.input('/lockstyleset 001')
    --     elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Dagger/Shield
    --         windower.chat.input('/lockstyleset 002')
    --     elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
    --         windower.chat.input('/lockstyleset 004')
    --     else
    --         windower.chat.input('/lockstyleset 001') --Catchall just in case something's weird.
    --     end
    -- end
end

autows_list = { ['Default'] = 'Savage Blade', ['Evisceration'] = 'Evisceration', ['Savage'] = 'Savage Blade',
    ['Ranged'] = 'Split Shot', ['DualWeapons'] = 'Savage Blade', ['DualSavageWeapons'] = 'Savage Blade',
    ['DualEvisceration'] = 'Evisceration', ['DualLeadenRanged'] = 'Leaden Salute', ['DualLeadenMelee'] = 'Leaden Salute',
    ['DualAeolian'] = 'Aeolian Edge', ['DualRanged'] = 'Sniper Shot' }
