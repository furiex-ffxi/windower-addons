-- Default trust settings for GEO
TrustSettings = {
    Default = {
        JobAbilities = S{
        },
        SelfBuffs = S{
        },
        PartyBuffs = S{
            Spell.new('Indi-Fury', L{'Entrust'}, L{'DRK','SAM'}),
            -- Spell.new('Indi-Refresh', L{'Entrust'}, L{'DRK'})
        },
        Geomancy = {
            -- Indi = Spell.new('Indi-Haste', L{}, L{}),
            Indi = Spell.new('Indi-Frailty', L{}, L{}),
            -- Indi = Spell.new('Indi-Acumen', L{}, L{}),
            Geo = Spell.new('Geo-Malaise', L{}, L{}, 'bt')
        },
        Skillchains = {
            defaultws = {'Black Halo'},
            tpws = {'Black Halo'},
            spamws = {'Black Halo'},
            starterws = {},
            preferws = {'Black Halo'},
            cleavews = {},
            amws = 'Exudation'
        }
    }
}
return TrustSettings

