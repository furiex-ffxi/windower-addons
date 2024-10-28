-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.HybridMode:options('Normal', 'DTLite', 'PDT', 'MDT')
    state.WeaponskillMode:options('Match', 'Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('Mpu', 'Twash', 'Qutrub')
    state.ExtraMeleeMode = M {
        ['description'] = 'Extra Melee Mode',
        'None',
        'Suppa',
        'DWEarrings',
        'DWMax'
    }

    gear.stp_jse_back = {
        name = "Senuna's Mantle",
        augments = {'DEX+20', 'Accuracy+20 Attack+20', '"Store TP"+10'}
    }
    gear.wsd_jse_back = {
        name = "Senuna's Mantle",
        augments = {'DEX+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%'}
    }

    -- Additional local binds
    send_command('bind @` gs c step')
    send_command('bind ^!@` gs c toggle usealtstep')
    send_command('bind ^@` gs c cycle mainstep')
    send_command('bind !@` gs c cycle altstep')
    send_command('bind ^` input /ja "Saber Dance" <me>')
    send_command('bind !` input /ja "Fan Dance" <me>')
    send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')
    send_command('bind !\\\\ input /ja "Spectral Jig" <me>')
    send_command('bind !backspace input /ja "Reverse Flourish" <me>')
    send_command('bind ^backspace input /ja "No Foot Rise" <me>')
    send_command('bind %~` gs c cycle SkillchainMode')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Suppa = {
        ear1 = "Suppanomimi",
        ear2 = "Sherida Earring"
    }
    sets.DWEarrings = {
        ear1 = "Dudgeon Earring",
        ear2 = "Heartseeker Earring"
    }
    sets.DWMax = {
        ear1 = "Dudgeon Earring",
        ear2 = "Heartseeker Earring",
        body = "Adhemar Jacket +1",
        hands = "Floral Gauntlets",
        waist = "Shetal Stone"
    }

    -- Weapons sets
    sets.weapons.Mpu = {
        main = "Mpu Gandring",
        sub = {
            name = "Fusetto +2",
            augments = {'TP Bonus +1000'}
        }
    }
    sets.weapons.Twash = {
        main = {
            name = "Twashtar",
            augments = {'Path: A'}
        },
        sub = {
            name = "Fusetto +2",
            augments = {'TP Bonus +1000'}
        }
    }

    sets.weapons.Qutrub = {
        main = "Qutrub Knife",
        sub = "Fusetto +2"
    }

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['No Foot Rise'] = {
        body = {
            name = "Horos Casaque +3",
            augments = {'Enhances "No Foot Rise" effect'}
        }
    }

    sets.precast.JA['Trance'] = {
        head = {
            name = "Horos Tiara +3",
            augments = {'Enhances "Trance" effect'}
        }
    } 

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    sets.Self_Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Samba = {
        head = "Maxixi Tiara +2"
    }
    
    sets.precast.Jig = {
        legs = {
            name = "Horos Tights +3",
            augments = {'Enhances "Saber Dance" effect'}
        },
        feet = "Maxixi Toe Shoes +2"
    }

    sets.precast.Step = {
        ammo = "C. Palug Stone",
        head = "Maxixi Tiara +2",
        body = "Maxixi Casaque +2",
        hands = "Maxixi Bangles +2",
        legs = "Maculele Tights +2",
        feet = {
            name = "Horos T. Shoes +3",
            augments = {'Enhances "Closed Position" effect'}
        },
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Kentarch Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Odr Earring",
        right_ear = "Mache Earring +1",
        left_ring = {
            name = "Cacoethic Ring +1",
            augments = {'Path: A'}
        },
        right_ring = "Regal Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }

    sets.precast.Step['Feather Step'] = set_combine(sets.precast.step, {
        feet = "Macu. Toe Sh. +2"
    })

    sets.Enmity = {}

    sets.precast.JA.Provoke = sets.Enmity

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {}

    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity

    sets.precast.Flourish1['Desperate Flourish'] = {}

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {
        back = { name="Toetapper Mantle", augments={'"Store TP"+2','"Dual Wield"+2','"Rev. Flourish"+30',}},
        hands = "Macu. Bangles +2"
    } 

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body = "Macu. Casaque +2"} -- body="Charis Casaque +2"
    sets.precast.Flourish3['Climactic Flourish'] = {}

    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo = "Impatiens",
        -- head = {
        --     name = "Herculean Helm",
        --     augments = {'"Fast Cast"+5', 'INT+3'}
        -- },
        -- body = {
        --     name = "Adhemar Jacket +1",
        --     augments = {'HP+105', '"Fast Cast"+10', 'Magic dmg. taken -4'}
        -- },
        hands = {
            name = "Leyline Gloves",
            augments = {'Accuracy+15', 'Mag. Acc.+15', '"Mag.Atk.Bns."+15', '"Fast Cast"+3'}
        },
        legs = {
            name = "Herculean Trousers",
            augments = {'Pet: "Regen"+1', 'Accuracy+22', '"Fast Cast"+8', 'Mag. Acc.+1 "Mag.Atk.Bns."+1'}
        },
        feet = "Macu. Toe Sh. +2",
        neck = "Baetyl Pendant",
        waist = "Plat. Mog. Belt",
        left_ear = "Enchntr. Earring +1",
        right_ear = "Loquac. Earring",
        -- left_ring = "Weather. Ring +1",
        -- right_ring = "Medada's Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'CHR+20', '"Fast Cast"+10', 'Spell interruption rate down-10%'}
        }
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck = "Magoraga Beads"
    })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Maculele Tiara +2",
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = {
            name = "Nyame Gauntlets",
            augments = {'Path: B'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Kentarch Belt +1",
            augments = {'Path: A'}
        },
        left_ear = {
            name = "Moonshade Earring",
        },
        right_ear = {
            name = "Macu. Earring +1",
        },
        left_ring = "Epaminondas's Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    }

    sets.precast.WS.ATT = set_combine(sets.precast.WS, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Maculele Tiara +2",
        body = {
            name = "Gleti's Cuirass",
            augments = {'Path: A'}
        },
        hands = {
            name = "Nyame Gauntlets",
            augments = {'Path: B'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Kentarch Belt +1",
            augments = {'Path: A'}
        },
        left_ear = {
            name = "Moonshade Earring",
        },
        right_ear = {
            name = "Macu. Earring +1",
        },
        left_ring = "Epaminondas's Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Maculele Tiara +2",
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = {
            name = "Nyame Gauntlets",
            augments = {'Path: B'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Kentarch Belt +1",
            augments = {'Path: A'}
        },
        left_ear = {
            name = "Moonshade Earring",
        },
        right_ear = {
            name = "Macu. Earring +1",
        },
        left_ring = "Epaminondas's Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })
    sets.precast.WS["Rudra's Storm"].ATT = set_combine(sets.precast.WS.SomeAcc, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Maculele Tiara +2",
        body = {
            name = "Gleti's Cuirass",
            augments = {'Path: A'}
        },
        hands = {
            name = "Nyame Gauntlets",
            augments = {'Path: B'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Kentarch Belt +1",
            augments = {'Path: A'}
        },
        left_ear = {
            name = "Moonshade Earring",
        },
        right_ear = {
            name = "Macu. Earring +1",
        },
        left_ring = "Epaminondas's Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Maculele Tiara +2",
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = {
            name = "Nyame Gauntlets",
            augments = {'Path: B'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Kentarch Belt +1",
            augments = {'Path: A'}
        },
        left_ear = {
            name = "Moonshade Earring",
        },
        right_ear = {
            name = "Macu. Earring +1",
        },
        left_ring = "Epaminondas's Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })
    sets.precast.WS["Shark Bite"].ATT = set_combine(sets.precast.WS.SomeAcc, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Maculele Tiara +2",
        body = {
            name = "Gleti's Cuirass",
            augments = {'Path: A'}
        },
        hands = {
            name = "Nyame Gauntlets",
            augments = {'Path: B'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Kentarch Belt +1",
            augments = {'Path: A'}
        },
        left_ear = {
            name = "Moonshade Earring",
        },
        right_ear = {
            name = "Macu. Earring +1",
        },
        left_ring = "Epaminondas's Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo = "Charis Feather",
        head = {
            name = "Blistering Sallet +1",
            augments = {'Path: A'}
        },
        body = {
            name = "Gleti's Cuirass",
            augments = {'Path: A'}
        },
        hands = {
            name = "Gleti's Gauntlets",
            augments = {'Path: A'}
        },
        legs = {
            name = "Gleti's Breeches",
            augments = {'Path: A'}
        },
        feet = {
            name = "Gleti's Boots",
            augments = {'Path: A'}
        },
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = "Fotia Belt",
        left_ear = "Odr Earring",
        right_ear = {
            name = "Macu. Earring +1",
        },
        left_ring = "Ilabrat Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Crit.hit rate+10'}
        }
    })
    sets.precast.WS['Evisceration'].ATT = set_combine(sets.precast.WS.SomeAcc, {})

    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Maculele Tiara +2",
        body = {
            name = "Gleti's Cuirass",
            augments = {'Path: A'}
        },
        hands = {
            name = "Gleti's Gauntlets",
            augments = {'Path: A'}
        },
        legs = {
            name = "Gleti's Breeches",
            augments = {'Path: A'}
        },
        feet = {
            name = "Gleti's Boots",
            augments = {'Path: A'}
        },
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = "Fotia Belt",
        left_ear = "Sherida Earring",
        right_ear = {
            name = "Macu. Earring +1",
        },
        left_ring = "Ilabrat Ring",
        right_ring = "Regal Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })
    sets.precast.WS['Pyrrhic Kleos'].ATT = set_combine(sets.precast.WS.SomeAcc, {})

    sets.precast.WS['Aeolian Edge'] = {
        ammo = {
            name = "Ghastly Tathlum +1",
            augments = {'Path: A'}
        },
        head = {
            name = "Nyame Helm",
            augments = {'Path: B'}
        },
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = {
            name = "Nyame Gauntlets",
            augments = {'Path: B'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = "Sibyl Scarf",
        waist = "Orpheus's Sash",
        left_ear = "Friomisi Earring",
        right_ear = {
            name = "Moonshade Earring",
        },
        left_ring = "Epaminondas's Ring",
        right_ring = "Medada's Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    }

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = {
        left_ear = "Sherida Earring",
        right_ear = {
            name = "Macu. Earring +1",
        }
    }
    sets.AccMaxTP = {
        left_ear = "Sherida Earring",
        right_ear = {
            name = "Macu. Earring +1",
        }
    }

    sets.Skillchain = {} -- hands="Charis Bangles +2"

    -- Midcast Sets

    sets.midcast.FastRecast = {
        ammo = "Impatiens",
        -- head = {
        --     name = "Herculean Helm",
        --     augments = {'"Fast Cast"+5', 'INT+3'}
        -- },
        -- body = {
        --     name = "Adhemar Jacket +1",
        --     augments = {'HP+105', '"Fast Cast"+10', 'Magic dmg. taken -4'}
        -- },
        hands = {
            name = "Leyline Gloves",
            augments = {'Accuracy+15', 'Mag. Acc.+15', '"Mag.Atk.Bns."+15', '"Fast Cast"+3'}
        },
        -- legs = {
        --     name = "Herculean Trousers",
        --     augments = {'Pet: "Regen"+1', 'Accuracy+22', '"Fast Cast"+8', 'Mag. Acc.+1 "Mag.Atk.Bns."+1'}
        -- },
        feet = "Macu. Toe Sh. +2",
        neck = "Baetyl Pendant",
        waist = "Plat. Mog. Belt",
        left_ear = "Enchntr. Earring +1",
        right_ear = "Loquac. Earring",
        -- left_ring = "Weather. Ring +1",
        -- right_ring = "Medada's Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'CHR+20', '"Fast Cast"+10', 'Spell interruption rate down-10%'}
        }
    }

    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}
    sets.ExtraRegen = {}

    -- Idle sets

    sets.idle = {
        ammo = "Crepuscular Pebble",
        head = "Turms Cap +1",
        body = {
            name = "Gleti's Cuirass",
            augments = {'Path: A'}
        },
        hands = {
            name = "Gleti's Gauntlets",
            augments = {'Path: A'}
        },
        legs = {
            name = "Gleti's Breeches",
            augments = {'Path: A'}
        },
        feet = {
            name = "Gleti's Boots",
            augments = {'Path: A'}
        },
        neck = "Rep. Plat. Medal",
        waist = "Carrier's Sash",
        -- waist = "Engraved Belt",
        -- left_ear = "Infused Earring",
        left_ear = "Odnawa Earring +1",
        right_ear = "Eabani Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Chirich Ring +1",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }

    sets.idle.Sphere = set_combine(sets.idle, {
        body = "Mekosu. Harness"
    })

    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.defense.MEVA = {}

    sets.Kiting = {
        -- feet = "Tandava Crackows"
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
        head = "Maculele Tiara +2",
        body = {
            name = "Gleti's Cuirass",
            augments = {'Path: A'}
        },
        hands = "Malignance Gloves",
        legs = {
            name = "Gleti's Breeches",
            augments = {'Path: A'}
        },
        feet = "Macu. Toe Sh. +2",
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Gere Ring",
        right_ring = "Lehko's Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }

    sets.engaged.DT = {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Macu. Toe Sh. +2",
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Gere Ring",
        right_ring = "Defending Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }

    sets.engaged.Crit = {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = {
            name = "Blistering Sallet +1",
            augments = {'Path: A'}
        },
        body = {
            name = "Gleti's Cuirass",
            augments = {'Path: A'}
        },
        hands = {
            name = "Gleti's Gauntlets",
            augments = {'Path: A'}
        },
        legs = {
            name = "Gleti's Breeches",
            augments = {'Path: A'}
        },
        feet = {
            name = "Gleti's Boots",
            augments = {'Path: A'}
        },
        neck = {
            name = "Etoile Gorget +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Odr Earring",
        right_ear = "Mache Earring +1",
        left_ring = "Gere Ring",
        right_ring = "Defending Ring",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Crit.hit rate+10'}
        }
    }

    sets.engaged.AM = {}

    sets.engaged.Amon = {
        ammo = "Aurgelmir Orb +1",
        head = "Turms Cap +1",
        body = {
            name = "Gleti's Cuirass",
            augments = {'Path: A'}
        },
        hands = "Regal Gloves",
        legs = {
            name = "Gleti's Breeches",
            augments = {'Path: A'}
        },
        feet = {
            name = "Gleti's Boots",
            augments = {'Path: A'}
        },
        neck = "Rep. Plat. Medal",
        waist = {
            name = "Kentarch Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Sherida Earring",
        right_ear = "Dedition Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Chirich Ring +1",
        back = {
            name = "Senuna's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Store TP"+10', 'Phys. dmg. taken-10%'}
        }
    }

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = {} -- legs="Horos Tights"
    sets.buff['Climactic Flourish'] = {
        ammo = "Charis Feather",
        head = "Maculele Tiara +2"
    } -- head="Charis Tiara +2"
    sets.buff.Doom = set_combine(sets.buff.Doom, {
        neck = "Nicander's Necklace",
        waist = "Gishdubar Sash",
        left_ring = "Purity Ring",
        right_ring = "Blenmot's Ring +1"
    })
    sets.buff.Sleep = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(10, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'SAM' then
        set_macro_page(9, 9)
    elseif player.sub_job == 'THF' then
        set_macro_page(8, 9)
    else
        set_macro_page(10, 9)
    end
end
