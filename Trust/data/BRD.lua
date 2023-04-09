-- Default trust settings for BRD
TrustSettings = {
    Default = {
        SelfBuffs = L{
            Spell.new("Mage's Ballad III", L{'Pianissimo'}),
            Spell.new("Mage's Ballad II", L{'Pianissimo'}),
        },
        PartyBuffs = L{
            Spell.new("Mage's Ballad III", L{'Pianissimo'}, L{'BLM','WHM','GEO','SCH','BRD','DRK','RDM'}),
            Spell.new("Mage's Ballad II", L{'Pianissimo'}, L{'BLM','WHM','GEO','SCH','BRD','RDM'}),
            Spell.new("Mage's Ballad", L{'Pianissimo'}, L{'BLM','WHM','GEO','SCH','BRD','RDM'}),
            Spell.new("Sage Etude", L{'Pianissimo'}, L{'BLM'}),
        },
        Debuffs = L{
            Spell.new('Carnage Elegy')
        },
        Songs = L{
            Spell.new("Valor Minuet IV", L{}),
            Spell.new("Valor Minuet V", L{}),
            Spell.new("Blade Madrigal", L{}),
            Spell.new("Honor March", L{'Marcato'}),
            Spell.new("Valor Minuet III", L{}),
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
            defaultws = {'Exenterator','Savage Blade','Mordant Rime','Retribution'},
            tpws = {'Mordant Rime'},
            spamws = {'Savage Blade','Mordant Rime'},
            cleavews = {'Aeolian Edge'},
            starterws = {'Savage Blade','Mordant Rime'},
            -- preferws = {'Savage Blade','Mordant Rime',"Rudra's Storm"},
            preferws = {"Exenterator","Evisceration"},
            amws = 'Mordant Rime'
        }
    }
}
return TrustSettings

