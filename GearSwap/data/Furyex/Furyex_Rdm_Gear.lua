function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options("Normal", "Acc", "FullAcc", "DT")
	state.HybridMode:options("Normal", "DT")
	state.WeaponskillMode:options("Match", "Acc", "Proc")
	state.AutoBuffMode:options("Off", "Auto", "AutoMelee", "FullMeleeBuff")
	state.CastingMode:options("Normal", "OccultAcumen", "Resistant", "Fodder", "Proc", "Enmity")
	state.IdleMode:options("Normal", "PDT", "MDT", "DTHippo", "Aminon")
	state.PhysicalDefenseMode:options("PDT", "NukeLock")
	state.MagicalDefenseMode:options("MDT")
	state.ResistDefenseMode:options("MEVA")
	state.Weapons:options(
		"None",
		"Mpu",
		"Naegling",
		"Onion",
		"Club",
		"Tauret",
		"Murgleis",
		"Bow",
		"DualWeapons",
		"DualMpu",
		"DualOnion",
		"DualWeaponsAcc",
		"DualEvisceration",
		"DualClubs",
		"DualAeolian",
		"DualSeraph",
		"EnspellDW",
		"DualBow",
		"EnspellOnly",
		"Enspell"
	)
	state.ConvertMode = M {"Always", "300", "1000", "Never"}

	gear.nuke_jse_back = {
		name = "Sucellos's Cape",
		augments = {"MND+20", "Mag. Acc+20 /Mag. Dmg.+20", "MND+10", "Weapon skill damage +10%", "Phys. dmg. taken-10%"}
	}

	-- Additional local binds
	send_command("bind ^` gs c cycle ElementalMode")
	send_command("bind !` gs c cycle MagicBurstMode")
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command("bind @f8 gs c toggle AutoNukeMode")
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise" <me>')
	send_command("bind @f10 gs c cycle RecoverMode")
	send_command(
		"bind ^r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c weapons Default;gs c set unlockweapons false; gs c set weapons none"
	)
	send_command("bind ^q gs c set weapons enspellonly;gs c set unlockweapons true")
	send_command("bind !r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c set weapons dualweapons")
	send_command("bind !q gs c set skipprocweapons false;gs c set weapons DualProcSwords;gs c set weaponskillmode proc")
	send_command("bind !f7 gs c cycle ConvertMode")

	select_default_macro_book()
end

