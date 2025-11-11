do
    local enabled = false
    local settings = {
        trade_item = '', 
        trade_material = '', 
        augment_1 = '',
        augment_2 = '',
        augment_3 = '',
        style = '',
        watch_value_1 = 0,
        watch_value_2 = 0,
        watch_value_3 = 0,
        mode = '',
        delay = 2,
        augment_mode = ''}
    local skirmish_npc = nil
    local cape_npc = nil
    local oseem_npc = nil
    local world = nil
    local last_trade = os.clock()
    local gear_style_types = {
        [0] = {"Melee","Magic","Techniques"},
        [1] = {"Melee","Magic","Techniques"},
        [2] = {"Melee","Magic","Techniques"},
        [3] = {"Melee","Magic","Techniques"},
        [4] = {"Melee","Magic","Techniques"},
        [5] = {"Melee","Familiar","Techniques"},
        [6] = {"Melee","Familiar","Techniques"},
        [7] = {"Melee","Familiar","Techniques"},
        [8] = {"Melee","Familiar","Techniques"},
        [9] = {"Melee","Familiar","Techniques"},
        [10] = {"Melee","Ranged","Magic","Familiar","Techniques"},
        [11] = {"Melee","Ranged","Magic","Familiar","Techniques"},
        [12] = {"Melee","Ranged","Magic","Familiar","Techniques"},
        [13] = {"Melee","Ranged","Magic","Familiar","Techniques"},
        [14] = {"Melee","Ranged","Magic","Familiar","Techniques"},
        [15] = {"Magic", "Familiar","Techniques"},
        [16] = {"Magic", "Familiar","Techniques"},
        [17] = {"Magic", "Familiar","Techniques"},
        [18] = {"Magic", "Familiar","Techniques"},
        [19] = {"Magic", "Familiar","Techniques"},
        [20] = {"Melee", "Healing","Techniques"},
        [21] = {"Melee", "Healing","Techniques"},
        [22] = {"Melee", "Healing","Techniques"},
        [23] = {"Melee", "Healing","Techniques"},
        [24] = {"Melee", "Healing","Techniques"},
        [25] = {"Melee", "Familiar","Techniques"},
        [26] = {"Melee", "Magic","Techniques"},
        [27] = {"Melee", "Magic","Techniques"},
        [28] = {"Melee","Techniques"},
        [29] = {"Melee", "Familiar","Techniques"},
        [30] = {"Melee","Techniques"},
        [31] = {"Melee","Techniques"},
        [32] = {"Melee","Techniques"},
        [33] = {"Melee","Techniques"},
        [34] = {"Melee","Techniques"},
        [35] = {"Melee", "Magic","Techniques"},
        [36] = {"Magic", "Familiar","Techniques"},
        [37] = {"Ranged","Techniques"},
        [38] = {"Ranged","Techniques"}, }
    local stone_types = {
        ["Pellucid Stones"] = 0x0000, 
        ["Fern Stones"] = 0x0001, 
        ["Taupe Stones"] = 0x0002, 
        ["Dark Matter"] = 0x0003}
    local style_types = {
        ["Melee"] = 0x0008,
        ["Ranged"] = 0x0108, 
        ["Magic"] = 0x0208, 
        ["Familiar"] = 0x0308, 
        ["Healing"] = 0x0408,
        ["Techniques"] = 0x050A, }
    local augment_values = {
        [-1]    = {{stat="unknown",offset=0}},
        [0x000] = {{stat="none",offset=0}},
        [0x001] = {{stat="HP", offset=1}},
        [0x002] = {{stat="HP", offset=33}},
        [0x003] = {{stat="HP", offset=65}},
        [0x004] = {{stat="HP", offset=97}},
        [0x005] = {{stat="HP", offset=1,multiplier=-1}},
        [0x006] = {{stat="HP", offset=33,multiplier=-1}},
        [0x007] = {{stat="HP", offset=65,multiplier=-1}},
        [0x008] = {{stat="HP", offset=97,multiplier=-1}},
        [0x009] = {{stat="MP", offset=1}},
        [0x00A] = {{stat="MP", offset=33}},
        [0x00B] = {{stat="MP", offset=65}},
        [0x00C] = {{stat="MP", offset=97}},
        [0x00D] = {{stat="MP", offset=1,multiplier=-1}},
        [0x00E] = {{stat="MP", offset=33,multiplier=-1}},
        [0x00F] = {{stat="MP", offset=65,multiplier=-1}},
        [0x010] = {{stat="MP", offset=97,multiplier=-1}},
        [0x011] = {{stat="HP", offset=1}, {stat="MP", offset=1}},
        [0x012] = {{stat="HP", offset=33}, {stat="MP", offset=33}},
        [0x013] = {{stat="HP", offset=1}, {stat="MP", offset=1,multiplier=-1}},
        [0x014] = {{stat="HP", offset=33}, {stat="MP", offset=33,multiplier=-1}},
        [0x015] = {{stat="HP", offset=1,multiplier=-1}, {stat="MP", offset=1}},
        [0x016] = {{stat="HP", offset=33,multiplier=-1}, {stat="MP", offset=33}},
        [0x017] = {{stat="Accuracy", offset=1}},
        [0x018] = {{stat="Accuracy", offset=1,multiplier=-1}},
        [0x019] = {{stat="Attack", offset=1}},
        [0x01A] = {{stat="Attack", offset=1,multiplier=-1}},
        [0x01B] = {{stat="Ranged Accuracy", offset=1}},
        [0x01C] = {{stat="Ranged Accuracy", offset=1,multiplier=-1}},
        [0x01D] = {{stat="Ranged Attack", offset=1}},
        [0x01E] = {{stat="Ranged Attack", offset=1,multiplier=-1}},
        [0x01F] = {{stat="Evasion", offset=1}},
        [0x020] = {{stat="Evasion", offset=1,multiplier=-1}},
        [0x021] = {{stat="DEF", offset=1}},
        [0x022] = {{stat="DEF", offset=1,multiplier=-1}},
        [0x023] = {{stat="Magic Accuracy", offset=1}},
        [0x024] = {{stat="Magic Accuracy", offset=1,multiplier=-1}},
        [0x025] = {{stat="Magic Evasion", offset=1}},
        [0x026] = {{stat="Magic Evasion", offset=1,multiplier=-1}},
        [0x027] = {{stat="Enmity", offset=1}},
        [0x028] = {{stat="Enmity", offset=1,multiplier=-1}},
        [0x029] = {{stat="Critical hit rate", offset=1}},
        [0x02A] = {{stat="Enemy critical hit rate", offset=1,multiplier=-1}},
        [0x02B] = {{stat='Charm', offset=1}},
        [0x02C] = {{stat='Store TP', offset=1}, {stat='Subtle Blow', offset=1}},
        [0x02D] = {{stat="DMG", offset=1}},
        [0x02E] = {{stat="DMG", offset=1,multiplier=-1}},
        [0x02F] = {{stat="Delay", offset=1,percent=true}},
        [0x030] = {{stat="Delay", offset=1,multiplier=-1,percent=true}},
        [0x031] = {{stat="Haste", offset=1}},
        [0x032] = {{stat='Slow', offset=1}},
        [0x033] = {{stat="HP recovered while healing", offset=1}},
        [0x034] = {{stat="MP recovered while healing", offset=1}},
        [0x035] = {{stat="Spell interruption rate down", offset=1,multiplier=-1,percent=true}},
        [0x036] = {{stat="Physical damage taken", offset=1,multiplier=-1,percent=true}},
        [0x037] = {{stat="Magic damage taken", offset=1,multiplier=-1,percent=true}},
        [0x038] = {{stat="Breath damage taken", offset=1,multiplier=-1,percent=true}},
        [0x039] = {{stat="Magic critical hit rate", offset=1}},
        [0x03A] = {{stat='Magic Defense Bonus', offset=1,multiplier=-1}},
        [0x03B] = {{stat='Latent effect: Regain', offset=1}},
        [0x03C] = {{stat='Latent effect: Refresh', offset=1}},
        [0x03D] = {{stat="Occ. inc. resist. to stat. ailments", offset=1}},
        [0x03E] = {{stat="Accuracy", offset=33}},
        [0x03F] = {{stat="Ranged Accuracy", offset=33}},
        [0x040] = {{stat="Magic Accuracy", offset=33}},
        [0x041] = {{stat="Attack", offset=33}},
        [0x042] = {{stat="Ranged Attack", offset=33}},
        [0x043] = {{stat="All Songs", offset=1}},
        [0x044] = {{stat="Accuracy", offset=1},{stat="Attack", offset=1}},
        [0x045] = {{stat="Ranged Accuracy", offset=1},{stat="Ranged Attack", offset=1}},
        [0x046] = {{stat="Magic Accuracy", offset=1},{stat='Magic Attack Bonus', offset=1}},
        [0x047] = {{stat="Damage taken", offset=1,multiplier=-1,percent=true}},
        [0x04A] = {{stat="Cap. Point", offset=1,percent=true}},
        [0x04B] = {{stat="Cap. Point", offset=33,percent=true}},
        [0x04C] = {{stat="DMG", offset=33}},
        [0x04D] = {{stat="Delay", offset=33,multiplier=-1,percent=true}},
        [0x04E] = {{stat="HP", offset=1,multiplier=2}},
        [0x04F] = {{stat="HP", offset=1,multiplier=3}},
        [0x050] = {{stat="Magic Accuracy", offset=1}, {stat="Magic Damage", offset=1}},
        [0x051] = {{stat="Evasion", offset=1}, {stat="Magic Evasion", offset=1}},
        [0x052] = {{stat="MP", offset=1,multiplier=2}},
        [0x053] = {{stat="MP", offset=1,multiplier=3}},
        [0x060] = {{stat="Pet: Accuracy", offset=1}, {stat="Pet: Ranged Accuracy", offset=1}}, -- Pet: Accuracy+5 Rng.Acc.+5
        [0x061] = {{stat="Pet: Attack", offset=1}, {stat="Pet: Ranged Attack", offset=1}}, -- Pet: Attack +5 Rng.Atk.+5
        [0x062] = {{stat="Pet: Evasion", offset=1}},
        [0x063] = {{stat="Pet: DEF", offset=1}},
        [0x064] = {{stat="Pet: Magic Accuracy", offset=1}},
        [0x065] = {{stat='Pet: Magic Attack Bonus', offset=1}},
        [0x066] = {{stat="Pet: Critical Hit Rate", offset=1}},
        [0x067] = {{stat="Pet: Enemy Critical Hit Rate", offset=1,multiplier=-1}},
        [0x068] = {{stat="Pet: Enmity", offset=1}},
        [0x069] = {{stat="Pet: Enmity", offset=1,multiplier=-1}},
        [0x06A] = {{stat="Pet: Accuracy", offset=1}, {stat="Pet: Ranged Accuracy", offset=1}},
        [0x06B] = {{stat="Pet: Attack", offset=1}, {stat="Pet: Ranged Attack", offset=1}},
        [0x06C] = {{stat="Pet: Magic Accuracy", offset=1}, {stat='Pet: Magic Attack Bonus', offset=1}},
        [0x06D] = {{stat='Pet: Double Attack', offset=1}, {stat="Pet: Critical Hit Rate", offset=1}},
        [0x06E] = {{stat='Pet: Regen', offset=1}},
        [0x06F] = {{stat="Pet: Haste", offset=1}},
        [0x070] = {{stat="Pet: Damage Taken", offset=1,multiplier=-1,percent=true}},
        [0x071] = {{stat="Pet: Ranged Accuracy", offset=1}},
        [0x072] = {{stat="Pet: Ranged Attack", offset=1}},
        [0x073] = {{stat='Pet: Store TP', offset=1}},
        [0x074] = {{stat='Pet: Subtle Blow', offset=1}},
        [0x075] = {{stat="Pet: Magic Evasion", offset=1}},
        [0x076] = {{stat="Pet: Physical Damage Taken", offset=1,multiplier=-1,percent=true}},
        [0x077] = {{stat='Pet: Magic Defense Bonus', offset=1}},
        [0x078] = {{stat='Avatar: Magic Attack Bonus', offset=1}},
        [0x079] = {{stat='Pet: Breath', offset=1}},
        [0x07A] = {{stat='Pet: TP Bonus', offset=1, multiplier=20}},
        [0x07B] = {{stat='Pet: Double Attack', offset=1}},
        [0x07C] = {{stat="Pet: Accuracy", offset=1}, {stat="Pet: Ranged Accuracy", offset=1}, {stat="Pet: Attack", offset=1}, {stat="Pet: Ranged Attack", offset=1}},
        [0x07D] = {{stat="Pet: Magic Accuracy", offset=1}, {stat="Pet: Magic Damage", offset=1}},
        [0x07E] = {{stat='Pet: Magic Damage', offset=1}},
        [0x080] = {{stat="Pet:",offset = 0}},
        [0x085] = {{stat='Magic Attack Bonus', offset=1}},
        [0x086] = {{stat='Magic Defense Bonus', offset=1}},
        [0x087] = {{stat="Avatar:",offset=0}},
        [0x089] = {{stat="Regen", offset=1}},
        [0x08A] = {{stat="Refresh", offset=1}},
        [0x08B] = {{stat="Rapid Shot", offset=1}},
        [0x08C] = {{stat="Fast Cast", offset=1}},
        [0x08D] = {{stat="Conserve MP", offset=1}},
        [0x08E] = {{stat="Store TP", offset=1}},
        [0x08F] = {{stat="Double Attack", offset=1}},
        [0x090] = {{stat="Triple Attack", offset=1}},
        [0x091] = {{stat="Counter", offset=1}},
        [0x092] = {{stat="Dual Wield", offset=1}},
        [0x093] = {{stat="Treasure Hunter", offset=1}},
        [0x094] = {{stat="Gilfinder", offset=1}},
        [0x097] = {{stat='Martial Arts', offset=1}},
        [0x099] = {{stat='Shield Mastery', offset=1}},
        [0x0B0] = {{stat='Resist Sleep', offset=1}},
        [0x0B1] = {{stat='Resist Poison', offset=1}},
        [0x0B2] = {{stat='Resist Paralyze', offset=1}},
        [0x0B3] = {{stat='Resist Blind', offset=1}},
        [0x0B4] = {{stat='Resist Silence', offset=1}},
        [0x0B5] = {{stat='Resist Petrify', offset=1}},
        [0x0B6] = {{stat='Resist Virus', offset=1}},
        [0x0B7] = {{stat='Resist Curse', offset=1}},
        [0x0B8] = {{stat='Resist Stun', offset=1}},
        [0x0B9] = {{stat='Resist Bind', offset=1}},
        [0x0BA] = {{stat='Resist Gravity', offset=1}},
        [0x0BB] = {{stat='Resist Slow', offset=1}},
        [0x0BC] = {{stat='Resist Charm', offset=1}},
        [0x0C2] = {{stat='Kick Attacks', offset=1}},
        [0x0C3] = {{stat='Subtle Blow', offset=1}},
        [0x0C6] = {{stat='Zanshin', offset=1}},
        [0x0D3] = {{stat='Snapshot', offset=1}},
        [0x0D4] = {{stat='Recycle', offset=1}},
        [0x0D7] = {{stat='Ninja Tool Expertise', offset=1}},
        [0x0E9] = {{stat='Blood Boon', offset=1}},
        [0x0ED] = {{stat='Occult Acumen', offset=1}},
        [0x101] = {{stat="Hand-to-Hand skill", offset=1}},
        [0x102] = {{stat="Dagger skill", offset=1}},
        [0x103] = {{stat="Sword skill", offset=1}},
        [0x104] = {{stat="Great Sword skill", offset=1}},
        [0x105] = {{stat="Axe skill", offset=1}},
        [0x106] = {{stat="Great Axe skill", offset=1}},
        [0x107] = {{stat="Scythe skill", offset=1}},
        [0x108] = {{stat="Polearm skill", offset=1}},
        [0x109] = {{stat="Katana skill", offset=1}},
        [0x10A] = {{stat="Great Katana skill", offset=1}},
        [0x10B] = {{stat="Club skill", offset=1}},
        [0x10C] = {{stat="Staff skill", offset=1}},
        [0x116] = {{stat="Melee skill", offset=1}}, -- Automaton
        [0x117] = {{stat="Ranged skill", offset=1}}, -- Automaton
        [0x118] = {{stat="Magic skill", offset=1}}, -- Automaton
        [0x119] = {{stat="Archery skill", offset=1}},
        [0x11A] = {{stat="Marksmanship skill", offset=1}},
        [0x11B] = {{stat="Throwing skill", offset=1}},
        [0x11E] = {{stat="Shield skill", offset=1}},
        [0x120] = {{stat="Divine magic skill", offset=1}},
        [0x121] = {{stat="Healing magic skill", offset=1}},
        [0x122] = {{stat="Enhancing magic skill", offset=1}},
        [0x123] = {{stat="Enfeebling magic skill", offset=1}},
        [0x124] = {{stat="Elemental magic skill", offset=1}},
        [0x125] = {{stat="Dark magic skill", offset=1}},
        [0x126] = {{stat="Summoning magic skill", offset=1}},
        [0x127] = {{stat="Ninjutsu skill", offset=1}},
        [0x128] = {{stat="Singing skill", offset=1}},
        [0x129] = {{stat="String instrument skill", offset=1}},
        [0x12A] = {{stat="Wind instrument skill", offset=1}},
        [0x12B] = {{stat="Blue Magic skill", offset=1}},
        [0x12C] = {{stat="Geomancy Skill", offset=1}},
        [0x12D] = {{stat="Handbell Skill", offset=1}},
        [0x140] = {{stat='Blood Pact ability delay', offset=1,multiplier=-1}},
        [0x141] = {{stat='Avatar perpetuation cost', offset=1,multiplier=-1}},
        [0x142] = {{stat="Song spellcasting time", offset=1,multiplier=-1,percent=true}},
        [0x143] = {{stat='Cure spellcasting time', offset=1,multiplier=-1,percent=true}},
        [0x144] = {{stat='Call Beast ability delay', offset=1,multiplier=-1}},
        [0x145] = {{stat='Quick Draw ability delay', offset=1,multiplier=-1}},
        [0x146] = {{stat="Weapon Skill Accuracy", offset=1}},
        [0x147] = {{stat="Weapon skill damage", offset=1,percent=true}},
        [0x148] = {{stat="Critical hit damage", offset=1,percent=true}},
        [0x149] = {{stat='Cure potency', offset=1,percent=true}},
        [0x14A] = {{stat='Waltz potency', offset=1,percent=true}},
        [0x14B] = {{stat='Waltz ability delay', offset=1,multiplier=-1}},
        [0x14C] = {{stat="Skillchain Damage", offset=1,percent=true}},
        [0x14D] = {{stat='Conserve TP', offset=1}},
        [0x14E] = {{stat="Magic Burst Damage", offset=1,percent=true}},
        [0x14F] = {{stat="Magic Critical Hit Damage", offset=1,percent=true}},
        [0x150] = {{stat='Sic and Ready ability delay', offset=1,multiplier=-1}},
        [0x151] = {{stat="Song recast delay", offset=1,multiplier=-1}},
        [0x152] = {{stat='Barrage', offset=1}},
        [0x153] = {{stat='Elemental Siphon', offset=1, multiplier=5}},
        [0x154] = {{stat='Phantom Roll ability delay', offset=1,multiplier=-1}},
        [0x155] = {{stat='Repair potency', offset=1,percent=true}},
        [0x156] = {{stat='Waltz TP cost', offset=1,multiplier=-1}},
        [0x157] = {{stat='Drain and Aspir potency', offset=1}},
        [0x15E] = {{stat="Occ. maximizes magic accuracy", offset=1,percent=true}},
        [0x15F] = {{stat="Occ. quickens spellcasting", offset=1,percent=true}},
        [0x160] = {{stat="Occ. grants dmg. bonus based on TP", offset=1,percent=true}},
        [0x161] = {{stat="TP Bonus", offset=1, multiplier=5}},
        [0x162] = {{stat="Quadruple Attack", offset=1}},
        [0x164] = {{stat='Potency of Cure effect received', offset=1, percent=true}},
        [0x168] = {{stat="Save TP", offset=1, multiplier=10}},
        [0x16A] = {{stat="Magic Damage", offset=1}},
        [0x16B] = {{stat="Chance of successful block", offset=1}},
        [0x16E] = {{stat="Blood Pact ability delay II", offset=1, multiplier=-1}},
        [0x170] = {{stat="Phalanx", offset=1}},
        [0x171] = {{stat="Blood Pact Damage", offset=1}},
        [0x172] = {{stat='Reverse Flourish', offset=1}},
        [0x173] = {{stat='Regen Potency', offset=1}},
        [0x174] = {{stat='Embolden', offset=1}},
        [0x200] = {{stat="STR", offset=1}},
        [0x201] = {{stat="DEX", offset=1}},
        [0x202] = {{stat="VIT", offset=1}},
        [0x203] = {{stat="AGI", offset=1}},
        [0x204] = {{stat="INT", offset=1}},
        [0x205] = {{stat="MND", offset=1}},
        [0x206] = {{stat="CHR", offset=1}},
        [0x207] = {{stat="STR", offset=1,multiplier=-1}},
        [0x208] = {{stat="DEX", offset=1,multiplier=-1}},
        [0x209] = {{stat="VIT", offset=1,multiplier=-1}},
        [0x20A] = {{stat="AGI", offset=1,multiplier=-1}},
        [0x20B] = {{stat="INT", offset=1,multiplier=-1}},
        [0x20C] = {{stat="MND", offset=1,multiplier=-1}},
        [0x20D] = {{stat="CHR", offset=1,multiplier=-1}},
        [0x20E] = {{stat="STR", offset=1}, {stat="DEX", offset=1, multiplier=-0.5}, {stat="VIT", offset=1, multiplier=-0.5}},
        [0x20F] = {{stat="STR", offset=1}, {stat="DEX", offset=1, multiplier=-0.5}, {stat="AGI", offset=1, multiplier=-0.5}},
        [0x210] = {{stat="STR", offset=1}, {stat="VIT", offset=1, multiplier=-0.5}, {stat="AGI", offset=1, multiplier=-0.5}},
        [0x211] = {{stat="STR", offset=1, multiplier=-0.5}, {stat="DEX", offset=1}, {stat="VIT", offset=1, multiplier=-0.5}},
        [0x212] = {{stat="STR", offset=1, multiplier=-0.5}, {stat="DEX", offset=1}, {stat="AGI", offset=1, multiplier=-0.5}},
        [0x213] = {{stat="DEX", offset=1}, {stat="VIT", offset=1, multiplier=-0.5}, {stat="AGI", offset=1, multiplier=-0.5}},
        [0x214] = {{stat="STR", offset=1, multiplier=-0.5}, {stat="DEX", offset=1, multiplier=-0.5}, {stat="VIT", offset=1}},
        [0x215] = {{stat="STR", offset=1, multiplier=-0.5}, {stat="VIT", offset=1}, {stat="AGI", offset=1, multiplier=-0.5}},
        [0x216] = {{stat="DEX", offset=1, multiplier=-0.5}, {stat="VIT", offset=1}, {stat="AGI", offset=1, multiplier=-0.5}},
        [0x217] = {{stat="STR", offset=1, multiplier=-0.5}, {stat="DEX", offset=1, multiplier=-0.5}, {stat="AGI", offset=1}},
        [0x218] = {{stat="STR", offset=1, multiplier=-0.5}, {stat="VIT", offset=1, multiplier=-0.5}, {stat="AGI", offset=1}},
        [0x219] = {{stat="DEX", offset=1, multiplier=-0.5}, {stat="VIT", offset=1, multiplier=-0.5}, {stat="AGI", offset=1}},
        [0x21A] = {{stat="AGI", offset=1}, {stat="INT", offset=1, multiplier=-0.5}, {stat="MND", offset=1, multiplier=-0.5}},
        [0x21B] = {{stat="AGI", offset=1}, {stat="INT", offset=1, multiplier=-0.5}, {stat="CHR", offset=1, multiplier=-0.5}},
        [0x21C] = {{stat="AGI", offset=1}, {stat="MND", offset=1, multiplier=-0.5}, {stat="CHR", offset=1, multiplier=-0.5}},
        [0x21D] = {{stat="AGI", offset=1, multiplier=-0.5}, {stat="INT", offset=1}, {stat="MND", offset=1, multiplier=-0.5}},
        [0x21E] = {{stat="AGI", offset=1, multiplier=-0.5}, {stat="INT", offset=1}, {stat="CHR", offset=1, multiplier=-0.5}},
        [0x21F] = {{stat="INT", offset=1}, {stat="MND", offset=1, multiplier=-0.5}, {stat="CHR", offset=1, multiplier=-0.5}},
        [0x220] = {{stat="AGI", offset=1, multiplier=-0.5}, {stat="INT", offset=1, multiplier=-0.5}, {stat="MND", offset=1}},
        [0x221] = {{stat="AGI", offset=1, multiplier=-0.5}, {stat="MND", offset=1}, {stat="CHR", offset=1, multiplier=-0.5}},
        [0x222] = {{stat="INT", offset=1, multiplier=-0.5}, {stat="MND", offset=1}, {stat="CHR", offset=1, multiplier=-0.5}},
        [0x223] = {{stat="AGI", offset=1, multiplier=-0.5}, {stat="INT", offset=1, multiplier=-0.5}, {stat="CHR", offset=1}},
        [0x224] = {{stat="AGI", offset=1, multiplier=-0.5}, {stat="MND", offset=1, multiplier=-0.5}, {stat="CHR", offset=1}},
        [0x225] = {{stat="INT", offset=1, multiplier=-0.5}, {stat="MND", offset=1, multiplier=-0.5}, {stat="CHR", offset=1}},
        [0x226] = {{stat="STR", offset=1}, {stat="DEX", offset=1}},
        [0x227] = {{stat="STR", offset=1}, {stat="VIT", offset=1}},
        [0x228] = {{stat="STR", offset=1}, {stat="AGI", offset=1}},
        [0x229] = {{stat="DEX", offset=1}, {stat="AGI", offset=1}},
        [0x22A] = {{stat="INT", offset=1}, {stat="MND", offset=1}},
        [0x22B] = {{stat="MND", offset=1}, {stat="CHR", offset=1}},
        [0x22C] = {{stat="INT", offset=1}, {stat="MND", offset=1}, {stat="CHR", offset=1}},
        [0x22D] = {{stat="STR", offset=1}, {stat="CHR", offset=1}},
        [0x22E] = {{stat="STR", offset=1}, {stat="INT", offset=1}},
        [0x22F] = {{stat="STR", offset=1}, {stat="MND", offset=1}},
        [0x2E4] = {{stat="DMG", offset=1}},
        [0x2E5] = {{stat="DMG", offset=33}},
        [0x2E6] = {{stat="DMG", offset=65}},
        [0x2E7] = {{stat="DMG", offset=97}},
        [0x2E8] = {{stat="DMG", offset=1,multiplier=-1}},
        [0x2E9] = {{stat="DMG", offset=33,multiplier=-1}},
        [0x2EA] = {{stat="DMG", offset=1}},
        [0x2EB] = {{stat="DMG", offset=33}},
        [0x2EC] = {{stat="DMG", offset=65}},
        [0x2ED] = {{stat="DMG", offset=97}},
        [0x2EE] = {{stat="DMG", offset=1,multiplier=-1}},
        [0x2EF] = {{stat="DMG", offset=33,multiplier=-1}},
        [0x2F0] = {{stat="Delay", offset=1}},
        [0x2F1] = {{stat="Delay", offset=33}},
        [0x2F2] = {{stat="Delay", offset=65}},
        [0x2F3] = {{stat="Delay", offset=97}},
        [0x2F4] = {{stat="Delay", offset=1,multiplier=-1}},
        [0x2F5] = {{stat="Delay", offset=33,multiplier=-1}},
        [0x2F6] = {{stat="Delay", offset=65,multiplier=-1}},
        [0x2F7] = {{stat="Delay", offset=97,multiplier=-1}},
        [0x2F8] = {{stat="Delay", offset=1}},
        [0x2F9] = {{stat="Delay", offset=33}},
        [0x2FA] = {{stat="Delay", offset=65}},
        [0x2FB] = {{stat="Delay", offset=97}},
        [0x2FC] = {{stat="Delay", offset=1,multiplier=-1}},
        [0x2FD] = {{stat="Delay", offset=33,multiplier=-1}},
        [0x2FE] = {{stat="Delay", offset=65,multiplier=-1}},
        [0x2FF] = {{stat="Delay", offset=97,multiplier=-1}},
        [0x380] = {{stat="Sword enhancement spell damage", offset=1}},
        [0x381] = {{stat='Enhances Souleater effect', offset=1,percent=true}},
        [0x480] = {{stat="DEF", offset=1,multiplier=10}},
        [0x481] = {{stat="Evasion", offset=1,multiplier=3}},
        [0x482] = {{stat="Mag. Evasion", offset=1,multiplier=3}},
        [0x483] = {{stat="Phys. dmg. taken", offset=1,multiplier=-2,percent=true}},
        [0x484] = {{stat="Magic dmg. taken", offset=1,multiplier=-2,percent=true}},
        [0x485] = {{stat="Spell interruption rate down", offset=1,multiplier=-2,percent=true}},
        [0x486] = {{stat="Occ. inc. resist. to stat. ailments", offset=1,multiplier=2}},
	    [0x4DE] = {{stat="Pet: Phys. dmg. taken", offset=1,multiplier=-2,percent=true}},
	    [0x4DF] = {{stat="Pet: Magic dmg. taken", offset=1,multiplier=-2,percent=true}},
        [0x4E0] = {{stat="Enh. Mag. eff. dur.", offset=1}},
        [0x4E1] = {{stat="Helix eff. dur.", offset=1}},
        [0x4E2] = {{stat="Indi. eff. dur.", offset=1}},
        [0x4F0] = {{stat="Meditate eff. dur.", offset=1}},
        [0x548] = {{stat='Enfeebling Magic duration', offset=0,multiplier=0}},
        [0x549] = {{stat='Magic Accuracy', offset=0,multiplier=0}},
        [0x54A] = {{stat='Enhancing Magic duration', offset=0,multiplier=0}},
        [0x54B] = {{stat='Enspell Damage', offset=0,multiplier=0}},
        [0x54C] = {{stat='Accuracy', offset=0,multiplier=0}},
        [0x54D] = {{stat='Immunobreak Chance', offset=0,multiplier=0}},
        [0x700] = {{stat="Pet: STR", offset=1}},
        [0x701] = {{stat="Pet: DEX", offset=1}},
        [0x702] = {{stat="Pet: VIT", offset=1}},
        [0x703] = {{stat="Pet: AGI", offset=1}},
        [0x704] = {{stat="Pet: INT", offset=1}},
        [0x705] = {{stat="Pet: MND", offset=1}},
        [0x706] = {{stat="Pet: CHR", offset=1}},
        [0x707] = {{stat="Pet: STR", offset=1,multiplier=-1}},
        [0x708] = {{stat="Pet: DEX", offset=1,multiplier=-1}},
        [0x709] = {{stat="Pet: VIT", offset=1,multiplier=-1}},
        [0x70A] = {{stat="Pet: AGI", offset=1,multiplier=-1}},
        [0x70B] = {{stat="Pet: INT", offset=1,multiplier=-1}},
        [0x70C] = {{stat="Pet: MND", offset=1,multiplier=-1}},
        [0x70D] = {{stat="Pet: CHR", offset=1,multiplier=-1}},
        [0x70E] = {{stat="Pet: STR", offset=1},{stat="Pet: DEX", offset=1},{stat="Pet: VIT", offset=1}},
		[0x70F] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x710] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x711] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x712] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x713] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x714] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x715] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x716] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x717] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x718] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x719] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x71A] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x71B] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x71C] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x71D] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x71E] = {{stat="Pet:", offset=0,multiplier=0}},
        [0x71F] = {{stat="Pet:", offset=0,multiplier=0}},}
    local aug_npc = nil

    function augmentation_engine()
        if not enabled then return end
        local p = get_player_data()
        if not p then enabled = false return end
        if os.clock() - last_trade > settings.delay and p.status == 0 then
            if settings.mode == 'Skirmish' then
                trade_items(skirmish_npc)
            elseif settings.mode == 'Cape' then
                trade_items(cape_npc)
            elseif settings.mode == 'Geas Fete' then
                trade_items(oseem_npc)
            else
                log('Wrong Mode')
                enabled = false
                return
            end
        end
    end

    -- get environmental variables
    function start_augmentation()
        world = get_info()
        local zones = get_res_all_zones()
        if world and zones and zones[world.zone].en == "Western Adoulin" then
            get_adoulin_npc_data()
            -- Start the engine
            enabled = true
        elseif world and zones and zones[world.zone].en == "Norg" then
            get_norg_npc_data()
            -- Start the engine
            enabled = true
        else
            log('Wrong Zone')
        end
    end

    function stop_augmentation()
        log('Stopping Augs')
        enabled = false
        -- special abort due to Oseem
        if aug_npc and oseem_npc and oseem_npc.index == aug_npc.index then
            log('Reset Oseem')
            reject(oseem_npc)
        end
    end

    function get_adoulin_npc_data()
        local mob_array = get_mob_array()
        for id, mob in pairs(mob_array) do
            -- Find the skirmish NPC
            if mob and mob.name == 'Divainy-Gamainy' then
                log('Divainy-Gamainy found!')
                skirmish_npc = mob
                skirmish_npc.reject_option = 262
                skirmish_npc.reject_unknown = 0
                skirmish_npc.accept_option = 7
            end
            -- Find the JSE Cape NPC
            if mob and mob.name == 'Detrovio' then
                log('Detrovio found!')
                cape_npc = mob
                cape_npc.reject_option = 262
                cape_npc.reject_unknown = 0
                cape_npc.accept_option = 7
            end
        end
    end
        
    function get_norg_npc_data()
        local mob_array = get_mob_array()
        for id, mob in pairs(mob_array) do
            -- Find the Oseem NPC
            if mob and mob.name == 'Oseem' then
                log('Oseem found!')
                oseem_npc = mob
                oseem_npc.reject_option = 0
                oseem_npc.reject_unknown = 16384
                oseem_npc.accept_option = 9
            end
        end
    end

    function trade_items(npc)
        if not npc or not npc.id or npc.distance:sqrt() > 6 then info('No target or too far away!') enabled = false return end

        -- Find the base item data
        local base_item = get_item_res(settings.trade_item)
        if not base_item then info('Unable to find base item data ['..settings.trade_item..']!') enabled = false return end

        -- Find the material item data
        local material_item = nil
        if settings.mode ~= 'Geas Fete' then
            material_item = get_item_res(settings.trade_material)
        else
            material_item = settings.trade_material
        end
        if not material_item then info('Unable to find materials data ['..settings.trade_material..']!') enabled = false return end

        -- Grab the player inventory to determine index
        local inventory = get_items(0)
        if not inventory then info('Unable to load inventory!') enabled = false return end

        local base_index = find_item(inventory, base_item.id)
        if not base_index then info('Unable to find base item ['..settings.trade_item..'] in your inventory!') enabled = false return end

        local material_index = nil
        local material_amount = 1
        local number_of_items = 2
        if settings.mode ~= 'Geas Fete' then
            material_index = find_item(inventory, material_item.id)
        else
            material_index = 0
            material_amount = 0
            number_of_items = 1
        end
        if not material_index then log('Unable to find materials ['..settings.trade_material..'] in your inventory!') enabled = false return end

        -- Item Count, Item Index, Target Index, Number of Items
        local menu_item = 'C4I11C10HI':pack(0x36,0x20,0x00,0x00,npc.id,
        1,material_amount,0,0,0,0,0,0,0,0x00,
        base_index,material_index,0,0,0,0,0,0,0,0x00,
        npc.index,number_of_items)

        last_trade = os.clock()
        -- Store which NPC is being used to cancel if stopped
        aug_npc = npc
        inject_packet_outgoing(0x36, menu_item)
    end

    function get_item_res(item)
        for k,v in pairs(get_res_all_items()) do
            if v.en:lower() == item:lower() or v.enl:lower() == item:lower() then
                return v
            end
        end
        return nil
    end

    function find_item(inventory, item_id)
        for k, v in ipairs(inventory) do
            if v.id == item_id then
                -- log('Item ['..item_id..'] at position ['..v.slot..'] found in the inventory.')
                return v.slot
            end
        end
        return nil
    end

    -- 0x034 response packet
    function augmentation_npc_response(packet)
        if not enabled then return end    

        -- Alluvian Skirmish NPC
        if skirmish_npc and skirmish_npc.index == packet['NPC Index'] then

            skirmish_npc.menu = packet['Menu ID']

            -- New parameters
            local newAugs = packet['Menu Parameters']:sub(21)
            local results = decode_augment(newAugs)

            -- Inject the correct packets
            process_response(results, skirmish_npc)

            -- Block the menu
            return true
        end

        -- JSE Cape
        if cape_npc and cape_npc.index == packet['NPC Index'] then

            cape_npc.menu = packet['Menu ID']

            -- New parameters
            local newAugs = packet['Menu Parameters']:sub(21)
            local results = decode_augment(newAugs)

            -- Inject the correct packets
            process_response(results, cape_npc)

            -- Block the menu
            return true
        end

        -- Oseem initial trade
        if oseem_npc and oseem_npc.index == packet['NPC Index'] then
            -- Store the Menu ID
            oseem_npc.menu = packet['Menu ID']
            -- Log the state of the materials
            oseem_npc.pellucid = packet['Menu Parameters']:byte(1)
            oseem_npc.fern = packet['Menu Parameters']:byte(2)
            oseem_npc.taupe = packet['Menu Parameters']:byte(3)
            oseem_npc.dark = packet['Menu Parameters']:byte(4)
            -- This sets the possible styles based off the gear (index in the gear_style_types table)
            oseem_npc.gear = packet['Menu Parameters']:byte(5)
            -- Send the response to set the style and block menu if valid
            if submit_response(settings.style, settings.trade_material) then 
                return true
            else
                stop_augmentation()
            end
        end

    end

    function submit_response(style,stone)
        if not style or not stone then log('Abort Submit Response') return false end
        log('Style is ['..style..'] and using Stone ['..stone..'].')

        -- Check for sufficient Stones
        if stone == "Pellucid Stones" then 
            if oseem_npc.pellucid < 1 then info('Out of materials!') return false 
            else oseem_npc.pellucid = oseem_npc.pellucid -1 end
        elseif stone == "Fern Stones" then
            if oseem_npc.fern < 1 then info('Out of materials!') return false 
            else  oseem_npc.fern = oseem_npc.fern -1 end
        elseif stone == "Taupe Stones" then
            if oseem_npc.taupe < 1 then info('Out of materials!') return false 
            else oseem_npc.taupe = oseem_npc.taupe -1 end
        elseif stone == "Dark Matter" then
            if oseem_npc.dark < 1 then info('Out of materials!') return false 
            else oseem_npc.dark = oseem_npc.dark -1 end
        else return false end

        local item_styles = gear_style_types[oseem_npc.gear]

        if not item_styles then info('Style not found!') return false end

        if item_styles[1] ~= style and item_styles[2] ~= style and item_styles[3] ~= style and item_styles[4] ~= style and item_styles[5] ~= style then info('Wrong style set for the item!') return false end

        --info('Materials: Pellucid ['..oseem_npc.pellucid..'], Fern ['..oseem_npc.fern..'], Taupe ['..oseem_npc.taupe..'], Dark ['..oseem_npc.dark..']')

        local inject = new_packet("outgoing", 0x5B, {
            ['Target'] = oseem_npc.id,
            ['Option Index'] = style_types[style],
            ['_unknown1'] = stone_types[stone],
            ['Target Index'] = oseem_npc.index,
            ['Automated Message'] = true,
            ['Zone'] = world.zone,
            ['Menu ID'] = oseem_npc.menu
        })
        inject_packet(inject)
        --packet_log(inject, "outgoing")
        return true
    end

    -- Process the augment respnose 0x05C
    function start_oseem(data)
        local packet = parse_packet('incoming', data)
        -- New parameters
        local newAugs = packet['Menu Parameters']:sub(21)
        local results = decode_augment(newAugs)

        -- Inject the correct packets
        process_response(results, oseem_npc)
    end

    function process_response(results, npc)
        local match = false
        local number = 0

        local augment_1_results = check_augment(settings.augment_1, settings.watch_value_1, results)
        local augment_2_results = check_augment(settings.augment_2, settings.watch_value_2, results)
        local augment_3_results = check_augment(settings.augment_3, settings.watch_value_3, results)

        log(augment_1_results)
        log(augment_2_results)
        log(augment_3_results)

        if settings.augment_mode == 'or' then
            if augment_1_results or augment_2_results or augment_3_results then
                match = true
                info('Match Found!')
            end
        else
            -- Three Augments
            if settings.watch_value_1 ~= nil and settings.watch_value_2 ~= nil and settings.watch_value_3 ~= nil then
                log('3 Augments detected')
                if augment_1_results and augment_2_results and augment_3_results then
                    match = true
                    info('Match Found!')
                end
            -- Two Augments
            elseif settings.watch_value_1 ~= nil and settings.watch_value_2 ~= nil then
                log('2 Augments detected')
                if augment_1_results and augment_2_results then
                    match = true
                    info('Match Found!')
                end
            -- One Augments
            elseif settings.watch_value_1 ~= nil then
                log('1 Augments detected')
                if augment_1_results then
                    match = true
                    info('Match Found!')
                end
            end
        end

        -- Log the values
        local display_values = ''
        local count = 1
        for k,v in pairs(results) do
            display_values = display_values..firstToUpper(k)..' ['..v..'], '
            count = count + 1
        end
        display_values = display_values:sub(1, #display_values - 2)
        info(display_values) 

        if match then
            enabled = false
            accept(npc)
        else
            if oseem_npc and npc.index == oseem_npc.index then
                log('Oseem continue')
                if settings.delay then
                    coroutine.schedule(delay_augment, settings.delay)
                else
                    stop_augmentation()
                end
            else
                reject(npc)
            end
        end
    end

    function delay_augment()        
        if not submit_response(settings.style, settings.trade_material) then 
            stop_augmentation()
        end
    end

    function check_augment(augment, value, results)
        
        -- "any" option
        if augment:contains(' and ') then
            local message = augment:split(' and ')
            if results[message[1]] and results[message[2]] then
                log('Double Augment Found')
                local augment_string = results[message[1]]
                local augment_value = math.abs(tonumber(augment_string))
                if augment_value >= value then
                    return true
                else
                    info('Augment ['..augment..'] with value ['..augment_string..'] found but needs ['..value..'] or more to match.')
                end
            end
        end

        -- Loop through to find single augments
        for k,v in pairs(results) do
            if k:lower() == augment then
                local augment_value = math.abs(tonumber(v))
                if augment_value >= value then
                    return true
                else
                    info('Augment ['..augment..'] with value ['..augment_value..'] found but needs ['..value..'] or more to match.')
                end
            end
            -- An unknown Augment Found
            if k == 'unknown' then
                info('Unknown augment found with a value of ['..v..']')
            end
        end

        return false
    end

    function reject(npc)
        local inject = new_packet("outgoing", 0x5B, {
                ['Target'] = npc.id,
                ['Option Index'] = npc.reject_option,
                ['Target Index'] = npc.index,
                ['Automated Message'] = false,
                ['Zone'] = world.zone,
                ['Menu ID'] = npc.menu,
                ['_unknown1'] = npc.reject_unknown
        })   
        inject_packet(inject)
        --packet_log(inject, "outgoing")
    end

    function accept(npc)
        local inject = new_packet("outgoing", 0x5B, {
                ['Target'] = npc.id,
                ['Option Index'] = npc.accept_option,
                ['Target Index'] = npc.index,
                ['Automated Message'] = false,
                ['Zone'] = world.zone,
                ['Menu ID'] = npc.menu
            })
        inject_packet(inject)
        --packet_log(inject, "outgoing")
    end

    function decode_augment(str)
        local tab = augments_to_table(str:sub(3,12))
	    local res = T{}
	    for k,v in pairs(tab) do
		    local augs = get_augment(v[1])
			for aug in augs:it() do
			    if res:containskey(aug) then
				    res[aug] = res[aug] + v[2]
			    else
				    res[aug] = v[2]
			    end
		    end
	    end
	    return res
    end

    function augments_to_table(str)
        local augments,ids,vals = {},{},{}
        for i=1,#str,2 do
            local id,val = unpack_augment(str:sub(i,i+1))
            augments[#augments+1] = {id,(val+augment_values[id][1].offset)*(augment_values[id][1].multiplier or 1)}
        end
        return augments
    end

    function get_augment(id)
	    local ret = L{}
	    if id > 0 then
		    for k,v in pairs(augment_values[id]) do
			    ret:append(v.stat:lower())	
		    end
	    end
	    return ret
    end

    function unpack_augment(short)
	    return short:byte(1) + short:byte(2)%8*256,  math.floor(short:byte(2)/8)
    end

    function set_augmentation_settings(value)
        settings = value
    end

    function get_augmentation_settings()
        return settings
    end

    function get_augmentation_enabled()
        return enabled
    end

end