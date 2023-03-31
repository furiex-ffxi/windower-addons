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
            defaultws = {'Resolution','Ground Strike','Dragon Kick','Penta Thrust','Herculean Slash','Upheaval','Full Break',"King's Justice","Ukko's Fury",'Savage Blade','Impulse Drive'},
            tpws = {},
            spamws = {'Impulse Drive','Upheaval','Savage Blade','Judgment'},
            starterws = {'Upheaval'},
            preferws = {'Resolution','Ground Strike',"King's Justice",'Steel Cyclone','Upheaval','Savage Blade','Full Break','Impulse Drive'},
            cleavews = {'Fell Cleave'},
            amws = "King's Justice"
        },
    }
}
return TrustSettings