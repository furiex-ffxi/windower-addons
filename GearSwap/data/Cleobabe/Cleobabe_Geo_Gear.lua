function user_job_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc', 'Staff', 'DW')
    state.HybridMode:options("Normal")
    state.WeaponskillMode:options("Match", "Acc")
    state.CastingMode:options('Normal', 'OccultAcumen', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'Aminon')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
    state.MagicalDefenseMode:options('MDT', 'NukeLock')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('None', 'Idris', 'Tishtrya', 'Mpaca', 'Maxentius', 'Ternion', 'Daybreak', 'DualWeapons')

    gear.nuke_jse_back = {
        name = "Nantosuelta's Cape",
        augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', 'Phys. dmg. taken-10%'}
    }
    gear.idle_jse_back = {
        name = "Nantosuelta's Cape",
        augments = {'HP+60', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Pet: "Regen"+10', 'Pet: "Regen"+5'}
    }
    
    gear.fc_jse_back = {
        name = "Nantosuelta's Cape",
        augments = {'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Mag. Acc.+10', '"Fast Cast"+10', 'Damage taken-5%'}
    }

    gear.wsd_str_jse_back = { 
        name="Nantosuelta's Cape", 
        augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}
    }

    gear.obi_cure_back = "Tempered Cape +1"
    gear.obi_cure_waist = "Witful Belt"

    gear.obi_low_nuke_back = gear.nuke_jse_back
    gear.obi_low_nuke_waist = "Sekhmet Corset"

    gear.obi_high_nuke_back = gear.nuke_jse_back
    gear.obi_high_nuke_waist = "Refoccilation Stone"

    autoindi = "Haste"
    autogeo = "Frailty"

    -- Additional local binds
    send_command('bind ^` gs c cycle ElementalMode')
    send_command('bind !` input /ja "Full Circle" <me>')
    send_command('bind @f8 gs c toggle AutoNukeMode')
    send_command('bind @` gs c cycle MagicBurstMode')
    send_command('bind @f10 gs c cycle RecoverMode')
    send_command('bind ^backspace input /ja "Entrust" <me>')
    send_command('bind !backspace input /ja "Life Cycle" <me>')
    send_command('bind @backspace input /ma "Sleep II" <t>')
    send_command('bind ^delete input /ma "Aspir III" <t>')
    send_command('bind @delete input /ma "Sleep" <t>')

    indi_duration = 290

    select_default_macro_book()
end

