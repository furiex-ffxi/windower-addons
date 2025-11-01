function user_job_setup()
    -- Options: Override default values
    state.CastingMode:options('Normal', 'Resistant', 'Proc', 'OccultAcumen')
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'PDT', 'DTHippo')
    state.Weapons:options('None', 'BurstWeapons', 'Khatvanga', 'Lathi')

    gear.nuke_jse_back = {
        name = "Taranus's Cape",
        augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10'}
    }
    gear.stp_jse_back = {
        name = "Taranus's Cape",
        augments = {'DEX+20', 'Accuracy+20 Attack+20', '"Store TP"+10'}
    }

    -- Additional local binds
    send_command('bind ^` gs c cycle ElementalMode')
    send_command('bind ~^` gs c cycleback ElementalMode') -- Robbiewobbie's idea
    send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
    send_command('bind !q gs c weapons Default;gs c reset CastingMode;gs c reset DeathMode;gs c reset MagicBurstMode')
    send_command('bind !r gs c set DeathMode Single;gs c set MagicBurstMode Single')
    send_command('bind !\\\\ input /ja "Manawell" <me>')
    send_command('bind !` input /ma "Aspir III" <t>')
    send_command('bind @` gs c cycle MagicBurstMode')
    send_command('bind @f10 gs c cycle RecoverMode')
    send_command('bind @f9 gs c cycle DeathMode')
    send_command('bind @^` input /ja "Parsimony" <me>')
    send_command('bind !pause gs c toggle AutoSubMode') -- Automatically uses sublimation and Myrkr.
    send_command('bind ^backspace input /ma "Stun" <t>')
    send_command('bind !backspace input /ja "Enmity Douse" <t>')
    send_command('bind @backspace input /ja "Alacrity" <me>')
    send_command('bind != input /ja "Light Arts" <me>')
    send_command('bind @= input /ja "Addendum: White" <me>')
    send_command('bind ^delete input /ja "Dark Arts" <me>')
    send_command('bind !delete input /ja "Addendum: Black" <me>')
    send_command('bind @delete input /ja "Manifestation" <me>')

    select_default_macro_book()
end

