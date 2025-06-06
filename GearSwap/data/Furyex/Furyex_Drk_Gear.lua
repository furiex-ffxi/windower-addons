function user_job_setup()
	-- Options: Override default values
	state.OffenseMode:options("Normal", "Acc", "Crit", "Fodder", "Subtle")
	state.WeaponskillMode:options("Match", "Normal", "Acc", "Crit", "Fodder", "Subtle")
	state.HybridMode:options("Normal", "DT")
	state.PhysicalDefenseMode:options("PDT", "PDTReraise")
	state.MagicalDefenseMode:options("MDT", "MDTReraise")
	state.ResistDefenseMode:options("MEVA")
	state.IdleMode:options("Normal", "PDT", "Refresh", "Reraise")
	state.Weapons:options("Caladbolg", "Apocalypse", "Liberator", "Montante", "Anguta", "Lycurgos", "Loxotic")
	state.ExtraMeleeMode = M {["description"] = "Extra Melee Mode", "None"}
	state.Passive = M {["description"] = "Passive Mode", "None", "MP", "Twilight"}
	state.DrainSwapWeaponMode = M {"Always", "Never", "300", "1000"}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command("bind @` gs c cycle SkillchainMode")
	send_command("bind !f7 gs c cycle DrainSwapWeaponMode")

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	DRKCape = {}
	DRKCape.FC = {
		name = "Ankou's Mantle",
		augments = {"INT+20", "Mag. Acc+20 /Mag. Dmg.+20", "Mag. Acc.+10", '"Fast Cast"+10', "Phys. dmg. taken-10%"}
	}
	DRKCape.TP = {
		name = "Ankou's Mantle",
		augments = {"DEX+20", "Accuracy+20 Attack+20", "Accuracy+10", '"Dbl.Atk."+10', "Phys. dmg. taken-10%"}
	}
	DRKCape.STP = {
		name = "Ankou's Mantle",
		augments = {"DEX+20", "Accuracy+20 Attack+20", "Accuracy+10", '"Store TP"+10', "Phys. dmg. taken-10%"}
	}
	DRKCape.STR = {
		name = "Ankou's Mantle",
		augments = {"STR+20", "Accuracy+20 Attack+20", "STR+10", "Weapon skill damage +10%", "Phys. dmg. taken-10%"}
	}
	DRKCape.VIT = {
		name = "Ankou's Mantle",
		augments = {"VIT+20", "Accuracy+20 Attack+20", "VIT+10", "Weapon skill damage +10%", "Phys. dmg. taken-10%"}
	}

	gear.af = {
		Head = "Ig. Burgeonet +3",
		Body = "Ignominy Cuirass +3",
		Hands = "Ig. Gauntlets +3",
		Legs = "Ig. Flanchard +3",
		Feet = "Ig. Sollerets +3"
	}

	gear.relic = {
		Head = {name = "Fall. Burgeonet +3", augments = {'Enhances "Dark Seal" effect'}},
		Body = {name = "Fall. Cuirass +3", augments = {'Enhances "Blood Weapon" effect'}},
		Hands = {name = "Fall. Fin. Gaunt. +3", augments = {'Enhances "Diabolic Eye" effect'}},
		Legs = {name = "Fall. Flanchard +3", augments = {'Enhances "Muted Soul" effect'}},
		Feet = {name = "Fall. Sollerets +3", augments = {'Enhances "Desperate Blows" effect'}}
	}

	gear.empy = {
		Head = "Heath. Bur. +3",
		Body = "Heath. Cuirass +3",
		Hands = "Heath. Gauntlets +3",
		Legs = "Heath. Flanchard +3",
		Feet = "Heath. Sollerets +3"
	}

	gear.sulevia = {
		Head = "Sulevia's Mask +2",
		Body = "Sulevia's Plate. +2",
		Hands = "Sulev. Gauntlets +2",
		Legs = "Sulev. Cuisses +2",
		Feet = "Sulev. Leggings +2"
	}

	sets.enmity = {
		head = "Halitus Helm",
		back = "Agema Cape",
		neck = "Warder's Charm +1",
		ring1 = "Petrov Ring",
		ring2 = "Provocare Ring"
	}

	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA["Diabolic Eye"] = {
		hands = gear.relic.Hands
	}
	sets.precast.JA["Arcane Circle"] = {
		feet = gear.af.Feet
	}
	sets.precast.JA["Souleater"] = {}
	sets.precast.JA["Weapon Bash"] = {
		hands = gear.af.Hands
	}
	sets.precast.JA["Nether Void"] = {}
	sets.precast.JA["Blood Weapon"] = {
		body = gear.relic.Body
	}
	sets.precast.JA["Dark Seal"] = {}
	sets.precast.JA["Last Resort"] = {back = DRKCape.TP}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz["Healing Waltz"] = {}

	sets.precast.Step = {}

	sets.precast.Flourish1 = {}

	-- Fast cast sets for spells

	sets.precast.FC = {
		ammo = "Sapience Orb",
		head = "Carmine Mask +1",
		neck = "Baetyl Pendant",
		ear1 = "Loquac. Earring",
		ear2 = "Malignance Earring",
		body = gear.relic.Body,
		hands = "Leyline Gloves",
		ring1 = "Prolix Ring",
		ring2 = "Kishar Ring",
		back = DRKCape.FC,
		waist = "Flume Belt +1",
		legs = gear.odyssean_fc_legs,
		feet = {
			name = "Odyssean Greaves",
			augments = {"Pet: STR+7", "Accuracy+8", '"Fast Cast"+6', 'Mag. Acc.+7 "Mag.Atk.Bns."+7'}
		}
	}

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head = empty, body = "Twilight Cloak"})

	-- Midcast Sets
	sets.midcast.FastRecast = {
		ammo = "Staunch Tathlum +1",
		head = "Carmine Mask +1",
		neck = "Voltsurge Torque",
		ear1 = "Enchntr. Earring +1",
		ear2 = "Malignance Earring",
		body = "Odyss. Chestplate",
		hands = "Leyline Gloves",
		ring1 = "Lebeche Ring",
		ring2 = "Kishar Ring",
		back = "Moonlight Cape",
		waist = "Tempus Fugit",
		legs = gear.odyssean_fc_legs,
		feet = "Odyssean Greaves"
	}

	-- Specific spells
	sets.midcast["Sleep"] = sets.enmity
	sets.midcast["Sleep II"] = sets.enmity

	sets.midcast["Dark Magic"] = {
		ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1",
		neck = "Erra Pendant",
		ear1 = "Digni. Earring",
		ear2 = "Malignance Earring",
		body = gear.empy.Body,
		hands = gear.relic.Hands,
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Toro Cape",
		waist = "Eschan Stone",
		legs = gear.empy.Legs,
		feet = gear.empy.Feet
	}

	sets.midcast["Elemental Magic"] = {
		ammo = "Pemphredo Tathlum",
		head = sets.Nyame.Head,
		neck = "Baetyl Pendant",
		ear1 = "Friomisi Earring",
		ear2 = "Malignance Earring",
		body = sets.Nyame.Body,
		hands = sets.Nyame.Hands,
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = DRKCape.FC,
		waist = "Eschan Stone",
		legs = sets.Nyame.Legs,
		feet = gear.empy.Feet
	}

	sets.midcast["Enfeebling Magic"] = {
		ammo = "Pemphredo Tathlum",
		head = "Carmine Mask +1",
		neck = "Erra Pendant",
		ear1 = "Digni. Earring",
		ear2 = "Malignance Earring",
		body = gear.empy.Body,
		hands = gear.empy.Hands,
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = DRKCape.FC,
		waist = "Eschan Stone",
		legs = gear.empy.Legs,
		feet = gear.empy.Feet
	}

	sets.midcast["Dread Spikes"] =
		set_combine(
		sets.midcast["Dark Magic"],
		{
			ear1 = "Odnowa Earring +1",
			ear2 = "Tuisto Earring",
			neck = "Unmoving Collar +1",
			waist = "Plat. Mog. Belt",
			ring1 = "Gelatinous Ring +1",
			ring2 = "Moonbeam Ring",
			head = "Ratri Sallet +1",
			body = gear.empy.Body,
			hands = "Rat. Gadlings +1",
			legs = "Ratri Cuisses +1",
			feet = "Rat. Sollerets +1",
			back = "Moonlight Cape"
		}
	)
	sets.midcast.Absorb =
		set_combine(
		sets.midcast["Dark Magic"],
		{
			head = gear.af.Head,
			back = DRKCape.TP,
			ring1 = "Kishar Ring"
		}
	)
	sets.midcast["Absorb-TP"] =
		set_combine(
		sets.midcast.Absorb,
		{
			hands = gear.empy.Hands
		}
	)

	sets.midcast.Stun =
		set_combine(
		sets.midcast.Enfeeling,
		{
			waist = "Eschan Stone",
			legs = "Eschite Cuisses"
		}
	)

	sets.midcast.Drain =
		set_combine(
		sets.midcast["Dark Magic"],
		{
			hands = gear.relic.Hands, -- low magic accuracy
			ring1 = "Evanescence Ring",
			ring2 = "Archon Ring",
			waist = "Austerity Belt +1",
			feet = "Ratri Sollerets +1",
			back = "Niht Mantle"
		}
	)

	sets.DrainWeapon = {main = "Apocalypse", sub = "Utu Strap"}

	sets.AbsorbWeapon = {main = "Liberator", sub = "Utu Strap"}
	sets.DreadWeapon = {main = "Crepuscular Scythe", sub = "Utu Grip"}

	sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Impact = set_combine(sets.midcast["Dark Magic"], {head = empty, body = "Twilight Cloak"})

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
		body = "Sakpata's Plate",
		ring2 = "Kunaji Ring",
		waist = "Gishdubar Sash"
	}
	sets.Self_Refresh = {waist = "Gishdubar Sash"}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo = "Knobkierrie",
		head = sets.Nyame.Head,
		neck = "Abyssal Beads +2",
		ear1 = {name = "Moonshade Earring", augments = {"Accuracy+4", "TP Bonus +250"}},
		ear2 = "Heath. Earring +1",
		body = sets.Nyame.Body,
		hands = sets.Nyame.Hands,
		legs = sets.Nyame.Legs,
		feet = gear.empy.Feet,
		ring1 = "Epaminondas's Ring",
		ring2 = "Regal Ring",
		back = DRKCape.STR,
		waist = "Sailfi Belt +1"
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck = "Combatant's Torque"})
	sets.precast.WS.Crit = set_combine(sets.precast.WS, {})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
	sets.precast.WS.Subtle =
		set_combine(
		sets.precast.WS,
		{
			ear2 = "Schere Earring",
			ring1 = "Chirich Ring +1",
			ring2 = "Niqmaddu Ring"
		}
	)

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Catastrophe"] =
		set_combine(
		sets.precast.WS,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Catastrophe"].Acc =
		set_combine(
		sets.precast.WS.Acc,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Catastrophe"].Crit =
		set_combine(
		sets.precast.WS.Crit,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Catastrophe"].Fodder =
		set_combine(
		sets.precast.WS.Fodder,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)

	sets.precast.WS["Torcleaver"] =
		set_combine(
		sets.precast.WS,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			back = DRKCape.VIT
		}
	)
	sets.precast.WS["Torcleaver"].Acc =
		set_combine(
		sets.precast.WS.Acc,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			back = DRKCape.VIT
		}
	)
	sets.precast.WS["Torcleaver"].Crit =
		set_combine(
		sets.precast.WS.Crit,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			back = DRKCape.VIT
		}
	)
	sets.precast.WS["Torcleaver"].Fodder =
		set_combine(
		sets.precast.WS.Fodder,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			back = DRKCape.VIT
		}
	)
	sets.precast.WS["Torcleaver"].Subtle =
		set_combine(
		sets.precast.WS.Subtle,
		{
			ear2 = "Schere Earring",
			back = DRKCape.VIT
		}
	)

	sets.precast.WS["Insurgency"] =
		set_combine(
		sets.precast.WS,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			hands = "Sakpata's Gauntlets"
		}
	)
	sets.precast.WS["Insurgency"].Acc =
		set_combine(
		sets.precast.WS.Acc,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			hands = "Sakpata's Gauntlets"
		}
	)
	sets.precast.WS["Insurgency"].Crit =
		set_combine(
		sets.precast.WS.Crit,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			hands = "Sakpata's Gauntlets"
		}
	)
	sets.precast.WS["Insurgency"].Fodder =
		set_combine(
		sets.precast.WS.Fodder,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			hands = "Sakpata's Gauntlets",
			legs = "Ratri Cuisses +1"
		}
	)

	sets.precast.WS["Cross Reaper"] =
		set_combine(
		sets.precast.WS,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Cross Reaper"].Acc =
		set_combine(
		sets.precast.WS.Acc,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Cross Reaper"].Crit =
		set_combine(
		sets.precast.WS.Crit,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Cross Reaper"].Fodder =
		set_combine(
		sets.precast.WS.Fodder,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)

	sets.precast.WS["Quietus"] =
		set_combine(
		sets.precast.WS,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			waist = "Fotia Belt"
		}
	)
	sets.precast.WS["Quietus"].Acc =
		set_combine(
		sets.precast.WS.Acc,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			waist = "Fotia Belt"
		}
	)
	sets.precast.WS["Quietus"].Crit =
		set_combine(
		sets.precast.WS.Crit,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			waist = "Fotia Belt"
		}
	)
	sets.precast.WS["Quietus"].Fodder =
		set_combine(
		sets.precast.WS.Fodder,
		{
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring",
			waist = "Fotia Belt"
		}
	)

	sets.precast.WS["Entropy"] =
		set_combine(
		sets.precast.WS,
		{
			head = "Hjarrandi Helm",
			waist = "Fotia Belt",
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Entropy"].Acc =
		set_combine(
		sets.precast.WS.Acc,
		{
			head = "Hjarrandi Helm",
			waist = "Fotia Belt",
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Entropy"].Crit =
		set_combine(
		sets.precast.WS.Crit,
		{
			head = "Hjarrandi Helm",
			waist = "Fotia Belt",
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Entropy"].Fodder =
		set_combine(
		sets.precast.WS.Fodder,
		{
			head = "Hjarrandi Helm",
			waist = "Fotia Belt",
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)

	sets.precast.WS["Resolution"] =
		set_combine(
		sets.precast.WS,
		{
			neck = "Fotia Gorget",
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Resolution"].Acc =
		set_combine(
		sets.precast.WS.Acc,
		{
			neck = "Fotia Gorget",
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Resolution"].Crit =
		set_combine(
		sets.precast.WS.Crit,
		{
			neck = "Fotia Gorget",
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Resolution"].Fodder =
		set_combine(
		sets.precast.WS.Fodder,
		{
			neck = "Fotia Gorget",
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)
	sets.precast.WS["Resolution"].Subtle =
		set_combine(
		sets.precast.WS.Subtle,
		{
			neck = "Fotia Gorget",
			ear2 = "Schere Earring",
			ring1 = "Regal Ring",
			ring2 = "Niqmaddu Ring"
		}
	)

	sets.precast.WS["Herculean Slash"] =
		set_combine(
		sets.precast.WS,
		{
			-- neck = "Sanctity Necklace",
			ear1 = "Friomisi Earring",
			ear2 = "Malignance Earring",
			waist = "Eschan Stone",
			ring2 = "Metamor. Ring +1",
			back = DRKCape.VIT
		}
	)
	sets.precast.WS["Herculean Slash"].Acc =
		set_combine(
		sets.precast.WS.Acc,
		{
			-- neck = "Sanctity Necklace",
			ear1 = "Friomisi Earring",
			ear2 = "Malignance Earring",
			waist = "Eschan Stone",
			ring2 = "Metamor. Ring +1",
			back = DRKCape.VIT
		}
	)
	sets.precast.WS["Herculean Slash"].Crit =
		set_combine(
		sets.precast.WS.Crit,
		{
			-- neck = "Sanctity Necklace",
			ear1 = "Friomisi Earring",
			ear2 = "Malignance Earring",
			waist = "Eschan Stone",
			ring2 = "Metamor. Ring +1",
			back = DRKCape.VIT
		}
	)
	sets.precast.WS["Herculean Slash"].Fodder =
		set_combine(
		sets.precast.WS.Fodder,
		{
			-- neck = "Sanctity Necklace",
			ear1 = "Friomisi Earring",
			ear2 = "Malignance Earring",
			waist = "Eschan Stone",
			ring2 = "Metamor. Ring +1",
			back = DRKCape.VIT
		}
	)

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1 = "Lugra Earring +1", ear2 = "Lugra Earring"}
	sets.AccMaxTP = {ear1 = "Mache Earring +1", ear2 = "Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1 = "Mache Earring +1", ear2 = "Telos Earring"}
	sets.DayMaxTPWSEars = {ear1 = "Ishvara Earring", ear2 = "Brutal Earring"}
	sets.AccDayWSEars = {ear1 = "Mache Earring +1", ear2 = "Telos Earring"}
	sets.DayWSEars = {ear1 = "Brutal Earring", ear2 = "Moonshade Earring"}

	-- Idle sets

	sets.idle = {
		ammo = "Staunch Tathlum +1",
		head = "Sakpata's Helm",
		body = "Sakpata's Breastplate",
		hands = "Sakpata's Gauntlets",
		legs = "Sakpata's Cuisses",
		feet = "Sakpata's Leggings",
		neck = "Loricate Torque +1",
		ear1 = "Genmei Earring",
		ear2 = "Ethereal Earring",
		ring1 = "Stikini Ring +1",
		ring2 = "Stikini Ring +1",
		back = "Shadow Mantle",
		waist = "Null Belt"
	}

	sets.idle.PDT =
		set_combine(
		sets.idle,
		{
			ring2 = "Shadow Ring"
		}
	)

	sets.idle.Refresh =
		set_combine(
		sets.idle,
		{
			hands = {
				name = "Odyssean Gauntlets",
				augments = {
					"Pet: Phys. dmg. taken -2%",
					"STR+2",
					'"Refresh"+2',
					"Accuracy+20 Attack+20",
					'Mag. Acc.+6 "Mag.Atk.Bns."+6'
				}
			}
		}
	)

	sets.idle.Weak =
		set_combine(
		sets.midcast["Dread Spikes"],
		{
			head = "Sakpata's Helm",
			body = "Sakpata's Plate",
			hands = "Sakpata's Gauntlets",
			legs = "Sakpata's Cuisses",
			feet = "Sakpata's Leggings"
		}
	)

	sets.idle.Reraise = set_combine(sets.idle, {head = "Twilight Helm", body = "Twilight Mail"})

	-- Defense sets
	sets.defense.PDT = {
		ammo = "Staunch Tathlum +1",
		neck = "Loricate Torque +1",
		ear1 = "Genmei Earring",
		ear2 = "Ethereal Earring",
		head = "Sakpata's Helm",
		body = "Sakpata's Plate",
		hands = "Sakpata's Gauntlets",
		legs = "Sakpata's Cuisses",
		feet = "Sakpata's Leggings",
		ring1 = "Gelatinous Ring +1",
		ring2 = "Moonlight Ring",
		back = "Shadow Mantle",
		waist = "Flume Belt +1"
	}

	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head = "Twilight Helm", body = "Twilight Mail"})

	sets.defense.MDT = {
		head = "Sakpata's Helm",
		body = "Adamantite Armor",
		hands = "Sakpata's Gauntlets",
		legs = "Sakpata's Cuisses",
		feet = "Sakpata's Leggings",
		neck = "Warder's Charm +1",
		ear2 = "Odnowa Earring +1",
		ring2 = "Shadow Ring"
	}

	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head = "Twilight Helm", body = "Twilight Mail"})

	sets.defense.MEVA = set_combine(sets.defense.MDT, {})

	sets.Kiting = {legs = "Carmine Cuisses +1"}
	sets.passive.Reraise = {
		head = "Twilight Helm",
		body = "Twilight Mail"
	}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head = "Frenzy Sallet"}
	sets.buff["Dark Seal"] = {head = gear.relic.Head}

	-- Engaged sets
	sets.engaged = {
		ammo = "Coiste Bodhar",
		head = "Flam. Zucchetto +2",
		body = "Sakpata's Plate",
		hands = "Sakpata's Gauntlets",
		legs = gear.af.Legs,
		feet = "Flam. Gambieras +2",
		neck = "Abyssal Beads +2",
		waist = "Ioskeha Belt +1",
		left_ear = "Telos Earring",
		right_ear = "Cessance Earring",
		left_ring = "Lehko's Ring",
		right_ring = "Niqmaddu Ring",
		back = DRKCape.TP
	}

	sets.engaged.Weak =
		set_combine(
		sets.midcast["Dread Spikes"],
		{
			head = "Sakpata's Helm",
			body = "Sakpata's Plate",
			hands = "Sakpata's Gauntlets",
			legs = "Sakpata's Cuisses",
			feet = "Sakpata's Leggings"
		}
	)

	sets.engaged.Acc =
		set_combine(
		sets.engaged,
		{
			hands = "Gazu Bracelets +1"
		}
	)

	sets.engaged.Crit =
		set_combine(
		sets.engaged,
		{
			body = "Hjarrandi Breastplate",
			hands = "Flam. Manopolas +2"
			-- ring2 = "Hetairoi Ring"
		}
	)

	sets.engaged.Fodder = set_combine(sets.engaged, {})

	sets.engaged.DT =
		set_combine(
		sets.engaged,
		{
			head = "Sakpata's Helm",
			legs = "Sakpata's Cuisses",
			feet = "Sakpata's Leggings"
		}
	)

	sets.engaged.Subtle =
		set_combine(
		sets.engaged,
		{
			body = "Dagon Breast.",
			head = "Sakpata's Helm",
			hands = "Sakpata's Gauntlets",
			legs = "Sakpata's Cuisses",
			feet = "Sakpata's Leggings",
			left_ring = "Niqmaddu Ring",
			right_ring = "Chirich Ring +1"
		}
	)

	sets.engaged.Liberator = set_combine(sets.engaged, {})

	sets.engaged.Liberator.DT = set_combine(sets.engaged, {})

	sets.engaged.Liberator.AM = {
		ammo = "Aurgelmir Orb +1",
		waist = "Goading Belt",
		neck = "Vim Torque +1",
		head = "Hjarrandi Helm",
		body = "Hjarrandi Breastplate",
		hands = "Sakpata's Gauntlets",
		legs = "Ratri Cuisses +1",
		feet = "Sakpata's Leggings",
		left_ear = "Dedition Earring",
		right_ear = "Crep. Earring",
		left_ring = "Lehko's Ring",
		right_ring = "Moonlight Ring",
		back = DRKCape.STP
	}
	sets.engaged.Liberator.DT.AM =
		set_combine(
		sets.engaged.Liberator.AM,
		{
			legs = "Sakpata's Cuisses"
		}
	)

	--Example sets:
	--[[
    sets.engaged.Adoulin = {}
	sets.engaged.Acc.Adoulin = {}
	sets.engaged.Fodder.Adoulin = {}
	
	sets.engaged.PDT = {}
	sets.engaged.Acc.PDT = {}
	sets.engaged.Fodder.PDT = {}
	
	sets.engaged.PDT.Adoulin = {}
	sets.engaged.Acc.PDT.Adoulin = {}
	sets.engaged.Fodder.PDT.Adoulin = {}
	
	sets.engaged.MDT = {}
	sets.engaged.Acc.MDT = {}
	sets.engaged.Fodder.MDT = {}
	
	sets.engaged.MDT.Adoulin = {}
	sets.engaged.Acc.MDT.Adoulin = {}
	sets.engaged.Fodder.MDT.Adoulin = {}
	
            -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
            -- sets if more refined versions aren't defined.
            -- If you create a set with both offense and defense modes, the offense mode should be first.
            -- EG: sets.engaged.Dagger.Accuracy.Evasion

-- Liberator melee sets
    sets.engaged.Liberator = {}
	sets.engaged.Liberator.Acc = {}
	sets.engaged.Liberator.Fodder = {}
	
    sets.engaged.Liberator.Adoulin = {}
	sets.engaged.Liberator.Acc.Adoulin = {}
	sets.engaged.Liberator.Fodder.Adoulin = {}
	
    sets.engaged.Liberator.AM = {}
	sets.engaged.Liberator.Acc.AM = {}
	sets.engaged.Liberator.Fodder.AM = {}
	
    sets.engaged.Liberator.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.Adoulin.AM = {}

	sets.engaged.Liberator.PDT = {}
	sets.engaged.Liberator.Acc.PDT = {}
	sets.engaged.Liberator.Fodder.PDT = {}
	
	sets.engaged.Liberator.PDT.Adoulin = {}
	sets.engaged.Liberator.Acc.PDT.Adoulin = {}
	sets.engaged.Liberator.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Liberator.PDT.AM = {}
	sets.engaged.Liberator.Acc.PDT.AM = {}
	sets.engaged.Liberator.Fodder.PDT.AM = {}
	
	sets.engaged.Liberator.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Liberator.MDT = {}
	sets.engaged.Liberator.Acc.MDT = {}
	sets.engaged.Liberator.Fodder.MDT = {}
	
	sets.engaged.Liberator.MDT.Adoulin = {}
	sets.engaged.Liberator.Acc.MDT.Adoulin = {}
	sets.engaged.Liberator.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Liberator.MDT.AM = {}
	sets.engaged.Liberator.Acc.MDT.AM = {}
	sets.engaged.Liberator.Fodder.MDT.AM = {}
	
	sets.engaged.Liberator.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.MDT.Adoulin.AM = {}
]]
	--
	--Extra Special Sets

	sets.buff.Souleater = {
		head = gear.af.Head
	}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head = "Frenzy Sallet"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.Caladbolg = {main = "Caladbolg", sub = "Utu Grip"}
	sets.weapons.Apocalypse = {main = "Apocalypse", sub = "Utu Grip"}
	sets.weapons.Liberator = {main = "Liberator", sub = "Utu Grip"}
	sets.weapons.Montante = {main = "Montante +1", sub = "Utu Grip"}
	sets.weapons.Anguta = {main = "Anguta", sub = "Utu Grip"}
	sets.weapons.Lycurgos = {main = "Lycurgos", sub = "Utu Grip"}
	sets.weapons.Loxotic = {main = "Loxotic Mace +1", sub = "Blurred Shield +1"}
end

function user_job_lockstyle()
	windower.chat.input("/lockstyleset 003")
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == "WAR" then
		set_macro_page(2, 15)
	elseif player.sub_job == "SAM" then
		set_macro_page(3, 15)
	elseif player.sub_job == "DNC" then
		set_macro_page(4, 15)
	elseif player.sub_job == "THF" then
		set_macro_page(1, 15)
	else
		set_macro_page(5, 15)
	end
end
