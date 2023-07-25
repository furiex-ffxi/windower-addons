-- Default trust settings for COR
TrustSettings = {
    Default = {
        -- Roll1=Roll.new("Wizard's Roll", true),
        -- Roll2=Roll.new("Caster's Roll", false),
        -- Roll1=Roll.new("Corsair's Roll", true),
        Roll1=Roll.new("Corsair's Roll", true),
        Roll2=Roll.new("Samurai Roll", false),
        -- Roll1=Roll.new("Beast Roll", true),
        -- Roll2=Roll.new("Companion's Roll", false),
        Skillchains = {
            defaultws = {'Leaden Salute','Savage Blade'},
            tpws = {'Leaden Salute','Savage Blade'},
            spamws = {'Savage Blade'},
            starterws = {'Leaden Salute','Savage Blade'},
            preferws = {'Leaden Salute','Savage Blade'},
            cleavews = {},
            amws = 'Leaden Salute'
        }
    }
}
return TrustSettings

