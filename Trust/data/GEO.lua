-- Default trust settings for GEO
TrustSettings = {
    Default = {
        JobAbilities = S{
        },
        SelfBuffs = S{
        },
        PartyBuffs = S{
            Spell.new('Indi-Acumen', L{'Entrust'}, L{'RDM'}),
            -- Spell.new('Indi-Refresh', L{'Entrust'}, L{'RUN'})
        },
        Geomancy = {
            Indi = Spell.new('Indi-Malaise', L{}, L{}),
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

