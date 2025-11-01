-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DTLite', 'DT')
    state.RangedMode:options('Normal', 'Acc', 'Crit')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc')
    state.IdleMode:options('Normal', 'PDT')
    state.Weapons:options('Default', 'Yoichi', 'Anni', 'DualEviscerationWeapons', 'DualGastra', 'DualYoichi', 'DualAnni', 'DualWeapons', 'DualSavageWeapons', 'DualSavageKraken', 'DualMagicWeapons',
        'DualMalevolence', 'DualFermion')

    -- Ikenga_vest_bonus = 180  -- It is 190 at R20. Uncomment if you need to manually adjust because you are using below R20

    WeaponType = {
        ['Fail-Not'] = "Bow",
        ['Fomalhaut'] = "Gun",
        ['Ataktos'] = "Gun",
        ['Annihilator'] = "Gun"
    }

    DefaultAmmo = {
        ['Bow'] = {
            ['Default'] = "Eminent Arrow",
            ['WS'] = "Eminent Arrow",
            ['Acc'] = "Eminent Arrow",
            ['Magic'] = "Eminent Arrow",
            ['MagicAcc'] = "Eminent Arrow",
            ['Unlimited'] = "Hauksbok Arrow",
            ['MagicUnlimited'] = "Hauksbok Arrow",
            ['MagicAccUnlimited'] = "Hauksbok Arrow"
        },

        ['Gun'] = {
            ['Default'] = "Chrono Bullet",
            ['WS'] = "Chrono Bullet",
            ['Acc'] = "Chrono Bullet",
            ['Magic'] = "Orichalc. Bullet",
            ['MagicAcc'] = "Orichalc. Bullet",
            ['Unlimited'] = "Hauksbok Bullet",
            ['MagicUnlimited'] = "Hauksbok Bullet",
            ['MagicAccUnlimited'] = "Animikii Bullet"
        },

        ['Crossbow'] = {
            ['Default'] = "Eminent Bolt",
            ['WS'] = "Eminent Bolt",
            ['Acc'] = "Eminent Bolt",
            ['Magic'] = "Eminent Bolt",
            ['MagicAcc'] = "Eminent Bolt",
            ['Unlimited'] = "Hauksbok Bolt",
            ['MagicUnlimited'] = "Hauksbok Bolt",
            ['MagicAccUnlimited'] = "Hauksbok Bolt"
        }
    }

    -- Additional local binds
    send_command('bind !` input /ra <t>')
    send_command('bind !backspace input /ja "Bounty Shot" <t>')
    send_command('bind @f7 gs c toggle RngHelper')
    send_command('bind @` gs c cycle SkillchainMode')
    send_command('bind !r gs c weapons MagicWeapons;gs c update')
    send_command('bind ^q gs c weapons SingleWeapon;gs c update')

    select_default_macro_book()

end