function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Weapons sets
    sets.weapons.BurstWeapons = {}
    sets.weapons.Lathi = {}
    sets.weapons.Khatvanga = {}

    sets.buff.Sublimation = {
        waist = "Embla Sash"
    }
    sets.buff.DTSublimation = {
        waist = "Embla Sash"
    }

    -- Treasure Hunter

    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    ---- Precast Sets ----

    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        back = gear.nuke_jse_back,
        feet = "Wicce Sabots +3"
    }

    sets.precast.JA.Manafont = {
        body = {
            name = "Arch. Coat +3",
            augments = {'Enhances "Manafont" effect'}
        }
    } -- body="Sorcerer's Coat +2"

    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}

    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo = "Psilomene",
        head = {
            name = "Merlinic Hood",
            augments = {'"Fast Cast"+7', 'CHR+8', 'Mag. Acc.+12', '"Mag.Atk.Bns."+6'}
        },
        body = "Zendik Robe",
        hands = {
            name = "Agwu's Gages",
            augments = {'Path: A'}
        },
        legs = {
            name = "Agwu's Slops",
            augments = {'Path: A'}
        },
        feet = "Wicce Sabots +3",
        neck = "Baetyl Pendant",
        waist = {
            name = "Shinjutsu-no-Obi +1",
            augments = {'Path: A'}
        },
        left_ear = "Malignance Earring",
        right_ear = "Loquac. Earring",
        left_ring = "Medada's Ring",
        right_ring = "Kishar Ring",
        back = "Fi Follet Cape +1"
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist = "Siegel Sash"
    })

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
        ammo = "Sapience Orb",
        head = empty,
        body = "Crepuscular Cloak",
        hands = {
            name = "Agwu's Gages",
            augments = {'Path: A'}
        },
        legs = {
            name = "Agwu's Slops",
            augments = {'Path: A'}
        },
        feet = {
            name = "Merlinic Crackows",
            augments = {'Attack+5', '"Fast Cast"+7', 'MND+7', 'Mag. Acc.+11', '"Mag.Atk.Bns."+14'}
        },
        neck = "Baetyl Pendant",
        waist = {
            name = "Shinjutsu-no-Obi +1",
            augments = {'Path: A'}
        },
        left_ear = "Malignance Earring",
        right_ear = "Loquac. Earring",
        left_ring = "Medada's Ring",
        right_ring = "Kishar Ring",
        back = "Fi Follet Cape +1"
    })
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main = "Daybreak",
        sub = "Genmei Shield"
    })

    sets.precast.FC.Death = {
        main = "Opashoro",
        sub = "Enki Strap",
        ammo = {
            name = "Ghastly Tathlum +1",
            augments = {'Path: A'}
        },
        head = {
            name = "Merlinic Hood",
            augments = {'"Fast Cast"+7', 'CHR+8', 'Mag. Acc.+12', '"Mag.Atk.Bns."+6'}
        },
        body = {
            name = "Merlinic Jubbah",
            augments = {'"Fast Cast"+7', 'INT+6'}
        },
        hands = {
            name = "Agwu's Gages",
            augments = {'Path: A'}
        },
        legs = {
            name = "Amalric Slops +1",
            augments = {'MP+80', 'Mag. Acc.+20', '"Mag.Atk.Bns."+20'}
        },
        feet = {
            name = "Merlinic Crackows",
            augments = {'Attack+5', '"Fast Cast"+7', 'MND+7', 'Mag. Acc.+11', '"Mag.Atk.Bns."+14'}
        },
        neck = "Dualism Collar +1",
        waist = {
            name = "Shinjutsu-no-Obi +1",
            augments = {'Path: A'}
        },
        left_ear = "Malignance Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Medada's Ring",
        right_ring = {
            name = "Mephitas's Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Fi Follet Cape +1",
            augments = {'Path: A'}
        }
    }

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = "Oshasha's Treatise",
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
        neck = "Combatant's Torque",
        waist = "Grunfeld Rope",
        left_ear = "Ishvara Earring",
        right_ear = {
            name = "Moonshade Earring",
            augments = {'"Mag.Atk.Bns."+4', 'TP Bonus +250'}
        },
        left_ring = "Epaminondas's Ring",
        right_ring = {
            name = "Cacoethic Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Aurist's Cape +1",
            augments = {'Path: A'}
        }
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {
        ammo = {
            name = "Ghastly Tathlum +1",
            augments = {'Path: A'}
        },
        head = "Wicce Petasos +3",
        body = "Wicce Coat +3",
        hands = "Wicce Gloves +3",
        legs = "Wicce Chausses +3",
        feet = "Wicce Sabots +3",
        neck = {
            name = "Src. Stole +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Acuity Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Malignance Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Medada's Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Aurist's Cape +1",
            augments = {'Path: A'}
        }
    }

    sets.precast.WS['Myrkr'] = {
        ammo = "Psilomene",
        head = {
            name = "Amalric Coif +1",
            augments = {'MP+80', 'Mag. Acc.+20', '"Mag.Atk.Bns."+20'}
        },
        body = {
            name = "Weather. Robe +1",
            augments = {'MP+120'}
        },
        hands = {
            name = "Otomi Gloves",
            augments = {'HP+30', 'MP+30', 'MP+30'}
        },
        legs = {
            name = "Amalric Slops +1",
            augments = {'MP+80', 'Mag. Acc.+20', '"Mag.Atk.Bns."+20'}
        },
        feet = "Wicce Sabots +3",
        neck = "Dualism Collar +1",
        waist = {
            name = "Shinjutsu-no-Obi +1",
            augments = {'Path: A'}
        },
        left_ear = "Nehalennia Earring",
        right_ear = {
            name = "Moonshade Earring",
            augments = {'"Mag.Atk.Bns."+4', 'TP Bonus +250'}
        },
        left_ring = "Mephitas's Ring",
        right_ring = {
            name = "Mephitas's Ring +1",
            augments = {'Path: A'}
        },
        back = "Bane Cape"
    }

    sets.MaxTPMyrkr = {
        left_ear = "Etiolation Earring",
        right_ear = "Nehalennia Earring"
    }

    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
        ammo = "Psilomene",
        head = {
            name = "Merlinic Hood",
            augments = {'"Fast Cast"+7', 'CHR+8', 'Mag. Acc.+12', '"Mag.Atk.Bns."+6'}
        },
        body = "Zendik Robe",
        hands = {
            name = "Agwu's Gages",
            augments = {'Path: A'}
        },
        legs = {
            name = "Agwu's Slops",
            augments = {'Path: A'}
        },
        feet = "Wicce Sabots +3",
        neck = "Baetyl Pendant",
        waist = {
            name = "Shinjutsu-no-Obi +1",
            augments = {'Path: A'}
        },
        left_ear = "Malignance Earring",
        right_ear = "Loquac. Earring",
        left_ring = "Medada's Ring",
        right_ring = "Kishar Ring",
        back = "Fi Follet Cape +1"
    }

    sets.midcast.Cure = {
        ammo = "Pemphredo Tathlum",
        head = {
            name = "Vanya Hood",
            augments = {'MND+10', 'Spell interruption rate down +15%', '"Conserve MP"+6'}
        },
        body = {
            name = "Vanya Robe",
            augments = {'Healing magic skill +20', '"Cure" spellcasting time -7%', 'Magic dmg. taken -3'}
        },
        hands = {
            name = "Telchine Gloves",
            augments = {'DEF+20', '"Conserve MP"+5', 'Enh. Mag. eff. dur. +10'}
        },
        legs = {
            name = "Vanya Slops",
            augments = {'MND+10', 'Spell interruption rate down +15%', '"Conserve MP"+6'}
        },
        feet = {
            name = "Vanya Clogs",
            augments = {'"Cure" potency +5%', '"Cure" spellcasting time -15%', '"Conserve MP"+6'}
        },
        neck = "Nodens Gorget",
        waist = {
            name = "Shinjutsu-no-Obi +1",
            augments = {'Path: A'}
        },
        left_ear = "Mendi. Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Lebeche Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Aurist's Cape +1",
            augments = {'Path: A'}
        }
    }

    sets.midcast.LightWeatherCure = {
        ammo = "Pemphredo Tathlum",
        head = {
            name = "Vanya Hood",
            augments = {'MND+10', 'Spell interruption rate down +15%', '"Conserve MP"+6'}
        },
        body = {
            name = "Vanya Robe",
            augments = {'Healing magic skill +20', '"Cure" spellcasting time -7%', 'Magic dmg. taken -3'}
        },
        hands = {
            name = "Telchine Gloves",
            augments = {'DEF+20', '"Conserve MP"+5', 'Enh. Mag. eff. dur. +10'}
        },
        legs = {
            name = "Vanya Slops",
            augments = {'MND+10', 'Spell interruption rate down +15%', '"Conserve MP"+6'}
        },
        feet = {
            name = "Vanya Clogs",
            augments = {'"Cure" potency +5%', '"Cure" spellcasting time -15%', '"Conserve MP"+6'}
        },
        neck = "Nodens Gorget",
        waist = {
            name = "Shinjutsu-no-Obi +1",
            augments = {'Path: A'}
        },
        left_ear = "Mendi. Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Lebeche Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Aurist's Cape +1",
            augments = {'Path: A'}
        }
    }

    -- Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {
        ammo = "Pemphredo Tathlum",
        head = {
            name = "Vanya Hood",
            augments = {'MND+10', 'Spell interruption rate down +15%', '"Conserve MP"+6'}
        },
        body = {
            name = "Vanya Robe",
            augments = {'Healing magic skill +20', '"Cure" spellcasting time -7%', 'Magic dmg. taken -3'}
        },
        hands = {
            name = "Telchine Gloves",
            augments = {'DEF+20', '"Conserve MP"+5', 'Enh. Mag. eff. dur. +10'}
        },
        legs = {
            name = "Vanya Slops",
            augments = {'MND+10', 'Spell interruption rate down +15%', '"Conserve MP"+6'}
        },
        feet = {
            name = "Vanya Clogs",
            augments = {'"Cure" potency +5%', '"Cure" spellcasting time -15%', '"Conserve MP"+6'}
        },
        neck = "Nodens Gorget",
        waist = {
            name = "Shinjutsu-no-Obi +1",
            augments = {'Path: A'}
        },
        left_ear = "Mendi. Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Lebeche Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Aurist's Cape +1",
            augments = {'Path: A'}
        }
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {})

    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

    sets.midcast['Enhancing Magic'] = {
        ammo = "Sapience Orb",
        head = {
            name = "Telchine Cap",
            augments = {'DEF+14', '"Conserve MP"+5', 'Enh. Mag. eff. dur. +10'}
        },
        body = {
            name = "Telchine Chas.",
            augments = {'DEF+17', '"Conserve MP"+5', 'Enh. Mag. eff. dur. +10'}
        },
        hands = {
            name = "Telchine Gloves",
            augments = {'DEF+20', '"Conserve MP"+5', 'Enh. Mag. eff. dur. +10'}
        },
        legs = {
            name = "Telchine Braconi",
            augments = {'Mag. Evasion+17', '"Conserve MP"+5', 'Enh. Mag. eff. dur. +10'}
        },
        feet = {
            name = "Telchine Pigaches",
            augments = {'DEF+18', '"Conserve MP"+5', 'Enh. Mag. eff. dur. +10'}
        },
        neck = "Incanter's Torque",
        waist = "Embla Sash",
        left_ear = "Mimir Earring",
        right_ear = "Andoaa Earring",
        left_ring = "Stikini Ring +1",
        right_ring = "Stikini Ring +1",
        back = {
            name = "Fi Follet Cape +1",
            augments = {'Path: A'}
        }
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
        head = "Amalric Coif +1"
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        head = "Amalric Coif +1",
        hands = "Regal Cuffs",
        waist = "Emphatikos Rope",
        legs = "Shedir Seraweels"
    })

    sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {
        legs = "Shedir Seraweels"
    })

    sets.midcast['Enfeebling Magic'] = {
        ammo = {
            name = "Ghastly Tathlum +1",
            augments = {'Path: A'}
        },
        head = "Wicce Petasos +3",
        body = "Spaekona's Coat +3",
        hands = "Regal Cuffs",
        legs = "Wicce Chausses +3",
        feet = "Wicce Sabots +3",
        neck = {
            name = "Src. Stole +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Acuity Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Regal Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Medada's Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Aurist's Cape +1",
            augments = {'Path: A'}
        }
    }

    sets.midcast['Enfeebling Magic'].Resistant = {}

    sets.midcast.ElementalEnfeeble = {
        ammo = {
            name = "Ghastly Tathlum +1",
            augments = {'Path: A'}
        },
        head = "Wicce Petasos +3",
        body = "Wicce Coat +3",
        hands = "Spae. Gloves +3",
        legs = {
            name = "Arch. Tonban +3",
            augments = {'Increases Elemental Magic debuff time and potency'}
        },
        feet = {
            name = "Arch. Sabots +3",
            augments = {'Increases Aspir absorption amount'}
        },
        neck = {
            name = "Src. Stole +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Acuity Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Regal Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Medada's Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Aurist's Cape +1",
            augments = {'Path: A'}
        }
    }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast['Dark Magic'] = {}

    sets.midcast.Drain = {
        ammo = {
            name = "Ghastly Tathlum +1",
            augments = {'Path: A'}
        },
        head = "Pixie Hairpin +1",
        body = {
            name = "Merlinic Jubbah",
            augments = {'Mag. Acc.+27', '"Drain" and "Aspir" potency +11', '"Mag.Atk.Bns."+8'}
        },
        hands = {
            name = "Merlinic Dastanas",
            augments = {'Mag. Acc.+15 "Mag.Atk.Bns."+15', '"Drain" and "Aspir" potency +11', 'CHR+4', 'Mag. Acc.+14'}
        },
        legs = "Spae. Tonban +3",
        feet = {
            name = "Agwu's Pigaches",
            augments = {'Path: A'}
        },
        neck = "Erra Pendant",
        waist = "Fucho-no-Obi",
        left_ear = "Hirudinea Earring",
        right_ear = "Mani Earring",
        left_ring = "Evanescence Ring",
        right_ring = "Archon Ring",
        back = {
            name = "Aurist's Cape +1",
            augments = {'Path: A'}
        }
    }

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Aspir.Death = {
        main = "Opashoro",
        sub = "Enki Strap",
        ammo = {
            name = "Ghastly Tathlum +1",
            augments = {'Path: A'}
        },
        head = "Pixie Hairpin +1",
        body = "Wicce Coat +3",
        hands = {
            name = "Arch. Gloves +3",
            augments = {'Increases Elemental Magic accuracy'}
        },
        legs = "Spae. Tonban +3",
        feet = {
            name = "Agwu's Pigaches",
            augments = {'Path: A'}
        },
        neck = "Erra Pendant",
        waist = "Fucho-no-Obi",
        left_ear = "Malignance Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Medada's Ring",
        right_ring = {
            name = "Mephitas's Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Aurist's Cape +1",
            augments = {'Path: A'}
        }
    }

    sets.midcast.Death = {
        main = "Opashoro",
        sub = "Enki Strap",
        ammo = {
            name = "Ghastly Tathlum +1",
            augments = {'Path: A'}
        },
        head = "Pixie Hairpin +1",
        body = "Wicce Coat +3",
        hands = {
            name = "Agwu's Gages",
            augments = {'Path: A'}
        },
        legs = "Wicce Chausses +3",
        feet = {
            name = "Agwu's Pigaches",
            augments = {'Path: A'}
        },
        neck = {
            name = "Src. Stole +2",
            augments = {'Path: A'}
        },
        waist = "Hachirin-no-Obi",
        left_ear = "Malignance Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Medada's Ring",
        right_ring = {
            name = "Mephitas's Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Taranus's Cape",
            augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', "Phys. dmg. taken-10%"}
        }
    }

    sets.midcast.Comet = {
        main = "Opashoro",
        sub = "Enki Strap",
        ammo = {
            name = "Ghastly Tathlum +1",
            augments = {'Path: A'}
        },
        head = "Pixie Hairpin +1",
        body = "Wicce Coat +3",
        hands = {
            name = "Agwu's Gages",
            augments = {'Path: A'}
        },
        legs = "Wicce Chausses +3",
        feet = {
            name = "Agwu's Pigaches",
            augments = {'Path: A'}
        },
        neck = {
            name = "Src. Stole +2",
            augments = {'Path: A'}
        },
        waist = "Hachirin-no-Obi",
        left_ear = "Malignance Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Medada's Ring",
        right_ring = {
            name = "Mephitas's Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Taranus's Cape",
            augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', "Phys. dmg. taken-10%"}
        }
    }

    sets.midcast.Stun = {}

    sets.midcast.Stun.Resistant = {}

    sets.midcast.BardSong = {}

    sets.midcast.Impact = {
        ammo = "Pemphredo Tathlum",
        head = empty,
        body = "Crepuscular Cloak",
        hands = "Wicce Gloves +3",
        legs = "Wicce Chausses +3",
        feet = "Wicce Sabots +3",
        neck = {
            name = "Src. Stole +2",
            augments = {'Path: A'}
        },
        waist = {
            name = "Acuity Belt +1",
            augments = {'Path: A'}
        },
        left_ear = "Malignance Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Medada's Ring",
        right_ring = {
            name = "Metamor. Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Aurist's Cape +1",
            augments = {'Path: A'}
        }
    }

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
        ammo = {
            name = "Ghastly Tathlum +1",
            augments = {'Path: A'}
        },
        head = "Ea Hat +1",
        body = "Wicce Coat +3",
        hands = {
            name = "Agwu's Gages",
            augments = {'Path: A'}
        },
        legs = "Wicce Chausses +3",
        feet = {
            name = "Agwu's Pigaches",
            augments = {'Path: A'}
        },
        neck = {
            name = "Src. Stole +2",
            augments = {'Path: A'}
        },
        waist = "Sacro Cord",
        left_ear = "Malignance Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Freke Ring",
        right_ring = "Medada's Ring",
        back = {
            name = "Taranus's Cape",
            augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', "Phys. dmg. taken-10%"}
        }
    }

    sets.midcast['Elemental Magic'].Resistant = {}

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(
        sets.midcast['Elemental Magic'].Resistant, {}
    )
    sets.midcast['Elemental Magic'].LowTierNuke = set_combine(sets.midcast['Elemental Magic'], {
        body = "Spaekona's Coat +3"
    })
    sets.midcast['Elemental Magic'].LowTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {
        body = "Spaekona's Coat +3"
    })

    sets.midcast.Helix = sets.midcast['Elemental Magic']
    sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant

    -- Minimal damage gear, maximum recast gear for procs.
    sets.midcast['Elemental Magic'].Proc = {}

    sets.midcast['Elemental Magic'].OccultAcumen = {
        ammo = "Seraphic Ampulla",
        head = {
            name = "Merlinic Hood",
            augments = {'Attack+20', '"Occult Acumen"+11', 'Mag. Acc.+11', '"Mag.Atk.Bns."+1'}
        },
        body = {
            name = "Merlinic Jubbah",
            augments = {'"Mag.Atk.Bns."+29', '"Occult Acumen"+11'}
        },
        hands = {
            name = "Merlinic Dastanas",
            augments = {'Mag. Acc.+23', '"Occult Acumen"+11', 'AGI+5'}
        },
        legs = "Perdition Slops",
        feet = {
            name = "Merlinic Crackows",
            augments = {'"Occult Acumen"+11', '"Mag.Atk.Bns."+13'}
        },
        neck = "Combatant's Torque",
        waist = "Oneiros Rope",
        left_ear = "Crep. Earring",
        right_ear = "Dedition Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Crepuscular Ring",
        back = {
            name = "Taranus's Cape",
            augments = {'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', '"Store TP"+10'}
        }
    }

    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {
        head = empty,
        body = "Crepuscular Cloak"
    })
    -- Gear that converts elemental damage done to recover MP.	
    sets.RecoverMP = {
        body = "Spaekona's Coat +3"
    }

    -- Gear for Magic Burst mode.
    sets.MagicBurst = {}

    sets.ResistantMagicBurst = {}

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}

    -- Idle sets

    -- Normal refresh idle set
    sets.idle = {
        ammo = "Psilomene",
        head = "Volte Beret",
        body = "Wicce Coat +3",
        hands = "Merlinic Dastanas",
        legs = {
            name = "Assid. Pants +1",
            augments = {'Path: A'}
        },
        feet = "Volte Gaiters",
        neck = "Null Loop",
        waist = "Null Belt",
        -- waist = {
        --     name = "Shinjutsu-no-Obi +1",
        --     augments = {'Path: A'}
        -- },
        left_ear = "Malignance Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Stikini Ring +1",
        right_ring = "Stikini Ring +1",
        back = {
            name = "Taranus's Cape",
            augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', "Phys. dmg. taken-10%"}
        }
    }

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {
        ammo = "Crepuscular Pebble",
        head = {
            name = "Nyame Helm",
            augments = {'Path: B'}
        },
        body = "Shamash Robe",
        hands = {
            name = "Nyame Gauntlets",
            augments = {'Path: B'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = "Wicce Sabots +3",
        neck = {
            name = "Loricate Torque +1",
            augments = {'Path: A'}
        },
        waist = {
            name = "Shinjutsu-no-Obi +1",
            augments = {'Path: A'}
        },
        left_ear = "Genmei Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Stikini Ring +1",
        right_ring = "Stikini Ring +1",
        back = {
            name = "Taranus's Cape",
            augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', "Phys. dmg. taken-10%"}
        }
    }

    sets.idle.MDT = {
        ammo = "Crepuscular Pebble",
        head = {
            name = "Nyame Helm",
            augments = {'Path: B'}
        },
        body = "Shamash Robe",
        hands = {
            name = "Nyame Gauntlets",
            augments = {'Path: B'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = "Wicce Sabots +3",
        neck = {
            name = "Loricate Torque +1",
            augments = {'Path: A'}
        },
        waist = {
            name = "Shinjutsu-no-Obi +1",
            augments = {'Path: A'}
        },
        left_ear = "Genmei Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Stikini Ring +1",
        right_ring = "Stikini Ring +1",
        back = {
            name = "Taranus's Cape",
            augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', "Phys. dmg. taken-10%"}
        }
    }

    sets.idle.DTHippo = set_combine(sets.idle.PDT, {})

    sets.idle.Death = {
        main = "Opashoro",
        sub = "Enki Strap",
        ammo = "Psilomene",
        head = "Wicce Petasos +3",
        body = "Wicce Coat +3",
        hands = {
            name = "Merlinic Dastanas",
            augments = {'AGI+9', 'Weapon skill damage +1%', '"Refresh"+2', 'Accuracy+2 Attack+2',
                        'Mag. Acc.+10 "Mag.Atk.Bns."+10'}
        },
        legs = {
            name = "Amalric Slops +1",
            augments = {'MP+80', 'Mag. Acc.+20', '"Mag.Atk.Bns."+20'}
        },
        feet = "Wicce Sabots +3",
        neck = "Dualism Collar +1",
        waist = {
            name = "Shinjutsu-no-Obi +1",
            augments = {'Path: A'}
        },
        left_ear = "Etiolation Earring",
        right_ear = "Wicce Earring +2",
        left_ring = "Stikini Ring +1",
        right_ring = {
            name = "Mephitas's Ring +1",
            augments = {'Path: A'}
        },
        back = {
            name = "Taranus's Cape",
            augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', "Phys. dmg. taken-10%"}
        }
    }
    sets.idle.Town = {
        ear2 = "Wicce Earring +2"
    }
    sets.idle.Weak = {}

    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.defense.MEVA = {}

    sets.Kiting = {
        feet = "Herald's Gaiters"
    }
    sets.latent_refresh = {
        waist = "Fucho-no-obi"
    }
    sets.latent_refresh_grip = {
        sub = "Oneiros Grip"
    }
    sets.TPEat = {
        neck = "Chrys. Torque"
    }
    sets.DayIdle = {}
    sets.NightIdle = {}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.

    sets.HPDown = {
        head = "Pixie Hairpin +1",
        ear1 = "Genmei Earring",
        ear2 = "Evans Earring",
        body = "Jhakri Robe +2",
        hands = "Jhakri Cuffs +2",
        ring1 = "Mephitas's Ring +1",
        ring2 = "Mephitas's Ring",
        back = "Swith Cape +1",
        legs = "Shedir Seraweels",
        feet = "Jhakri Pigaches +2"
    }

    sets.HPCure = {
        main = gear.gada_healing_club,
        sub = "Sors Shield",
        ammo = "Hasty Pinion +1",
        head = "Nyame Helm",
        neck = "Nodens Gorget",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Vrikodara Jupon",
        hands = "Telchine Gloves",
        ring1 = "Kunaji Ring",
        ring2 = "Meridian Ring",
        back = "Tempered Cape +1",
        waist = "Witful Belt",
        legs = "Psycloth Lappas",
        feet = "Vanya Clogs"
    }

    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Mana Wall'] = {
        back = gear.nuke_jse_back,
        feet = "Wicce Sabots +3"
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        ammo = "Amar Cluster",
        head = {
            name = "Nyame Helm",
            augments = {'Path: B'}
        },
        body = {
            name = "Nyame Mail",
            augments = {'Path: B'}
        },
        hands = {
            name = "Gazu Bracelets +1",
            augments = {'Path: A'}
        },
        legs = {
            name = "Nyame Flanchard",
            augments = {'Path: B'}
        },
        feet = {
            name = "Nyame Sollerets",
            augments = {'Path: B'}
        },
        neck = "Combatant's Torque",
        waist = "Grunfeld Rope",
        left_ear = "Mache Earring +1",
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Chirich Ring +1",
        back = {
            name = "Aurist's Cape +1",
            augments = {'Path: A'}
        }
    }

    sets.engaged.DT = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        neck = "Combatant's Torque",
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Ramuh Ring +1",
        ring2 = "Ramuh Ring +1",
        back = gear.stp_jse_back,
        waist = "Olseni Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    -- Situational sets: Gear that is equipped on certain targets
    sets.Self_Healing = {
        waist = "Gishdubar Sash"
    }
    sets.Cure_Received = {
        waist = "Gishdubar Sash"
    }
    sets.Self_Refresh = {
        back = "Grapevine Cape",
        waist = "Gishdubar Sash"
    }

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 7)
end
