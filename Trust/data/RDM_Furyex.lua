-- Default trust settings for RDM
TrustSettings = {
    Default = {
        JobAbilities = L{
            'Composure'
        },
        SelfBuffs = L{
            Buff.new('Refresh'),
            Buff.new('Haste'),
            Buff.new('Temper'),
            Spell.new('Enblizzard'),
            -- Spell.new('Gain-INT', L{}, L{}, nil, L{ IdleCondition.new() }),
            Spell.new('Gain-STR', L{}, L{}, nil, L{ InBattleCondition.new() }),
            Spell.new('Phalanx'),
            Buff.new('Protect'),
            Buff.new('Shell'),
            Buff.new('Barthundra')
        },
        PartyBuffs = L{
            Buff.new('Refresh', L{}, L{'DRK','PUP','PLD','BLU','BLM','BRD','GEO','SMN','WHM','RUN', 'RDM'}),
            Buff.new('Haste', L{}, job_util.melee_jobs():extend(L{'SCH','BLM', 'RDM', 'BRD'})),
            Buff.new('Flurry', L{}, L{'RNG'}, nil, L{ IdleCondition.new() }),
            Spell.new('Phalanx II', L{}, job_util.melee_jobs(), nil, L{ InBattleCondition.new() }),
        },
        CureSettings = {
            Thresholds = {
                ['Default'] = 78,
                ['Emergency'] = 50,
                ['Cure IV'] = 800,
                ['Cure III'] = 500,
                ['Cure II'] = 0
            }
        },
        Debuffs = L{
            Debuff.new('Dia'),
            Spell.new('Distract III', L{}, L{}, nil, L{ InBattleCondition.new() }),
            Debuff.new('Distract'),
            Debuff.new('Slow'),
            Debuff.new('Paralyze'),
        },
        Skillchains = {
            defaultws = {'Exenterator','Chant du Cygne','Savage Blade','Seraph Blade','Death Blossom','Black Halo','Evisceration'},
            tpws = {'Savage Blade'},
            spamws = {'Savage Blade','Black Halo','Evisceration'},
            starterws = {'Burning Blade','Death Blossom','Savage Blade','Chant du Cygne'},
            preferws = {'Flat Blade','Death Blossom','Savage Blade','Black Halo','Realmrazer','Evisceration'},
            cleavews = {'Aeolian Edge'},
            amws = 'Death Blossom'
        },
        AutoFood = 'Grape Daifuku'
    },
}
return TrustSettings
