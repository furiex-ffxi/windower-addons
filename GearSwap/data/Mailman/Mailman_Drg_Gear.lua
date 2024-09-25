-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.WeaponskillMode:options('Match', 'Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal', 'PDT', 'Refresh', 'Reraise')
    state.ExtraMeleeMode = M {
        ['description'] = 'Extra Melee Mode',
        'None'
    }
    state.Weapons:options('Shining One', 'Naegling') -- 'Trishula', 
    state.Passive = M {
        ['description'] = 'Passive Mode',
        'None',
        'MP',
        'Twilight'
    }

    select_default_macro_book()

    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind @f7 gs c toggle AutoJumpMode')
    send_command('bind @` gs c cycle SkillchainMode')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    gear.af = {
        Head = "Vishap Armet +2",
        Body = "Vishap Mail +2",
        Hands = "Vis. Fing. Gaunt. +2",
        Legs = "Vishap Brais +2",
        Feet = "Vishap Greaves +2",
    }

    gear.empy = {
        Head = "Peltast's Mezail +2",
        Body = "Pelt. Plackart +2",
        Hands = "Pel. Vambraces +2",
        Legs = "Pelt. Cuissots +2",
        Feet = "Pelt. Schyn. +2",
    }
    
    gear.relic = {
        Head = "Ptero. Armet +3",
        Body = "Ptero. Mail +3",
        Hands = "Ptero. Fin. G. +3",
        Legs = "Ptero. Brais +3",
        Feet = "Ptero. Greaves +3",
    }

    gear.str_wsd_jse_back = {
        name = "Brigantia's Mantle",
        augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
    }
    gear.tp_jse_back = {
        name = "Brigantia's Mantle",
        augments = {'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
    }

    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Angon = {
        ammo = "Angon",
        hands = gear.relic.Hands,
    }
    sets.precast.JA.Jump = {
        ammo = "Coiste Bodhar",
        head = gear.relic.Head,
        neck = "Dgn. Collar +2",
        ear1 = "Crep. Earring",
        ear2 = "Sherida Earring",
        body = gear.relic.Body,
        hands = gear.empy.Hands,
        ring1 = "Petrov Ring",
        ring2 = "Niqmaddu Ring",
        back = gear.tp_jse_back,
        waist = "Sailfi Belt +1",
        legs = gear.relic.Legs,
        feet = "Maenadic Gambieras"
    }
    sets.precast.JA['Ancient Circle'] = {
        legs = gear.af.Legs,
    }
    sets.precast.JA['High Jump'] = sets.precast.JA.Jump
    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {
        feet = gear.empy.Feet,
    })
    sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {
        feet = gear.empy.Feet,
    })
    sets.precast.JA['Super Jump'] = {}
    sets.precast.JA['Spirit Link'] = {
        head = gear.af.Head,
        hands = gear.relic.Hands,
    }
    sets.precast.JA['Call Wyvern'] = { body = gear.relic.Body, } 
    sets.precast.JA['Deep Breathing'] = { hands = gear.relic.Hands, }
    sets.precast.JA['Spirit Surge'] = { body = gear.relic.Body, }
    sets.precast.JA['Steady Wing'] = {}

    -- Breath sets
    sets.precast.JA['Restoring Breath'] = {
        back = "Brigantia's Mantle"
    }
    sets.precast.JA['Smiting Breath'] = {
        back = "Brigantia's Mantle"
    }
    sets.HealingBreath = {
        back = "Brigantia's Mantle"
    }
    -- sets.SmitingBreath = {back="Brigantia's Mantle"}

    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo = "Impatiens",
        head = "Carmine Mask +1",
        neck = "Voltsurge Torque",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        body = gear.taeon_pet_body,
        hands = "Leyline Gloves",
        ring1 = "Lebeche Ring",
        ring2 = "Prolix Ring",
        back = "Moonlight Cape",
        waist = "Flume Belt +1",
        legs = "Founder's Hose",
        feet = "Carmine Greaves +1"
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.midcast.Cure = {}

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

    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo = "Staunch Tathlum +1",
        head = "Carmine Mask +1",
        neck = "Voltsurge Torque",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        body = gear.taeon_pet_body,
        hands = "Leyline Gloves",
        ring1 = "Lebeche Ring",
        ring2 = "Prolix Ring",
        back = "Moonlight Cape",
        waist = "Tempus Fugit",
        legs = "Founder's Hose",
        feet = "Carmine Greaves +1"
    }

    -- Put HP+ gear and the AF head to make healing breath trigger more easily with this set.
    sets.midcast.HB_Trigger = set_combine(sets.midcast.FastRecast, {
        head = gear.af.Head,
    })

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined

    sets.precast.WS = {
        ammo = "Knobkierrie",
        head = sets.Nyame.Head,
        body = sets.Nyame.Body,
        hands = sets.Nyame.Hands,
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet,
        waist = "Sailfi Belt +1",
        left_ear = {
            name = "Moonshade Earring",
            augments = {'Accuracy+4', 'TP Bonus +250'}
        },
        right_ear = "Ishvara Earring",
        -- left_ring="Regal Ring",
        left_ring = "Karieyh Ring",
        right_ring = "Epaminondas's Ring",
        back = gear.str_wsd_jse_back
    }

    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        neck = "Shulmanu Collar"
    })
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {
        neck = "Shulmanu Collar"
    })
    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Stardiver'].SomeAcc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Stardiver'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Drakesbane'].SomeAcc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Drakesbane'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        body = "Gleti's Cuirass"
    })
    sets.precast.WS['Impulse Drive'].SomeAcc = set_combine(sets.precast.WS.Acc, {
        body = "Gleti's Cuirass"
    })
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS.Acc, {
        body = "Gleti's Cuirass"
    })
    sets.precast.WS['Impulse Drive'].Fodder = set_combine(sets.precast.WS.Fodder, {
        body = "Gleti's Cuirass"
    })    

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {
        ammo = "Staunch Tathlum +1",
        head = gear.empy.Head,
        neck = "Dgn. Collar +2",
        ear1 = "Genmei Earring",
        ear2 = "Ethereal Earring",
        body = gear.relic.Body,
        hands = "Gleti's Gauntlets",
        ring1 = "Defending Ring",
        ring2 = "Shadow Ring",
        back = gear.tp_jse_back,
        waist = "Plat. Mog. Belt",
        legs = "Gleti's Breeches",
        feet = "Gleti's Boots"
    }

    sets.idle.Refresh = sets.idle

    sets.idle.Weak = set_combine(sets.idle, {
        head = "Twilight Helm",
        body = "Twilight Mail"
    })

    sets.idle.Reraise = set_combine(sets.idle, {
        head = "Twilight Helm",
        body = "Twilight Mail"
    })

    -- Defense sets
    sets.defense.PDT = sets.idle

    sets.defense.PDTReraise = set_combine(sets.defense.PDT, {
        head = "Twilight Helm",
        body = "Twilight Mail"
    })

    sets.defense.MDT = sets.idle

    sets.defense.MDTReraise = set_combine(sets.defense.MDT, {
        head = "Twilight Helm",
        body = "Twilight Mail"
    })

    sets.defense.MEVA = sets.idle

    sets.Kiting = {
        legs = "Carmine Cuisses +1"
    }
    sets.Reraise = {
        head = "Twilight Helm",
        body = "Twilight Mail"
    }
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Sleep = {
        head = "Frenzy Sallet"
    }

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.passive.MP = {
        ear2 = "Ethereal Earring",
        waist = "Flume Belt +1"
    }
    sets.passive.Twilight = {
        head = "Twilight Helm",
        body = "Twilight Mail"
    }
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    -- Weapons sets
    sets.weapons.Trishula = {
        main = "Trishula",
        sub = "Utu Grip"
    }

    sets.weapons["Shining One"] = {
        main = "Shining One",
        sub = "Utu Grip"
    }

    sets.weapons.Naegling = {
        main = "Naegling",
        sub = "Legion Scutum"
    }

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = {
        ear1 = "Lugra Earring +1",
        ear2 = "Sherida Earring"
    }
    sets.AccMaxTP = {
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring"
    }
    sets.AccDayMaxTPWSEars = {
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring"
    }
    sets.DayMaxTPWSEars = {
        ear1 = "Brutal Earring",
        ear2 = "Sherida Earring"
    }
    sets.AccDayWSEars = {
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring"
    }
    sets.DayWSEars = {
        ear1 = "Moonshade Earring",
        ear2 = "Sherida Earring"
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group

    sets.engaged = {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Hjarrandi Helm",
        body = gear.empy.Body,
        -- body = "Hjarrandi Breast.",
        hands = gear.empy.Hands,
        legs = gear.relic.Legs,
        feet = "Flam. Gambieras +2",
        neck = "Shulmanu Collar",
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Lehko's Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.tp_jse_back
    }
    sets.engaged.SomeAcc = set_combine(sets.engaged, {
    })
    sets.engaged.Acc = set_combine(sets.engaged, {
    })
    sets.engaged.FullAcc = set_combine(sets.engaged, {
    })
    sets.engaged.Fodder = set_combine(sets.engaged, {
    })

    sets.engaged.AM = {}
    sets.engaged.AM.SomeAcc = {}
    sets.engaged.AM.Acc = {}
    sets.engaged.AM.FullAcc = {}
    sets.engaged.AM.Fodder = {}

    sets.engaged.PDT = {}
    sets.engaged.SomeAcc.PDT = {}
    sets.engaged.Acc.PDT = {}
    sets.engaged.FullAcc.PDT = {}
    sets.engaged.Fodder.PDT = {}

    sets.engaged.AM.PDT = {}
    sets.engaged.AM.SomeAcc.PDT = {}
    sets.engaged.AM.Acc.PDT = {}
    sets.engaged.AM.FullAcc.PDT = {}
    sets.engaged.AM.Fodder.PDT = {}

    --[[ Melee sets for in Adoulin, which has an extra 2% Haste from Ionis.
	
    sets.engaged.Adoulin = {}
    sets.engaged.Adoulin.SomeAcc = {}
	sets.engaged.Adoulin.Acc = {}
    sets.engaged.Adoulin.FullAcc = {}
    sets.engaged.Adoulin.Fodder = {}

    sets.engaged.Adoulin.AM = {}
    sets.engaged.Adoulin.AM.SomeAcc = {}
	sets.engaged.Adoulin.AM.Acc = {}
    sets.engaged.Adoulin.AM.FullAcc = {}
    sets.engaged.Adoulin.AM.Fodder = {}
	
    sets.engaged.Adoulin.PDT = {}
    sets.engaged.Adoulin.SomeAcc.PDT = {}
	sets.engaged.Adoulin.Acc.PDT = {}
    sets.engaged.Adoulin.FullAcc.PDT = {}
    sets.engaged.Adoulin.Fodder.PDT = {}
	
    sets.engaged.Adoulin.AM.PDT = {}
    sets.engaged.Adoulin.AM.SomeAcc.PDT = {}
	sets.engaged.Adoulin.AM.Acc.PDT = {}
    sets.engaged.Adoulin.AM.FullAcc.PDT = {}
    sets.engaged.Adoulin.AM.Fodder.PDT = {}
	]]

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(5, 13)
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 13)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 13)
    else
        set_macro_page(5, 13)
    end
end