function init_gear_sets()
	-- JSE
	AF = {} -- leave this empty
	RELIC = {} -- leave this empty
	EMPY = {} -- leave this empty
	Chiro = {} -- leave this empty
	Carm = {} -- leave this empty
	Jhakri = {} -- leave this empty

	-- Fill this with your own JSE.
	--Atrophy
	AF.Head = "Atro. Chapeau +4"
	AF.Body = "Atrophy Tabard +4"
	AF.Hands = "Atro. Gloves +4"
	AF.Legs = "Atro. Tights +4"
	AF.Feet = "Atro. Boots +4"

	--Vitiation
	RELIC.Head = "Viti. Chapeau +3"
	RELIC.Body = "Viti. Tabard +3"
	RELIC.Hands = "Viti. Gloves +3"
	RELIC.Legs = "Viti. Tights +3"
	RELIC.Feet = "Vitiation Boots +3"

	--Lethargy
	EMPY.Head = "Leth. Chappel +3"
	EMPY.Body = "Lethargy Sayon +3"
	EMPY.Hands = "Leth. Ganth. +3"
	EMPY.Legs = "Leth. Fuseau +3"
	EMPY.Feet = "Leth. Houseaux +3"

	-- Carmine
	Carm.Legs = {}
	Carm.Legs.D = {name = "Carmine Cuisses +1", augments = {"Accuracy+20", "Attack+12", '"Dual Wield"+6'}}

	--Chironic
	Chiro.Legs = {}
	Chiro.Legs.MACC = "Chironic Hose"

	Jhakri = {
		Head = "Jhakri Coronal +2",
		Body = "Jhakri Robe +2",
		Hands = "Jhakri Cuffs +2",
		Legs = "Jhakri Slops +2",
		Feet = "Jhakri Pigaches +2",
		Ring1 = "Jhakri Ring"
	}

	-- Capes:
	-- Sucellos's And such, add your own.
	RDMCape = {}
	RDMCape.TP = {
		name = "Sucellos's Cape",
		augments = {"DEX+20", "Accuracy+20 Attack+20", "Accuracy+10", '"Store TP"+10', "Phys. dmg. taken-10%"}
	}
	RDMCape.DW = {
		name = "Sucellos's Cape",
		augments = {"DEX+20", "Accuracy+20 Attack+20", "Accuracy+10", '"Dual Wield"+10', "Phys. dmg. taken-10%"}
	}
	RDMCape.MACC = {
		name = "Sucellos's Cape",
		augments = {"MND+20", "Mag. Acc+20 /Mag. Dmg.+20", "MND+10", '"Cure" potency +10%', "Phys. dmg. taken-10%"}
	}
	RDMCape.FC = {
		name = "Sucellos's Cape",
		augments = {"INT+20", "Mag. Acc+20 /Mag. Dmg.+20", "INT+10", '"Fast Cast"+10', "Phys. dmg. taken-10%"}
	}
	RDMCape.STRWSD = {
		name = "Sucellos's Cape",
		augments = {"STR+20", "Accuracy+20 Attack+20", "STR+10", "Weapon skill damage +10%", "Phys. dmg. taken-10%"}
	}
	RDMCape.DEXWSD = {
		name = "Sucellos's Cape",
		augments = {"DEX+20", "Accuracy+20 Attack+20", "DEX+10", "Weapon skill damage +10%", "Phys. dmg. taken-10%"}
	}

	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	sets.enmity = {
		head = "Halitus Helm",
		hands = "Merlinic Dastanas",
		back = "Agema Cape",
		neck = "Warder's Charm +1",
		ring1 = "Petrov Ring",
		ring2 = "Provocare Ring"
	}

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA["Chainspell"] = {body = RELIC.Body}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz["Healing Waltz"] = {}

	sets.precast.RA = {}

	-- Fast cast sets for spells

	sets.precast.FC = {
		neck = "Loricate Torque +1",
		head = AF.Head, -- 16
		body = RELIC.Body, -- 15
		hands = sets.Nyame.Hands,
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet,
		waist = "Plat. Mog. Belt",
		left_ear = "Malignance Earring", -- 4
		right_ear = "Leth. Earring +1", -- 8
		left_ring = "Defending Ring",
		right_ring = "Kishar Ring", -- 4
		back = "Perimede Cape",
		ammo = "Staunch Tathlum +1",
		range = empty
		--Total: 47 gear + 38 job
	}

	-- Curing Precast, Cure Spell Casting time -
	sets.precast.FC.Cure =
		set_combine(
		sets.precast.FC,
		{
			right_ear = "Mendi. Earring",
			waist = "Plat. Mog. Belt"
			--Total: 44 gear + 38 job
		}
	)
	sets.precast.FC.Impact =
		set_combine(
		sets.precast.FC,
		{
			head = empty,
			body = "Crepuscular Cloak"
		}
	)
	sets.precast.FC.Dispelga =
		set_combine(
		sets.precast.FC,
		{
			main = "Daybreak",
			sub = "Ammurapi Shield"
		}
	)

	-- Absorb TP set- Haste 25% and FC 42 Gear + 38 Job Traits = 80%
	sets.precast.FC.Absorb = {
		main = "Maxentius",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = AF.Head, -- 16 FC
		body = EMPY.Body,
		hands = EMPY.Hands,
		legs = EMPY.Legs,
		feet = EMPY.Feet,
		neck = "Null Loop",
		waist = "Null Belt",
		left_ear = "Malignance Earring", -- 4 FC
		right_ear = "Leth. Earring +1", -- 8 FC
		left_ring = {name = "Metamor. Ring +1", augments = {"Path: A"}},
		right_ring = "Kishar Ring", -- 4 FC
		back = RDMCape.FC -- 10 FC
	}

	sets.precast.FC.Stun = set_combine(sets.precast.FC.Absorb)

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head = sets.Nyame.Head,
		ammo = "Oshasha's Treatise",
		neck = "Rep. Plat. Medal",
		body = sets.Nyame.Body,
		hands = sets.Nyame.Hands,
		legs = sets.Nyame.Legs,
		feet = EMPY.Feet,
		waist = "Sailfi Belt +1",
		left_ear = "Ishvara Earring",
		right_ear = {name = "Moonshade Earring", augments = {"Accuracy+4", "TP Bonus +250"}},
		left_ring = "Epaminondas's Ring",
		right_ring = "Karieyh Ring",
		back = RDMCape.STRWSD
	}

	sets.precast.WS.Proc = {
		range = empty,
		ammo = "Hasty Pinion +1",
		head = sets.Malignance.Head,
		neck = "Combatant's Torque",
		ear1 = "Mache Earring +1",
		ear2 = "Telos Earring",
		body = sets.Malignance.Body,
		hands = sets.Malignance.Hands,
		ring1 = "Ramuh Ring +1",
		ring2 = "Ramuh Ring +1",
		back = RDMCape.TP,
		waist = "Olseni Belt",
		legs = sets.Malignance.Legs,
		feet = sets.Malignance.Feet
	}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Requiescat"] = set_combine(sets.precast.WS, {})

	sets.precast.WS["Chant Du Cygne"] =
		set_combine(
		sets.precast.WS,
		{
			range = empty,
			ammo = "Coiste Bodhar",
			head = sets.Malignance.Head,
			neck = "Fotia Gorget",
			body = EMPY.Body,
			ear1 = "Sherida Earring",
			ear2 = "Leth. Earring +1",
			hands = sets.Malignance.Hands,
			-- ring1 = "Begrudging Ring",
			ring1 = "Karieyh Ring",
			ring2 = "Ilabrat Ring",
			back = RDMCape.STRWSD,
			waist = "Fotia Belt"
		}
	)
	sets.precast.WS["Evisceration"] = sets.precast.WS["Chant Du Cygne"]

	sets.precast.WS["Ruthless Stroke"] =
		set_combine(
		sets.precast.WS,
		{
			waist = {name = "Kentarch Belt +1", augments = {"Path: A"}},
			ammo = "Crepuscular Pebble",
			back = RDMCape.DEXWSD
		}
	)

	sets.precast.WS["Savage Blade"] =
		set_combine(
		sets.precast.WS,
		{
			right_ring = "Sroda Ring"
		}
	)

	sets.precast.WS["Fast Blade II"] =
		set_combine(
		sets.precast.WS,
		{
			neck = "Fotia Gorget",
			ammo = "Coiste Bodhar",
			ear1 = "Sherida Earring",
			ear2 = "Leth. Earring +1",
			waist = "Fotia Belt",
			back = RDMCape.DEXWSD
		}
	)

	sets.precast.WS["Black Halo"] = set_combine(sets.precast.WS["Savage Blade"], {})

	sets.precast.WS["Black Halo"].Acc =
		set_combine(
		sets.precast.WS["Black Halo"],
		{
			right_ear = "Dominance Earring +1"
		}
	)

	sets.precast.WS["Sanguine Blade"] =
		set_combine(
		sets.precast.WS,
		{
			ammo = {name = "Ghastly Tathlum +1", augments = {"Path: A"}},
			head = "Pixie Hairpin +1",
			neck = "Sibyl Scarf",
			hands = "Jhakri Cuffs +2",
			feet = EMPY.Feet,
			right_ear = "Malignance Earring",
			right_ring = "Archon Ring",
			waist = "Orpheus's Sash",
			back = RDMCape.STRWSD
		}
	)

	sets.precast.WS["Seraph Blade"] =
		set_combine(
		sets.precast.WS,
		{
			ammo = {name = "Ghastly Tathlum +1", augments = {"Path: A"}},
			neck = "Sibyl Scarf",
			hands = "Jhakri Cuffs +2",
			feet = EMPY.Feet,
			right_ear = "Malignance Earring",
			waist = "Orpheus's Sash",
			back = RDMCape.STRWSD
		}
	)

	sets.precast.WS["Red Lotus Blade"] =
		set_combine(
		sets.precast.WS,
		{
			ammo = {name = "Ghastly Tathlum +1", augments = {"Path: A"}},
			neck = "Sibyl Scarf",
			hands = "Jhakri Cuffs +2",
			feet = EMPY.Feet,
			right_ear = "Malignance Earring",
			waist = "Orpheus's Sash",
			back = RDMCape.STRWSD
		}
	)

	sets.precast.WS["Aeolian Edge"] =
		set_combine(
		sets.precast.WS,
		{
			ammo = {name = "Ghastly Tathlum +1", augments = {"Path: A"}},
			neck = "Sibyl Scarf",
			hands = "Jhakri Cuffs +2",
			feet = EMPY.Feet,
			right_ear = "Malignance Earring",
			waist = "Orpheus's Sash",
			back = RDMCape.STRWSD
		}
	)

	-- Midcast Sets

	-- Gear that converts elemental damage done to recover MP.
	sets.RecoverMP = {body = "Seidr Cotehardie"}

	-- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
	sets.midcast.Casting = {
		neck = "Dls. Torque +2",
		back = RDMCape.MACC,
		body = EMPY.Body,
		head = EMPY.Head,
		hands = EMPY.Hands,
		legs = EMPY.Legs,
		feet = EMPY.Feet,
		left_ear = "Malignance Earring",
		right_ear = "Snotra Earring",
		waist = "Null Belt",
		ammo = "Regal Gem",
		left_ring = {name = "Metamor. Ring +1", augments = {"Path: A"}},
		right_ring = "Freke Ring"
		-- left_ear	=	"Friomisi Earring",
		-- right_ear	=	"Enchntr. Earring +1",
	}

	sets.midcast.FastRecast = {
		main = gear.grioavolr_fc_staff,
		sub = "Clerisy Strap +1",
		-- ammo = "Hasty Pinion +1",
		head = AF.Head,
		neck = "Baetyl Pendant",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Malignance Earring",
		body = "Zendik Robe",
		hands = "Gende. Gages +1",
		ring1 = "Prolix Ring",
		ring2 = "Kishar Ring",
		back = RDMCape.FC,
		waist = "Witful Belt",
		legs = "Psycloth Lappas",
		feet = "Medium's Sabots"
	}

	sets.midcast.Absorb = {
		ammo = "Regal Gem",
		head = AF.Head, -- 16
		body = RELIC.Body, -- 15
		hands = EMPY.Hands,
		legs = EMPY.Legs,
		feet = EMPY.Feet,
		neck = "Null Loop",
		waist = "Sailfi Belt +1",
		left_ear = "Regal Earring",
		right_ear = "Leth. Earring +1", -- 8
		left_ring = {name = "Metamor. Ring +1", augments = {"Path: A"}},
		right_ring = {name = "Stikini Ring +1", bag = "wardrobe2"},
		back = RDMCape.FC -- 10
	}

	sets.midcast.Cure =
		set_combine(
		sets.midcast.Casting,
		{
			ammo = "Pemphredo Tathlum",
			main = "Sakpata's Sword",
			sub = "Sacro Bulwark",
			head = "Kaykaus Mitra +1",
			body = "Kaykaus Bliaut +1",
			hands = "Kaykaus Cuffs +1",
			legs = "Kaykaus Tights +1",
			feet = "Kaykaus Boots +1",
			neck = "Loricate Torque +1",
			waist = "Shinjutsu no-Obi +1",
			left_ear = "Mendi. Earring",
			right_ear = "Meili Earring",
			left_ring = {name = "Stikini Ring +1", bag = "wardrobe1"},
			right_ring = "Mephitas's Ring +1",
			back = RDMCape.MACC
		}
	)

	sets.midcast.LightWeatherCure = {
		ammo = "Pemphredo Tathlum",
		main = "Sakpata's Sword",
		sub = "Sacro Bulwark",
		head = "Kaykaus Mitra +1",
		body = "Kaykaus Bliaut +1",
		hands = "Kaykaus Cuffs +1",
		legs = "Kaykaus Tights +1",
		feet = "Kaykaus Boots +1",
		neck = "Loricate Torque +1",
		waist = "Hachirin-no-Obi",
		left_ear = "Mendi. Earring",
		right_ear = "Meili Earring",
		left_ring = {name = "Stikini Ring +1", bag = "wardrobe1"},
		right_ring = "Mephitas's Ring +1",
		back = RDMCape.MACC
	}

	--Cureset for if it's not light weather but is light day.
	sets.midcast.LightDayCure = {
		ammo = "Pemphredo Tathlum",
		main = "Sakpata's Sword",
		sub = "Sacro Bulwark",
		head = "Kaykaus Mitra +1",
		body = "Kaykaus Bliaut +1",
		hands = "Kaykaus Cuffs +1",
		legs = "Kaykaus Tights +1",
		feet = "Kaykaus Boots +1",
		neck = "Loricate Torque +1",
		waist = "Hachirin-no-Obi",
		left_ear = "Mendi. Earring",
		right_ear = "Meili Earring",
		left_ring = {name = "Stikini Ring +1", bag = "wardrobe1"},
		right_ring = "Mephitas's Ring +1",
		back = RDMCape.MACC
	}

	sets.midcast.Cursna = {
		main = gear.grioavolr_fc_staff,
		sub = "Curatio Grip",
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

	sets.midcast.StatusRemoval =
		set_combine(
		sets.midcast.FastRecast,
		{
			main = gear.grioavolr_fc_staff,
			sub = "Clemency Grip"
		}
	)

	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {
		neck = "Phalaina Locket",
		ear1 = "Etiolation Earring",
		ring2 = "Kunaji Ring",
		waist = "Gishdubar Sash"
	}
	sets.Cure_Received = {
		neck = "Phalaina Locket",
		ring2 = "Kunaji Ring",
		waist = "Gishdubar Sash"
	}
	sets.Self_Refresh = {back = "Grapevine Cape", waist = "Gishdubar Sash"}

	sets.Phalanx_Received = {
		main = "Sakpata's Sword",
		head = gear.taeon_phalanx_head,
		body = gear.taeon_phalanx_body,
		hands = gear.taeon_phalanx_hands,
		legs = gear.taeon_phalanx_legs,
		feet = gear.taeon_phalanx_feet
	}

	sets.Self_Phalanx = {
		main = "Sakpata's Sword",
		sub = " Ammurapi Shield",
		ammo = "Sapience Orb",
		head = gear.taeon_phalanx_head,
		body = gear.taeon_phalanx_body,
		hands = gear.taeon_phalanx_hands,
		legs = gear.taeon_phalanx_legs,
		feet = gear.taeon_phalanx_feet,
		neck = {name = "Dls. Torque +2", augments = {"Path: A"}},
		waist = "Embla Sash",
		left_ear = "Malignance Earring",
		right_ear = "Leth. Earring +1",
		ring1 = {name = "Stikini Ring +1", bag = "wardrobe1"},
		ring2 = {name = "Stikini Ring +1", bag = "wardrobe2"},
		back = "Ghostfyre Cape"
	}

	sets.midcast["Enhancing Magic"] = {
		main = "Colada",
		sub = "Ammurapi Shield",
		ammo = "Sapience Orb",
		head = {name = "Telchine Cap", augments = {'"Regen"+2', "Enh. Mag. eff. dur. +10"}},
		neck = "Dls. Torque +2",
		ear1 = "Andoaa Earring",
		ear2 = "Leth. Earring +1",
		body = RELIC.Body,
		hands = AF.Hands,
		ring1 = {name = "Stikini Ring +1", bag = "wardrobe2"},
		ring2 = "Lehko's Ring",
		back = "Ghostfyre Cape",
		waist = "Embla Sash",
		legs = {name = "Telchine Braconi", augments = {'"Regen"+2', "Enh. Mag. eff. dur. +10"}},
		feet = EMPY.Feet
	}

	sets.midcast.Phalanx =
		set_combine(
		sets.midcast["Enhancing Magic"],
		{
			main = "Sakpata's Sword",
			sub = " Ammurapi Shield",
			head = gear.taeon_phalanx_head,
			body = gear.taeon_phalanx_body,
			hands = gear.taeon_phalanx_hands,
			legs = gear.taeon_phalanx_legs,
			feet = gear.taeon_phalanx_feet
		}
	)

	--Atrophy Gloves are better than Lethargy for me despite the set bonus for duration on others.
	sets.buff.ComposureOther = {
		head = EMPY.Head,
		body = EMPY.Body,
		hands = AF.Hands,
		legs = EMPY.Legs,
		feet = EMPY.Feet
	}

	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.EnhancingSkill = {
		main = "Pukulatmuj +1",
		sub = "Forfend +1",
		head = "Befouled Crown",
		neck = "Incanter's Torque",
		hands = RELIC.Hands,
		legs = AF.Legs,
		ear1 = "Andoaa Earring",
		ear2 = "Mimir Earring",
		ring1 = {name = "Stikini Ring +1", bag = "wardrobe1"},
		ring2 = {name = "Stikini Ring +1", bag = "wardrobe2"},
		waist = "Olympus Sash",
		back = "Ghostfyre Cape"
	}
	sets.midcast.Refresh = {head = "Amalric Coif +1", body = AF.Body, legs = EMPY.Legs}
	sets.midcast.Regen = {
		main = "Bolelabunga",
		feet = "Bunzi's Sabots"
	}
	sets.midcast.Aquaveil = {
		head = "Amalric Coif +1",
		hands = "Regal Cuffs",
		waist = "Emphatikos Rope",
		legs = "Shedir Seraweels"
	}
	sets.midcast.BarElement = {
		neck = "Sroda Necklace",
		legs = "Shedir Seraweels"
	}
	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Temper.DW = set_combine(sets.midcast.Temper, {})
	sets.midcast.Enspell = sets.midcast.Temper
	sets.midcast.Enspell.DW = set_combine(sets.midcast.Enspell, {})
	sets.midcast.BoostStat = {hands = AF.Hands}
	sets.midcast.Stoneskin = {
		neck = "Nodens Gorget",
		ear2 = "Earthcry Earring",
		waist = "Siegel Sash",
		legs = "Shedir Seraweels"
	}
	sets.midcast.Protect = {ring2 = "Sheltered Ring"}
	sets.midcast.Shell = {ring2 = "Sheltered Ring"}

	sets.midcast["Enfeebling Magic"] = {
		main = "Murgleis",
		sub = "Ammurapi Shield",
		ring1 = {name = "Stikini Ring +1", bag = "wardrobe2"},
		ring2 = "Kishar Ring",
		ammo = "Regal Gem",
		range = empty,
		neck = "Dls. Torque +2",
		head = RELIC.Head,
		body = EMPY.Body,
		hands = "Regal Cuffs",
		legs = "Chironic Hose",
		feet = RELIC.Feet,
		waist = "Obstinate Sash",
		left_ear = "Snotra Earring",
		right_ear = "Malignance Earring",
		back = "Null Shawl"
	}

	sets.midcast["Enfeebling Magic"].Resistant =
		set_combine(
		sets.midcast["Enfeebling Magic"],
		{
			main = "Daybreak",
			sub = "Ammurapi Shield",
			head = AF.Head,
			neck = "Null Loop",
			ear1 = "Regal Earring",
			hands = EMPY.Hands,
			waist = "Null Belt",
			ring1 = "Metamor. Ring +1",
			ring2 = {name = "Stikini Ring +1", bag = "wardrobe2"}
		}
	)

	sets.midcast.DurationOnlyEnfeebling =
		set_combine(
		sets.midcast["Enfeebling Magic"],
		{
			main = "Bunzi's Rod",
			sub = "Ammurapi Shield",
			hands = "Regal Cuffs",
			body = EMPY.Body,
			left_ear = "Snotra Earring",
			ring2 = "Kishar Ring",
			waist = "Obstinate Sash",
			feet = EMPY.Feet
		}
	)

	sets.midcast.Silence = sets.midcast.DurationOnlyEnfeebling
	sets.midcast.Silence.Resistant = sets.midcast["Enfeebling Magic"].Resistant
	sets.midcast.Sleep = set_combine(sets.midcast.DurationOnlyEnfeebling, {waist = "Acuity Belt +1"})
	sets.midcast.Sleep.Resistant = set_combine(sets.midcast["Enfeebling Magic"].Resistant, {waist = "Acuity Belt +1"})
	sets.midcast.Bind = set_combine(sets.midcast.DurationOnlyEnfeebling, {waist = "Acuity Belt +1"})
	sets.midcast.Bind.Resistant = set_combine(sets.midcast["Enfeebling Magic"].Resistant, {waist = "Acuity Belt +1"})
	sets.midcast.Break = set_combine(sets.midcast.DurationOnlyEnfeebling, {waist = "Acuity Belt +1"})
	sets.midcast.Break.Resistant = set_combine(sets.midcast["Enfeebling Magic"].Resistant, {waist = "Acuity Belt +1"})
	sets.midcast.Foil = sets.enmity
	sets.midcast.Flash = sets.enmity

	sets.midcast.Dispel = set_combine(sets.midcast["Enfeebling Magic"].Resistant, {
		neck = "Dls. Torque +2",
	})

	sets.midcast.SkillBasedEnfeebling =
		set_combine(
		sets.midcast["Enfeebling Magic"],
		{
			ear1 = "Regal Earring",
			ear2 = "Vor Earring",
			hands = EMPY.Hands,
			body = AF.Body,
			waist = "Obstin. Sash",
			ring1 = {name = "Stikini Ring +1", bag = "wardrobe1"},
			ring2 = {name = "Stikini Ring +1", bag = "wardrobe2"}
		}
	)

	sets.midcast["Frazzle II"] =
		set_combine(
		sets.midcast["Enfeebling Magic"].Resistant,
		{
			neck = "Null Loop"
		}
	)
	sets.midcast["Frazzle III"] =
		set_combine(
		sets.midcast.SkillBasedEnfeebling,
		{
			ear1 = "Snotra Earring",
			ring1 = "Kishar Ring",
			body = EMPY.Body,
			hands = EMPY.Hands,
			legs = EMPY.Legs
		}
	)
	sets.midcast["Frazzle III"].Resistant = sets.midcast["Enfeebling Magic"].Resistant

	sets.midcast["Distract III"] = sets.midcast.SkillBasedEnfeebling
	sets.midcast["Distract III"].Resistant = sets.midcast["Enfeebling Magic"].Resistant

	sets.midcast["Divine Magic"] = set_combine(sets.midcast["Enfeebling Magic"].Resistant, {})

	sets.midcast.Dia =
		set_combine(
		sets.midcast["Enfeebling Magic"],
		{
			waist = "Obstinate Sash"
		}
	)
	sets.midcast.Diaga = sets.midcast.Dia

	sets.midcast.Bio = set_combine(sets.midcast["Enfeebling Magic"], sets.TreasureHunter)

	sets.midcast["Elemental Magic"] = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		ammo = {name = "Ghastly Tathlum +1", augments = {"Path: A"}},
		head = EMPY.Head,
		body = EMPY.Body,
		hands = EMPY.Hands,
		legs = EMPY.Legs,
		feet = EMPY.Feet,
		neck = "Sibyl Scarf",
		waist = "Sacro Cord",
		left_ear = "Malignance Earring",
		right_ear = "Regal Earring",
		left_ring = {name = "Metamor. Ring +1", augments = {"Path: A"}},
		right_ring = "Freke Ring",
		back = RDMCape.FC
	}

	sets.midcast["Elemental Magic"].Resistant = set_combine(sets.midcast["Elemental Magic"], {})
	sets.midcast["Elemental Magic"].Fodder = set_combine(sets.midcast["Elemental Magic"], {})

	sets.midcast["Elemental Magic"].Proc = {
		main = empty,
		sub = empty,
		range = empty,
		ammo = "Impatiens",
		head = "Vanya Hood",
		neck = "Baetyl Pendant",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Loquac. Earring",
		body = "Zendik Robe",
		hands = "Gende. Gages +1",
		ring1 = "Prolix Ring",
		ring2 = "Kishar Ring",
		back = "Swith Cape +1",
		waist = "Witful Belt",
		legs = "Psycloth Lappas",
		feet = "Regal Pumps +1"
	}

	sets.midcast["Blizzard V"] = sets.midcast["Elemental Magic"]
	sets.midcast["Thunder V"] = sets.midcast["Elemental Magic"]

	sets.midcast["Elemental Magic"].HighTierNuke =
		set_combine(
		sets.midcast["Elemental Magic"],
		{head = gear.merlinic_nuke_head, ammo = "Pemphredo Tathlum", ear1 = "Regal Earring", ring1 = "Metamor. Ring +1"}
	)
	sets.midcast["Elemental Magic"].HighTierNuke.Resistant =
		set_combine(
		sets.midcast["Elemental Magic"].Resistant,
		{head = gear.merlinic_nuke_head, ear1 = "Regal Earring", ring1 = "Metamor. Ring +1"}
	)
	sets.midcast["Elemental Magic"].HighTierNuke.Fodder =
		set_combine(
		sets.midcast["Elemental Magic"].Fodder,
		{head = gear.merlinic_nuke_head, ammo = "Pemphredo Tathlum", ear1 = "Regal Earring", ring1 = "Metamor. Ring +1"}
	)

	-- Gear for Magic Burst mode.
	sets.MagicBurst =
		set_combine(
		sets.midcast["Elemental Magic"],
		{
			main = "Bunzi's Rod",
			shield = "Ammurapi Shield",
			head = "Ea Hat +1",
			hands = "Bunzi's Gloves",
			body = "Ea Houppe. +1",
			ammo = "Ghastly Tathlum +1",
			feet = EMPY.Feet
		}
	)

	sets.midcast.Impact =
		set_combine(
		sets.midcast["Elemental Magic"],
		{
			-- range = "Ullr",
			-- ammo = empty,
			head = empty,
			body = "Crepuscular Cloak",
			hands = EMPY.Hands,
			legs = EMPY.Legs,
			feet = EMPY.Feet,
			neck = "Dls. Torque +2",
			back = "Aurist's Cape +1",
			ring1 = "Metamor. Ring +1",
			ring2 = {name = "Stikini Ring +1", bag = "wardrobe2"}
		}
	)

	sets.midcast.Impact.OccultAcumen =
		set_combine(
		sets.midcast.Impact,
		{
			main = "Maxentius",
			sub = "Ammurapi Shield",
			ammo = "Aurgelmir Orb +1",
			body = "Crepuscular Cloak",
			hands = {name = "Merlinic Dastanas", augments = {'"Occult Acumen"+11', "INT+9"}},
			legs = "Perdition Slops",
			feet = {name = "Merlinic Crackows", augments = {'"Occult Acumen"+11', "MND+9"}},
			neck = "Anu Torque",
			waist = "Oneiros Rope",
			left_ear = "Sherida Earring",
			right_ear = "Dedition Earring",
			left_ring = "Chirich Ring +1",
			right_ring = "Chirich Ring +1",
			back = RDMCape.TP
		}
	)

	sets.midcast["Blizzard V"].OccultAcumen = {
		sub = "Ammurapi Shield",
		ammo = "Aurgelmir Orb +1",
		head = {name = "Merlinic Hood", augments = {'"Mag.Atk.Bns."+19', '"Occult Acumen"+11', "VIT+7", "Mag. Acc.+14"}},
		body = {name = "Merlinic Jubbah", augments = {'"Occult Acumen"+11', "INT+9"}},
		hands = {name = "Merlinic Dastanas", augments = {'"Occult Acumen"+11', "INT+9"}},
		legs = "Perdition Slops",
		feet = {name = "Merlinic Crackows", augments = {'"Occult Acumen"+11', "MND+9"}},
		neck = "Anu Torque",
		waist = "Oneiros Rope",
		left_ear = "Sherida Earring",
		right_ear = "Dedition Earring",
		left_ring = "Chirich Ring +1",
		right_ring = "Chirich Ring +1",
		back = RDMCape.TP
	}
	sets.midcast["Thunder V"].OccultAcumen = sets.midcast["Blizzard V"].OccultAcumen

	sets.midcast["Dark Magic"] =
		set_combine(
		sets.midcast["Enfeebling Magic"].Resistant,
		{
			main = "Rubicundity",
			sub = "Ammurapi Shield",
			neck = "Erra Pendant",
			ear1 = "Regal Earring",
			ear2 = "Malignance Earring",
			back = RDMCape.FC
		}
	)

	sets.midcast.Drain =
		set_combine(
		sets.midcast["Dark Magic"],
		{
			main = "Rubicundity",
			sub = "Ammurapi Shield",
			ammo = "Regal Gem",
			head = "Pixie Hairpin +1",
			ring1 = "Evanescence Ring",
			ring2 = "Archon Ring",
			waist = "Fucho-no-obi",
			feet = "Merlinic Crackows"
		}
	)

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun =
		set_combine(
		sets.midcast["Dark Magic"],
		{
			main = "Bunzi's Rod",
			sub = "Ammurapi Shield"
			-- ammo = empty,
			-- head = AF.Head,
			-- body = "Zendik Robe",
			-- hands = "Volte Gloves",
			-- ring1 = "Metamor. Ring +1",
			-- ring2 = "Stikini Ring +1",
			-- back = gear.nuke_jse_back,
			-- legs = "Chironic Hose",
		}
	)

	sets.midcast.Stun.Resistant =
		set_combine(
		sets.midcast.Stun,
		{
			main = "Bunzi's Rod",
			sub = "Ammurapi Shield",
			head = AF.Head,
			body = AF.Body,
			hands = "Volte Gloves"
		}
	)

	-- Sets for special buff conditions on spells.

	sets.buff.Saboteur = {hands = EMPY.Hands}

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
		-- ammo = "Hasty Pinion +1",
		head = "Gende. Caubeen +1",
		neck = "Unmoving Collar +1",
		ear1 = "Gifted Earring",
		ear2 = "Mendi. Earring",
		body = RELIC.Body,
		hands = "Kaykaus Cuffs +1",
		ring1 = "Gelatinous Ring +1",
		ring2 = "Meridian Ring",
		back = "Moonlight Cape",
		waist = "Luminary Sash",
		legs = "Carmine Cuisses +1",
		feet = "Kaykaus Boots +1"
	}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {
		main = "Chatoyant Staff",
		sub = "Oneiros Grip",
		range = empty,
		ammo = "Homiliary",
		head = RELIC.Head,
		neck = "Loricate Torque +1",
		ear1 = "Etiolation Earring",
		ear2 = "Ethereal Earring",
		body = "Jhakri Robe +2",
		hands = gear.merlinic_refresh_hands,
		ring1 = "Defending Ring",
		ring2 = "Sheltered Ring",
		back = RDMCape.TP,
		waist = "Flume Belt +1",
		legs = "Lengo Pants",
		feet = gear.chironic_refresh_feet
	}

	-- Idle sets
	sets.idle = {
		ammo = "Homiliary",
		head = RELIC.Head,
		neck = "Null Loop",
		body = EMPY.Body,
		hands = sets.VolteSandoria.Hands,
		legs = sets.VolteSandoria.Legs,
		feet = sets.VolteSandoria.Feet,
		waist = "Null Belt",
		left_ear = "Etiolation Earring",
		right_ear = "Ethereal Earring",
		left_ring = "Defending Ring",
		right_ring = {name = "Stikini Ring +1", bag = "wardrobe2"},
		back = RDMCape.TP
	}

	sets.idle.Aminon =
		set_combine(
		sets.idle,
		{
			ammo = "Aurgelmir Orb +1",
			head = {name = "Bunzi's Hat", augments = {"Path: A"}},
			body = "Volte Harness",
			hands = "Malignance Gloves",
			legs = "Malignance Tights",
			feet = "Malignance Boots",
			neck = "Rep. Plat. Medal",
			waist = "Goading Belt",
			left_ear = "Sherida Earring",
			right_ear = "Dedition Earring",
			left_ring = "Roller's Ring",
			right_ring = "Lehko's Ring",
			back = RDMCape.TP
		}
	)

	sets.idle.Town = {
		main = "Mpu Gandring",
		sub = "Kraken Club",
		head = "Null Masque",
		hands = sets.Nyame.Hands,
		body = sets.Nyame.Body,
		legs = sets.Nyame.Legs,
		feet = sets.Nyame.Feet,
		waist = "Orpheus's Sash"
	}

	sets.idle.PDT =
		set_combine(
		sets.idle,
		{
			head = sets.Nyame.Head,
			hands = sets.Nyame.Hands,
			body = sets.Nyame.Body,
			legs = sets.Nyame.Legs,
			feet = sets.Nyame.Feet
		}
	)

	sets.idle.MDT = set_combine(sets.idle.PDT)

	sets.idle.Weak = set_combine(sets.idle.PDT, {})

	sets.idle.DTHippo =
		set_combine(
		sets.idle.PDT,
		{
			legs = "Carmine Cuisses +1",
			feet = "Hippo. Socks +1"
		}
	)

	-- Defense sets
	sets.defense.PDT = {
		back = "Agema Cape",
		head = sets.Malignance.Head,
		hands = sets.Malignance.Hands,
		body = sets.Malignance.Body,
		waist = "Plat. Mog. Belt",
		legs = sets.Malignance.Legs,
		feet = sets.Malignance.Feet,
		left_ring = "Gelatinous Ring +1",
		right_ring = "Defending Ring"
	}

	sets.defense.NukeLock = sets.midcast["Elemental Magic"]

	sets.defense.MDT =
		set_combine(
		sets.defense.PDT,
		{
			ear1 = "Odnowa Earring +1"
		}
	)
	sets.defense.MEVA = set_combine(sets.defense.MDT, {})

	sets.Kiting = {legs = "Carmine Cuisses +1", ring1 = "Karieyh Ring"}
	sets.latent_refresh = {waist = "Fucho-no-obi"}
	sets.latent_refresh_grip = {sub = "Oneiros Grip"}
	sets.TPEat = {neck = "Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Weapons sets
	sets.weapons.Mpu = {main = "Mpu Gandring", sub = "Ammurapi Shield", range = empty}
	sets.weapons.Murgleis = {main = "Murgleis", sub = "Ammurapi Shield", range = empty}
	sets.weapons.Naegling = {main = "Naegling", sub = "Ammurapi Shield", range = empty}
	sets.weapons.Onion = {main = "Onion Sword III", sub = "Ammurapi Shield", range = empty}
	sets.weapons.Bow = {main = "Naegling", sub = "Sacro Bulwark", range = "Ullr", ammo = "Beetle Arrow"}
	sets.weapons.DualMpu = {main = "Mpu Gandring", sub = "Thibron", range = empty}
	sets.weapons.DualOnion = {main = "Onion Sword III", sub = "Kraken Club", range = empty}
	sets.weapons.DualWeapons = {main = "Naegling", sub = "Thibron", range = empty}
	-- sets.weapons.DualWeaponsAcc = { main = "Naegling", sub = "Almace", range = empty }
	sets.weapons.DualWeaponsAcc = {main = "Naegling", sub = "Ternion Dagger +1", range = empty}
	-- sets.weapons.DualEvisceration = { main = "Tauret", sub = "Almace", range = empty }
	sets.weapons.DualClubs = {main = "Maxentius", sub = "Thibron", range = empty}
	sets.weapons.DualEvisceration = {main = "Tauret", sub = "Ternion Dagger +1", range = empty}
	sets.weapons.DualAeolian = {main = "Tauret", sub = "Daybreak", range = empty}
	sets.weapons.Tauret = {main = "Tauret", sub = "Ammurapi Shield"}
	sets.weapons.Club = {main = "Maxentius", sub = "Forfend +1"}
	sets.weapons.EnspellOnly = {main = "Hedron Dagger", sub = "Qutrub Knife", range = empty}
	sets.weapons.Enspell = {main = "Crocea Mors", sub = "Ammurapi Shield", range = empty}
	sets.weapons.EnspellDW = {main = "Crocea Mors", sub = "Crepuscular Knife", range = empty}
	sets.weapons.DualSeraph = {main = "Crocea Mors", sub = "Daybreak", range = empty}
	sets.weapons.DualAlmace = {main = "Almace", sub = "Sequence", range = empty}
	sets.weapons.DualBow = {main = "Naegling", sub = "Thibron", range = "Ullr", ammo = "Chapuli Arrow"}
	sets.weapons.BowMacc = {main = "Naegling", sub = "Tauret", range = "Ullr", ammo = empty}

	sets.buff.Sublimation = {waist = "Embla Sash"}
	sets.buff.DTSublimation = {waist = "Embla Sash"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {
		-- 	sub  Crepuscular Knife
		--  ranged  Empty
		--    legs  Malignance Tights
		--   waist  Windbuffet Belt +1
		--   ring1  Chirich Ring +1 A
		--   ring2  Chirich Ring +1 B
		--    back  Sucellos's Cape DEX Dual Wield
		ammo = "Aurgelmir Orb +1",
		range = empty,
		head = "Bunzi's Hat",
		hands = sets.Malignance.Hands,
		body = sets.Malignance.Body,
		left_ring = "Chirich Ring +1",
		right_ring = "Lehko's Ring",
		legs = sets.Malignance.Legs,
		feet = sets.Malignance.Feet,
		neck = "Anu Torque",
		waist = "Sailfi Belt +1",
		left_ear = "Sherida Earring",
		right_ear = "Dedition Earring",
		back = RDMCape.TP
	}

	sets.engaged.Subtle =
		set_combine(
		sets.engaged,
		{
			left_ear = "Sherida Earring",
			left_ring = "Apate Ring"
		}
	)

	sets.engaged.EnspellOnly =
		set_combine(
		sets.engaged,
		{
			head = sets.Malignance.Head,
			neck = "Dls. Torque +2",
			ammo = "Sroda Tathlum",
			ear1 = "Crep. Earring",
			ear2 = "Leth. Earring +1",
			body = EMPY.Body,
			hands = "Aya. Manopolas +2",
			ring1 = "Metamor. Ring +1",
			ring2 = "Lehko's Ring",
			waist = "Orpheus's Sash",
			back = RDMCape.DW,
			legs = sets.Malignance.Legs,
			feet = sets.Malignance.Feet
		}
	)

	sets.engaged.Enspell = set_combine(sets.engaged.EnspellOnly, {})

	sets.engaged.EnspellDW = set_combine(sets.engaged.EnspellOnly, {})

	sets.engaged.Acc =
		set_combine(
		sets.engaged,
		{
			neck = "Null Loop",
			waist = "Null Belt",
			right_ear = "Leth. Earring +1"
		}
	)

	sets.engaged.FullAcc = set_combine(sets.Acc, {})

	sets.engaged.DT =
		set_combine(
		sets.engaged,
		{
			neck = "Loricate Torque +1"
		}
	)

	sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.DT)

	sets.engaged.FullAcc.DT = set_combine(sets.engaged.FullAcc, sets.engaged.DT)

	sets.engaged.DW =
		set_combine(
		sets.engaged,
		{
			waist = "Reiki Yotai",
			ear2 = "Suppanomimi"
		}
	)
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})
	sets.engaged.DW.FullAcc = set_combine(sets.engaged.DW, {})
	sets.engaged.DW.DT =
		set_combine(
		sets.engaged.DW,
		{
			ring1 = "Defending Ring"
		}
	)
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == "DNC" then
		set_macro_page(1, 1)
	elseif player.sub_job == "NIN" then
		set_macro_page(1, 1)
	elseif player.sub_job == "BLM" then
		set_macro_page(1, 1)
	else
		set_macro_page(1, 1)
	end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if
			state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and
				(buffactive["Elvorseal"] or buffactive["Reive Mark"] or not player.in_combat)
		 then
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
	if buff:startswith("Addendum: ") or buff:endswith(" Arts") then
		style_lock = true
	end
