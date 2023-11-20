function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Acc', 'FullAcc', 'DT')
	state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Match', 'Proc')
	state.AutoBuffMode:options('Off', 'Auto', 'AutoMelee','FullMeleeBuff')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
	state.IdleMode:options('Normal', 'PDT', 'MDT', 'DTHippo')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Naegling', 'DualWeapons', 'DualWeaponsAcc', 'DualEvisceration', 'DualClubs',
	'DualAeolian', 'DualProcSwords', 'DualProcDaggers', 'EnspellOnly', 'EnspellDW')

	gear.stp_jse_back = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
	gear.nuke_jse_back = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
	gear.wsd_jse_back = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise" <me>')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command(
	'bind ^r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c weapons Default;gs c set unlockweapons false')
	send_command('bind ^q gs c set weapons enspellonly;gs c set unlockweapons true')
	send_command('bind !r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c set weapons dualweapons')
	send_command('bind !q gs c set skipprocweapons false;gs c set weapons DualProcSwords;gs c set weaponskillmode proc')

	select_default_macro_book()
end

function init_gear_sets()
	-- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty
    Chiro = {}      -- leave this empty
    Carm = {}       -- leave this empty
    Jhakri = {}     -- leave this empty
    Malignance = {} -- leave this empty

	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	"Atrophy Chapeau +3"
    AF.Body		=	"Atrophy Tabard +3"
    AF.Hands		=	"Atrophy Gloves +3"
    AF.Legs		=	"Atrophy Tights +3"
    AF.Feet		=	"Atrophy Boots +3"

    --Vitiation
    RELIC.Head		=	"Viti. Chapeau +3"
    RELIC.Body		=	"Viti. Tabard +3"
    RELIC.Hands 	=	"Viti. Gloves +3"
    RELIC.Legs		=	"Viti. Tights +3"
    RELIC.Feet		=	"Vitiation Boots +3"

    --Lethargy
    EMPY.Head		=	"Leth. Chappel +2"
    EMPY.Body		=	"Lethargy Sayon +3"
    EMPY.Hands		=	"Leth. Gantherots +3"
    EMPY.Legs		=	"Leth. Fuseau +3"
    EMPY.Feet		=	"Leth. Houseaux +3"

    -- Carmine
    Carm.Legs = {}
    Carm.Legs.D = { name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}

    --Chironic
    Chiro.Legs = {}
    Chiro.Legs.MACC = { name="Chironic Hose", augments={'Mag. Acc.+27','MND+13',}}

    Jhakri = {
        Head="Jhakri Coronal +2",
        Body="Jhakri Robe +2", 
        Hands="Jhakri Cuffs +2",
        Legs="Jhakri Slops +2",
        Feet="Jhakri Pigaches +2",
        Ring1="Jhakri Ring",
    }
    
    Nyame = {
        Head="Nyame Helm",
        Body="Nyame Mail",
        Hands="Nyame Gauntlets",
        Legs="Nyame Flanchard",
        Feet="Nyame Sollerets"
    }

    Malignance = {
        Head="Malignance Chapeau",
        Body="Malignance Tabard",
		Hands="Malignance Gloves",
		Feet="Malignance Boots",
    }

    -- Capes:
    -- Sucellos's And such, add your own.
    RDMCape = {}
    RDMCape.TP	=	{ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    RDMCape.MACC	=	{ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
    -- RDMCape.TP		=	{ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    -- RDMCape.MACC	=	{ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = { body = RELIC.Body }


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells

	sets.precast.FC = {
        -- main		=	"Crocea Mors",		--20
        head        =   AF.Head,
        hands       =   Jhakri.Hands,
        -- legs        =   Jhakri.Legs,
        body        =   RELIC.Body,
        feet        =   Jhakri.Feet,
        legs		=	"Aya. Cosciales +2",    --6
        -- neck		=	"Voltsurge Torque",     --4
        waist		=	"Embla Sash",          --5
        left_ear	=	"Malignance Earring",   --1
        right_ear	=	"Lethargy Earring",  --2
        left_ring	=	"Kishar Ring",          --4
        right_ring	=	"Jhakri Ring",        --5
	    -- head		=	Carm.Head.D,            --14
        --body		=	Merl.Body.FC,           --12
        ammo        =   "Regal Gem",
		--Total: 71 -- To Do: overkill need to slot DT / HP 
	}

	-- Curing Precast, Cure Spell Casting time -
	sets.precast.FC.Cure = set_combine(sets.precast.FC,{
		-- back		=	"Pahtli Cape",
		-- feet		=	"Telchine Pigaches",
		neck        =   "Diemer Gorget",
		-- left_ring	=	"Lebeche Ring",		
		left_ear    =   "Mendi. Earring",
		})
	sets.precast.FC.Impact = set_combine(sets.precast.FC, { 
		-- head = empty, body = "Twilight Cloak" 
	})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { 
		main = "Daybreak", 
		-- sub = "Sacro Bulwark"
	 })

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		-- range = empty,
		-- head = RELIC.Head,
		-- neck = "Asperity Necklace",
		-- ear1 = "Cessance Earring",
		-- ear2 = "Sherida Earring",
		-- body = "Ayanmo Corazza +2",
		-- hands = "Aya. Manopolas +2",
		-- ring1 = "Petrov Ring",
		-- ring2 = "Ilabrat Ring",
        -- back		=	RDMCape.MACC,		
		-- waist = "Windbuffet Belt +1",
		-- legs = "Carmine Cuisses +1",
		-- feet = "Carmine Greaves +1"
		-- ammo		=	"Regal Gem",
		head		=	RELIC.Head,
		ammo = "Oshasha's Treatise",
		-- body		=	RELIC.Body,
		neck = "Anu Torque",
		body		=	EMPY.Body,        
		hands       =   Jhakri.Hands,
		legs		=	EMPY.Legs,
		feet		=	EMPY.Feet,
		-- neck		=	"Dls. Torque +2",
		-- waist		=	"Prosilio Belt +1",
		left_ear	=	{ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear	=	"Ishvara Earring",
		right_ring	=	"Karieyh Ring",
		back		=	RDMCape.MACC,		
	}

	sets.precast.WS.Proc = {
		range = empty,
		ammo = "Hasty Pinion +1",
		head = "Malignance Chapeau",
		neck = "Combatant's Torque",
		ear1 = "Mache Earring +1",
		ear2 = "Telos Earring",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		ring1 = "Ramuh Ring +1",
		ring2 = "Ramuh Ring +1",
        back		=	RDMCape.TP,		
		waist = "Olseni Belt",
		legs = "Malignance Tights",
		feet = "Malignance Boots"
	}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = {
		range = empty,
		ammo = "Regal Gem",
		head = "Jhakri Coronal +2",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = "Jhakri Robe +2",
		hands = AF.Hands,
		ring1 = "Ifrit Ring +1",
		ring2 = "Rufescent Ring",
        back = RDMCape.MACC,		
		waist = "Fotia Belt",
		legs = "Jhakri Slops +2",
		feet = "Jhakri Pigaches +2"
	}

	sets.precast.WS['Chant Du Cygne'] = set_combine(sets.precast.WS, {
		range = empty,
		head = "Malignance Chapeau",
		neck = "Fotia Gorget",
        ear1 = { name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		ear2 = "Sherida Earring",
		hands = AF.Hands,
		-- ring1 = "Begrudging Ring",
		ring1 = "Karieyh Ring",
		ring2 = "Ilabrat Ring",
        back		=	RDMCape.MACC,		
		waist = "Fotia Belt",
		legs = "Carmine Cuisses +1",
		-- feet = "Thereoid Greaves"
		feet = EMPY.Feet,
	})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS['Chant Du Cygne'], {
		ear1 = "Ishvara Earring"
	})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        -- ammo		=	"Regal Gem",
        head		=	RELIC.Head,
        -- body		=	RELIC.Body,
        hands		=	AF.Hands,
        body		=	EMPY.Body,        
        legs		=	EMPY.Legs,
        feet		=	EMPY.Feet,
        neck		=	"Dls. Torque +2",
        -- waist		=	"Prosilio Belt +1",
        left_ear	=	{ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear	=	"Ishvara Earring",
        -- left_ring   =   "Stikini Ring +1",
        right_ring	=	"Karieyh Ring",
        -- right_ring	=	"Rufescent Ring",
        back		=	RDMCape.MACC,		
		-- range = empty,
		-- ammo = "Regal Gem",
		-- head = "Viti. Chapeau +3",
		-- neck = "Caro Necklace",
		-- ear1 = "Moonshade Earring",
		-- ear2 = "Ishvara Earring",
		-- body = "Viti. Tabard +3",
		-- ring1 = "Ifrit Ring +1",
		-- ring2 = "Rufescent Ring",
		-- back = gear.wsd_jse_back,
		-- waist = "Sailfi Belt +1",
		-- legs = "Jhakri Slops +2",
		-- feet = "Jhakri Pigaches +2"
	})

	sets.precast.WS['Sanguine Blade'] = {
		-- range = empty,
		-- ammo = "Pemphredo Tathlum",
		-- head = "Pixie Hairpin +1",
		-- neck = "Baetyl Pendant",
		-- ear1 = "Regal Earring",
		-- ear2 = "Malignance Earring",
		-- body = gear.merlinic_nuke_body,
		-- hands = "Jhakri Cuffs +2",
		-- ring1 = "Metamor. Ring +1",
		-- ring2 = "Archon Ring",
		-- back = gear.nuke_jse_back,
		-- waist = "Refoccilation Stone",
		-- legs = "Merlinic Shalwar",
		-- feet = "Amalric Nails +1"
        neck        =   "Mizu. Kubikazari",
        head        =   EMPY.Head,
        body        =   EMPY.Body,
		hands = "Jhakri Cuffs +2",
        legs        =   EMPY.Legs,
        feet        =   EMPY.Feet,
        left_ear    =   "Malignance Earring",
        right_ear   =   "Snotra Earring",
        waist       =   "Acuity Belt +1",
        ammo        =   "Regal Gem",
        left_ring   =   "Jhakri Ring",
        right_ring  =   "Ayanmo Ring",
        back		=	RDMCape.MACC,	
	}

	sets.precast.WS['Seraph Blade'] = {
		range = empty,
		ammo = "Pemphredo Tathlum",
		head = gear.merlinic_nuke_head,
		neck = "Baetyl Pendant",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = gear.merlinic_nuke_body,
		hands = "Jhakri Cuffs +2",
		ring1 = "Shiva Ring +1",
		ring2 = "Freke Ring",
		back = gear.nuke_jse_back,
		waist = "Refoccilation Stone",
		legs = "Merlinic Shalwar",
		feet = "Amalric Nails +1"
	}

	sets.precast.WS['Aeolian Edge'] = {
		-- range = empty,
		-- ammo = "Pemphredo Tathlum",
		-- head = gear.merlinic_nuke_head,
		-- neck = "Baetyl Pendant",
		-- ear1 = "Regal Earring",
		-- body = gear.merlinic_nuke_body,
		-- ring1 = "Metamor. Ring +1",
		-- ring2 = "Freke Ring",
		-- back = gear.nuke_jse_back,
		-- waist = "Refoccilation Stone",
		-- legs = "Merlinic Shalwar",
		-- feet = "Amalric Nails +1"
        neck        =   "Mizu. Kubikazari",
        head        =   EMPY.Head,
        body        =   EMPY.Body,
		hands = "Jhakri Cuffs +2",
        legs        =   EMPY.Legs,
        feet        =   EMPY.Feet,
        left_ear    =   "Malignance Earring",
        right_ear   =   "Snotra Earring",
        waist       =   "Acuity Belt +1",
        ammo        =   "Regal Gem",
        left_ring   =   "Jhakri Ring",
        right_ring  =   "Ayanmo Ring",
        back		=	RDMCape.MACC,		
	}

	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, { feet = gear.chironic_treasure_feet })

	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = { body = "Seidr Cotehardie" }

	-- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.Casting = {
        -- main		=	"Maxentius",
        -- sub		    =	"Ammurapi Shield",
        neck        =   "Mizu. Kubikazari",
        back		=	RDMCape.MACC,
        body        =   EMPY.Body,
        head        =   EMPY.Head,
        hands       =   EMPY.Hands,
        legs        =   EMPY.Legs,
        feet        =   EMPY.Feet,
        left_ear    =   "Malignance Earring",
        right_ear   =   "Snotra Earring",
        waist       =   "Acuity Belt +1",
        ammo        =   "Regal Gem",
        left_ring   =   "Jhakri Ring",
        right_ring  =   "Ayanmo Ring",
        -- -- ammo		=	"Pemphredo Tathlum",
        --head		=	Merl.Head.ACC,
        --body		=	Amal.Body.A,
        --hands		=	Amal.Hands.D,
        --legs		=	Amal.Legs.A,
        --feet		=	Amal.Feet.A,
        -- -- neck		=	"Dls. Torque +2",
        -- -- waist		=	"Refoccilation Stone",
        -- left_ear	=	"Friomisi Earring",
        -- right_ear	=	"Enchntr. Earring +1",
        -- right_ring	=	"Freke Ring",
    }

	sets.midcast.FastRecast = {
		main = gear.grioavolr_fc_staff,
		sub = "Clerisy Strap +1",
		range = empty,
		ammo = "Hasty Pinion +1",
		head = AF.Head,
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Malignance Earring",
		body = "Zendik Robe",
		hands = "Gende. Gages +1",
		ring1 = "Kishar Ring",
		ring2 = "Prolix Ring",
		back = "Swith Cape +1",
		waist = "Witful Belt",
		legs = "Psycloth Lappas",
		feet = "Medium's Sabots"
	}

	sets.midcast.Cure = set_combine(sets.midcast.Casting,{
		-- main = "Daybreak",
		-- sub = "Sors Shield",
        head		=	"Vanya Hood",
        -- body		=	"Gende. Bilaut +1",
        -- hands		=	"Telchine Gloves", 
        legs		=	AF.Legs,
        feet		=	"Vanya Clogs",
        -- feet		=	RELIC.Feet,
        -- neck		=	"Fylgja Torque +1",
        -- waist		=	"Porous Rope",
        left_ear	=	"Mendi. Earring",
        -- right_ear	=	"Roundel Earring",
        -- left_ring	=	"Stikini Ring +1",
        -- right_ring	=	"Lebeche Ring",
        back		=	"Ghostfyre Cape",
        -- sub		=	"Enki Strap",
    })

	sets.midcast.LightWeatherCure = {
		main = "Chatoyant Staff",
		sub = "Curatio Grip",
		range = empty,
		ammo = "Hasty Pinion +1",
		head = "Gende. Caubeen +1",
		neck = "Incanter's Torque",
		ear1 = "Meili Earring",
		ear2 = "Mendi. Earring",
		body = "Kaykaus Bliaut",
		hands = "Kaykaus Cuffs",
		ring1 = "Janniston Ring",
		ring2 = "Menelaus's Ring",
		back = "Twilight Cape",
		waist = "Hachirin-no-Obi",
		legs = "Carmine Cuisses +1",
		feet = "Kaykaus Boots"
	}

	--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = {
		-- main = "Daybreak",
		sub = "Sors Shield",
		range = empty,
		ammo = "Hasty Pinion +1",
		head = "Gende. Caubeen +1",
		neck = "Incanter's Torque",
		ear1 = "Meili Earring",
		ear2 = "Mendi. Earring",
		body = "Kaykaus Bliaut",
		hands = "Kaykaus Cuffs",
		ring1 = "Janniston Ring",
		ring2 = "Menelaus's Ring",
		back = "Twilight Cape",
		waist = "Hachirin-no-Obi",
		legs = "Carmine Cuisses +1",
		feet = "Kaykaus Boots"
	}

	sets.midcast.Cursna = {
		main = gear.grioavolr_fc_staff,
		sub = "Curatio Grip",
		range = empty,
		ammo = "Staunch Tathlum +1",
		head = "Bunzi's Hat",
		neck = "Debilis Medallion",
		ear1 = "Meili Earring",
		ear2 = "Mendi. Earring",
		body = RELIC.Body,
		hands = "Hieros Mittens",
		ring1 = "Haoma's Ring",
		ring2 = "Menelaus's Ring",
		back = "Oretan. Cape +1",
		waist = "Witful Belt",
		legs = "Carmine Cuisses +1",
		feet = "Vanya Clogs"
	}

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, { main = gear.grioavolr_fc_staff,
		sub = "Clemency Grip" })

	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = { neck = "Phalaina Locket", ear1 = "Etiolation Earring", hands = "Buremte Gloves",
		ring2 = "Kunaji Ring", waist = "Gishdubar Sash" }
	sets.Cure_Received = { neck = "Phalaina Locket", hands = "Buremte Gloves", ring2 = "Kunaji Ring",
		waist = "Gishdubar Sash" }
	sets.Self_Refresh = { back = "Grapevine Cape", waist = "Gishdubar Sash" }

	sets.midcast['Enhancing Magic'] = {
		main = "Colada",
		sub = "Ammurapi Shield",
		range = empty,
		ammo = "Hasty Pinion +1",
		head = "Telchine Cap",
		neck = "Dls. Torque +2",
		ear1 = "Andoaa Earring",
		ear2 = "Lethargy Earring",
		body = RELIC.Body,
		hands = AF.Hands,
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Embla Sash",
		legs = "Telchine Braconi",
		feet = EMPY.Feet
	}

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.		
	sets.buff.ComposureOther = {
		head = EMPY.Head,
		body = EMPY.Body,
		hands = EMPY.Hands,
		legs = EMPY.Legs,
		feet = EMPY.Feet
	}

	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.EnhancingSkill = { 
		main = "Pukulatmuj +1", 
		head = "Befouled Crown", 
		neck = "Incanter's Torque",
		ear2 = "Mimir Earring", 
		hands = RELIC.Hands, 
		back = "Ghostfyre Cape", 
		waist = "Olympus Sash",
		legs = AF.Legs 
	}
	sets.midcast.Refresh = { head = "Amalric Coif +1", body = AF.Body, legs = EMPY.Feet }
	sets.midcast.Aquaveil = { head = "Amalric Coif +1", hands = "Regal Cuffs", waist = "Emphatikos Rope",
		legs = "Shedir Seraweels" }
	sets.midcast.BarElement = { legs = "Shedir Seraweels" }
	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Temper.DW = set_combine(sets.midcast.Temper, { sub = "Pukulatmuj" })
	sets.midcast.Enspell = sets.midcast.Temper
	sets.midcast.Enspell.DW = set_combine(sets.midcast.Enspell, { sub = "Pukulatmuj" })
	sets.midcast.BoostStat = { hands = AF.Hands }
	sets.midcast.Stoneskin = { neck = "Nodens Gorget", ear2 = "Earthcry Earring", waist = "Siegel Sash",
		legs = "Shedir Seraweels" }
	sets.midcast.Protect = { ring2 = "Sheltered Ring" }
	sets.midcast.Shell = { ring2 = "Sheltered Ring" }

	sets.midcast['Enfeebling Magic'] = {
		-- main		=	"Maxentius",
        -- sub		=	"Ammurapi Shield",
        -- body		=	Amal.Body.A,
        --hands		=	Kayk.Hands.A,
        -- waist		=	"Porous Rope",
        -- left_ring	=	"Stikini Ring +1",
        -- right_ring	=	"Stikini Ring",
        ammo		=	"Regal Gem",
        neck		=	"Dls. Torque +2",
        head		=	RELIC.Head,
        body		=	AF.Body,
		hands		=	EMPY.Hands,
        legs		=	Chiro.Legs.MACC,
        feet		=	RELIC.Feet,
        left_ear	=	"Snotra Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Kishar Ring",
        right_ring	=	"Jhakri Ring",       
        back		=	RDMCape.MACC
	}

	sets.midcast['Enfeebling Magic'].Resistant =  set_combine(sets.midcast['Enfeebling Magic'], {
		-- main = "Daybreak",
		-- sub = "Ammurapi Shield",
		range = "Ullr",
		ammo = empty,
		-- ear1 = "Regal Earring",
		-- hands = gear.chironic_enfeeble_hands,
		-- ring1 = "Metamor. Ring +1",
		-- ring2 = "Stikini Ring +1",
		-- back = gear.nuke_jse_back,
		-- waist = "Luminary Sash",
	})

	sets.midcast.DurationOnlyEnfeebling = set_combine(sets.midcast['Enfeebling Magic'],
	{ 
		main = "Bunzi's Rod", 
		range = "Kaja Bow",
		body = AF.Body, 
		left_ear = "Snotra Earring",
		left_ring = "Kishar Ring",
		waist = "Obstinate Sash",
		feet = EMPY.Feet,
	})

	sets.midcast.Silence = sets.midcast.DurationOnlyEnfeebling
	sets.midcast.Silence.Resistant = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast.Sleep = set_combine(sets.midcast.DurationOnlyEnfeebling, { waist = "Acuity Belt +1" })
	sets.midcast.Sleep.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, { waist = "Acuity Belt +1" })
	sets.midcast.Bind = set_combine(sets.midcast.DurationOnlyEnfeebling, { waist = "Acuity Belt +1" })
	sets.midcast.Bind.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, { waist = "Acuity Belt +1" })
	sets.midcast.Break = set_combine(sets.midcast.DurationOnlyEnfeebling, { waist = "Acuity Belt +1" })
	sets.midcast.Break.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, { waist = "Acuity Belt +1" })

	sets.midcast.Dispel = sets.midcast['Enfeebling Magic'].Resistant

	sets.midcast.SkillBasedEnfeebling = set_combine(sets.midcast['Enfeebling Magic'],
	{ ear1 = "Vor Earring", hands = EMPY.Hands, ring1 = "Stikini Ring +1", legs = "Psycloth Lappas" })

	sets.midcast['Frazzle II'] = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Frazzle III'] = sets.midcast.SkillBasedEnfeebling
	sets.midcast['Frazzle III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant

	sets.midcast['Distract III'] = sets.midcast.SkillBasedEnfeebling
	sets.midcast['Distract III'].Resistant = sets.midcast['Enfeebling Magic'].Resistant

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], 
		{
			waist = "Obstinate Sash"
		})
	sets.midcast.Diaga = sets.midcast.Dia

	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast['Elemental Magic'] = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		range = empty,
		ammo = "Ghastly Tathlum +1",
		head = EMPY.Head,
		-- neck = "Baetyl Pendant",
		neck = "Mizu. Kubikazari",
		-- ear1 = "Crematio Earring",
		-- ear2 = "Friomisi Earring",
		ear1 = "Malignance Earring",
		ear2 = "Lethargy Earring",
		-- body = gear.merlinic_nuke_body,
		body = EMPY.Body,
		-- hands = "Amalric Gages +1",
		hands = EMPY.Hands,
		-- ring1 = "Shiva Ring +1",
		-- ring2 = "Freke Ring",
		ring1 = Jhakri.Ring,
		ring2 = "Ayanmo Ring",
		back = gear.nuke_jse_back,
		-- waist = gear.ElementalObi,
		waist = "Acuity Belt +1",
		-- legs = "Merlinic Shalwar",
		-- feet = "Amalric Nails +1"
		legs = EMPY.Legs,
		feet = EMPY.Feet
	}

	sets.midcast['Elemental Magic'].Resistant = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = gear.merlinic_nuke_head,
		neck = "Dls. Torque +2",
		ear1 = "Regal Earring",
		ear2 = "Friomisi Earring",
		body = gear.merlinic_nuke_body,
		hands = "Amalric Gages +1",
		ring1 = "Metamor. Ring +1",
		ring2 = "Freke Ring",
		back = gear.nuke_jse_back,
		waist = "Yamabuki-no-Obi",
		legs = "Merlinic Shalwar",
		feet = "Amalric Nails +1"
	}

	sets.midcast['Elemental Magic'].Fodder = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		range = empty,
		ammo = "Ghastly Tathlum +1",
		head = "Bunzi's Hat",
		neck = "Baetyl Pendant",
		ear1 = "Crematio Earring",
		ear2 = "Friomisi Earring",
		body = gear.merlinic_nuke_body,
		hands = "Amalric Gages +1",
		ring1 = "Shiva Ring +1",
		ring2 = "Freke Ring",
		back = gear.nuke_jse_back,
		waist = gear.ElementalObi,
		legs = "Merlinic Shalwar",
		feet = "Amalric Nails +1"
	}

	sets.midcast['Elemental Magic'].Proc = {
		main = empty,
		sub = empty,
		range = empty,
		ammo = "Impatiens",
		head = "Vanya Hood",
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Loquac. Earring",
		body = "Zendik Robe",
		hands = "Gende. Gages +1",
		ring1 = "Kishar Ring",
		ring2 = "Prolix Ring",
		back = "Swith Cape +1",
		waist = "Witful Belt",
		legs = "Psycloth Lappas",
		feet = "Regal Pumps +1"
	}

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'],
	{ head = gear.merlinic_nuke_head, ammo = "Pemphredo Tathlum", ear1 = "Regal Earring", ring1 = "Metamor. Ring +1" })
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant,
	{ head = gear.merlinic_nuke_head, ear1 = "Regal Earring", ring1 = "Metamor. Ring +1" })
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder,
	{ head = gear.merlinic_nuke_head, ammo = "Pemphredo Tathlum", ear1 = "Regal Earring", ring1 = "Metamor. Ring +1" })

	-- Gear for Magic Burst mode.
	sets.MagicBurst = set_combine(sets.midcast['Elemental Magic'],{
		-- main = gear.grioavolr_nuke_staff, 
		-- sub = "Alber Strap", 
		-- head = "Ea Hat +1",
		neck = "Mizu. Kubikazari", 
		hands = "Bunzi's Gloves",
		-- body = "Ea Houppe. +1", 
		-- hands = "Amalric Gages +1", 
		waist = "Acuity Belt +1",
		ammo = "Ghastly Tathlum +1",
		ring1 = "Jhakri Ring",
		ring2 = "Mujin Band",
		-- legs = "Ea Slops +1", 
		feet = "Jhakri Pigaches +2" 
	})
	
	sets.midcast.Impact = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		range = "Kaja Bow",
		ammo = empty,
		head = empty,
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = "Twilight Cloak",
		hands = EMPY.Hands,
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Luminary Sash",
		legs = "Merlinic Shalwar",
		feet = "Amalric Nails +1"
	}

	sets.midcast['Dark Magic'] = {
		main = "Rubicundity",
		sub = "Ammurapi Shield",
		range = "Kaja Bow",
		ammo = empty,
		head = "Amalric Coif +1",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = AF.Body,
		hands = EMPY.Hands,
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Luminary Sash",
		legs = "Psycloth Lappas",
		feet = "Amalric Nails +1"
	}

	sets.midcast.Drain = {
		main = "Rubicundity",
		sub = "Ammurapi Shield",
		range = "Kaja Bow",
		ammo = empty,
		head = "Pixie Hairpin +1",
		neck = "Erra Pendant",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = gear.merlinic_nuke_body,
		hands = gear.chironic_enfeeble_hands,
		ring1 = "Evanescence Ring",
		ring2 = "Archon Ring",
		back = gear.nuke_jse_back,
		waist = "Fucho-no-obi",
		legs = "Chironic Hose",
		feet = gear.merlinic_aspir_feet
	}

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		range = "Kaja Bow",
		ammo = empty,
		head = AF.Head,
		neck = "Dls. Torque +2",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = "Zendik Robe",
		hands = "Volte Gloves",
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Sailfi Belt +1",
		legs = "Chironic Hose",
		feet = gear.merlinic_aspir_feet
	}

	sets.midcast.Stun.Resistant = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		range = "Kaja Bow",
		ammo = empty,
		head = AF.Head,
		neck = "Dls. Torque +2",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = AF.Body,
		hands = "Volte Gloves",
		ring1 = "Metamor. Ring +1",
		ring2 = "Stikini Ring +1",
		back = gear.nuke_jse_back,
		waist = "Acuity Belt +1",
		legs = "Chironic Hose",
		feet = gear.merlinic_aspir_feet
	}

	-- Sets for special buff conditions on spells.

	sets.buff.Saboteur = { hands = EMPY.Hands }

	sets.HPDown = {
		head = "Pixie Hairpin +1",
		ear1 = "Mendicant's Earring",
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
		-- main = "Daybreak",
		sub = "Sors Shield",
		range = empty,
		ammo = "Hasty Pinion +1",
		head = "Gende. Caubeen +1",
		neck = "Unmoving Collar +1",
		ear1 = "Gifted Earring",
		ear2 = "Mendi. Earring",
		body = RELIC.Body,
		hands = "Kaykaus Cuffs",
		ring1 = "Gelatinous Ring +1",
		ring2 = "Meridian Ring",
		back = "Moonlight Cape",
		waist = "Luminary Sash",
		legs = "Carmine Cuisses +1",
		feet = "Kaykaus Boots"
	}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {
		main = "Chatoyant Staff",
		sub = "Oneiros Grip",
		range = empty,
		ammo = "Impatiens",
		head = RELIC.Head,
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = "Jhakri Robe +2",
		hands = gear.merlinic_refresh_hands,
		ring1 = "Defending Ring",
		ring2 = "Sheltered Ring",
		back = "Umbra Cape",
		waist = "Flume Belt +1",
		legs = "Lengo Pants",
		feet = gear.chironic_refresh_feet
	}

	-- Idle sets
	sets.idle = {
        ammo		=	"Homiliary",
        head		=	RELIC.Head,
		neck = "Dls. Torque +2",
        body		=	AF.Body,
        hands		=	EMPY.Hands,
        -- legs		=	Carm.Legs.D,
        feet		=	EMPY.Feet,
        -- neck		=	"Twilight Torque",
        -- waist		=	"Flume Belt",
        -- left_ear	=	"Etiolation Earring",
        -- right_ear	=	"Ethereal Earring",
        -- left_ring	=	"Defending Ring +1",
        -- right_ring	=	"Stikini Ring",
        back		=	RDMCape.TP,
	}

	sets.idle.Town = {
		Head = AF.Head,
        Body = AF.Body, 
        Hands = AF.Hands,
        Legs = AF.Legs,
        Feet = AF.Feet,
	}

	sets.idle.PDT = {
        -- neck		=	"Twilight Torque",
        back        =   "Agema Cape",
        head		=	Nyame.Head,
        hands		=	Nyame.Hands,
        body        =   Nyame.Body,
		waist		=   "Plat. Mog. Belt",
        -- legs		=	RELIC.Legs,
        legs        =   Nyame.Legs,
        feet		=	Nyame.Feet,
	    left_ring	=	"Gelatinous Ring +1",
        right_ring	=	"Ayanmo Ring",
	}

	sets.idle.MDT = set_combine(sets.idle.PDT)

	sets.idle.Weak = {
		main = "Bolelabunga",
		sub = "Sacro Bulwark",
		range = empty,
		ammo = "Homiliary",
		head = RELIC.Head,
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Sanare Earring",
		body = "Jhakri Robe +2",
		hands = gear.merlinic_refresh_hands,
		ring1 = "Defending Ring",
		ring2 = "Dark Ring",
		back = "Umbra Cape",
		waist = "Flume Belt +1",
		legs = "Lengo Pants",
		feet = gear.chironic_refresh_feet
	}

	sets.idle.DTHippo = set_combine(sets.idle.PDT, { back = "Umbra Cape", legs = "Carmine Cuisses +1",
		feet = "Hippo. Socks +1" })

	-- Defense sets
	sets.defense.PDT = {
		-- neck		=	"Twilight Torque",
		back        =   "Agema Cape",
		head		=	Malignance.Head,
		hands		=	Malignance.Hands,
		body        =   Malignance.Body,
		waist		=   "Plat. Mog. Belt",
		-- legs		=	RELIC.Legs,
		legs        =   Nyame.Legs,
		feet		=	Nyame.Feet,
		left_ring	=	"Gelatinous Ring +1",
		right_ring	=	"Ayanmo Ring",
	}

	sets.defense.NukeLock = sets.midcast['Elemental Magic']

	sets.defense.MDT = set_combine(sets.defense.PDT, {
		ear1 = "Odnowa Earring +1"
	})
	sets.defense.MEVA = set_combine(sets.defense.MDT, {
		-- main = "Daybreak",
		-- sub = "Sacro Bulwark",
		-- range = empty,
		-- ammo = "Staunch Tathlum +1",
		-- head = "Malignance Chapeau",
		-- neck = "Warder's Charm +1",
		-- ear1 = "Etiolation Earring",
		-- ear2 = "Ethereal Earring",
		-- body = "Malignance Tabard",
		-- hands = "Malignance Gloves",
		-- ring1 = "Defending Ring",
		-- ring2 = "Dark Ring",
		-- back = "Moonlight Cape",
		-- waist = "Carrier's Sash",
		-- legs = "Malignance Tights",
		-- feet = "Malignance Boots"
	})

	sets.Kiting = { legs = "Carmine Cuisses +1" }
	sets.latent_refresh = { waist = "Fucho-no-obi" }
	sets.latent_refresh_grip = { sub = "Oneiros Grip" }
	sets.TPEat = { neck = "Chrys. Torque" }
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Weapons sets
	sets.weapons.Naegling = { main = "Naegling", sub = "Sacro Bulwark", range = empty }
	sets.weapons.DualWeapons = { main = "Naegling", sub = "Machaera +3", range = empty }
	sets.weapons.DualWeaponsAcc = { main = "Naegling", sub = "Almace", range = empty }
	-- sets.weapons.DualEvisceration = { main = "Tauret", sub = "Almace", range = empty }
	sets.weapons.DualEvisceration = { main = "Tauret", sub = "Ternion Dagger +1", range = empty }
	sets.weapons.DualAeolian = { main = "Tauret", sub = "Daybreak", range = empty }
	sets.weapons.DualProcSwords = { main = "Brunello", sub = "Soulflayer's Wand", range = empty }
	sets.weapons.DualProcDaggers = { main = "Blurred Knife +1", sub = "Atoyac", range = empty }
	sets.weapons.EnspellOnly = { main = "Norgish Dagger", sub = "Aern Dagger", range = "Kaja Bow", ammo = "Beetle Arrow" }
	sets.weapons.EnspellDW = { main = "Blurred Knife +1", sub = "Atoyac", range = "Kaja Bow", ammo = "Beetle Arrow" }
	sets.weapons.DualClubs = { main = "Maxentius", sub = "Machaera +3", range = empty }
	sets.weapons.DualAlmace = { main = "Almace", sub = "Sequence", range = empty }
	sets.weapons.DualBow = { main = "Naegling", sub = "Tauret", range = "Kaja Bow" }
	sets.weapons.BowMacc = { main = "Naegling", sub = "Tauret", range = "Kaja Bow", ammo = empty }

	sets.buff.Sublimation = { waist = "Embla Sash" }
	sets.buff.DTSublimation = { waist = "Embla Sash" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.Dagger.Accuracy.Evasion

	-- Normal melee group
	--	sets.engaged = {ammo="Aurgelmir Orb +1",
	--		head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
	--		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Ilabrat Ring",
	--		back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

	sets.engaged = {
		ammo		=	"Ginsen",
        --head		=	Taeon.Head.TP,
        head=Malignance.Head,
        hands=Malignance.Hands,     
        body=Malignance.Body,
        -- body		=	"Ayanmo Corazza +2",
        left_ring = "Ilabrat Ring",
        right_ring = "Lehko's Ring",
        -- left_ring	=	{name="Chirich Ring +1", bag="wardrobe2"}, -- I do this to prevent issues with lag sometimes if 2 ring are the same in same bag GS sometimes only equips 1 of them        
        -- legs		=	Carm.Legs.D,
		legs 		=   RELIC.Legs,
        feet        =   Malignance.Feet,
        --feet		=	Carm.Feet.B,
        neck		=	"Anu Torque",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Sherida Earring",
        right_ear	=	"Crep. Earring",
        back		=	RDMCape.TP,  
	}

	sets.engaged.Subtle = set_combine(sets.engaged, {
		neck="Subtlety Spec.",
		left_ear="Sherida Earring",
		left_ring="Apate Ring",
	})	

	sets.engaged.EnspellOnly = {
		head = "Malignance Chapeau",
		neck = "Dls. Torque +2",
		ear1 = "Suppanomimi",
		ear2 = "Digni. Earring",
		body = "Ayanmo Corazza +2",
		hands = "Aya. Manopolas +2",
		ring1 = "Metamor. Ring +1",
		ring2 = "Ramuh Ring +1",
		back = "Ghostfyre Cape",
		waist = "Windbuffet Belt +1",
		legs = "Carmine Cuisses +1",
		feet = "Malignance Boots"
	}

	sets.engaged.Acc = set_combine(sets.engaged, {
        --head		=	Carm.Head.D,
        -- neck		=	"Sanctity Necklace",
        right_ear   =  { name="Domin. Earring +1", augments={'Path: A',}},
        -- right_ear	=	"Mache Earring +1",
        -- waist		=	"Grunfeld Rope",
    })

	sets.engaged.FullAcc = set_combine(sets.Acc, {
        --head		=	Carm.Head.D,
        -- neck		=	"Sanctity Necklace",
        right_ear   =  { name="Domin. Earring +1", augments={'Path: A',}},
        -- right_ear	=	"Mache Earring +1",
        -- waist		=	"Grunfeld Rope",
    })

	sets.engaged.DT = set_combine(sets.engaged,{
        -- neck		=	"Twilight Torque",
        neck		=	"Loricate Torque +1",
        -- legs		=	RELIC.Legs,
		legs 		=   RELIC.Legs,
	    -- left_ring	=	"Ayanmo Ring",
        -- right_ring	=	"Defending Ring",
    })

	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, sets.engaged.Acc)

	sets.engaged.FullAcc.DT = set_combine(sets.engaged.DT, sets.engaged.Acc, {
		feet = "Battlecast Gaiters"
	})

	sets.engaged.DW =  set_combine(sets.engaged)
	sets.engaged.DW.Acc = set_combine(sets.engaged.Acc)
	sets.engaged.DW.FullAcc = set_combine(sets.engaged.FullAcc)
	sets.engaged.DW.DT = set_combine(sets.engaged, sets.engaged.DT)
	sets.engaged.DW.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.DT)
	sets.engaged.DW.FullAcc.DT = set_combine(sets.engaged.FullAcc, sets.engaged.DT)
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'DNC' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 1)
	else
		set_macro_page(1, 1)
	end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.chat.input('/ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[984] < spell_latency and not have_trust("August") then
					windower.chat.input('/ma "August" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.chat.input('/ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.chat.input('/ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.chat.input('/ma "Selh\'teus" <me>')
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

function user_job_buff_change(buff, gain)
	if buff:startswith('Addendum: ') or buff:endswith(' Arts') then
		style_lock = true
	end
end

function user_job_lockstyle()
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		if player.equipment.main == nil or player.equipment.main == 'empty' then
			windower.chat.input('/lockstyleset 021')
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
				windower.chat.input('/lockstyleset 021')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
				windower.chat.input('/lockstyleset 022')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Sword/Club.
				windower.chat.input('/lockstyleset 022')
			else
				windower.chat.input('/lockstyleset 021')                    --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Dagger/Sword.
				windower.chat.input('/lockstyleset 021')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
				windower.chat.input('/lockstyleset 021')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Dagger/Club.
				windower.chat.input('/lockstyleset 022')
			else
				windower.chat.input('/lockstyleset 021')                    --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 11 then --Club in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Club/Sword.
				windower.chat.input('/lockstyleset 021')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Club/Dagger.
				windower.chat.input('/lockstyleset 021')
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Club/Club.
				windower.chat.input('/lockstyleset 022')
			else
				windower.chat.input('/lockstyleset 021') --Catchall
			end
		end
	elseif player.sub_job == 'WHM' or state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
		windower.chat.input('/lockstyleset 030')
	elseif player.sub_job == 'BLM' or state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
		windower.chat.input('/lockstyleset 031')
	else
		windower.chat.input('/lockstyleset 032')
	end
end

autows_list = { ['Naegling'] = 'Savage Blade',['DualWeapons'] = 'Savage Blade',['DualWeaponsAcc'] = 'Savage Blade',
	['DualEvisceration'] = 'Evisceration',['DualClubs'] = 'Black Halo',['DualAeolian'] = 'Aeolian Edge',
	['EnspellDW'] = 'Sanguine Blade' }
