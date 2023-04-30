-- Default trust settings for BRD
TrustSettings = {
    Default = {
        SelfBuffs = L{
            -- Spell.new("Mage's Ballad III", L{'Pianissimo'}, L{'BRD'}),
            -- Spell.new("Mage's Ballad II", L{'Pianissimo'}, L{'BRD'}),
        },
        PartyBuffs = L{
            Spell.new("Mage's Ballad III", L{'Pianissimo'}, L{'BLM','WHM','GEO','SCH','BRD','RDM'}),
            -- Spell.new("Mage's Ballad II", L{'Pianissimo'}, L{'BLM','WHM','GEO','SCH','BRD','RDM'}),
            -- Spell.new("Sage Etude", L{'Pianissimo'}, L{'BLM'}),
        },
        JobAbilities = S{
            'Soul Voice',
            'Clarion Call',
        },
        Debuffs = L{
            Spell.new('Carnage Elegy')
        },
        Songs = L{
            Spell.new("Valor Minuet IV", L{}),
            Spell.new("Valor Minuet V", L{}),
            Spell.new("Blade Madrigal", L{}),
            Spell.new("Honor March", L{'Marcato'}),
            Spell.new("Victory March", L{}),
            -- Spell.new("Valor Minuet III"),
        },
        DummySongs = L{
            Spell.new("Army's Paeon IV"),
            Spell.new("Goddess's Hymnus"),
            Spell.new("Scop's Operetta"),
            Spell.new("Sheepfoe Mambo"),
            Spell.new("Goblin Gavotte")
        },
        NumSongs = 4,
        SongDuration = 240,
        Skillchains = {
            defaultws = {'Rudra\'s Storm','Savage Blade','Mordant Rime','Retribution'},
            tpws = {'Mordant Rime'},
            spamws = {'Savage Blade','Mordant Rime','Rudra\'s Storm'},
            cleavews = {'Aeolian Edge'},
            starterws = {'Savage Blade','Mordant Rime'},
            -- preferws = {'Savage Blade','Mordant Rime',"Rudra's Storm"},
            preferws = {'Rudra\'s Storm',"Exenterator","Evisceration"},
            amws = 'Exenterator'
        }
    }
}
return TrustSettings

