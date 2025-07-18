-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options("Normal", "Acc", "FullAcc", "Fodder")
    state.HybridMode:options("Pet", "DT", "Normal")
    state.WeaponskillMode:options("Match", "Normal", "Acc", "FullAcc", "Fodder")
    state.PhysicalDefenseMode:options("PDT")
    state.IdleMode:options("Normal", "PDT", "Refresh")
    state.Weapons:options("None", "PetWeapons", "PetWeaponsRanged", "Verethragna", "Godhands", "Midnights")
    state.PetMode =
        M {
        ["description"] = "Pet Mode",
        "None",
        "Melee",
        "Ranged",
        "HybridRanged",
        "Bruiser",
        "Tank",
        "LightTank",
        "Magic",
        "Heal",
        "Nuke"
    }
    state.AutoRepairMode = M(false, "Auto Repair Mode")
    state.AutoDeployMode = M(false, "Auto Deploy Mode")
    state.AutoPetMode = M(false, "Auto Pet Mode")
    state.PetWSGear = M(false, "Pet WS Gear")
    state.PetEnmityGear = M(true, "Pet Enmity Gear")

    -- Default/Automatic maneuvers for each pet mode.  Define at least 3.
    defaultManeuvers = {
        Melee = {
            {Name = "Fire Maneuver", Amount = 1},
            {Name = "Thunder Maneuver", Amount = 1},
            {Name = "Wind Maneuver", Amount = 1},
            {Name = "Light Maneuver", Amount = 0}
        },
        Bruiser = {
            {Name = "Light Maneuver", Amount = 1},
            {Name = "Water Maneuver", Amount = 1},
            {Name = "Fire Maneuver", Amount = 1},
            {Name = "Light Maneuver", Amount = 0}
        },
        Ranged = {
            {Name = "Wind Maneuver", Amount = 3},
            {Name = "Fire Maneuver", Amount = 0},
            {Name = "Light Maneuver", Amount = 0},
            {Name = "Thunder Maneuver", Amount = 0}
        },
        HybridRanged = {
            {Name = "Wind Maneuver", Amount = 1},
            {Name = "Fire Maneuver", Amount = 1},
            {Name = "Light Maneuver", Amount = 1},
            {Name = "Thunder Maneuver", Amount = 0}
        },
        Tank = {
            {Name = "Earth Maneuver", Amount = 1},
            {Name = "Fire Maneuver", Amount = 1},
            {Name = "Light Maneuver", Amount = 1},
            {Name = "Dark Maneuver", Amount = 0}
        },
        LightTank = {
            {Name = "Earth Maneuver", Amount = 1},
            {Name = "Fire Maneuver", Amount = 1},
            {Name = "Light Maneuver", Amount = 1},
            {Name = "Dark Maneuver", Amount = 0}
        },
        Magic = {
            {Name = "Light Maneuver", Amount = 1},
            {Name = "Ice Maneuver", Amount = 1},
            {Name = "Dark Maneuver", Amount = 1},
            {Name = "Earth Maneuver", Amount = 0}
        },
        Heal = {
            {Name = "Light Maneuver", Amount = 2},
            {Name = "Dark Maneuver", Amount = 1},
            {Name = "Water Maneuver", Amount = 0},
            {Name = "Earth Maneuver", Amount = 0}
        },
        Nuke = {
            {Name = "Ice Maneuver", Amount = 2},
            {Name = "Dark Maneuver", Amount = 1},
            {Name = "Water Maneuver", Amount = 0},
            {Name = "Earth Maneuver", Amount = 0}
        }
    }

    deactivatehpp = 85

    select_default_macro_book()

    send_command("bind @` gs c cycle SkillchainMode")
    send_command("bind @f8 gs c toggle AutoPuppetMode")
    send_command("bind @f7 gs c toggle AutoRepairMode")
    send_command("bind !f7 gs c toggle PetMode")
end

