-- Default trust settings for WAR
TrustSettings = {
    Default = {
        JobAbilities = S{
            'Berserk',
            'Aggressor',
            'Warcry',
            'Restraint',
            'Blood Rage',
            'Retaliation',
        },
        Skillchains = {
            defaultws = {'Ground Strike','Dragon Kick','Herculean Slash','Upheaval','Full Break',"King's Justice","Ukko's Fury",'Savage Blade','Impulse Drive'},
            tpws = {},
            spamws = {'Impulse Drive','Upheaval','Savage Blade','Judgment'},
            starterws = {'Upheaval','Impulse Drive'},
            preferws = {'Ground Strike',"King's Justice",'Upheaval','Steel Cyclone','Savage Blade','Full Break','Impulse Drive',"Ukko's Fury"},
            cleavews = {'Fell Cleave','Cyclone'},
            amws = "King's Justice"
        },
    }
}
return TrustSettings