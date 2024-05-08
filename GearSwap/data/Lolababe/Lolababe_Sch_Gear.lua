-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc', 'OccultAcumen', '9k')
    state.IdleMode:options('Normal', 'PDT')
    state.HybridMode:options('Normal', 'PDT')
    state.Weapons:options('None', 'Musa', 'Grioavolr', 'Bunzi', 'Akademos', 'Khatvanga')

    gear.nuke_jse_back = { name = "Lugh's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', '"Mag.Atk.Bns."+10' } }
    gear.fc_jse_back = { name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
    -- Additional local binds
    send_command('bind ^` gs c cycle ElementalMode')
    send_command('bind !` gs c scholar power')
    send_command('bind @` gs c cycle MagicBurstMode')
    send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
    send_command('bind !q gs c weapons default;gs c reset CastingMode')
    send_command('bind @f10 gs c cycle RecoverMode')
    send_command('bind @f8 gs c toggle AutoNukeMode')
    send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
    send_command('bind @^` input /ja "Parsimony" <me>')
    send_command('bind ^backspace input /ma "Stun" <t>')
    send_command('bind !backspace gs c scholar speed')
    send_command('bind @backspace gs c scholar aoe')
    send_command('bind ^= input /ja "Dark Arts" <me>')
    send_command('bind != input /ja "Light Arts" <me>')
    send_command('bind ^\\\\ input /ma "Protect V" <t>')
    send_command('bind @\\\\ input /ma "Shell V" <t>')
    send_command('bind !\\\\ input /ma "Reraise III" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = { legs = "Peda. Pants +1" }
    sets.precast.JA['Enlightenment'] = { body = "Peda. Gown +3" }
    -- Fast cast sets for spells

    sets.precast.FC = {
        main = gear.grioavolr_fc_staff,
        -- sub = "Clerisy Strap +1",
        ammo = "Sapience Orb",
        head = gear.merlinic_fc_head,
        neck = "Orunmila's Torque",
        -- ear1 = "Enchntr. Earring +1",
        ear1 = "Etiolation Earring",
        ear2 = "Malignance Earring",
        body = "Pinga Tunic +1",
        -- body = "Zendik Robe",
        -- hands = "Volte Gloves",
        hands = "Acad. Bracers +3",
        ring1 = "Kishar Ring",
        -- ring2 = "Lebeche Ring",
        -- back = "Perimede Cape",
        waist = "Witful Belt",
        legs = "Kaykaus Tights +1",
        feet = "Merlinic Crackows",
        back= gear.fc_jse_back,
        -- feet = "Regal Pumps +1"
    }

    sets.precast.FC.Arts = {}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { ear1 = "Malignance Earring" })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        -- main = "Serenity",
        -- sub = "Clerisy Strap +1",
        -- body = "Heka's Kalasiris"
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], { 
        head = empty,
        -- body = "Twilight Cloak" 
    })
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Genmei Shield" })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS['Myrkr'] = {
        ammo = "Ghastly Tathlum +1",
        -- head = "Pixie Hairpin +1",
        neck = "Sanctity Necklace",
        ear1 = "Evans Earring",
        ear2 = "Etiolation Earring",
        body = "Amalric Doublet +1",
        hands = "Regal Cuffs",
        ring1 = "Mephitas's Ring +1",
        ring2 = "Mephitas's Ring",
        -- back = "Aurist's Cape +1",
        waist = "Luminary Sash",
        legs = "Psycloth Lappas",
        -- feet = "Kaykaus Boots"
    }

    -- Midcast Sets

    sets.TreasureHunter = set_combine(sets.TreasureHunter, { 
        body = "Volte Jupon",
    })

    -- Gear that converts elemental damage done to recover MP.	
    sets.RecoverMP = {
        -- body = "Seidr Cotehardie"
    }

    -- Gear for specific elemental nukes.
    sets.element.Dark = { 
        -- head = "Pixie Hairpin +1", 
        ring2 = "Archon Ring" 
    }

    sets.midcast.FastRecast = {
        -- main = gear.grioavolr_fc_staff,
        -- sub = "Clerisy Strap +1",
        -- ammo = "Hasty Pinion +1",
        head = "Amalric Coif +1",
        -- neck = "Voltsurge Torque",
        -- ear1 = "Enchntr. Earring +1",
        ear2 = "Malignance Earring",
        -- body = "Zendik Robe",
        hands = "Gende. Gages +1",
        ring1 = "Kishar Ring",
        -- ring2 = "Prolix Ring",
        -- back = "Swith Cape +1",
        waist = "Witful Belt",
        legs = "Psycloth Lappas",
        -- feet = "Regal Pumps +1"
    }

    sets.midcast.Cure = {
        main = "Daybreak",
        -- main = "Serenity",
        -- sub = "Curatio Grip",
        -- ammo = "Hasty Pinion +1",
        -- head = "Gende. Caubeen +1",
        -- neck = "Incanter's Torque",
        -- ear1 = "Meili Earring",
        ear2 = "Malignance Earring",
        body = "Kaykaus Bliaut +1",
        hands = "Kaykaus Cuffs +1",
        -- ring1 = "Janniston Ring",
        -- ring2 = "Lebeche Ring",
        -- back = "Tempered Cape +1",
        waist = "Luminary Sash",
        legs = "Chironic Hose",
        -- feet = "Kaykaus Boots"
    }

    sets.midcast.LightWeatherCure = {
        main = "Daybreak",
        -- main = "Chatoyant Staff",
        -- sub = "Curatio Grip",
        -- ammo = "Hasty Pinion +1",
        -- head = "Gende. Caubeen +1",
        -- neck = "Incanter's Torque",
        -- ear1 = "Meili Earring",
        ear2 = "Malignance Earring",
        body = "Kaykaus Bliaut +1",
        hands = "Kaykaus Cuffs +1",
        -- ring1 = "Janniston Ring",
        -- ring2 = "Lebeche Ring",
        -- back = "Twilight Cape",
        waist = "Hachirin-no-Obi",
        legs = "Chironic Hose",
        -- feet = "Kaykaus Boots"
    }

    sets.midcast.LightDayCure = sets.midcast.LightWeatherCure

    sets.midcast.Curaga = sets.midcast.Cure

    sets.Self_Healing = {
        -- neck = "Phalaina Locket",
        -- ring1 = "Kunaji Ring",
        -- ring2 = "Asklepian Ring",
        waist = "Gishdubar Sash"
    }
    sets.Cure_Received = sets.Self_Healing
    sets.Self_Refresh = { 
        -- back = "Grapevine Cape", 
        waist = "Gishdubar Sash", 
        -- feet = "Inspirited Boots" 
    }

    sets.midcast.Cursna = {
        -- main = gear.grioavolr_fc_staff,
        -- sub = "Clemency Grip",
        -- ammo = "Hasty Pinion +1",
        head = "Amalric Coif +1",
        -- neck = "Debilis Medallion",
        -- ear1 = "Meili Earring",
        ear2 = "Malignance Earring",
        -- body = "Zendik Robe",
        -- hands = "Hieros Mittens",
        -- ring1 = "Haoma's Ring",
        -- ring2 = "Menelaus's Ring",
        -- back = "Oretan. Cape +1",
        waist = "Witful Belt",
        legs = "Psycloth Lappas",
        feet = "Vanya Clogs"
    }

    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {
        -- main = gear.grioavolr_fc_staff,
        -- sub = "Clemency Grip"
    })

    sets.midcast['Enhancing Magic'] = {
        -- main = gear.gada_enhancing_club,
        sub = "Ammurapi Shield",
        head = "Telchine Cap",
        -- neck = "Incanter's Torque",
        ear1 = "Andoaa Earring",
        -- ear2 = "Gifted Earring",
        body = "Telchine Chas.",
        hands = "Telchine Gloves",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        -- back = "Perimede Cape",
        waist = "Embla Sash",
        legs = "Telchine Braconi",
        feet = "Telchine Pigaches"
    }

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], { 
        main = "Musa",
        sub = "Enki Strap",
        head = "Arbatel Bonnet +3",
        back = gear.nuke_jse_back 
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],
    { 
        -- neck = "Nodens Gorget", 
        -- ear2 = "Earthcry Earring", 
        waist = "Siegel Sash", 
        -- legs = "Shedir Seraweels"
    })

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], { head = "Amalric Coif +1" })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],
        {
            -- main = "Vadose Rod",
            sub = "Genmei Shield",
            head = "Amalric Coif +1",
            -- hands = "Regal Cuffs",
            -- waist = "Emphatikos Rope",
            -- legs = "Shedir Seraweels"
        })

    sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], { 
        -- legs = "Shedir Seraweels"
    })

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], { 
        -- feet = "Peda. Loafers +1" 
    })

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], { 
        -- ring2 = "Sheltered Ring" 
    })
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], { 
        -- ring2 = "Sheltered Ring"
    })
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes

    sets.midcast['Enfeebling Magic'] = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Acad. Mortar. +3",
        neck = "Erra Pendant",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        -- body = "Chironic Doublet",
        hands = "Regal Cuffs",
        ring1 = "Kishar Ring",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        -- waist = "Obstin. Sash",
        legs = "Chironic Hose",
        -- feet = "Uk'uxkaj Boots"
    }

    sets.midcast['Enfeebling Magic'].Resistant =set_combine(sets.midcast['Enfeebling Magic'], {
        ear2 = "Digni. Earring",
        -- body = "Chironic Doublet",
        hands = "Acad. Bracers +3",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        waist = "Luminary Sash",
        legs = "Chironic Hose",
        -- feet = "Medium's Sabots"
    })

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'],
        { 
            head = "Amalric Coif +1", 
            ear2 = "Malignance Earring", 
            back = gear.nuke_jse_back, 
            waist = "Acuity Belt +1" 
        })
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant,
        { 
            head = "Amalric Coif +1",
            back = gear.nuke_jse_back,
            waist = "Acuity Belt +1" 
        })

    sets.midcast.IntEnfeebles = sets.midcast.ElementalEnfeeble
    sets.midcast.IntEnfeebles.Resistant = sets.midcast.ElementalEnfeeble.Resistant
    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
    sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Bio II'] = sets.midcast['Enfeebling Magic']

    sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'],
        { ring2 = "Stikini Ring +1", feet = gear.chironic_nuke_feet })

    sets.midcast['Dark Magic'] = {
        -- main = "Rubicundity",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Amalric Coif +1",
        -- neck = "Incanter's Torque",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        -- body = "Chironic Doublet",
        hands = "Acad. Bracers +3",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Chironic Hose",
        -- feet = gear.merlinic_aspir_feet
    }

    sets.midcast.Kaustra = {
        main = "Akademos",
        sub = "Enki Strap",
        ammo = "Pemphredo Tathlum",
        -- head = "Pixie Hairpin +1",
        neck = "Saevus Pendant +1",
        -- ear1 = "Crematio Earring",
        ear2 = "Malignance Earring",
        -- body = gear.merlinic_nuke_body,
        hands = "Amalric Gages +1",
        ring1 = "Freke Ring",
        ring2 = "Archon Ring",
        back = gear.nuke_jse_back,
        waist = "Refoccilation Stone",
        legs = "Merlinic Shalwar",
        feet = "Amalric Nails +1"
    }

    sets.midcast.Kaustra.Resistant = {
        -- main = gear.grioavolr_nuke_staff,
        sub = "Enki Strap",
        ammo = "Pemphredo Tathlum",
        head = gear.merlinic_nuke_head,
        neck = "Erra Pendant",
        ear1 = "Crematio Earring",
        ear2 = "Malignance Earring",
        -- body = gear.merlinic_nuke_body,
        hands = "Amalric Gages +1",
        -- ring1 = "Shiva Ring +1",
        ring2 = "Freke Ring",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Merlinic Shalwar",
        feet = "Amalric Nails +1"
    }

    sets.midcast.Drain = {
        -- main = "Rubicundity",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        -- head = "Pixie Hairpin +1",
        neck = "Erra Pendant",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        -- body = "Chironic Doublet",
        hands = "Acad. Bracers +3",
        -- ring1 = "Evanescence Ring",
        ring2 = "Archon Ring",
        back = gear.nuke_jse_back,
        waist = "Fucho-no-obi",
        -- legs = "Chironic Hose",
        -- feet = gear.merlinic_aspir_feet
    }

    sets.midcast.Drain.Resistant = set_combine(sets.midcast.Drain, {
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Amalric Coif +1",
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        waist = "Acuity Belt +1",
    })

    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

    sets.midcast.Stun = {
        -- main = gear.grioavolr_fc_staff,
        -- sub = "Clerisy Strap +1",
        -- ammo = "Hasty Pinion +1",
        head = "Amalric Coif +1",
        neck = "Voltsurge Torque",
        -- ear1 = "Enchntr. Earring +1",
        ear2 = "Malignance Earring",
        -- body = "Zendik Robe",
        hands = "Acad. Bracers +3",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        waist = "Witful Belt",
        legs = "Psycloth Lappas",
        -- feet = "Regal Pumps +1"
    }

    sets.midcast.Stun.Resistant = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Acad. Mortar. +3",
        neck = "Erra Pendant",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        -- body = "Zendik Robe",
        hands = "Acad. Bracers +3",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        -- legs = "Chironic Hose",
        -- feet = gear.merlinic_aspir_feet
    }

    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Ghastly Tathlum +1",
        head = "Agwu's Cap",
        neck = "Argute Stole +2",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        body = "Arbatel Gown +3",
        hands = "Arbatel Bracer's +3",
        ring1 = "Freke Ring",
        ring2 = "Metamor. Ring +1",
        back = gear.nuke_jse_back,
        waist = "Refoccilation Stone",
        legs = "Agwu's Slops",
        feet = "Arbatel Loafers +3"
    }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], 
    {
        neck = "Argute Stole +2",
        ear1 = "Malignance Earring",
        ear2 = "Regal Earring",
        -- hands = "Mallquis Cuffs +2",
        ring2 = "Metamor. Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
    })

    sets.midcast['Elemental Magic']['9k'] = set_combine(sets.midcast['Elemental Magic'], {
        main = "Daybreak",
        head = gear.merlinic_nuke_head,
        ear1 = "Crematio Earring",
        ear2 = "Malignance Earring",
        -- body = gear.merlinic_nuke_body,
        -- hands = "Mallquis Cuffs +2",
        -- ring1 = "Shiva Ring +1",
        ring2 = "Freke Ring",
        -- back = "Swith Cape +1",
        waist = "Witful Belt",
        legs = "Psycloth Lappas",
        -- feet = "Regal Pumps +1"
    })

    sets.midcast['Elemental Magic'].Proc = {
        main = empty,
        sub = empty,
        ammo = "Impatiens",
        head = "Vanya Hood",
        neck = "Orunmila's Torque",
        ear1 = "Eabani Earring",
        ear2 = "Etiolation Earring",
        body = "Pinga Tunic +1",
        hands = "Gende. Gages +1",
        ring1 = "Kishar Ring",
        ring2 = "Defending Ring",
        back = "Perimede Cape",
        waist = "Witful Belt",
        legs = "Psycloth Lappas",
        feet = "Telchine Pigaches"
    }

    sets.midcast['Elemental Magic'].OccultAcumen = {
        -- main = "Khatvanga",
        -- sub = "Bloodrain Strap",
        -- ammo = "Seraphic Ampulla",
        -- head = "Mall. Chapeau +2",
        -- neck = "Combatant's Torque",
        ear1 = "Dedition Earring",
        ear2 = "Telos Earring",
        -- body = gear.merlinic_occult_body,
        -- hands = gear.merlinic_occult_hands,
        ring1 = "Rajas Ring",
        ring2 = "Petrov Ring",
        back = gear.nuke_jse_back,
        -- waist = "Oneiros Rope",
        -- legs = "Perdition Slops",
        -- feet = gear.merlinic_occult_feet
    }

    -- Gear for Magic Burst mode.

    --[[
    Best Stone V set with the provided buffs:

        main  Bunzi's Rod R20
        sub  Ammurapi Shield
        ranged  Empty
        ammo  Ghastly Tathlum +1 R15
        head  Agwu's Cap R20
        body  Arbatel Gown +3
        hands  Arbatel Bracers +3
        legs  Arbatel Pants +3
        feet  Arbatel Loafers +3
        neck  Argute Stole +2 R25
        waist  Hachirin-no-Obi
        ear1  Regal Earring
        ear2  Malignance Earring
        ring1  Metamorph Ring +1 R15
        ring2  Freke Ring
        back  Lugh's Cape INT Magic Attack

    List of potential swaps within 2.0% of the best set (32489.46 ):
    head   Pedagogy Mortarboard +3                            31909.74    1.8%
    ear1   Barkarole Earring                                  31858.90    1.9%
    ear2   Arbatel Earring +1                                 31862.43    1.9%
    ear2   Barkarole Earring                                  31999.81    1.5%
    hands  Agwu's Gages R20                                   31937.75    1.7%
    ring1  Mujin Band                                         31844.05    2.0%
    ring1  Shiva Ring +1A                                     31971.63    1.6%
    ring2  Mujin Band                                         31985.55    1.6%
    ring2  Shiva Ring +1A                                     32101.97    1.2%
    legs   Agwu's Slops R20                                   31957.54    1.6%
    ]]    
    sets.MagicBurst = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Ghastly Tathlum +1",
        head = "Agwu's Cap",
        neck = "Argute Stole +2",
        ear1 = "Malignance Earring",
        ear2 = "Regal Earring",
        body = "Arbatel Gown +3",
        hands = "Agwu's Gages",
        ring1 = "Freke Ring",
        ring2 = "Metamor. Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Agwu's Slops",
        feet = "Arbatel Loafers +3"
    }

    sets.HelixBurst = set_combine(sets.MagicBurst, {
        head = "Arbatel Bonnet +3",
        body = "Agwu's Robe",
        ring1 = "Mujin Band",
        waist = "Acuity Belt +1",
        ear2 = "Arbatel Earring +2",
    })

    sets.ResistantHelixBurst = set_combine(sets.HelixBurst, {
    })

    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Ghastly Tathlum +1",
        head = "Merlinic Hood",
        neck = "Argute Stole +2",
        -- neck = "Saevus Pendant +1",
        ear1 = "Malignance Earring",
        ear2 = "Regal Earring",
        body = "Amalric Doublet +1",
        hands = "Amalric Gages +1",
        ring1 = "Freke Ring",
        ring2 = "Metamorph Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Merlinic Shalwar",
        feet = "Amalric Nails +1"
    }

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Ghastly Tathlum +1",
        head = "Merlinic Hood",
        neck = "Argute Stole +2",
        ear1 = "Malignance Earring",
        ear2 = "Regal Earring",
        body = "Amalric Doublet +1",
        hands = "Jhakri Cuffs +1",
        ring1 = "Freke Ring",
        ring2 = "Metamorph Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Merlinic Shalwar",
        feet = "Jhakri Pigaches +2"
    }

    sets.midcast.Helix = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Ghastly Tathlum +1",
        head = "Merlinic Hood",
        neck = "Argute Stole +2",
        -- ear1 = "Crematio Earring",
        ear2 = "Friomisi Earring",
        -- body = gear.merlinic_nuke_body,
        hands = "Amalric Gages +1",
        ring1 = "Metamor. Ring +1",
        ring2 = "Freke Ring",
        back = gear.nuke_jse_back,
        waist = "Refoccilation Stone",
        legs = "Merlinic Shalwar",
        feet = "Amalric Nails +1"
    }

    sets.midcast.Helix.Resistant = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = gear.merlinic_nuke_head,
        neck = "Argute Stole +2",
        ear1 = "Malignance Earring",
        ear2 = "Friomisi Earring",
        -- body = gear.merlinic_nuke_body,
        hands = "Amalric Gages +1",
        ring1 = "Metamor. Ring +1",
        ring2 = "Freke Ring",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Merlinic Shalwar",
        feet = "Amalric Nails +1"
    }

    sets.midcast.Helix.Proc = {
        main = empty,
        sub = empty,
        ammo = "Impatiens",
        head = "Vanya Hood",
        -- neck = "Voltsurge Torque",
        -- ear1 = "Enchntr. Earring +1",
        ear2 = "Malignance Earring",
        -- body = "Zendik Robe",
        hands = "Gende. Gages +1",
        ring1 = "Kishar Ring",
        -- ring2 = "Prolix Ring",
        -- back = "Swith Cape +1",
        waist = "Witful Belt",
        legs = "Psycloth Lappas",
        -- feet = "Regal Pumps +1"
    }

    sets.midcast.Impact = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = empty,
        neck = "Erra Pendant",
        ear1 = "Regal Earring",
        ear2 = "Malignance Earring",
        -- body = "Twilight Cloak",
        hands = "Acad. Bracers +3",
        ring1 = "Metamor. Ring +1",
        ring2 = "Stikini Ring +1",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Merlinic Shalwar",
        feet = "Amalric Nails +1"
    }

    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen,
    { 
        head = empty, 
        -- body = "Twilight Cloak" 
    })

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
        -- main = "Chatoyant Staff",
        -- sub = "Oneiros Grip",
        ammo = "Homiliary",
        head = "Befouled Crown",
        -- neck = "Chrys. Torque",
        ear1 = "Etiolation Earring",
        -- ear2 = "Ethereal Earring",
        body = "Amalric Doublet +1",
        -- hands = gear.merlinic_refresh_hands,
        ring1 = "Defending Ring",
        -- ring2 = "Dark Ring",
        -- back = "Umbra Cape",
        waist = "Fucho-no-obi",
        legs = "Assid. Pants +1",
        -- feet = gear.chironic_refresh_feet
    }

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        main = "Mpaca's Staff",
        -- sub = "Umbra Strap",
        ammo = "Homiliary",
        head = "Befouled Crown",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        -- ear2 = "Ethereal Earring",
        body = "Jhakri Robe +1",
        -- hands = gear.merlinic_refresh_hands,
        ring1 = "Stikini Ring +1",
        ring2 = "Stikini Ring +1",
        -- back = "Umbra Cape",
        -- waist = "Carrier's Sash",
        legs = "Assid. Pants +1",
        -- feet = gear.chironic_refresh_feet
    }

    sets.idle.PDT = {
        main = "Malignance Pole",
        -- sub = "Umbra Strap",
        ammo = "Staunch Tathlum +1",
        -- head = "Gende. Caubeen +1",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        -- ear2 = "Ethereal Earring",
        -- body = "Vrikodara Jupon",
        hands = "Gende. Gages +1",
        ring1 = "Defending Ring",
        -- ring2 = "Dark Ring",
        -- back = "Umbra Cape",
        -- waist = "Carrier's Sash",
        legs = "Nyame Flanchard",
        -- feet = gear.chironic_refresh_feet
    }

    sets.idle.Hippo = set_combine(sets.idle.PDT, { 
        -- feet = "Hippo. Socks +1"
    })

    sets.idle.Weak = {
        main = "Bolelabunga",
        sub = "Genmei Shield",
        ammo = "Homiliary",
        head = "Befouled Crown",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        -- ear2 = "Ethereal Earring",
        body = "Jhakri Robe +1",
        -- hands = gear.merlinic_refresh_hands,
        ring1 = "Defending Ring",
        -- ring2 = "Dark Ring",
        -- back = "Umbra Cape",
        -- waist = "Carrier's Sash",
        legs = "Assid. Pants +1",
        -- feet = gear.chironic_refresh_feet
    }

    -- Defense sets

    sets.defense.PDT = {
        main = "Malignance Pole",
        -- sub = "Umbra Strap",
        ammo = "Staunch Tathlum +1",
        head = "Gende. Caubeen +1",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        -- ear2 = "Ethereal Earring",
        -- body = "Mallquis Saio +2",
        hands = "Gende. Gages +1",
        ring1 = "Defending Ring",
        -- ring2 = "Dark Ring",
        -- back = "Umbra Cape",
        waist = "Carrier's Sash",
        legs = "Nyame Flanchard",
        -- feet = "Battlecast Gaiters"
    }

    sets.defense.MDT = {
        main = "Malignance Pole",
        -- sub = "Umbra Strap",
        ammo = "Staunch Tathlum +1",
        head = "Gende. Caubeen +1",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        -- ear2 = "Ethereal Earring",
        -- body = "Mallquis Saio +2",
        hands = "Gende. Gages +1",
        ring1 = "Defending Ring",
        -- ring2 = "Dark Ring",
        -- back = "Umbra Cape",
        -- waist = "Carrier's Sash",
        legs = "Nyame Flanchard",
        -- feet = "Battlecast Gaiters"
    }

    sets.defense.MEVA = {
        main = "Daybreak",
        sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = gear.merlinic_nuke_head,
        neck = "Warder's Charm +1",
        ear1 = "Etiolation Earring",
        -- ear2 = "Sanare Earring",
        -- body = gear.merlinic_nuke_body,
        hands = "Gende. Gages +1",
        -- ring1 = "Vengeful Ring",
        -- ring2 = "Purity Ring",
        back = gear.nuke_jse_back,
        waist = "Acuity Belt +1",
        legs = "Merlinic Shalwar",
        feet = "Amalric Nails +1"
    }

    sets.Kiting = { feet = "Herald's Gaiters" }
    sets.latent_refresh = { waist = "Fucho-no-obi" }
    sets.latent_refresh_grip = { sub = "Oneiros Grip" }
    sets.TPEat = { neck = "Chrys. Torque" }
    sets.DayIdle = {}
    sets.NightIdle = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        main = "Bolelabunga",
        sub = "Genmei Shield",
        ammo = "Homiliary",
        head = "Volte Beret",
        neck = "Sanctity Necklace",
        ear1 = "Crep. Earring",
        ear2 = "Telos Earring",
        body = "Volte Jupon",
        hands = "Gazu Bracelets +1",
        ring1 = "Chirich Ring +1",
        ring2 = "Chirich Ring +1",
        -- back = "Umbra Cape",
        waist = "Windbuffet Belt +1",
        legs = "Agwu's Slops",
        feet = "Nyame Sollerets"
    }

    sets.engaged.PDT = {
        main = "Malignance Pole",
        -- sub = "Oneiros Grip",
        ammo = "Staunch Tathlum +1",
        head = "Gende. Caubeen +1",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        -- ear2 = "Ethereal Earring",
        -- body = "Vrikodara Jupon",
        hands = "Gende. Gages +1",
        ring1 = "Defending Ring",
        -- ring2 = "Dark Ring",
        -- back = "Umbra Cape",
        -- waist = "Carrier's Sash",
        legs = "Nyame Flanchard",
        -- feet = gear.chironic_refresh_feet
    }

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = { head = "Arbatel Bonnet +3" }
    sets.buff['Rapture'] = { head = "Arbatel Bonnet +3" }
    sets.buff['Perpetuance'] = { hands = "Arbatel Bracers +3" }
    sets.buff['Immanence'] = { 
        head = "Nyame Helm",
        body = "Nyame Mail",
        neck = "Warder's charm +1",
        hands = "Arbatel Bracers +3",
        back = "Lugh's Cape",
    }

    -- sets.buff['Penury'] = { legs = "Arbatel Pants +1" }
    -- sets.buff['Parsimony'] = { legs = "Arbatel Pants +1" }
    -- sets.buff['Celerity'] = { feet = "Peda. Loafers +1" }
    -- sets.buff['Alacrity'] = { feet = "Peda. Loafers +1" }
    sets.buff['Klimaform'] = { feet = "Arbatel Loafers +3" }

    sets.HPDown = {
        -- head = "Pixie Hairpin +1",
        -- ear1 = "Mendicant's Earring",
        ear2 = "Evans Earring",
        -- body = "Zendik Robe",
        -- hands = "Hieros Mittens",
        ring1 = "Mephitas's Ring +1",
        ring2 = "Mephitas's Ring",
        -- back = "Swith Cape +1",
        -- waist = "Carrier's Sash",
        -- legs = "Shedir Seraweels",
        feet = ""
    }

    sets.HPCure = {
        main = "Daybreak",
        -- sub = "Sors Shield",
        range = empty,
        -- ammo = "Hasty Pinion +1",
        head = "Gende. Caubeen +1",
        neck = "Unmoving Collar +1",
        -- ear1 = "Gifted Earring",
        -- ear2 = "Mendi. Earring",
        body = "Kaykaus Bliaut +1",
        hands = "Kaykaus Cuffs +1",
        ring1 = "Gelatinous Ring +1",
        ring2 = "Meridian Ring",
        -- back = "Moonlight Cape",
        waist = "Luminary Sash",
        legs = "Carmine Cuisses +1",
        feet = "Kaykaus Boots +1"
    }

    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Light Arts'] = { legs="Acad. Pants +3" } 
    sets.buff['Dark Arts'] = { body="Acad. Gown +3" }  

    sets.buff.Sublimation = { head = "Acad. Mortar. +3", waist = "Embla Sash" }
    sets.buff.DTSublimation = { waist = "Embla Sash" }

    -- Weapons sets
    sets.weapons.Akademos = { main = "Akademos", sub = "Enki Strap" }
    sets.weapons.Khatvanga = 
    { 
        main = "Khatvanga", 
        sub = "Bloodrain Strap"
    }
    sets.weapons.Bunzi = { main = "Bunzi's Rod", sub = "Genmei Shield" }
    sets.weapons.Grioavolr = { main = "Grioavolr", sub = "Enki Strap" }
    sets.weapons.Musa = { main = "Musa", sub = "Enki Strap" }
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
    if player.sub_job == 'RDM' then
        set_macro_page(1, 18)
    elseif player.sub_job == 'BLM' then
        set_macro_page(1, 18)
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 18)
    else
        set_macro_page(1, 18)
    end
end