-- Define sets used by this job file.
function init_gear_sets()
    Animators = {}
    --Animators.Range = "Animator P II +1"
    Animators.Range = "Animator P +1"
    Animators.Melee = "Animator P +1"

    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head = "Foire Taj +2"
    Artifact_Foire.Body = "Foire Tobe +3"
    Artifact_Foire.Hands = "Foire Dastanas +3"
    Artifact_Foire.Legs = "Foire Churidars +3"
    Artifact_Foire.Feet = "Foire Babouches +3"

    Relic_Pitre = {}
    Relic_Pitre.Head = "Pitre Taj +3" --Enhances Optimization
    Relic_Pitre.Body = "Pitre Tobe +3" --Enhances Overdrive
    Relic_Pitre.Hands = "Pitre Dastanas +3" --Enhances Fine-Tuning
    Relic_Pitre.Legs = "Pitre Churidars +3" --Enhances Ventriloquy
    Relic_Pitre.Feet = "Pitre Babouches +3" --Role Reversal

    Empy_Karagoz = {}
    Empy_Karagoz.Head = "Kara. Cappello +2"
    Empy_Karagoz.Body = "Kara. Farsetto +2"
    Empy_Karagoz.Hands = "Karagoz Guanti +2"
    Empy_Karagoz.Legs = "Kara. Pantaloni +2"
    Empy_Karagoz.Feet = "Karagoz Scarpe +2"
    Empy_Karagoz.Earring = "Kara. Earring +1"

    -- Precast Sets
    sets.buff.Overdrive = {
        head = Empy_Karagoz.Head,
        hands = "Mpaca's Gloves",
        legs = Empy_Karagoz.Legs,
        waist = "Klouskap Sash +1"
    }

    -- Fast cast sets for spells
    sets.precast.FC = {
        head = gear.herculean_fc_head,
        neck = "Voltsurge Torque",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        body = "Zendik Robe",
        hands = "Malignance Gloves",
        ring1 = "Lebeche Ring",
        ring2 = "Prolix Ring",
        back = "Fi Follet Cape +1",
        waist = "Isa Belt",
        legs = "Rawhide Trousers",
        feet = "Regal Pumps +1"
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck = "Magoraga Beads"})

    -- Precast sets to enhance JAs
    sets.precast.JA["Tactical Switch"] = {feet = Empy_Karagoz.Feet}
    sets.precast.JA["Repair"] = {ammo = "Automat. Oil +3", feet = Artifact_Foire.Feet}
    sets.precast.JA["Maintenance"] = {ammo = "Automat. Oil +3"}
    sets.precast.JA["Overdrive"] = {body = Relic_Pitre.Body}
    sets.precast.JA["Ventriloquy"] = {body = Relic_Pitre.Legs}
    sets.precast.JA["Role Reversal"] = {body = Relic_Pitre.Feet}

    sets.precast.JA.Maneuver = {
        main = "Midnights",
        back = "Visucius's Mantle",
        neck = "Buffoon's Collar",
        hands = Artifact_Foire.Hands,
        body = Empy_Karagoz.Body
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head = "Lilitu Headpiece",
        neck = "Unmoving Collar +1",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Handler's Earring +1",
        body = gear.herculean_waltz_body,
        hands = gear.herculean_waltz_hands,
        ring1 = "Defending Ring",
        ring2 = "Valseur's Ring",
        back = "Moonlight Cape",
        waist = "Chaac Belt",
        legs = "Hiza. Hizayoroi +2",
        feet = gear.herculean_waltz_feet
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range = "Neo Animator",
        head = "Mpaca's Cap",
        body = "Mpaca's Doublet",
        hands = "Mpaca's Gloves",
        legs = "Mpaca's Hose",
        feet = "Mpaca's Boots",
        neck = "Fotia Gorget",
        ear1 = "Mache Earring +1",
        ear2 = "Kara. Earring +1",
        ring1 = "Niqmaddu Ring",
        ring2 = "Gere Ring",
        back = "Visucius's Mantle",
        waist = "Fotia Belt"
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS.FullAcc =
        set_combine(
        sets.precast.WS,
        {
            neck = "Combatant's Torque",
            ear1 = "Digni. Earring",
            ear2 = "Telos Earring",
            back = "Visucius's Mantle",
            feet = "Malignance Boots"
        }
    )

    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {body = "Abnoba Kaftan"})
    sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS.Acc, {body = "Sayadio's Kaftan"})
    sets.precast.WS["Victory Smite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {body = "Sayadio's Kaftan"})
    sets.precast.WS["Victory Smite"].Fodder = set_combine(sets.precast.WS.Fodder, {body = "Abnoba Kaftan"})

    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {body = "Abnoba Kaftan"})
    sets.precast.WS["Stringing Pummel"].Acc = set_combine(sets.precast.WS.FullAcc, {body = "Sayadio's Kaftan"})
    sets.precast.WS["Stringing Pummel"].FullAcc = set_combine(sets.precast.WS.FullAcc, {body = "Sayadio's Kaftan"})
    sets.precast.WS["Stringing Pummel"].Fodder = set_combine(sets.precast.WS.Fodder, {body = "Abnoba Kaftan"})

    sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Shijin Spiral"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Shijin Spiral"].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS["Asuran Fists"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Asuran Fists"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Asuran Fists"].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS["Dragon Kick"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Dragon Kick"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Dragon Kick"].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS["Tornado Kick"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Tornado Kick"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Tornado Kick"].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS["Asuran Fists"] =
        set_combine(
        sets.precast.WS,
        {
            head = Empy_Karagoz.Head,
            body = sets.Nyame.Body,
            hands = sets.Nyame.Hands,
            feet = sets.Nyame.Feet
        }
    )
    sets.precast.WS["Asuran Fists"].Acc =
        set_combine(
        sets.precast.WS.Acc,
        {
            head = Empy_Karagoz.Head,
            body = sets.Nyame.Body,
            hands = sets.Nyame.Hands,
            feet = sets.Nyame.Feet
        }
    )
    sets.precast.WS["Asuran Fists"].FullAcc =
        set_combine(
        sets.precast.WS.FullAcc,
        {
            head = Empy_Karagoz.Head,
            body = sets.Nyame.Body,
            hands = sets.Nyame.Hands,
            feet = sets.Nyame.Feet
        }
    )
    sets.precast.WS["Asuran Fists"].Fodder =
        set_combine(
        sets.precast.WS.Fodder,
        {
            head = Empy_Karagoz.Head,
            body = sets.Nyame.Body,
            hands = sets.Nyame.Hands,
            feet = sets.Nyame.Feet
        }
    )

    sets.precast.WS["Raging Fists"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Raging Fists"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Raging Fists"].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS["Howling Fist"] =
        set_combine(
        sets.precast.WS,
        {
            body = sets.Nyame.Body,
            hands = sets.Nyame.Hands,
            legs = sets.Nyame.Legs,
            feet = sets.Nyame.Feet,
            ear1 = "Moonshade Earring",
            ear2 = "Sroda Earring"
        }
    )
    sets.precast.WS["Howling Fist"].Acc =
        set_combine(
        sets.precast.WS.Acc,
        {
            body = sets.Nyame.Body,
            hands = sets.Nyame.Hands,
            legs = sets.Nyame.Legs,
            feet = sets.Nyame.Feet,
            ear1 = "Moonshade Earring",
            ear2 = "Sroda Earring"
        }
    )
    sets.precast.WS["Howling Fist"].FullAcc =
        set_combine(
        sets.precast.WS.FullAcc,
        {
            body = sets.Nyame.Body,
            hands = sets.Nyame.Hands,
            legs = sets.Nyame.Legs,
            feet = sets.Nyame.Feet,
            ear1 = "Moonshade Earring",
            ear2 = "Sroda Earring"
        }
    )
    sets.precast.WS["Howling Fist"].Fodder =
        set_combine(
        sets.precast.WS.Fodder,
        {
            body = sets.Nyame.Body,
            hands = sets.Nyame.Hands,
            legs = sets.Nyame.Legs,
            feet = sets.Nyame.Feet,
            ear1 = "Moonshade Earring",
            ear2 = "Sroda Earring"
        }
    )

    sets.precast.WS["Backhand Blow"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Backhand Blow"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Backhand Blow"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Backhand Blow"].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS["Spinning Attack"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Spinning Attack"].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS["Spinning Attack"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Spinning Attack"].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS["Shoulder Tackle"] =
        set_combine(
        sets.precast.WS,
        {
            head = Empy_Karagoz.Head,
            body = Empy_Karagoz.Body,
            hands = Empy_Karagoz.Hands,
            legs = Empy_Karagoz.Legs,
            feet = Empy_Karagoz.Feet
        }
    )
    sets.precast.WS["Shoulder Tackle"].Acc =
        set_combine(
        sets.precast.WS.Acc,
        {
            head = Empy_Karagoz.Head,
            body = Empy_Karagoz.Body,
            hands = Empy_Karagoz.Hands,
            legs = Empy_Karagoz.Legs,
            feet = Empy_Karagoz.Feet
        }
    )
    sets.precast.WS["Shoulder Tackle"].FullAcc =
        set_combine(
        sets.precast.WS.FullAcc,
        {
            head = Empy_Karagoz.Head,
            body = Empy_Karagoz.Body,
            hands = Empy_Karagoz.Hands,
            legs = Empy_Karagoz.Legs,
            feet = Empy_Karagoz.Feet
        }
    )
    sets.precast.WS["Shoulder Tackle"].Fodder =
        set_combine(
        sets.precast.WS.Fodder,
        {
            head = Empy_Karagoz.Head,
            body = Empy_Karagoz.Body,
            hands = Empy_Karagoz.Hands,
            legs = Empy_Karagoz.Legs,
            feet = Empy_Karagoz.Feet
        }
    )
    -- Midcast Sets

    sets.midcast.FastRecast = {
        head = gear.herculean_fc_head,
        neck = "Voltsurge Torque",
        ear1 = "Enchntr. Earring +1",
        ear2 = "Loquac. Earring",
        body = "Zendik Robe",
        hands = "Malignance Gloves",
        ring1 = "Lebeche Ring",
        ring2 = "Prolix Ring",
        back = "Perimede Cape",
        waist = "Isa Belt",
        legs = "Rawhide Trousers",
        feet = "Regal Pumps +1"
    }

    sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast["Dia II"] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast["Bio II"] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {}
    sets.midcast.Pet["Enfeebling Magic"] = {
        neck = "Adad Amulet",
        ear1 = "Enmerkar Earring",
        ear2 = "Handler's Earring +1",
        body = gear.taeon_pet_body,
        hands = "Regimen Mittens",
        ring1 = "Varar Ring +1",
        ring2 = "Varar Ring +1",
        waist = "Incarnation Sash",
        legs = "Tali'ah Sera. +2"
    }
    sets.midcast.Pet["Elemental Magic"] = {
        neck = "Adad Amulet",
        ear1 = "Enmerkar Earring",
        ear2 = "Handler's Earring +1",
        body = gear.taeon_pet_body,
        hands = "Regimen Mittens",
        ring1 = "Varar Ring +1",
        ring2 = "Varar Ring +1",
        waist = "Incarnation Sash",
        legs = "Tali'ah Sera. +2"
    }

    -- The following sets are predictive and are equipped before we even know the ability will happen, as a workaround due to
    -- the fact that start of ability packets are too late in the case of Pup abilities, WS, and certain spells.
    sets.midcast.Pet.PetEnmityGear = {}
    sets.midcast.Pet.PetWSGear = {
        main = "Xiucoatl",
        head = "Taeon Chapeau",
        neck = "Shulmanu Collar",
        ear1 = "Enmerkar Earring",
        ear2 = "Kara. Earring +1",
        body = {
            name = "Taeon Tabard",
            augments = {"Pet: Accuracy+24 Pet: Rng. Acc.+24", 'Pet: "Dbl. Atk."+5', "Pet: Damage taken -3%"}
        },
        legs = "Taeon Tights",
        hands = "Mpaca's Gloves",
        ring1 = "Varar Ring +1",
        ring2 = "C. Palug Ring",
        back = "Visucius's Mantle",
        waist = "Incarnation Sash",
        feet = "Mpaca's Boots"
    }

    sets.midcast.Pet.PetWSGear.Ranged =
        set_combine(
        sets.midcast.Pet.PetWSGear,
        {
            head = Empy_Karagoz.Head,
            waist = "Klouskap Sash +1",
            -- ear2 = "Domesticator's Earring",
            back = "Dispersal Mantle"
        }
    )
    sets.midcast.Pet.PetWSGear.HybridRanged = sets.midcast.Pet.PetWSGear.Ranged
    sets.midcast.Pet.PetWSGear.Melee = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Tank = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Bruiser = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.LightTank = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Magic = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Heal = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Nuke = set_combine(sets.midcast.Pet.PetWSGear, {})

    -- Currently broken, preserved in case of future functionality.
    --sets.midcast.Pet.WeaponSkill = {}

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}

    -- Idle sets

    sets.idle = {
        head = "Null Masque",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Karagoz Earring +1",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        ring1 = "Defending Ring",
        ring2 = "Shadow Ring",
        waist = "Plat. Mog. Belt",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        back = {
            name = "Visucius's Mantle",
            augments = {
                "Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20",
                "Accuracy+20 Attack+20",
                "Pet: Haste+10",
                "System: 1 ID: 1246 Val: 4"
            }
        }
    }

    sets.idle.Refresh =
        set_combine(
        sets.idle,
        {
            ring1 = "Stikini Ring +1",
            ring2 = "Stikini Ring +1",
            waist = "Fucho-no-Obi",
            feet = "Hippo. Socks +1"
        }
    )

    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet =
        set_combine(
        sets.idle,
        {
            back = {
                name = "Visucius's Mantle",
                augments = {
                    "Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20",
                    "Accuracy+20 Attack+20",
                    "Pet: Haste+10",
                    "System: 1 ID: 1246 Val: 4"
                }
            }
        }
    )

    sets.idle.Pet.Tank =
        set_combine(
        sets.idle.Pet,
        {
            head = "Rao Kabuto +1",
            body = "Rao Togi +1",
            hands = "Rao Kote +1",
            legs = "Rao Haidate +1",
            feet = "Rao Sune-Ate +1",
            waist = "Isa Belt",
            ear1 = "Rimeice Earring",
            ear2 = "Handler's Earring +1",
            ring2 = "Overbearing Ring"
        }
    )

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {
        neck = "Shulmanu Collar",
        head = {
            name = "Taeon Chapeau",
            augments = {"Pet: Accuracy+23 Pet: Rng. Acc.+23", 'Pet: "Dbl. Atk."+4', "Pet: Damage taken -3%"}
        },
        body = {
            name = "Taeon Tabard",
            augments = {"Pet: Accuracy+24 Pet: Rng. Acc.+24", 'Pet: "Dbl. Atk."+5', "Pet: Damage taken -3%"}
        },
        hands = {
            name = "Taeon Gloves",
            augments = {"Pet: Accuracy+20 Pet: Rng. Acc.+20", 'Pet: "Dbl. Atk."+4', "Pet: Damage taken -3%"}
        },
        legs = {
            name = "Taeon Tights",
            augments = {"Pet: Accuracy+23 Pet: Rng. Acc.+23", 'Pet: "Dbl. Atk."+4', "Pet: Damage taken -4%"}
        },
        feet = "Mpaca's Boots",
        waist = "Klouskap Sash +1",
        ear1 = "Enmerkar Earring",
        ear2 = "Kara. Earring +1",
        ring1 = "C. Palug Ring",
        ring2 = "Varar Ring +1",
        back = {
            name = "Visucius's Mantle",
            augments = {
                "Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20",
                "Accuracy+20 Attack+20",
                "Pet: Haste+10",
                "System: 1 ID: 1246 Val: 4"
            }
        }
    }

    sets.idle.Pet.Engaged.Ranged =
        set_combine(
        sets.idle.Pet.Engaged,
        {
            head = Relic_Pitre.Head,
            body = Relic_Pitre.Body,
            hands = "Mpaca's Gloves",
            legs = Empy_Karagoz.Legs,
            ear2 = "Crep. Earring",
            ring1 = "Varar Ring +1",
            ring2 = "Varar Ring +1"
        }
    )
    sets.idle.Pet.Engaged.Melee = set_combine(sets.idle.Pet.Engaged, {})
    sets.idle.Pet.Engaged.Tank =
        set_combine(
        sets.idle.Pet.Engaged,
        {
            head = "Rao Kabuto +1",
            body = "Rao Togi +1",
            hands = "Rao Kote +1",
            legs = "Rao Haidate +1",
            feet = "Rao Sune-Ate +1",
            waist = "Isa Belt",
            ear1 = "Rimeice Earring",
            ear2 = "Handler's Earring +1",
            ring2 = "Overbearing Ring"
        }
    )
    sets.idle.Pet.Engaged.Bruiser =
        set_combine(
        sets.idle.Pet.Engaged,
        {
            hands = "Mpaca's Gloves",
            feet = "Mpaca's Boots"
        }
    )
    sets.idle.Pet.Engaged.LightTank =
        set_combine(
        sets.idle.Pet.Engaged,
        {
            waist = "Isa Belt",
            ear2 = "Handler's Earring +1"
        }
    )
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {})
    sets.idle.Pet.Engaged.Heal = sets.idle.Pet.Engaged.Magic
    sets.idle.Pet.Engaged.Nuke = sets.idle.Pet.Engaged.Magic

    -- Defense sets

    sets.defense.PDT = {
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Genmei Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Defending Ring",
        ring2 = "Dark Ring",
        back = "Moonlight Cape",
        waist = "Isa Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MDT = {
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Genmei Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Defending Ring",
        ring2 = "Dark Ring",
        back = "Moonlight Cape",
        waist = "Isa Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.defense.MEVA = {
        head = "Nyame Helm",
        neck = "Loricate Torque +1",
        ear1 = "Etiolation Earring",
        ear2 = "Genmei Earring",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        ring1 = "Defending Ring",
        ring2 = "Dark Ring",
        back = "Moonlight Cape",
        waist = "Isa Belt",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets"
    }

    sets.Kiting = {feet = "Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        neck = "Shulmanu Collar",
        head = "Malignance Chapeau",
        body = "Mpaca's Doublet",
        hands = gear.herculean_qa_hands,
        ear1 = "Mache Earring +1",
        ear2 = "Kara. Earring +1",
        ring1 = "Niqmaddu Ring",
        ring2 = "Gere Ring",
        back = "Null Shawl",
        waist = "Moonbow Belt +1",
        legs = "Samnuha Tights",
        feet = gear.herculean_ta_feet
    }

    sets.engaged.Acc =
        set_combine(
        sets.engaged,
        {
            ear1 = "Mache Earring +1"
        }
    )
    sets.engaged.FullAcc = set_combine(sets.engaged, {})
    sets.engaged.Fodder = set_combine(sets.engaged, {})

    sets.engaged.DT =
        set_combine(
        sets.engaged,
        {
            body = "Malignance Tabard",
            hands = "Malignance Gloves",
            legs = "Malignance Tights",
            feet = "Malignance Boots"
        }
    )

    sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {})
    sets.engaged.FullAcc.DT = set_combine(sets.engaged.DT, {})
    sets.engaged.Fodder.DT = set_combine(sets.engaged.DT, {})

    sets.engaged.Pet = {
        head = {
            name = "Taeon Chapeau",
            augments = {"Pet: Accuracy+23 Pet: Rng. Acc.+23", 'Pet: "Dbl. Atk."+4', "Pet: Damage taken -3%"}
        },
        body = {
            name = "Taeon Tabard",
            augments = {"Pet: Accuracy+24 Pet: Rng. Acc.+24", 'Pet: "Dbl. Atk."+5', "Pet: Damage taken -3%"}
        },
        hands = {
            name = "Taeon Gloves",
            augments = {"Pet: Accuracy+20 Pet: Rng. Acc.+20", 'Pet: "Dbl. Atk."+4', "Pet: Damage taken -3%"}
        },
        legs = {
            name = "Taeon Tights",
            augments = {"Pet: Accuracy+23 Pet: Rng. Acc.+23", 'Pet: "Dbl. Atk."+4', "Pet: Damage taken -4%"}
        },
        feet = "Mpaca's Boots",
        neck = "Shulmanu Collar",
        waist = "Klouskap Sash +1",
        left_ear = "Rimeice Earring",
        right_ear = "Kara. Earring +1",
        left_ring = "C. Palug Ring",
        right_ring = "Overbearing Ring",
        back = {
            name = "Visucius's Mantle",
            augments = {
                "Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20",
                "Accuracy+20 Attack+20",
                "Pet: Haste+10",
                "System: 1 ID: 1246 Val: 4"
            }
        }
    }

    sets.engaged.Acc.Pet = set_combine(sets.engaged.Pet, {})
    sets.engaged.FullAcc.Pet = set_combine(sets.engaged.Pet, {})
    sets.engaged.Fodder.Pet = set_combine(sets.engaged.Pet, {})

    -- Weapons sets
    sets.weapons.Godhands = {main = "Godhands", range = "Animator P +1"}
    sets.weapons.Verethragna = {main = "Verethragna", range = "Animator P +1"}
    sets.weapons.Midnights = {main = "Midnights", range = "Animator P +1"}
    sets.weapons.PetWeapons = {main = "Xiucoatl", range = "Animator P +1"}
    sets.weapons.PetWeaponsRanged = {main = "Xiucoatl", range = "Animator P II +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == "DNC" then
        set_macro_page(2, 20)
    elseif player.sub_job == "NIN" then
        set_macro_page(2, 20)
    elseif player.sub_job == "THF" then
        set_macro_page(2, 20)
    else
        set_macro_page(2, 20)
    end
end
