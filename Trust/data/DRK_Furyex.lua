-- Default trust settings for DRK
TrustSettings = {
    Default = {
        SelfBuffs = S{
            Spell.new('Endark II', L{}),
            -- Spell.new('Absorb-DEX', L{}, L{}, 'bt'),
            -- Spell.new('Absorb-STR', L{}, L{}, 'bt'),
            Spell.new('Dread Spikes', L{}, L{}, nil, L{ HasBuffCondition.new('Max HP Boost'), IdleCondition.new() })
        },
        JobAbilities = S{
            'Last Resort',
            'Scarlet Delirium'
        },
        Debuffs = L{
            Spell.new('Drain III'),

        },        
        Skillchains = {
            defaultws = {'Resolution','Cross Reaper','Catastrophe','Insurgency','Entropy','Torcleaver'},
            tpws = {'Cross Reaper'},
            spamws = {'Resolution','Catastrophe','Torcleaver','Entropy','Judgment','Savage Blade'},
            starterws = {'Resolution','Torcleaver','Cross Reaper','Catastrophe','Entropy'},
            -- preferws = {'Cross Reaper','Catastrophe','Torcleaver'},
            preferws = {'Resolution','Catastrophe'},
            cleavews = {'Fell Cleave'},
            amws = 'Catastrophe'
            -- amws = 'Entropy'
        }
    }
}
return TrustSettings