function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    gear.af = {
        Head = "Geo. Galero +4",
        Body = "Geo. Tunic +4",
        Hands = "Geo. Mitaines +4",
        Legs = "Geo. Pants +4",
        Feet = "Geo. Sandals +4"
    }

    gear.relic = {
        Head = "Bagua Galero +4",
        Body = "Bagua Tunic +4",
        Hands = "Bagua Mitaines +4",
        Legs = "Bagua Pants +4",
        Feet = "Bagua Sandals +4"
    }

    gear.empy = {
        Head = "Azimuth Hood +3",
        Body = "Azimuth Coat +3",
        Hands = "Azimuth Gloves +3",
        Legs = "Azimuth Tights +3",
        Feet = "Azimuth Gaiters +3"
    }

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {
        body = gear.relic.Body
    }
    sets.precast.JA['Life Cycle'] = {
        body = gear.af.Body,
        back = gear.idle_jse_back
    }
    sets.precast.JA['Radial Arcana'] = {
        feet = gear.relic.Feet
    }
    sets.precast.JA['Mending Halation'] = {
        legs = gear.relic.Legs
    }
    sets.precast.JA['Full Circle'] = {
        head = gear.empy.Head,
        hands = gear.relic.Hands
    }

    -- Indi Duration in slots that would normally have skill here to make entrust more efficient.
    sets.buff.Entrust = {
        main = gear.gada_indi_club,
        neck = "Incanter's Torque",
        back = gear.idle_jse_back,
        legs = gear.relic.Legs,
        feet = gear.empy.Feet
    }

    -- Relic hat for Blaze of Glory HP increase.
    sets.buff['Blaze of Glory'] = {
        head = gear.relic.Head
    }

    -- Fast cast sets for spells

    sets.precast.FC = {
        range = "Dunna", -- 3
        head = "C. Palug Crown", -- 8
        neck = "Voltsurge Torque", -- 4
        ear1 = "Enchntr. Earring +1", -- 2
        ear2 = "Malignance Earring", -- 4
        body = "Zendik Robe", -- 13
        hands = "Volte Gloves", -- 6
        ring1 = "Kishar Ring", -- 4
        ring2 = "Prolix Ring", -- 2
        back = "Fi Follet Cape +1", -- 10
        waist = "Witful Belt", -- 3 / 3 QM
        legs = gear.af.Legs, -- 15
        feet = "Volte Gaiters" -- 6
    } -- Total FC 80%

    sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {
        range = "Dunna",
        ammo = empty
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        ear2 = "Malignance Earring",
        hands = gear.relic.Hand
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        main = "Serenity",
        sub = "Clerisy Strap +1"
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.Self_Healing = {
        neck = "Phalaina Locket",
        ring1 = "Kunaji Ring",
        ring2 = "Asklepian Ring",
        waist = "Gishdubar Sash"
    }
    sets.Cure_Received = {
        neck = "Phalaina Locket",
        ring1 = "Kunaji Ring",
        ring2 = "Asklepian Ring",
        waist = "Gishdubar Sash"
    }
    sets.Self_Refresh = {
        back = "Grapevine Cape",
        waist = "Gishdubar Sash",
        feet = "Inspirited Boots"
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist = "Siegel Sash"
    })

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC.Impact = {
        head = empty,
        neck = "Voltsurge Torque",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Malignance Earring",
        body = "Twilight Cloak",
        hands = "Volte Gloves",
        ring1 = "Kishar Ring",
        ring2 = "Lebeche Ring",
        back = "Lifestream Cape",
        waist = "Witful Belt",
        legs = gear.af.Legs,
        feet = "Regal Pumps +1"
    }

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main = "Daybreak",
        sub = "Genmei Shield"
    })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head = sets.Nyame.Head,
        neck = "Rep. Plat. Medal",
        body = sets.Nyame.Body,
        hands = sets.Nyame.Hands,
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet,
        waist = "Cornelia's Belt",
        left_ear = {
            name = "Moonshade Earring",
            augments = {'Accuracy+4', 'TP Bonus +250'}
        },
        right_ear = "Ishvara Earring",
        left_ring = "Epaminondas's Ring",
        right_ring = "Cornelia's Ring",
        back = gear.wsd_str_jse_back
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        neck = "Null Loop",
        waist = "Null Belt",
        right_ear = "Telos Earring",
    })

    sets.precast.WS["Flash Nova"] = set_combine(sets.precast.WS, {
        right_ear = "Malignance Earring"
    })

    sets.precast.WS['Cataclysm'] = {
        head = sets.Nyame.Head,
        neck = "Baetyl Pendant",
        body = sets.Nyame.Body,
        hands = sets.Nyame.Hands,
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet,
        waist = "Eschan Stone",
        left_ear = {
            name = "Moonshade Earring",
            augments = {'Accuracy+4', 'TP Bonus +250'}
        },
        right_ear = "Ishvara Earring",
        left_ring = "Epaminondas's Ring",
        right_ring = "Karieyh Ring",
        back = gear.wsd_str_jse_back
    }

    sets.precast.WS["Black Halo"] = set_combine(sets.precast.WS, {
        right_ring = "Metamor. Ring +1",
        back = gear.wsd_str_jse_back
    })

    sets.precast.WS['Aeolian Edge'] = {
        head = sets.Nyame.Head,
        neck = "Baetyl Pendant",
        body = sets.Nyame.Body,
        hands = sets.Nyame.Hands,
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet,
        waist = "Eschan Stone",
        left_ear = {
            name = "Moonshade Earring",
            augments = {'Accuracy+4', 'TP Bonus +250'}
        },
        right_ear = "Ishvara Earring",
        left_ring = "Epaminondas's Ring",
        right_ring = "Karieyh Ring",
        back = gear.wsd_str_jse_back,
    }

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        main = gear.grioavolr_fc_staff,
        sub = "Clerisy Strap +1",
        head = "Amalric Coif +1",
        neck = "Voltsurge Torque",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Malignance Earring",
        body = "Zendik Robe",
        hands = "Volte Gloves",
        ring1 = "Kishar Ring",
        ring2 = "Prolix Ring",
        back = "Lifestream Cape",
        waist = "Witful Belt",
        legs = gear.af.Legs,
        feet = "Regal Pumps +1"
    }

    sets.midcast.Geomancy = {
        main = "Idris",
        sub = "Genmei Shield",
        range = "Dunna",
        head = "Vanya Hood",
        neck = "Bagua Charm +2",
        ear1 = "Gifted Earring",
        ear2 = "Malignance Earring",
        body = "Vedic Coat",
        hands = gear.af.Hands,
        ring1 = "Defending Ring",
        ring2 = "Murky Ring",
        back = "Solemnity Cape",
        waist = "Austerity Belt +1",
        legs = "Vanya Slops",
        feet = "Medium's Sabots"
    }

    -- Extra Indi duration as long as you can keep your 900 skill cap.
    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
        back = gear.idle_jse_back,
        legs = gear.relic.Legs,
        feet = gear.empy.Feet
    })

    sets.midcast.Cure = {
        -- main = "Daybreak",
        -- sub = "Sors Shield",
        head = "Amalric Coif +1",
        neck = "Incanter's Torque",
        ear1 = "Gifted Earring",
        ear2 = "Mendi. Earring",
        body = "Zendik Robe",
        hands = "Telchine Gloves",
        ring1 = "Lebeche Ring",
        -- ring2 = "Menelaus's Ring",
        back = "Tempered Cape +1",
        waist = "Witful Belt",
        legs = gear.af.Legs,
        feet = "Vanya Clogs"
    }

    sets.midcast.LightWeatherCure = {
        -- main = "Chatoyant Staff",
        -- sub = "Curatio Grip",
        head = "Amalric Coif +1",
        neck = "Phalaina Locket",
        ear1 = "Gifted Earring",
        ear2 = "Etiolation Earring",
        body = "Vrikodara Jupon",
        hands = "Telchine Gloves",
        ring1 = "Janniston Ring",
        ring2 = "Menelaus's Ring",
        back = "Twilight Cape",
        waist = "Hachirin-no-Obi",
        legs = gear.af.Legs,
        feet = "Vanya Clogs"
    }

    -- Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {
        -- main = "Daybreak",
        -- sub = "Sors Shield",
        head = "Amalric Coif +1",
        neck = "Incanter's Torque",
        ear1 = "Gifted Earring",
        ear2 = "Etiolation Earring",
        body = "Zendik Robe",
        hands = "Telchine Gloves",
        ring1 = "Janniston Ring",
        ring2 = "Lebeche Ring",
        back = "Twilight Cape",
        waist = "Hachirin-no-Obi",
        legs = gear.af.Legs,
        feet = "Vanya Clogs"
    }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        neck = "Debilis Medallion",
        hands = "Hieros Mittens",
        back = "Oretan. Cape +1",
        ring1 = "Haoma's Ring",
        ring2 = "Menelaus's Ring",
        waist = "Witful Belt",
        feet = "Vanya Clogs"
    })

    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {
        main = gear.grioavolr_fc_staff,
        sub = "Clemency Grip"
    })

    sets.midcast['Elemental Magic'] = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Ghastly Tathlum +1",
        head = "Ea Hat +1",
        body = gear.empy.Body,
        hands = "Agwu's Gages",
        -- legs = "Agwu's Slops", -- swap at r30
        legs = gear.empy.Legs,
        feet = "Agwu's Pigaches",
        neck = "Sibyl Scarf",
        waist = "Acuity Belt +1",
        left_ear = "Malignance Earring",
        right_ear = "Azimuth Earring +2",
        left_ring = "Freke Ring",
        right_ring = "Metamor. Ring +1",
        back = gear.nuke_jse_back
    }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast['Elemental Magic'].Proc = {
        main = empty,
        sub = empty,
        head = "Vanya Hood",
        neck = "Loricate Torque +1",
        ear1 = "Gifted Earring",
        ear2 = "Loquac. Earring",
        body = "Seidr Cotehardie",
        hands = "Regal Cuffs",
        ring1 = "Kishar Ring",
        ring2 = "Prolix Ring",
        back = "Swith Cape +1",
        waist = "Witful Belt",
        legs = "Assid. Pants +1",
        feet = "Regal Pumps +1"
    }

    sets.midcast['Elemental Magic'].Fodder = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast["Thundara III"] = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast["Blizzara III"] = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast["Blizzara III"].OccultAcumen = {
        head={ name="Merlinic Hood", augments={'"Occult Acumen"+11','Mag. Acc.+4',}},
        body={ name="Merlinic Jubbah", augments={'Mag. Acc.+1','"Occult Acumen"+11','AGI+9','"Mag.Atk.Bns."+8',}},
        hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+18','"Occult Acumen"+11','Mag. Acc.+4',}},
        legs="Perdition Slops",
        feet={ name="Merlinic Crackows", augments={'"Occult Acumen"+11','CHR+10','Mag. Acc.+5','"Mag.Atk.Bns."+12',}},
        neck="Combatant's Torque",
        waist="Oneiros Rope",
        left_ear="Crep. Earring",
        right_ear="Dedition Earring",
        left_ring="Chirich Ring +1",
        right_ring="Chirich Ring +1",
        back="Null Shawl"
    }
    sets.midcast["Thundara III"].OccultAcumen = set_combine(sets.midcast["Blizzara III"].OccultAcumen, {})

    sets.midcast['Dark Magic'] = {
        head = gear.merlinic_nuke_head,
        neck = "Erra Pendant",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        body = gear.merlinic_nuke_body,
        hands = "Amalric Gages +1",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        waist = "Yamabuki-no-Obi",
        legs = "Merlinic Shalwar",
        feet = gear.merlinic_aspir_feet
    }

    sets.midcast.Drain = {
        head = "Pixie Hairpin +1",
        neck = "Erra Pendant",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        body = gear.merlinic_nuke_body,
        hands = "Amalric Gages +1",
        ring1 = "Archon Ring",
        ring2 = "Evanescence Ring",
        back = gear.nuke_jse_back,
        waist = "Fucho-no-obi",
        legs = "Merlinic Shalwar",
        feet = gear.merlinic_aspir_feet
    }

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {
        main = gear.grioavolr_fc_staff,
        sub = "Clerisy Strap +1",
        head = "Amalric Coif +1",
        neck = "Voltsurge Torque",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Malignance Earring",
        body = "Zendik Robe",
        hands = "Volte Gloves",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Lifestream Cape",
        waist = "Witful Belt",
        legs = "Psycloth Lappas",
        feet = "Regal Pumps +1"
    }

    sets.midcast.Stun.Resistant = {
        head = "Amalric Coif +1",
        neck = "Erra Pendant",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        body = "Zendik Robe",
        hands = "Amalric Gages +1",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Merlinic Shalwar",
        feet = gear.merlinic_aspir_feet
    }

    sets.midcast.Impact = {
        head = empty,
        neck = "Erra Pendant",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        body = "Twilight Cloak",
        hands = "Regal Cuffs",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Merlinic Shalwar",
        feet = "Amalric Nails +1"
    }

    sets.midcast["Impact"].OccultAcumen = set_combine(sets.midcast["Blizzara III"].OccultAcumen, {
        head = empty,
        body = "Twilight Cloak",
    })

    sets.midcast.Dispel = {
        head = "Amalric Coif +1",
        neck = "Erra Pendant",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        body = "Zendik Robe",
        hands = "Amalric Gages +1",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Merlinic Shalwar",
        feet = gear.merlinic_aspir_feet
    }

    sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {
        main = "Daybreak",
        sub = "Ammurapi Shield"
    })

    sets.midcast.Absorb = {
        head = gear.empy.Head, 
        neck = "Null Loop",
        ear1 = "Malignance Earring", -- 4 FC
        ear2 = "Alabaster Earring", 
        body = "Zendik Robe", -- 13 FC
        hands = gear.empy.Hands,
        ring1 = "Kishar Ring", -- 4 FC
        ring2 = "Prolix Ring", -- 2 FC
        back = gear.fc_jse_back, -- 10 FC
        waist = "Embla Sash", -- 5 FC
        legs = gear.af.Legs, -- 15 FC
        feet = "Agwu's Pigaches" -- 4 FC
    } -- Total FC 60%

    sets.midcast['Enfeebling Magic'] = {
        head = gear.empy.Head,
        body = gear.empy.Body,
        neck = "Bagua Charm +2",
        ear1 = "Malignance Earring",
        ear2 = "Azimuth Earring +2",
        hands = "Regal Cuffs",
        ring1 = "Metamor. Ring +1",
        ring2 = "Kishar Ring",
        back = "Aurist's Cape +1",
        waist = "Acuity Belt +1",
        legs = gear.empy.Legs,
        feet = gear.empy.Feet
    }

    sets.midcast['Enfeebling Magic'].Resistant = {
        head = gear.empy.Head,
        body = gear.empy.Body,
        neck = "Bagua Charm +2",
        ear1 = "Malignance Earring",
        ear2 = "Azimuth Earring +2",
        hands = "Regal Cuffs",
        ring1 = "Metamor. Ring +1",
        ring2 = "Kishar Ring",
        back = "Aurist's Cape +1",
        waist = "Acuity Belt +1",
        legs = gear.empy.Legs,
        feet = gear.empy.Feet
    }

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {
        head = "Amalric Coif +1",
        ear2 = "Malignance Earring",
        waist = "Acuity Belt +1"
    })
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
        head = "Amalric Coif +1",
        ear2 = "Malignance Earring",
        waist = "Acuity Belt +1"
    })

    sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
        head = "Amalric Coif +1",
        ear2 = "Malignance Earring",
        waist = "Acuity Belt +1"
    })
    sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
        head = "Amalric Coif +1",
        ear2 = "Malignance Earring",
        waist = "Acuity Belt +1"
    })

    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
        ring1 = "Stikini Ring +1"
    })
    sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
        ring1 = "Stikini Ring +1"
    })

    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {
        ring1 = "Stikini Ring +1"
    })

    sets.midcast['Enhancing Magic'] = {
        main = gear.gada_enhancing_club,
        sub = "Ammurapi Shield",
        head = "Telchine Cap",
        neck = "Incanter's Torque",
        ear1 = "Andoaa Earring",
        ear2 = "Gifted Earring",
        body = "Telchine Chas.",
        hands = "Telchine Gloves",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = "Perimede Cape",
        waist = "Embla Sash",
        legs = "Telchine Braconi",
        feet = "Telchine Pigaches"
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        neck = "Nodens Gorget",
        ear2 = "Earthcry Earring",
        waist = "Siegel Sash",
        legs = "Shedir Seraweels"
    })

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
        head = "Amalric Coif +1"
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        main = "Vadose Rod",
        sub = "Genmei Shield",
        head = "Amalric Coif +1",
        hands = "Regal Cuffs",
        waist = "Emphatikos Rope",
        legs = "Shedir Seraweels"
    })

    sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {
        legs = "Shedir Seraweels"
    })

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {
        ring2 = "Sheltered Ring",
        ear1 = "Gifted Earring",
        ear2 = "Malignance Earring",
        waist = "Sekhmet Corset"
    })
    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {
        ring2 = "Sheltered Ring",
        ear1 = "Gifted Earring",
        ear2 = "Malignance Earring",
        waist = "Sekhmet Corset"
    })
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {
        ring2 = "Sheltered Ring",
        ear1 = "Gifted Earring",
        ear2 = "Malignance Earring",
        waist = "Sekhmet Corset"
    })
    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {
        ring2 = "Sheltered Ring",
        ear1 = "Gifted Earring",
        ear2 = "Malignance Earring",
        waist = "Sekhmet Corset"
    })

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
        main = "Chatoyant Staff",
        sub = "Oneiros Grip",
        head = "Befouled Crown",
        neck = "Chrys. Torque",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Azimuth Coat +3",
        hands = gear.merlinic_refresh_hands,
        ring1 = "Defending Ring",
        ring2 = "Murky Ring",
        back = "Umbra Cape",
        legs = "Assid. Pants +1",
        feet = gear.merlinic_refresh_feet
    }

    -- Idle sets

    sets.idle = {
        main = "Tishtrya",
        sub = "Ammurapi Shield",
        ranged = "Dunna",
        neck = "Loricate Torque +1",
        ear1 = "Odnowa Earring +1",
        ear2 = "Alabaster Earring",
        head = "Null Masque",
        body = "Zendik Robe",
        hands = gear.relic.Hands,
        legs = "Volte Brais",
        feet = "Volte Gaiters",
        ring1 = "Stikini Ring +1",
        ring2 = "Murky Ring",
        back = gear.idle_jse_back,
        waist = "Plat. Mog. Belt"
    }

    sets.idle.PDT = set_combine(sets.idle, {
        head = "Null Masque",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Alabaster Earring",
        body = "Shamash Robe",
        ring1 = "Stikini Ring +1",
        ring2 = "Murky Ring",
        back = gear.idle_jse_back,
        waist = "Null Belt"
    })

    sets.idle.Aminon = set_combine(sets.idle, {
        main = "Tishtrya",
        sub = "Ammurapi Shield",
        ranged = "Dunna",
    })

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {
        head = gear.empy.Head,
        neck = "Bagua Charm +2",
        ear1 = "Etiolation Earring",
        ear2 = "Odnawa Earring +1",
        body = "Shamash Robe",
        hands = gear.af.Hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Murky Ring",
        back = gear.idle_jse_back,
        waist = "Isa Belt",
        legs = "Agwu's Slops",
        feet = gear.relic.Feet
    }

    sets.idle.PDT.Pet = {
        head = gear.empy.Head,
        neck = "Bagua Charm +2",
        ear1 = "Etiolation Earring",
        ear2 = "Odnawa Earring +1",
        body = "Shamash Robe",
        hands = gear.af.Hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Murky Ring",
        back = gear.idle_jse_back,
        waist = "Isa Belt",
        legs = "Nyame Flanchard",
        feet = gear.relic.Feet
    }

    sets.idle.Aminon.Pet = set_combine(sets.idle.Pet, {
        main = "Tishtrya",
        sub = "Ammurapi Shield",
        ranged = "Dunna",
    })

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

    sets.idle.Weak = {
        head = "Befouled Crown",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Ethereal Earring",
        body = "Adamantite Armor",
        hands = gear.merlinic_refresh_hands,
        ring1 = "Defending Ring",
        ring2 = "Murky Ring",
        back = "Umbra Cape",
        waist = "Carrier's Sash",
        legs = "Assid. Pants +1",
        feet = gear.empy.Feet
    }

    -- Defense sets

    sets.defense.PDT = {
        main = "Malignance Pole",
        sub = "Umbra Strap",
        head = "Null Masque",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Handler's Earring +1",
        body = "Adamantite Armor",
        hands = "Nyame Gauntlets",
        ring1 = "Defending Ring",
        ring2 = "Murky Ring",
        back = "Umbra Cape",
        waist = "Carrier's Sash",
        legs = "Nyame Flanchard",
        feet = gear.empy.Feet
    }

    sets.defense.MDT = {
        main = "Malignance Pole",
        sub = "Umbra Strap",
        head = gear.empy.Head,
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Handler's Earring +1",
        body = "Adamantite Armor",
        hands = "Nyame Gauntlets",
        ring1 = "Defending Ring",
        ring2 = "Murky Ring",
        back = "Umbra Cape",
        waist = "Carrier's Sash",
        legs = "Nyame Flanchard",
        feet = gear.empy.Feet
    }

    sets.defense.MEVA = {
        main = "Malignance Pole",
        sub = "Enki Strap",
        head = gear.empy.Head,
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        ear2 = "Sanare Earring",
        body = gear.merlinic_nuke_body,
        hands = "Telchine Gloves",
        ring1 = "Vengeful Ring",
        Ring2 = "Purity Ring",
        back = gear.idle_jse_back,
        waist = "Luminary Sash",
        legs = "Telchine Braconi",
        feet = gear.empy.Feet
    }

    sets.defense.PetPDT = sets.idle.PDT.Pet

    sets.defense.NukeLock = sets.midcast['Elemental Magic']

    sets.defense.GeoLock = sets.midcast.Geomancy.Indi

    sets.Kiting = {
        feet = gear.af.Feet
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
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {
        feet = gear.merlinic_treasure_feet
    })

    sets.HPDown = {
        head = "Pixie Hairpin +1",
        ear1 = "Mendicant's Earring",
        ear2 = "Evans Earring",
        body = "Telchine Chas.",
        hands = "Telchine Gloves",
        ring1 = "Mephitas's Ring +1",
        ring2 = "Defending Ring",
        waist = "Null Belt",
        back = "Null Shawl",
        legs = "Shedir Seraweels",
        feet = "Telchine Pigaches"
    }

    sets.buff.Doom = set_combine(sets.buff.Doom, {})

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        main = "Tishtrya",
        sub = "Ammurapi Shield",
        head = "Blistering Sallet +1",
        neck = "Combatant's Torque",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = sets.Nyame.Body,
        hands = "Gazu Bracelets +1",
        ring1 = "Petrov Ring",
        ring2 = "Chirich Ring +1",
        back = "Null Shawl",
        waist = "Goading Belt",
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        neck = "Null Loop",
    })

    sets.engaged.Staff = {
        main = "Contemplator +1",
        sub = "Umbra Strap",
        head = "Blistering Sallet +1",
        neck = "Combatant's Torque",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = sets.Nyame.Body,
        hands = "Gazu Bracelets +1",
        ring1 = "Petrov Ring",
        ring2 = "Chirich Ring +1",
        back = "Null Shawl",
        waist = "Goading Belt",
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet
    }

    sets.engaged.DW = {
        main = "Tishtrya",
        sub = "C. Palug Hammer",
        head = "Blistering Sallet +1",
        neck = "Null Loop",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = gear.empy.Body,
        hands = "Gazu Bracelets +1",
        ring1 = "Petrov Ring",
        ring2 = "Cacoethic Ring",
        back = "Null Shawl",
        waist = "Null Belt",
        legs = gear.empy.Legs,
        feet = "Battlecast Gaiters"
    }

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    -- Gear that converts elemental damage done to recover MP.	
    sets.RecoverMP = {
        body = "Seidr Cotehardie"
    }

    -- Gear for Magic Burst mode.
    sets.MagicBurst = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Ghastly Tathlum +1",
        head = "Ea Hat +1",
        body = gear.empy.Body,
        hands = "Agwu's Gages",
        -- legs = "Agwu's Slops", -- swap at r30
        legs = gear.empy.Legs,
        feet = "Agwu's Pigaches",
        neck = "Sibyl Scarf",
        waist = "Acuity Belt +1",
        left_ear = "Malignance Earring",
        right_ear = "Regal Earring",
        left_ring = "Freke Ring",
        right_ring = "Metamor. Ring +1",
        back = gear.nuke_jse_back
    }

    sets.buff.Sublimation = {
        waist = "Embla Sash"
    }
    sets.buff.DTSublimation = {
        waist = "Embla Sash"
    }

    -- Weapons sets
    sets.weapons.Idris = {
        main = 'Idris',
        sub = 'Genmei Shield'
    }

    sets.weapons.Tishtrya = {
        main = 'Tishtrya',
        sub = 'Ammurapi Shield'
    }

    sets.weapons.Mpaca = {
        main = "Mpaca's Staff",
        sub = 'Umbra Strap'
    }
    sets.weapons.Maxentius = {
        main = 'Maxentius',
        sub = 'Genmei Shield'
    }
    sets.weapons.Ternion = {
        main = 'Ternion Dagger +1',
        sub = 'Genmei Shield'
    }
    sets.weapons.Daybreak = {
        main = 'Daybreak',
        sub = 'Genmei Shield'
    }
    sets.weapons.DualWeapons = {
        main = 'Idris',
        sub = 'C. Palug Hammer'
    }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(4, 10)
end

function user_job_lockstyle()
    windower.chat.input('/lockstyleset 003')
end
