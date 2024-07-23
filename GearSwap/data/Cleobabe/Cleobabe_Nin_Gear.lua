-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.YagyuMode:options('Always','300','1000','Never')
    state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder', 'Crit')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match', 'Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder', 'Proc')
    state.CastingMode:options('Normal', 'Proc', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'EVA', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('Savage', 'Heishi', 'MagicWeapons', 'ProcSword', 'ProcDagger', 'ProcGreatSword', 'ProcScythe',
        'ProcPolearm', 'ProcGreatKatana', 'ProcKatana', 'ProcClub', 'ProcStaff')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None', 'SuppaBrutal', 'DWEarrings', 'DWMax' }

    gear.wsd_jse_back = { name = "Andartia's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%',} }
    gear.da_jse_back = { name = "Andartia's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%',} }

    send_command('bind ^` input /ja "Innin" <me>')
    send_command('bind !` input /ja "Yonin" <me>')
    send_command('bind @` gs c cycle SkillchainMode')
    send_command('bind !r gs c set skipprocweapons false;gs c set weapons ProcSword;gs c set WeaponskillMode Proc;;gs c set CastingMode Proc;gs c update')
    send_command('bind ^r gs c weapons Default;gs c set WeaponskillMode Normal;gs c set CastingMode Normal;gs c update')
    send_command('bind !f7 gs c cycle YagyuMode')

    utsusemi_cancel_delay = .3
    utsusemi_ni_cancel_delay = .06

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    gear.af = {
        Head = "Hachi. Hatsu. +2",
        Body = "Hachi. Chain. +2",
        Hands = "Hachiya Tekko +2",
        Legs = "Hachiya Hakama +3",
        Feet = "Hachi. Kyahan +2"
    }

    gear.relic = {
        Head = "Mochi. Hatsuburi +3",
        Body = "Mochi. Chainmail +3",
        Hands = "Mochizuki Tekko +3",
        Legs = "Mochi. Hakama +3",
        Feet = "Mochi. Kyahan +3"
    }

    gear.empy = {
        Head = "Hattori Zukin +2",
        Body = "Hattori Ningi +2",
        Hands = "Hattori Tekko +2",
        Legs = "Hattori Hakama +2",
        Feet = "Hattori Kyahan +2"
    }

    sets.Enmity = {
        -- ammo = "Date shuriken",
        -- head = "Canute's Helm",
        neck = "Unmoving Collar +1",
        ear1 = "Cryptic Earring",
        -- ear2 = "Trux Earring",
        body = "Emet Harness +1",
        -- hands = "Kurys Gloves",
        ring1 = "Petrov Ring",
        ring2 = "Odium Ring",
        -- ring2 = "Pernicious Ring",
        back = "Agema Cape",
        -- waist = "Sinew belt",
        legs = "Zoar Subligar +1",
        feet = gear.relic.Feet
    }

    sets.Phalanx_Received = {
		head = gear.taeon_phalanx_head,
		body = gear.taeon_phalanx_body,
		hands = gear.taeon_phalanx_hands,
		legs = gear.taeon_phalanx_legs,
		feet = gear.taeon_phalanx_feet,
	}

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {
        --main="Nagi"
        legs = gear.relic.Legs,
    }
    sets.precast.JA['Futae'] = {
        hands = gear.empy.Hands,
    }
    sets.precast.JA['Sange'] = {
        body= gear.relic.Body
    }
    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['Warcry'] = sets.Enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        ammo = "Yamarang",
        head = "Mummu Bonnet +2",
        neck = "Unmoving Collar +1",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Handler's Earring +1",
        body = gear.herculean_waltz_body,
        hands = gear.herculean_waltz_hands,
        ring1 = "Defending Ring",
        ring2 = "Valseur's Ring",
        back = "Moonlight Cape",
        waist = "Chaac Belt",
        legs = "Dashing Subligar",
        feet = gear.herculean_waltz_feet
    }

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
        ammo = "Togakushi Shuriken",
        head = "Dampening Tam",
        neck = "Moonbeam Nodowa",
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring",
        body = "Mummu Jacket +2",
        hands = "Adhemar Wrist. +1",
        ring1 = "Ramuh Ring +1",
        ring2 = "Ramuh Ring +1",
        back = "Andartia's Mantle",
        waist = "Olseni Belt",
        legs = "Mummu Kecks +2",
        feet = "Malignance Boots"
    }

    sets.precast.Flourish1 = {
        ammo = "Togakushi Shuriken",
        head = "Dampening Tam",
        neck = "Moonbeam Nodowa",
        ear1 = "Gwati Earring",
        ear2 = "Digni. Earring",
        body = "Mekosu. Harness",
        hands = "Adhemar Wrist. +1",
        ring1 = "Ramuh Ring +1",
        ring2 = "Ramuh Ring +1",
        back = "Andartia's Mantle",
        waist = "Olseni Belt",
        legs = gear.empy.Legs,
        feet = "Malignance Boots"
    }

    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo = "Impatiens",
        -- head = gear.herculean_fc_head,
        -- neck = "Voltsurge Torque",
        -- ear1 = "Enchntr. Earring +1",
        -- ear2 = "Loquac. Earring",
        -- body = "Dread Jupon",
        hands = "Leyline Gloves",
        ring1 = "Lebeche Ring",
        ring2 = "Kishar Ring",
        legs = "Gyve Trousers",
        feet = gear.relic.Feet
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,
        {
            -- neck = "Magoraga Beads",
            -- body = "Passion Jacket",
            feet = gear.empy.Feet
        })
    sets.precast.FC.Shadows = set_combine(sets.precast.FC.Utsusemi, {
        -- ammo = "Staunch Tathlum +1",
        ring1 = "Prolix Ring"
    })

    -- Snapshot for ranged
    sets.precast.RA = {}
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        -- ammo = "Voluspa Tathlum",
        -- head = "Hachiya Hatsu. +3",
        -- ear1 = "Lugra Earring",
        -- ear2 = "Moonshade Earring",
        -- body = "Adhemar Jacket +1",
        -- hands = "Adhemar Wrist. +1",
        -- back = gear.wsd_jse_back,
        -- waist = "Fotia Belt",
        -- feet = "Mochi. Hakama +3"
        ammo = "Oshasha's Treatise",
        neck = "Fotia Gorget",
        head = sets.Nyame.Head,
        body = sets.Nyame.Body,
        hands = sets.Nyame.Hands,
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet,
        waist = { name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear = { name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear = "Lugra Earring",
        left_ring = "Epaminondas's Ring",
        right_ring = "Cornelia's Ring",        
        back = { name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Damage taken-5%',}},
    }
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS,
    {
        head = "Dampening Tam",
        body = "Ken. Samue",
        legs = "Hiza. Hizayoroi +2",
        ear2 = "Telos Earring"
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS,
    {
        ammo = "C. Palug Stone",
        head = "Ynglinga Sallet",
        neck = "Combatant's Torque",
        ear2 = "Telos Earring",
        body = "Ken. Samue",
        hands = "Mummu Wrists +2",
        waist = "Olseni Belt",
        legs = "Hiza. Hizayoroi +2",
        feet = "Malignance Boots"
    })
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS,
    {
        ammo = "C. Palug Stone",
        head = "Ynglinga Sallet",
        neck = "Moonbeam Nodowa",
        ear1 = "Mache Earring +1",
        ear2 =
        "Telos Earring",
        body = "Mummu Jacket +2",
        ring1 = "Ramuh Ring +1",
        ring2 = "Ramuh Ring +1",
        waist =
        "Olseni Belt",
        legs = "Hiza. Hizayoroi +2",
        feet = "Malignance Boots"
    })
    sets.precast.WS.Proc = {
        ammo = "Togakushi Shuriken",
        head = "Ynglinga Sallet",
        neck = "Moonbeam Nodowa",
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring",
        body = "Mummu Jacket +2",
        hands = "Mummu Wrists +2",
        ring1 = "Ramuh Ring +1",
        ring2 = "Ramuh Ring +1",
        back = gear.da_jse_back,
        waist = "Olseni Belt",
        legs = "Mummu Kecks +2",
        feet = "Malignance Boots"
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS,
    {
        ammo = "Yetshila +1",
        head = "Adhemar Bonnet +1",
        ammo = "Yetshila +1",
        head = "Adhemar Bonnet +1",
        body = "Abnoba Kaftan",
        hands = "Ryuo Tekko",
        ring1 = "Begrudging Ring",
        waist = "Grunfeld Rope",
        legs = "Mummu Kecks +2",
        feet = "Mummu Gamash. +2"
    })
    sets.precast.WS['Blade: Jin'].SomeAcc = set_combine(sets.precast.WS.SomeAcc,
    {
        ammo = "Yetshila +1",
        head = "Mummu Bonnet +2",
        ammo = "Yetshila +1",
        head = "Mummu Bonnet +2",
        body = "Abnoba Kaftan",
        hands = "Ryuo Tekko",
        waist = "Grunfeld Rope",
        legs = "Mummu Kecks +2",
        feet = "Mummu Gamash. +2"
    })
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS.Acc,
    {
        head = "Mummu Bonnet +2",
        body = "Sayadio's Kaftan",
        hands = "Ryuo Tekko",
        legs = "Mummu Kecks +2",
        feet = "Mummu Gamash. +2"
    })
    sets.precast.WS['Blade: Jin'].FullAcc = set_combine(sets.precast.WS.FullAcc,
        { body = "Mummu Jacket +2", hands = "Ryuo Tekko", legs = "Mummu Kecks +2", feet = "Mummu Gamash. +2" })
    sets.precast.WS['Blade: Jin'].Fodder = set_combine(sets.precast.WS['Blade: Jin'], { head = "Adhemar Bonnet +1" })

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS,
    {
        ammo = "Yetshila +1",
        head = "Adhemar Bonnet +1",
        ear1 = "Moonshade Earring",
        ear2 = "Brutal Earring",
        body = "Abnoba Kaftan",
        hands = "Ryuo Tekko",
        ring1 = "Begrudging Ring",
        back = gear.wsd_jse_back,
        legs = "Hiza. Hizayoroi +2",
        feet = "Mummu Gamash. +2"
    })
    sets.precast.WS['Blade: Hi'].SomeAcc = set_combine(sets.precast.WS.SomeAcc,
    {
        ammo = "Yetshila +1",
        head = "Mummu Bonnet +2",
        ear1 = "Moonshade Earring",
        ear2 = "Trux Earring",
        body = "Abnoba Kaftan",
        hands = "Ryuo Tekko",
        ring1 = "Begrudging Ring",
        back = gear.wsd_jse_back,
        legs =
        "Hiza. Hizayoroi +2",
        feet = "Mummu Gamash. +2"
    })
    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS.Acc,
    {
        head = "Mummu Bonnet +2",
        ear1 = "Moonshade Earring",
        ear2 = "Telos Earring",
        body = "Sayadio's Kaftan",
        hands = "Ryuo Tekko",
        legs = "Hiza. Hizayoroi +2",
        feet = "Mummu Gamash. +2"
    })
    sets.precast.WS['Blade: Hi'].FullAcc = set_combine(sets.precast.WS.FullAcc,
        { hands = "Ryuo Tekko", legs = "Hiza. Hizayoroi +2" })
    sets.precast.WS['Blade: Hi'].Fodder = set_combine(sets.precast.WS['Blade: Hi'], {})

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS,
        { ammo = "C. Palug Stone", ear1 = "Lugra Earring", ear2 = "Lugra Earring +1", legs = "Jokushu Haidate" })
    sets.precast.WS['Blade: Shun'].SomeAcc = set_combine(sets.precast.WS.SomeAcc,
    {
        ammo = "C. Palug Stone",
        ear1 = "Lugra Earring",
        ear2 = "Lugra Earring +1",
        legs = "Jokushu Haidate",
        feet = "Malignance Boots"
    })
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Blade: Shun'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Shun'].Fodder = set_combine(sets.precast.WS['Blade: Shun'], {})

    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS,
    {
        ammo = "C. Palug Stone",
        neck = "Caro Necklace",
        ear1 = "Moonshade Earring",
        ear2 = "Lugra Earring +1",
        body = gear.herculean_wsd_body,
        back = gear.wsd_jse_back,
        waist = "Grunfeld Rope",
        legs = "Hiza. Hizayoroi +2",
        feet = gear.herculean_wsd_feet
    })
    sets.precast.WS['Blade: Ten'].SomeAcc = set_combine(sets.precast.WS.SomeAcc,
    {
        ammo = "C. Palug Stone",
        neck = "Caro Necklace",
        ear1 = "Moonshade Earring",
        body = gear.herculean_wsd_body,
        back = gear.wsd_jse_back,
        waist = "Grunfeld Rope",
        legs = "Hiza. Hizayoroi +2",
        feet = gear.herculean_wsd_feet
    })
    sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS.Acc, { back = gear.wsd_jse_back })
    sets.precast.WS['Blade: Ten'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Ten'].Fodder = set_combine(sets.precast.WS['Blade: Ten'], {})

    sets.precast.WS['Aeolian Edge'] = {
        ammo = "Ghastly Tathlum +1",
        head = "Dampening Tam",
        neck = "Baetyl Pendant",
        ear1 = "Friomisi Earring",
        ear2 = "Crematio Earring",
        body = "Adhemar Jacket +1",
        hands = "Adhemar Wrist. +1",
        ring1 = "Shiva Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Toro Cape",
        waist = "Chaac Belt",
        legs = "Nyame Flanchard",
        feet = "Malignance Boots"
    }

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear1 = "Lugra Earring", ear2 = "Lugra Earring +1", }
    sets.AccMaxTP = { ear1 = "Mache Earring +1", ear2 = "Telos Earring" }
    sets.AccDayMaxTPWSEars = { ear1 = "Mache Earring +1", ear2 = "Telos Earring" }
    sets.DayMaxTPWSEars = { ear1 = "Cessance Earring", ear2 = "Brutal Earring", }
    sets.AccDayWSEars = { ear1 = "Mache Earring +1", ear2 = "Telos Earring" }
    sets.DayWSEars = { ear1 = "Moonshade Earring", ear2 = "Brutal Earring", }


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head = gear.empy.Head,
        neck = "Voltsurge Torque",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Etiolation Earring",
        body = "Dread Jupon",
        hands = "Leyline Gloves",
        ring1 = "Defending Ring",
        ring2 = "Kishar Ring",
        legs = "Zoar Subligar +1",
        feet = "Malignance Boots"
    }

    sets.midcast.ElementalNinjutsu = {
        ammo = "Pemphredo Tathlum",
        head = gear.herculean_nuke_head,
        neck = "Baetyl Pendant",
        ear1 = "Crematio Earring",
        ear2 = "Friomisi Earring",
        body = "Samnuha Coat",
        hands = gear.empy.Hands,
        ring1 = "Shiva Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Toro Cape",
        waist = "Eschan Stone",
        legs = "Gyve Trousers",
        feet = gear.herculean_nuke_feet
    }

    sets.midcast.ElementalNinjutsu.Proc = sets.midcast.FastRecast

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})

    sets.MagicBurst = { ring1 = "Mujin Band", ring2 = "Locus Ring" }

    sets.midcast.NinjutsuDebuff = {
        ammo = "Ghastly Tathlum +1",
        head = "Dampening Tam",
        neck = "Incanter's Torque",
        ear1 = "Gwati Earring",
        ear2 = "Digni. Earring",
        body = "Mekosu. Harness",
        hands = gear.relic.Hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Metamor. Ring +1",
        back = "Andartia's Mantle",
        waist = "Chaac Belt",
        legs = "Rawhide Trousers",
        feet = gear.relic.Feet
    }

    sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, { back = "Mujin Mantle" })

    sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, {
        back = "Andartia's Mantle",
        body = "Passion Jacket",
        feet = gear.empy.Feet
    })

    sets.midcast.RA = {
        head = "Malignance Chapeau",
        neck = "Iskur Gorget",
        ear1 = "Enervating Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Apate Ring",
        ring2 = "Regal Ring",
        back = gear.da_jse_back,
        waist = "Chaac Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.midcast.RA.Acc = {
        head = "Malignance Chapeau",
        neck = "Iskur Gorget",
        ear1 = "Enervating Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Apate Ring",
        ring2 = "Regal Ring",
        back = gear.da_jse_back,
        waist = "Chaac Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {
        ammo = "Staunch Tathlum +1",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Eabani Earring",
        ear2 = "Assuage Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Shneddick Ring",
        back = "Moonlight Cape",
        waist = "Platinum Moogle Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.idle.DT = set_combine(sets.idle, { 
        head = sets.Nyame.Head,
        body = sets.Nyame.Body,
        hands = sets.Nyame.Hands,
        legs = sets.Nyame.Legs,
        feet = sets.Nyame.Feet
    })

    sets.idle.EVA= set_combine(sets.idle, { 
        ring1 = "Vengeful Ring",
    })

    sets.idle.Sphere = set_combine(sets.idle, { body = "Mekosu. Harness" })

    sets.defense.PDT = set_combine(sets.idle.DT, { 
    })

    sets.defense.MDT = set_combine(sets.idle.DT, { 
    })

    sets.defense.MEVA = set_combine(sets.idle.DT, { 
    })



    sets.Kiting = { feet = "Danzo Sune-Ate" }
    sets.DuskKiting = {}
    sets.DuskIdle = {}
    sets.DayIdle = {}
    sets.NightIdle = {}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands={ name="Tatena. Gote +1", augments={'Path: A',}},
        legs="Samnuha Tights",
        feet="Malignance Boots",
        neck="Ninja Nodowa +2",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Suppanomimi",
        right_ear="Cessance Earring",
        left_ring="Ilabrat Ring",
        right_ring="Epona's Ring",
        back=gear.da_jse_back,
    }

    sets.engaged.SomeAcc = {
        ammo = "Seki Shuriken",
        head = "Dampening Tam",
        neck = "Moonbeam Nodowa",
        ear1 = "Cessance Earring",
        ear2 = "Brutal Earring",
        body = "Ken. Samue",
        hands = "Adhemar Wrist. +1",
        ring1 = "Ilabrat Ring",
        ring2 = "Epona's Ring",
        back = gear.da_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Samnuha Tights",
        feet = gear.herculean_ta_feet
    }

    sets.engaged.Acc = {
        ammo = "Togakushi Shuriken",
        head = "Dampening Tam",
        neck = "Moonbeam Nodowa",
        ear1 = "Digni. Earring",
        ear2 = "Telos Earring",
        body = "Ken. Samue",
        hands = "Adhemar Wrist. +1",
        ring1 = "Ilabrat Ring",
        ring2 = "Regal Ring",
        back = gear.da_jse_back,
        waist = "Olseni Belt",
        legs = "Mummu Kecks +2",
        feet = "Malignance Boots"
    }

    sets.engaged.FullAcc = {
        ammo = "Togakushi Shuriken",
        head = "Malignance Chapeau",
        neck = "Moonbeam Nodowa",
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Ramuh Ring +1",
        ring2 = "Ramuh Ring +1",
        back = gear.da_jse_back,
        waist = "Olseni Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.Fodder = {
        ammo = "Togakushi Shuriken",
        head = "Dampening Tam",
        neck = "Moonbeam Nodowa",
        ear1 = "Dedition Earring",
        ear2 = "Brutal Earring",
        body = "Ken. Samue",
        hands = "Adhemar Wrist. +1",
        ring1 = "Gere Ring",
        ring2 = "Epona's Ring",
        back = gear.da_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Samnuha Tights",
        feet = gear.herculean_ta_feet
    }

    sets.engaged.Crit = {
        ammo = "Togakushi Shuriken",
        head = "Mummu Bonnet +2",
        neck = "Moonbeam Nodowa",
        ear1 = "Cessance Earring",
        ear2 = "Brutal Earring",
        body = "Mummu Jacket +2",
        hands = "Mummu Wrists +2",
        ring1 = "Gere Ring",
        ring2 = "Epona's Ring",
        back = gear.da_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Mummu Kecks +2",
        feet = "Mummu Gamash. +2"
    }

    sets.engaged.DT = set_combine(sets.engaged, {
        ammo = "Togakushi Shuriken",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear2 = "Eabani Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        back = gear.da_jse_back,
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    })

    sets.engaged.SomeAcc.DT = {
        ammo = "Togakushi Shuriken",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Cessance Earring",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Epona's Ring",
        back = gear.da_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.Acc.DT = {
        ammo = "Togakushi Shuriken",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Mache Earring +1",
        ear2 = "Telos Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Epona's Ring",
        back = gear.da_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.FullAcc.DT = {
        ammo = "Togakushi Shuriken",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Mache Earring +1",
        ear2 = "Odr Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Ramuh Ring +1",
        back = gear.da_jse_back,
        waist = "Olseni Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    sets.engaged.Fodder.DT = {
        ammo = "Togakushi Shuriken",
        head = "Malignance Chapeau",
        neck = "Loricate Torque +1",
        ear1 = "Cessance Earring",
        ear2 = "Brutal Earring",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Epona's Ring",
        back = gear.da_jse_back,
        waist = "Windbuffet Belt +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots"
    }

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = { body = gear.empy.Body }
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Futae = {}
    sets.buff.Yonin = { legs = gear.empy.Legs } 
    sets.buff.Innin = { head = gear.empy.Head }

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.SuppaBrutal = { ear1 = "Suppanomimi", ear2 = "Brutal Earring" }
    sets.DWEarrings = { ear1 = "Dudgeon Earring", ear2 = "Heartseeker Earring" }
    sets.DWMax = {
        ear1 = "Dudgeon Earring",
        ear2 = "Heartseeker Earring",
        body = "Adhemar Jacket +1",
        hands =
        "Floral Gauntlets",
        waist = "Shetal Stone"
    }
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.Skillchain = { legs = "Ryuo Hakama" }

    sets.HPCure = {
		ear1 = "Odnowa Earring +1",
		ear2 = "Etiolaion Earring",
		neck = "Unmoving Collar +1",
		waist = "Plat. Mog. Belt",
		ring1 = "Gelatinous Ring +1",
		ring2 = "Moonbeam Ring",
		head = sets.Nyame.Head,
		body = sets.Nyame.Body,
		hands =sets.Nyame.Hands,
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet,
		back = "Moonlight Cape",
	}

    -- Weapons sets
    sets.weapons.Heishi = { main = "Heishi Shorinken", sub = "Kunimitsu" }
    sets.weapons.Savage = { main = "Sasuke Katana", sub = "Uzura +2" }
    sets.weapons.Evisceration = { main = "Tauret", sub = "Kunimitsu" }
    sets.weapons.MagicWeapons = { main = "Kunimitsu", sub = "Tauret" }
	sets.weapons.ProcDagger = { main = "Qutrub Knife", sub = empty }
	sets.weapons.ProcSword = { main = "Wax Sword", sub = 'Qutrub Knife' }
	sets.weapons.ProcKatana = { main = "Trainee Burin", sub = empty }
	sets.weapons.ProcGreatSword = { main = "Goujian", sub = empty }
	sets.weapons.ProcScythe = { main = "Bronze Zaghnal", sub = empty }
	sets.weapons.ProcPolearm = { main = "Tzee Xicu's Blade", sub = empty }
	sets.weapons.ProcGreatKatana = { main = "Mutsunokami", sub = empty }
	sets.weapons.ProcClub = { main = "Kitty Rod", sub = empty }
	sets.weapons.ProcStaff = { main = "Cobra Staff", sub = empty }	
    -- sets.weapons.ProcDagger = { main = "Chicken Knife II", sub = empty }
    -- sets.weapons.ProcSword = { main = "Ark Sword", sub = empty }
    -- sets.weapons.ProcGreatSword = { main = "Lament", sub = empty }
    -- sets.weapons.ProcScythe = { main = "Ark Scythe", sub = empty }
    -- sets.weapons.ProcPolearm = { main = "Pitchfork +1", sub = empty }
    -- sets.weapons.ProcGreatKatana = { main = "Hardwood Katana", sub = empty }
    -- sets.weapons.ProcKatana = { main = "Kanaria", sub = empty }
    -- sets.weapons.ProcClub = { main = "Dream Bell +1", sub = empty }
    -- sets.weapons.ProcStaff = { main = "Terra's Staff", sub = empty }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'RNG' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 12)
    else
        set_macro_page(1, 12)
    end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 004')
end