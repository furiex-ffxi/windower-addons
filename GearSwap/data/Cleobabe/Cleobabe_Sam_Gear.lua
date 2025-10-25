-- Setup vars that are user-dependent.
function user_job_setup()
    state.OffenseMode:options('Normal', 'DT', 'SB')
    state.HybridMode:options('Normal')
    state.WeaponskillMode:options('Match', 'Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder', 'Proc')
    state.RangedMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal')
    state.Weapons:options('Doje', 'Masa', 'Shinning', 'Rng')

    gear.ws_jse_back = {
        name = "Smertrios's Mantle"
    }

    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    send_command('bind !backspace input /ja "Third Eye" <me>')
    send_command('bind @` gs c cycle SkillchainMode')
    send_command('bind !@^` gs c cycle Stance')
    send_command(
        'bind !r gs c set skipprocweapons false;gs c weapons ProcWeapon;gs c set WeaponskillMode Proc;gs c update')
    send_command(
        'bind ^r gs c set skipprocweapons true;gs c weapons Default;gs c set WeaponskillMode Normal;gs c update')
    send_command('bind ^q gs c weapons Bow;gs c update')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {
        head = "Wakido Kabuto +3",
        hands = "Sakonji Kote +3",
        back = gear.ws_jse_back
    }
    sets.precast.JA['Warding Circle'] = {
        head = "Wakido Kabuto +3"
    }
    sets.precast.JA['Blade Bash'] = {
        hands = "Sakonji Kote +3"
    }
    sets.precast.JA['Sekkanoki'] = {
        hands = "Kasuga Kote +3"
    }
    sets.precast.JA['Sengikori'] = {
        feet = "Kas. Sune-Ate +3"
    }

    sets.precast.Step = {}
    sets.precast.JA['Violent Flourish'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head = "Flam. Zucchetto +2",
        neck = "Unmoving Collar +1",
        ear1 = "Handler's Earring +1",
        ear2 = "Handler's Earring",
        body = "Tartarus Platemail",
        hands = "Flam. Manopolas +2",
        ring1 = "Asklepian Ring",
        ring2 = "Valseur's Ring",
        back = "Moonbeam Cape",
        waist = "Chaac Belt",
        legs = "Wakido Haidate +3",
        feet = "Sak. Sune-Ate +1"
    }

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo = "Sapience Orb",
        head = {
            name = "Nyame Helm",
            augments = {'Path: B'}
        },
        body = "Sacro Breastplate",
        hands = {
            name = "Leyline Gloves",
            augments = {'Accuracy+15', 'Mag. Acc.+15', '"Mag.Atk.Bns."+15', '"Fast Cast"+3'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = "Baetyl Pendant",
        waist = "Plat. Mog. Belt",
        left_ear = "Enchntr. Earring +1",
        right_ear = "Loquac. Earring",
        left_ring = "Weather. Ring +1",
        right_ring = "Medada's Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Store TP"+10', 'Phys. dmg. taken-10%'}
        }
    }

    -- Ranged snapshot gear
    sets.precast.RA = {}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = "Knobkierrie",
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
        neck = {
            name = "Sam. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = "Orpheus's Sash",
        left_ear = "Thrud Earring",
        right_ear = {
            name = "Moonshade Earring",
            augments = {'"Mag.Atk.Bns."+4', 'TP Bonus +250'}
        },
        left_ring = "Medada's Ring",
        right_ring = "Weather. Ring +1",
        back = {
            name = "Smertrios's Mantle",
            augments = {'STR+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Magic Damage +10', 'Weapon skill damage +10%',
                        'Phys. dmg. taken-10%'}
        }
    }
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

    sets.precast.WS.Proc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {
        ammo = "Knobkierrie",
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
        },
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = "Kasuga Kote +3",
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Sam. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Thrud Earring",
        right_ear = {
            name = "Moonshade Earring",
            augments = {'"Mag.Atk.Bns."+4', 'TP Bonus +250'}
        },
        left_ring = "Sroda Ring",
        right_ring = "Epaminondas's Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })
    sets.precast.WS['Tachi: Fudo'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Fudo'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Fudo'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
        ammo = "Knobkierrie",
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
        },
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = "Kasuga Kote +3",
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Sam. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Thrud Earring",
        right_ear = {
            name = "Moonshade Earring",
            augments = {'"Mag.Atk.Bns."+4', 'TP Bonus +250'}
        },
        left_ring = "Sroda Ring",
        right_ring = "Epaminondas's Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })
    sets.precast.WS['Tachi: Shoha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Shoha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Shoha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
        ammo = "Knobkierrie",
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
        },
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = "Kasuga Kote +3",
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Sam. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Thrud Earring",
        right_ear = {
            name = "Moonshade Earring",
            augments = {'"Mag.Atk.Bns."+4', 'TP Bonus +250'}
        },
        left_ring = "Sroda Ring",
        right_ring = "Epaminondas's Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })
    sets.precast.WS['Tachi: Rana'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Rana'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Rana'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {
        ammo = "Knobkierrie",
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
        },
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = "Kasuga Kote +3",
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Sam. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Thrud Earring",
        right_ear = {
            name = "Moonshade Earring",
            augments = {'"Mag.Atk.Bns."+4', 'TP Bonus +250'}
        },
        left_ring = "Sroda Ring",
        right_ring = "Epaminondas's Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })
    sets.precast.WS['Tachi: Kasha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Kasha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Kasha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Kasha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {
        ammo = "Knobkierrie",
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
        },
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = "Kasuga Kote +3",
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Sam. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Thrud Earring",
        right_ear = {
            name = "Moonshade Earring",
            augments = {'"Mag.Atk.Bns."+4', 'TP Bonus +250'}
        },
        left_ring = "Sroda Ring",
        right_ring = "Epaminondas's Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })
    sets.precast.WS['Tachi: Gekko'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Gekko'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Gekko'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Gekko'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {
        ammo = "Knobkierrie",
        head = {
            name = "Mpaca's Cap",
            augments = {'Path: A'}
        },
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = "Kasuga Kote +3",
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Sam. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Thrud Earring",
        right_ear = {
            name = "Moonshade Earring",
            augments = {'"Mag.Atk.Bns."+4', 'TP Bonus +250'}
        },
        left_ring = "Sroda Ring",
        right_ring = "Epaminondas's Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    })
    sets.precast.WS['Tachi: Yukikaze'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Yukikaze'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Ageha'] = {
        ammo = "Pemphredo Tathlum",
        head = "Kasuga Kabuto +3",
        body = "Kasuga Domaru +3",
        hands = "Kasuga Kote +3",
        legs = "Kasuga Haidate +3",
        feet = "Kas. Sune-Ate +3",
        neck = "Null Loop",
        waist = "Null Belt",
        left_ear = "Digni. Earring",
        right_ear = "Kasuga Earring +2",
        left_ring = "Medada's Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = "Null Shawl"
    }

    sets.precast.WS['Tachi: Hobaku'] = {
        ammo = "Pemphredo Tathlum",
        head = "Kasuga Kabuto +3",
        body = "Kasuga Domaru +3",
        hands = "Kasuga Kote +3",
        legs = "Kasuga Haidate +3",
        feet = "Kas. Sune-Ate +3",
        neck = "Sanctity Necklace",
        waist = "Eschan Stone",
        left_ear = "Digni. Earring",
        right_ear = "Kasuga Earring +2",
        left_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        right_ring = "Stikini Ring +1",
        back = {
            name = "Smertrios's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    }

    sets.precast.WS['Tachi: Jinpu'] = {
        ammo = "Knobkierrie",
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
        neck = {
            name = "Sam. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = "Orpheus's Sash",
        left_ear = "Thrud Earring",
        right_ear = {
            name = "Moonshade Earring",
            augments = {'"Mag.Atk.Bns."+4', 'TP Bonus +250'}
        },
        left_ring = "Sroda Ring", -- Medada's Ring
        right_ring = "Epaminondas's Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'STR+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Magic Damage +10', 'Weapon skill damage +10%',
                        'Phys. dmg. taken-10%'}
        }
    }

    sets.precast.WS['Namas Arrow'] = {
        head = {
            name = "Nyame Helm",
            augments = {'Path: B'}
        },
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = "Kasuga Kote +3",
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = {
            name = "Sam. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = "Fotia Belt",
        left_ear = "Thrud Earring",
        right_ear = {
            name = "Moonshade Earring",
            augments = {'"Mag.Atk.Bns."+4', 'TP Bonus +250'}
        },
        left_ring = "Epaminondas's Ring",
        right_ring = "Sroda Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%'}
        }
    }

    sets.precast.WS['Namas Arrow'].SomeAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Namas Arrow'].FullAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Namas Arrow'].Fodder = set_combine(sets.precast.WS['Apex Arrow'], {})

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = {
        left_ear = "Thrud Earring",
        right_ear = "Kasuga Earring +2"
    }
    sets.AccMaxTP = {
        left_ear = "Thrud Earring",
        right_ear = "Kasuga Earring +2"
    }
    sets.AccDayMaxTPWSEars = {
        left_ear = "Thrud Earring",
        right_ear = "Kasuga Earring +2"
    }
    sets.DayMaxTPWSEars = {
        left_ear = "Thrud Earring",
        right_ear = "Kasuga Earring +2"
    }
    sets.AccDayWSEars = {
        left_ear = "Thrud Earring",
        right_ear = "Kasuga Earring +2"
    }
    sets.DayWSEars = {
        left_ear = "Thrud Earring",
        right_ear = "Kasuga Earring +2"
    }

    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo = "Sapience Orb",
        head = {
            name = "Nyame Helm",
            augments = {'Path: B'}
        },
        body = "Sacro Breastplate",
        hands = {
            name = "Leyline Gloves",
            augments = {'Accuracy+15', 'Mag. Acc.+15', '"Mag.Atk.Bns."+15', '"Fast Cast"+3'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = "Baetyl Pendant",
        waist = "Plat. Mog. Belt",
        left_ear = "Enchntr. Earring +1",
        right_ear = "Loquac. Earring",
        left_ring = "Weather. Ring +1",
        right_ring = "Medada's Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Store TP"+10', 'Phys. dmg. taken-10%'}
        }
    }

    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    -- Ranged gear
    sets.midcast.RA = {
        head = "Flam. Zucchetto +2",
        neck = "Combatant's Torque",
        ear1 = "Clearview Earring",
        ear2 = "Neritic Earring",
        body = "Kyujutsugi",
        hands = "Buremte Gloves",
        ring1 = "Ilabrat Ring",
        ring2 = "Regal Ring",
        back = gear.stp_jse_back,
        waist = "Carrier's Sash",
        legs = "Wakido Haidate +3",
        feet = "Wakido Sune. +3"
    }

    sets.midcast.RA.Acc = {
        head = "Flam. Zucchetto +2",
        neck = "Combatant's Torque",
        ear1 = "Clearview Earring",
        ear2 = "Neritic Earring",
        body = "Kyujutsugi",
        hands = "Buremte Gloves",
        ring1 = "Ilabrat Ring",
        ring2 = "Regal Ring",
        back = gear.stp_jse_back,
        waist = "Carrier's Sash",
        legs = "Wakido Haidate +3",
        feet = "Wakido Sune. +3"
    }

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.Kiting = {
        feet = "Danzo Sune-ate"
    }

    sets.Reraise = {}

    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.Skillchain = {}

    sets.idle = {
        ammo = "Crepuscular Pebble",
        head = "Wakido Kabuto +3",
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
        feet = "Danzo Sune-Ate",
        neck = "Rep. Plat. Medal",
        waist = "Flume Belt +1",
        left_ear = "Tuisto Earring",
        right_ear = {
            name = "Odnowa Earring +1",
            augments = {'Path: A'}
        },
        left_ring = "Chirich Ring +1",
        right_ring = "Defending Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Store TP"+10', 'Phys. dmg. taken-10%'}
        }
    }

    sets.idle.Weak = {}

    sets.DayIdle = {}
    sets.NightIdle = {}

    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.defense.MEVA = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Kasuga Kabuto +3",
        body = "Kasuga Domaru +3",
        hands = {
            name = "Mpaca's Gloves",
            augments = {'Path: A'}
        },
        legs = "Kasuga Haidate +3",
        feet = {
            name = "Mpaca's Boots",
            augments = {'Path: A'}
        },
        neck = {
            name = "Sam. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        },
        right_ear = "Kasuga Earring +2",
        left_ring = "Niqmaddu Ring",
        right_ring = "Chirich Ring +1",
        back = {
            name = "Smertrios's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Store TP"+10', 'Phys. dmg. taken-10%'}
        }
    }

    sets.engaged.SB = {}

    sets.engaged.DT = {
        ammo = {
            name = "Coiste Bodhar",
            augments = {'Path: A'}
        },
        head = "Kasuga Kabuto +3",
        body = "Kasuga Domaru +3",
        hands = {
            name = "Mpaca's Gloves",
            augments = {'Path: A'}
        },
        legs = "Kasuga Haidate +3",
        feet = {
            name = "Mpaca's Boots",
            augments = {'Path: A'}
        },
        neck = {
            name = "Sam. Nodowa +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Sailfi Belt +1",
            augments = {'Path: A'}
        },
        left_ear = {
            name = "Schere Earring",
            augments = {'Path: A'}
        },
        right_ear = "Kasuga Earring +2",
        left_ring = "Niqmaddu Ring",
        right_ring = "Petrov Ring",
        back = {
            name = "Smertrios's Mantle",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Store TP"+10', 'Phys. dmg. taken-10%'}
        }
    }

    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
    --[[Right now Adoulin sets are the same as non-Adoulin.
	sets.engaged.Adoulin = {ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",neck="Moonbeam Nodowa",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands=gear.valorous_wsd_hands,ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.stp_jse_back,waist="Ioskeha Belt",legs="Wakido Haidate +3",feet="Flam. Gambieras +2"}
    sets.engaged.Adoulin.SomeAcc = {ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands="Flam. Manopolas +2",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Wakido Haidate +3",feet="Amm Greaves"}
	sets.engaged.Adoulin.Acc = {ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Kasuga Domaru +1",hands="Flam. Manopolas +2",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Wakido Haidate +3",feet="Amm Greaves"}
    sets.engaged.Adoulin.FullAcc = {ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Kasuga Domaru +1",hands="Flam. Manopolas +2",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Wakido Haidate +3",feet="Flam. Gambieras +2"}
    sets.engaged.Adoulin.Fodder = {ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands="Flam. Manopolas +2",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Wakido Haidate +3",feet="Flam. Gambieras +2"}
    sets.engaged.Adoulin.PDT = {ammo="Staunch Tathlum +1",
        head="Flam. Zucchetto +2",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Wakido Haidate +3",feet="Amm Greaves"}
    sets.engaged.Adoulin.SomeAcc.PDT = {ammo="Staunch Tathlum +1",
        head="Flam. Zucchetto +2",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Wakido Haidate +3",feet="Amm Greaves"}	
		sets.engaged.Adoulin.Acc.PDT = {ammo="Staunch Tathlum +1",
        head="Flam. Zucchetto +2",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Olseni Belt",legs="Wakido Haidate +3",feet="Amm Greaves"}
    sets.engaged.Adoulin.FullAcc.PDT = {ammo="Staunch Tathlum +1",
        head="Flam. Zucchetto +2",neck="Loricate Torque +1",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Letalis Mantle",waist="Olseni Belt",legs="Wakido Haidate +3",feet="Amm Greaves"}
    sets.engaged.Adoulin.Fodder.PDT = {ammo="Staunch Tathlum +1",
        head="Flam. Zucchetto +2",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt +1",legs="Wakido Haidate +3",feet="Amm Greaves"}
		
	sets.engaged.Adoulin.DTLite = sets.engaged.DTLite
    sets.engaged.Adoulin.SomeAcc.DTLite = sets.engaged.SomeAcc.DTLite
    sets.engaged.Adoulin.Acc.DTLite = sets.engaged.Acc.DTLite
    sets.engaged.Adoulin.FullAcc.DTLite = sets.engaged.FullAcc.DTLite
    sets.engaged.Adoulin.Fodder.DTLite = sets.engaged.Fodder.DTLite
    sets.engaged.Adoulin.Reraise = set_combine(sets.engaged.Adoulin, sets.Reraise)		
    sets.engaged.Adoulin.SomeAcc.Reraise = set_combine(sets.engaged.Adoulin.SomeAcc, sets.Reraise)		
    sets.engaged.Adoulin.Acc.Reraise = set_combine(sets.engaged.Adoulin.Acc, sets.Reraise)		
    sets.engaged.Adoulin.FullAcc.Reraise = set_combine(sets.engaged.Adoulin.FullAcc, sets.Reraise)		
    sets.engaged.Adoulin.Fodder.Reraise = set_combine(sets.engaged.Adoulin.Fodder, sets.Reraise)
]] -- Right now Adoulin sets are the same as non-Adoulin.

    -- Weapons sets
    sets.weapons.Masa = {
        main = {
            name = "Masamune",
            augments = {'Path: A'}
        },
        sub = "Utu Grip"
    }
    sets.weapons.Shinning = {
        main = "Shining One",
        sub = "Utu Grip"
    }
    sets.weapons.Doje = {
        main = {
            name = "Dojikiri Yasutsuna",
            augments = {'Path: A'}
        },
        sub = "Utu Grip"
    }
    sets.weapons.Rng = {
        main = "Shining One",
        sub = "Utu Grip",
        range = "Yoichinoyumi",
        ammo = "Eminent Arrow"
    }
    -- Buff sets
    sets.Cure_Received = {}
    sets.buff.Doom = set_combine(sets.buff.Doom, {
        neck = "Nicander's Necklace",
        waist = "Gishdubar Sash",
        left_ring = "Blenmot's Ring +1",
        right_ring = "Purity Ring"
    })
    sets.buff.Sleep = {
        neck = "Vim Torque +1"
    }
    sets.buff.Hasso = {}
    sets.buff['Third Eye'] = {} -- legs="Sakonji Haidate +3"
    sets.buff.Sekkanoki = {
        hands = "Kasuga Kote +3"
    }
    sets.buff.Sengikori = {
        feet = "Kas. Sune-Ate +3"
    }
    sets.buff['Meikyo Shisui'] = {
        feet = "Sak. Sune-Ate +3"
    }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(3, 1)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 1)
    else
        set_macro_page(1, 1)
    end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 007')
end

-- Job Specific Trust Overwrite
function check_trust()
    if not moving then
        if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and
            (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
            local party = windower.ffxi.get_party()
            if party.p5 == nil then
                local spell_recasts = windower.ffxi.get_spell_recasts()

                if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
                    windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
                    tickdelay = os.clock() + 3
                    return true
                elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
                    windower.send_command('input /ma "Koru-Moru" <me>')
                    tickdelay = os.clock() + 3
                    return true
                elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
                    windower.send_command('input /ma "Qultada" <me>')
                    tickdelay = os.clock() + 3
                    return true
                elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
                    windower.send_command('input /ma "Ulmia" <me>')
                    tickdelay = os.clock() + 3
                    return true
                elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
                    windower.send_command('input /ma "Selh\'teus" <me>')
                    tickdelay = os.clock() + 3
                    return true
                else
                    return false
                end
            end
        end
    end
    return false
end