end

function user_job_lockstyle()
	if player.sub_job == "NIN" or player.sub_job == "DNC" then
		if player.equipment.main == nil or player.equipment.main == "empty" then
			windower.chat.input("/lockstyleset 001")
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
				windower.chat.input("/lockstyleset 001")
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
				windower.chat.input("/lockstyleset 001")
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Sword/Club.
				windower.chat.input("/lockstyleset 001")
			else
				windower.chat.input("/lockstyleset 001") --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Dagger/Sword.
				windower.chat.input("/lockstyleset 001")
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
				windower.chat.input("/lockstyleset 001")
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Dagger/Club.
				windower.chat.input("/lockstyleset 001")
			else
				windower.chat.input("/lockstyleset 001") --Catchall
			end
		elseif res.items[item_name_to_id(player.equipment.main)].skill == 11 then --Club in main hand.
			if res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Club/Sword.
				windower.chat.input("/lockstyleset 001")
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Club/Dagger.
				windower.chat.input("/lockstyleset 001")
			elseif res.items[item_name_to_id(player.equipment.sub)].skill == 11 then --Club/Club.
				windower.chat.input("/lockstyleset 001")
			else
				windower.chat.input("/lockstyleset 001") --Catchall
			end
		end
	elseif player.sub_job == "WHM" or state.Buff["Light Arts"] or state.Buff["Addendum: White"] then
		windower.chat.input("/lockstyleset 001")
	elseif player.sub_job == "BLM" or state.Buff["Dark Arts"] or state.Buff["Addendum: Black"] then
		windower.chat.input("/lockstyleset 001")
	else
		windower.chat.input("/lockstyleset 001")
	end
end

autows_list = {
	["Naegling"] = "Savage Blade",
	["DualWeapons"] = "Savage Blade",
	["DualWeaponsAcc"] = "Savage Blade",
	["DualEvisceration"] = "Evisceration",
	["DualClubs"] = "Black Halo",
	["DualAeolian"] = "Aeolian Edge",
	["EnspellDW"] = "Sanguine Blade",
	["Club"] = "Black Halo"
}
