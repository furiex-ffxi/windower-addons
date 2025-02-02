function user_job_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'SB', 'DT', 'Conter')
    state.WeaponskillMode:options('Match', 'Normal', 'Acc', 'FullAcc')
    state.HybridMode:options('Normal', 'PDT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options( 'Verethragna','Godhands','Barehanded')

    state.ExtraMeleeMode = M {
        ['description'] = 'Extra Melee Mode',
        'None'
    }

    update_melee_groups()

    -- Additional local binds
    send_command('bind ^` input /ja "Boost" <me>')
    send_command('bind !` input /ja "Perfect Counter" <me>')
    send_command('bind ^backspace input /ja "Mantra" <me>')
    send_command('bind @` gs c cycle SkillchainMode')

end

function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {
        legs = "Hes. Hose +3"
    }
    sets.precast.JA['Boost'] = { hands = "Anchor. Gloves +3" }
    sets.precast.JA['Boost'].OutOfCombat = {
        waist = "Ask Sash",
        hands = "Anchor. Gloves +3"
    } -- Remove Haste and Add Slow Gear.
    sets.precast.JA['Dodge'] = {
        feet = "Anch. Gaiters +2"
    }
    sets.precast.JA['Focus'] = {
        head = "Anch. Crown +3"
    }
    sets.precast.JA['Counterstance'] = {
        feet = "Hes. Gaiters +3"
    } 
    sets.precast.JA['Footwork'] = {
        feet = "Bhikku Gaiters +3"
    }
    sets.precast.JA['Formless Strikes'] = {
        body = "Hes. Cyclas +3"
    }
    sets.precast.JA['Mantra'] = {
        feet = "Hes. Gaiters +3"
    } 

    sets.precast.JA['Chi Blast'] = {
        head = {
            name = "Hes. Crown +3",
        }
    }

    sets.precast.JA['Chakra'] = {
        body = "Anch. Cyclas +3",
        hands = {
            name = "Hes. Gloves +3",
            augments = {'Enhances "Invigorate" effect'}
        }
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {
        ammo = "Falcon Eye",
        head = "Malignance Chapeau",
        neck = "Moonbeam Nodowa",
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Hes. Gloves +3",
        ring1 = "Ramuh Ring +1",
        ring2 = "Ramuh Ring +1",
        back = "Segomo's Mantle",
        waist = "Olseni Belt",
        legs = "Hiza. Hizayoroi +2",
        feet = "Malignance Boots"
    }

    sets.precast.Flourish1 = {
        ammo = "Falcon Eye",
        head = "Malignance Chapeau",
        neck = "Moonbeam Nodowa",
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Hes. Gloves +3",
        ring1 = "Ramuh Ring +1",
        ring2 = "Ramuh Ring +1",
        back = "Segomo's Mantle",
        waist = "Olseni Belt",
        legs = "Mummu Kecks +2",
        feet = "Malignance Boots"
    }

    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo = "Sapience Orb",
        head = {
            name = "Herculean Helm",
        },
        -- body = {
        --     name = "Adhemar Jacket +1",
        -- },
        hands = {
            name = "Leyline Gloves",
            augments = {'Accuracy+15', 'Mag. Acc.+15', '"Mag.Atk.Bns."+15', '"Fast Cast"+3'}
        },
        legs = {
            name = "Herculean Trousers",
        },
        feet = "Bhikku Gaiters +3",
        neck = "Baetyl Pendant",
        waist = "Moonbow Belt +1",
        left_ear = "Enchntr. Earring +1",
        right_ear = "Loquac. Earring",
        -- left_ring = "Medada's Ring",
        -- right_ring = "Weather. Ring +1",
        back = {
            name = "Segomo's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck = "Magoraga Beads"
    })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = "Pemphredo Tathlum",
        head = "Bhikku Crown +3",
        body = "Bhikku Cyclas +3",
        hands = "Bhikku Gloves +3",
        legs = "Bhikku Hose +3",
        feet = "Bhikku Gaiters +3",
        neck = "Sanctity Necklace",
        waist = "Eschan Stone",
        left_ear = "Crep. Earring",
        right_ear = {
            name = "Bhikku Earring +1",
        },
		left_ring = "Epaminondas's Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Segomo's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }
    sets.precast.WS.Barehanded = {
        ammo = "Pemphredo Tathlum",
        head={ name="Taeon Chapeau", augments={'Phalanx +3',}},
        body={ name="Taeon Tabard", augments={'Phalanx +3',}},
        hands={ name="Taeon Gloves", augments={'Phalanx +3',}},
        legs={ name="Taeon Tights", augments={'Phalanx +3',}},
        feet={ name="Taeon Boots", augments={'Phalanx +3',}},
        neck = "Sanctity Necklace",
        waist = "Eschan Stone",
        left_ear = "Crep. Earring",
        right_ear = {
            name = "Bhikku Earring +1",
        },
		left_ring = "Epaminondas's Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Segomo's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }    
    sets.precast.WSAcc = {}
    sets.precast.WSFullAcc = {}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS, sets.precast.WSFullAcc)

    -- Specific weaponskill sets.

    sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
        },
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = "Bhikku Gloves +3",
        legs = {
            name = "Mpaca's Hose",
            augments = {'Path: A'}
        },
        feet = {
            name = "Mpaca's Boots",
            augments = {'Path: A'}
        },
        neck = "Rep. Plat. Medal",
        waist = "Moonbow Belt +1",
        left_ear = "Sherida Earring",
        right_ear = {
            name = "Moonshade Earring",
        },
        left_ring = "Niqmaddu Ring",
        right_ring = "Gere Ring",
        back = {
            name = "Segomo's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    })

    sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
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
            name = "Mpaca's Hose",
            augments = {'Path: A'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Mnk. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = "Moonbow Belt +1",
        left_ear = "Sherida Earring",
        right_ear = {
            name = "Moonshade Earring",
        },
        left_ring = "Niqmaddu Ring",
        right_ring = "Gere Ring",
        back = {
            name = "Segomo's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    })

    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
        },
        body = {
            name = "Mpaca's Doublet",
            augments = {'Path: A'}
        },
        hands = "Bhikku Gloves +3",
        legs = {
            name = "Mpaca's Hose",
            augments = {'Path: A'}
        },
        feet = {
            name = "Mpaca's Boots",
            augments = {'Path: A'}
        },
        neck = {
            name = "Mnk. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = "Moonbow Belt +1",
        left_ear = "Sherida Earring",
        right_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        },
        left_ring = "Niqmaddu Ring",
        right_ring = "Gere Ring",
        back = {
            name = "Segomo's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    })

    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
        ammo = "Pemphredo Tathlum",
        head = "Bhikku Crown +3",
        body = "Bhikku Cyclas +3",
        hands = "Bhikku Gloves +3",
        legs = "Bhikku Hose +3",
        feet = "Bhikku Gaiters +3",
        neck = "Sanctity Necklace",
        waist = "Eschan Stone",
        left_ear = "Crep. Earring",
        right_ear = {
            name = "Bhikku Earring +1",
        },
        -- left_ring = "Medada's Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Segomo's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    })

    sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
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
            name = "Mpaca's Hose",
            augments = {'Path: A'}
        },
        feet = "Anch. Gaiters +2",
        neck = {
            name = "Mnk. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = "Moonbow Belt +1",
        left_ear = {
            name = "Moonshade Earring",
        },
        right_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        },
        left_ring = "Niqmaddu Ring",
        right_ring = "Gere Ring",
        back = {
            name = "Segomo's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    })

    sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
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
            name = "Mpaca's Hose",
            augments = {'Path: A'}
        },
        feet = "Anch. Gaiters +2",
        neck = {
            name = "Mnk. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = "Moonbow Belt +1",
        left_ear = {
            name = "Moonshade Earring",
        },
        right_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        },
        left_ring = "Niqmaddu Ring",
        right_ring = "Gere Ring",
        back = {
            name = "Segomo's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    })

    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = {
            name = "Nyame Helm",
            augments = {'Path: B'}
        },
        body = "Bhikku Cyclas +3",
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
            name = "Mnk. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = "Moonbow Belt +1",
        left_ear = {
            name = "Moonshade Earring",
        },
        right_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        },
        left_ring = "Niqmaddu Ring",
        right_ring = "Gere Ring",
        back = {
            name = "Segomo's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    })

    sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
    sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
    sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
    sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc, {})
    sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc, {})
    sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
    sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
    sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

    sets.precast.WS["Raging Fists"].FullAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFullAcc)
    sets.precast.WS["Howling Fist"].FullAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFullAcc)
    sets.precast.WS["Asuran Fists"].FullAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFullAcc)
    sets.precast.WS["Ascetic's Fury"].FullAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSFullAcc,
        {})
    sets.precast.WS["Victory Smite"].FullAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSFullAcc, {})
    sets.precast.WS["Shijin Spiral"].FullAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFullAcc)
    sets.precast.WS["Dragon Kick"].FullAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFullAcc)
    sets.precast.WS["Tornado Kick"].FullAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSFullAcc)

    sets.precast.WS['Cataclysm'] = {
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
        left_ring = "Medada's Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Segomo's Mantle",
            augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    }

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = {
        left_ear = "Sherida Earring",
        right_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        }
    }
    sets.AccMaxTP = {
        left_ear = "Sherida Earring",
        right_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        }
    }

    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo = "Sapience Orb",
        head = {
            name = "Herculean Helm",
            augments = {'"Fast Cast"+5', 'INT+3'}
        },
        body = {
            name = "Adhemar Jacket +1",
            augments = {'HP+105', '"Fast Cast"+10', 'Magic dmg. taken -4'}
        },
        hands = {
            name = "Leyline Gloves",
            augments = {'Accuracy+15', 'Mag. Acc.+15', '"Mag.Atk.Bns."+15', '"Fast Cast"+3'}
        },
        legs = {
            name = "Herculean Trousers",
            augments = {'Pet: "Regen"+1', 'Accuracy+22', '"Fast Cast"+8', 'Mag. Acc.+1 "Mag.Atk.Bns."+1'}
        },
        feet = "Bhikku Gaiters +3",
        neck = "Baetyl Pendant",
        waist = "Moonbow Belt +1",
        left_ear = "Enchntr. Earring +1",
        right_ear = "Loquac. Earring",
        left_ring = "Medada's Ring",
        right_ring = "Weather. Ring +1",
        back = {
            name = "Segomo's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }

    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {
        ammo = "Crepuscular Pebble",
        head = "Null Masque",
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
        neck = "Rep. Plat. Medal",
        waist = "Moonbow Belt +1",
        left_ear = "Tuisto Earring",
        right_ear = {
            name = "Odnowa Earring +1",
            augments = {'Path: A'}
        },
        left_ring = "Chirich Ring +1",
        right_ring = "Chirich Ring +1",
        back = {
            name = "Segomo's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }

    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.defense.MEVA = {}

    sets.Kiting = {
        feet = "Herald's Gaiters",
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee sets
    sets.engaged = {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
        },
        body = {
            name = "Mpaca's Doublet",
            augments = {'Path: A'}
        },
        hands = "Malignance Gloves",
        -- hands = {
        --     name = "Adhemar Wrist. +1",
        --     augments = {'DEX+12', 'AGI+12', 'Accuracy+20'}
        -- },
        legs = "Bhikku Hose +3",
        feet = {
            name = "Herculean Boots",
        },
        neck = {
            name = "Mnk. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = "Moonbow Belt +1",
        left_ear = "Sherida Earring",
        right_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        },
        left_ring = "Niqmaddu Ring",
        right_ring = "Gere Ring",
        back = {
            name = "Segomo's Mantle",
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
        legs = "Bhikku Hose +3",
        feet = "Malignance Boots",
        neck = {
            name = "Mnk. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = "Moonbow Belt +1",
        left_ear = "Sherida Earring",
        right_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        },
        left_ring = "Niqmaddu Ring",
        right_ring = "Gere Ring",
        back = {
            name = "Segomo's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }

    sets.engaged.SB = {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Bhikku Crown +3",
        body = {
            name = "Mpaca's Doublet",
            augments = {'Path: A'}
        },
        hands = "Malignance Gloves",
        legs = "Bhikku Hose +3",
        feet = "Malignance Boots",
        neck = {
            name = "Mnk. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = "Moonbow Belt +1",
        left_ear = "Sherida Earring",
        right_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        },
        left_ring = "Niqmaddu Ring",
        right_ring = "Gere Ring",
        back = {
            name = "Segomo's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }

    sets.engaged.Conter = {
        ammo = "Amar Cluster",
        head = "Bhikku Crown +3",
        body = {
            name = "Mpaca's Doublet",
            augments = {'Path: A'}
        },
        hands = "Malignance Gloves",
        legs = "Anch. Hose +3",
        feet = {
            name = "Hes. Gaiters +3",
            augments = {'Enhances "Mantra" effect'}
        },
        neck = {
            name = "Bathy Choker +1",
            augments = {'Path: A'}
        },
        waist = "Moonbow Belt +1",
        left_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        },
        right_ear = {
            name = "Bhikku Earring +1",
        },
        left_ring = "Defending Ring",
        right_ring = "Gere Ring",
        back = {
            name = "Segomo's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%'}
        }
    }

    -- Defensive melee hybrid sets

    -- Hundred Fists/Impetus melee set mods

    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Sleep = {
        head = "Frenzy Sallet"
    }
    sets.buff.Impetus = {
        body = "Bhikku Cyclas +3"
    }
    sets.buff.Footwork = {}
    sets.buff.Boost = {} -- waist="Ask Sash"

    sets.FootworkWS = {}
    sets.DayIdle = {}
    sets.NightIdle = {}
    sets.Knockback = {}
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.Skillchain = {
        neck = "Warder's Charm +1",
    }

    -- Weapons sets
    sets.weapons.Godhands = {
        main = "Godhands"
    }
    sets.weapons.Verethragna = {
        main = "Verethragna"
    }
    sets.weapons.Barehanded = {
        main = empty
    }

    -- Select default macro book on initial load or subjob change.
    function select_default_macro_book()
        -- Default macro set/book
        if player.sub_job == 'DNC' then
            set_macro_page(5, 20)
        elseif player.sub_job == 'NIN' then
            set_macro_page(4, 20)
        elseif player.sub_job == 'THF' then
            set_macro_page(6, 20)
        elseif player.sub_job == 'RUN' then
            set_macro_page(7, 20)
        else
            set_macro_page(6, 20)
        end
    end
end

function user_job_lockstyle()
    windower.chat.input('/lockstyleset 008')
end