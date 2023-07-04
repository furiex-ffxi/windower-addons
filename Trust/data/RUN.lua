-- Default trust settings for RUN
TrustSettings = {
    Default = {
        SelfBuffs = S{
            Spell.new('Temper'),
            Spell.new('Crusade'),
            Spell.new('Refresh'),
            Spell.new('Regen IV'),
            Spell.new('Shell V'),
            Spell.new('Phalanx'),
        },
        PartyBuffs = S{
        },
        JobAbilities = S{
            'Swordplay'
        },
        Skillchains = {
            defaultws = {'Resolution','Dimidiation','Steel Cyclone'},
            tpws = {},
            spamws = {'Resolution','Dimidiation','Savage Blade'},
            starterws = {'Resolution','Dimidiation'},
            preferws = {'Resolution','Dimidiation','Savage Blade'},
            cleavews = {},
            amws = 'Dimidiation'
        },
    }
}
return TrustSettings