-- Set up all gear sets.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    gear.agi_wsd_jse_back = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.str_wsd_jse_back = { name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.tp_ranger_jse_back = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.snapshot_jse_back = { name="Belenus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Snapshot"+10','Mag. Evasion+15',}}
    gear.crit_jse_back = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}


    -- Precast sets to enhance JAs
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {
        hands = "Amini Glove. +3"
    })
    sets.precast.JA['Camouflage'] = {
        body = "Orion Jerkin +3"
    }
    sets.precast.JA['Scavenge'] = {
        feet = "Orion Socks +3"
    }
    sets.precast.JA['Shadowbind'] = {
        hands = "Orion Bracers +3"
    }
    sets.precast.JA['Sharpshot'] = {
        legs = "Orion Braccae +3"
    }
    sets.precast.JA['Double Shot'] = {
        back = gear.tp_ranger_jse_back
    }

    -- Fast cast sets for spells

    sets.precast.FC = {
        head = "Carmine Mask +1",
        neck = "Baetyl Pendant",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        body = "Dread Jupon",
        hands = "Leyline Gloves",
        ring1 = "Prolix Ring",
        ring2 = "Lebeche Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Rawhide Trousers",
        feet = "Carmine Greaves +1"
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck = "Magoraga Beads",
        body = "Passion Jacket"
    })

    -- Ranged sets (snapshot)

    sets.precast.RA = {
        neck="Scout's Gorget +2",
        left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        right_ear="Alabaster Earring",
        head = "Amini Gapette +3", -- 7
        body = "Amini Caban +3",
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- 8 / 11
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=2},
		right_ring="Crepuscular Ring", -- 3
        waist = "Yemaya Belt",
        legs = "Orion Braccae +3",
        feet = "Meg. Jam. +2",
        back = gear.snapshot_jse_back,
    } -- 38

    sets.precast.RA.Flurry = set_combine(sets.precast.RA, {
        head="Orion Beret +3",
	    legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}, -- 10/13
    })
    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
    })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head = "Orion Beret +3",
        neck = "Iskur Gorget",
        body = sets.Nyame.Body,
        hands = sets.Nyame.Hands,
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
        right_ring="Epaminondas's Ring",
        back = gear.agi_wsd_jse_back,
        waist = "Sailfi Belt +1",
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet
    }
    

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
	})

    sets.precast.WS['Savage Blade'] = {
        head = sets.Nyame.Head,
        neck = "Rep. Plat. Medal",
        body = sets.Nyame.Body,
        hands = sets.Nyame.Hands,
        left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="Ishvara Earring",
		left_ring="Sroda Ring",
        right_ring="Epaminondas's Ring",
        back = gear.str_wsd_jse_back,
        waist = "Sailfi Belt +1",
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet
    }

    sets.precast.WS['Wildfire'] = {
        head = "Orion Beret +3",
        neck = "Baetyl Pendant",
        ear1 = "Crematio Earring",
        ear2 = "Friomisi Earring",
        body = "Samnuha Coat",
        hands = "Carmine Fin. Ga. +1",
        ring1 = "Regal Ring",
        ring2 = "Dingir Ring",
        back = gear.agi_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Gyve Trousers",
        feet = gear.herculean_nuke_feet
    }

    sets.precast.WS['Wildfire'].Acc = {
        head = "Orion Beret +3",
        neck = "Sanctity Necklace",
        ear1 = "Crematio Earring",
        ear2 = "Friomisi Earring",
        body = "Samnuha Coat",
        hands = "Leyline Gloves",
        ring1 = "Regal Ring",
        ring2 = "Dingir Ring",
        back = gear.agi_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Gyve Trousers",
        feet = gear.herculean_nuke_feet
    }

    sets.precast.WS.MAB = set_combine(sets.precast.WS, {
        -- ammo = gear.MAbullet,
		feet=sets.Nyame.Feet,
		body=sets.Nyame.Body,
        hands = sets.Nyame.Hands,
		legs= sets.Nyame.Legs,
        waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hectate's Earring",
		left_ring="Dingir Ring",
        back=gear.agi_wsd_jse_back
	})

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB, {
        right_ear="Hectate's Earring",
		back=gear.magic_wsd_jse_back,
		body=sets.Nyame.Body,
    })

    sets.precast.WS['Trueflight'] = {
        head = "Orion Beret +3",
        neck = "Baetyl Pendant",
        ear1 = "Moonshade Earring",
        ear2 = "Friomisi Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Weatherspoon Ring",
        ring2 = "Dingir Ring",
        back = gear.agi_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Gyve Trousers",
        feet = gear.herculean_nuke_feet
    }

    sets.precast.WS['Trueflight'].Acc = {
        head = "Orion Beret +3",
        neck = "Sanctity Necklace",
        ear1 = "Crematio Earring",
        ear2 = "Friomisi Earring",
        body = "Samnuha Coat",
        hands = "Leyline Gloves",
        ring1 = "Regal Ring",
        ring2 = "Dingir Ring",
        back = gear.agi_wsd_jse_back,
        waist = "Eschan Stone",
        legs = "Gyve Trousers",
        feet = gear.herculean_nuke_feet
    }

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = {}
    sets.AccMaxTP = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Fast recast for spells

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

    -- Ranged sets

    sets.midcast.RA = {
        neck="Iskur Gorget",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
        head="Arcadian Beret +3",
        body = "Ikenga's Vest",
		hands = "Amini Glove. +3",
		legs = "Amini Bragues +3",
        left_ring = "Lehko's Ring",
		right_ring = "Crepuscular Ring",
        waist = "Tellen Belt",
        feet = "Ikenga's Clogs",
        back = gear.tp_ranger_jse_back,
    }

    sets.midcast.RA.Acc = {
        head = "Malignance Chapeau",
        neck = "Iskur Gorget",
        ear1 = "Enervating Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Regal Ring",
        ring2 = "Ilabrat Ring",
        back = gear.tp_ranger_jse_back,
        waist = "Yemaya Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.midcast.RA.Crit = {
        neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		left_ear="Odr Earring",
		right_ear="Sherida Earring", -- 5 II
        head = "Arcadian Beret +3",
        body="Amini Caban +3",
        hands="Amini Glove. +3",
        legs="Amini Bragues +3",
        feet={ name="Ikenga's Clogs", augments={'Path: A',}},
        waist={ name="Tellen Belt", augments={'Path: A',}},
		left_ring="Lehko's Ring",
		right_ring="Regal Ring",
        back = gear.crit_jse_back,
    }

    -- These sets will overlay based on accuracy level, regardless of other options.
    sets.buff.Camouflage = {
        body = "Orion Jerkin +3"
    }
    sets.buff.Camouflage.Acc = {}
    sets.buff['Double Shot'] = {}
    sets.buff['Double Shot'].Acc = {}
    sets.buff.Barrage = {
        hands = "Orion Bracers +3"
    }

    sets.Self_Healing = {
        neck = "Phalaina Locket",
        hands = "Buremte Gloves",
        ring2 = "Kunaji Ring",
        waist = "Gishdubar Sash"
    }
    sets.Cure_Received = {
        neck = "Phalaina Locket",
        hands = "Buremte Gloves",
        ring2 = "Kunaji Ring",
        waist = "Gishdubar Sash"
    }
    sets.Self_Refresh = {
        waist = "Gishdubar Sash"
    }

    sets.midcast.Utsusemi = sets.midcast.FastRecast

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Genmei Earring",
        ear2 = "Sanare Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Murky Ring",
        back = "Moonlight Cape",
        waist = "Carrier's Sash",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    -- Defense sets
    sets.defense.PDT = {
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Genmei Earring",
        ear2 = "Sanare Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Murky Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.defense.MDT = {
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Genmei Earring",
        ear2 = "Sanare Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Shadow Ring",
        back = "Moonlight Cape",
        waist = "Carrier's Sash",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.defense.MEVA = {
        head = "Malignance Chapeau",
        neck = "Warder's Charm +1",
        ear1 = "Genmei Earring",
        ear2 = "Sanare Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Vengeful Ring",
        back = "Moonlight Cape",
        waist = "Carrier's Sash",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.Kiting = {
        legs = "Carmine Cuisses +1"
    }
    sets.DayIdle = {}
    sets.NightIdle = {}
    sets.BulletPouch = {
        waist = "Chr. Bul. Pouch"
    }

    -- Weapons sets
    sets.weapons.Default = {
        main = "Kustawi +1",
        sub = "Nusku Shield",
        range = "Fail-Not",
        ammo = "Chrono Arrow"
    }
    sets.weapons.Anni = {
        main = "Kustawi +1",
        sub = "Nusku Shield",
        range = "Annihilator",
        ammo = "Chrono Bullet"
    }    
    sets.weapons.Yoichi = {
        main = "Perun +1",
        sub = "Nusku Shield",
        range = "Yoichinoyumi",
        ammo = "Chrono Arrow"
    }
    sets.weapons.DualWeapons = {
        main = "Kustawi +1",
        sub = "Gleti's Knife",
        range = "Fomalhaut",
        ammo = "Chrono Bullet"
    }
    sets.weapons.DualGastra = {
        main = "Kustawi +1",
        sub = "Malevolence",
        range = "Gastraphetes",
        ammo = "Quelling Bolt"
    }
    sets.weapons.DualAnni = {
        main = "Perun +1",
        sub = "Kustawi +1",
        range = "Annihilator",
        ammo = "Chrono Bullet"
    }    
    sets.weapons.DualYoichi = {
        main = "Perun +1",
        sub = "Kraken Club",
        range = "Yoichinoyumi",
        ammo = "Chrono Arrow"
    }
    sets.weapons.DualSavageWeapons = {
        main = "Naegling",
        sub = "Gleti's Knife",
        range = "Sparrowhawk +3",
        ammo = "Hauksbok Arrow"
    }
    sets.weapons.DualSavageKraken = {
        main = "Naegling",
        sub = "Kraken Club",
        range = "Sparrowhawk +3",
        ammo = "Hauksbok Arrow"
    }
    sets.weapons.DualEviscerationWeapons = {
        main = "Tauret",
        sub = "Malevolence",
        range = "Fomalhaut"
    }
    sets.weapons.DualMalevolence = {
        main = "Malevolence",
        sub = "Malevolence",
        range = "Fomalhaut"
    }
    sets.weapons.DualMagicWeapons = {
        main = "Tauret",
        sub = "Gleti's Knife",
        range = "Sparrowhawk +3",
        ammo = "Hauksbok Arrow"
    }

    sets.weapons.DualFermion = {
        main="Fermion Sword",
        sub="Qutrub Knife",
        range="Fomalhaut",
    }

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
        head = sets.Malignance.Head,
        neck = "Anu Torque",
        ear1 = "Dedition Earring",
        ear2 = "Sherida Earring",
        body = "Adhemar Jacket +1",
        hands = "Adhemar Wrist. +1",
        ring1 = "Epona's Ring",
        ring2 = "Lehko's Ring",
        back = "Null Shawl",
        waist = "Windbuffet Belt +1",
        legs = "Samnuha Tights",
        feet = "Herculean Boots"
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
       
    })

    sets.engaged.DTLite = set_combine(sets.engaged, {
       
    })

    sets.engaged.DT = set_combine(sets.engaged, {
        body = sets.Malignance.Body,
        hands = sets.Malignance.Hands,
        legs = sets.Malignance.Legs,   
    })

    sets.engaged.DW = set_combine(sets.engaged, {
        ear1 = "Suppanomimi"
    })

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, {
        body = sets.Malignance.Body,
        hands = sets.Malignance.Hands,
        legs = sets.Malignance.Legs,   
    })

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
       
    })

    sets.engaged.DualSavageKraken = set_combine(sets.engaged, {
        neck = "Iskur Gorget",
        head = sets.Malignance.Head,
        body = sets.Malignance.Body,
        hands = sets.Malignance.Hands,
        legs = sets.Malignance.Legs,
        feet = sets.Malignance.Feet, 
        waist = "Goading Belt",
        ear1 = "Dedition Earring",
    })

    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(1, 19)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 19)
    elseif player.sub_job == 'DRG' then
        set_macro_page(3, 19)
    else
        set_macro_page(1, 19)
    end
end

function user_job_lockstyle()
    windower.chat.input('/lockstyleset 004') 
end