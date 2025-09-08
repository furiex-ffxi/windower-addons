--This file is used to store custom duration bonuses used by the `debuff_icons` and `debuff_timers` options in Bars.
--Please note the servers, character names, and duration labels are case-sensitive.
--Available durations: Angon, Arcane Crest, Dragon Breaker, Enfeebling Magic, Gambit, Hamanoha, Rayke, Sepulcher, Shadowbind, Singing, and Tomahawk.
--Enfeebling Magic and Singing are the total PERCENT bonus from all gear combined. These may vary based on specific gear for specific spells/songs, but a good ballpark average should be fine.
--All abilities are total SECONDS bonus from all gear, merits, and/or job gifts combined.
--Only set duration bonuses that are known. Any duration numbers defined here will be taken as a "known value", meaning if you set a duration to 0 it will assume you have a specific bonus of 0 and will remove the relevant debuff based on that duration. If a specific duration is unknown, do not include it under the character.
--Included by default are my own current durations as an example.

return {
    ["Valefor"]={
        ["Keylesta"]={
            ["Angon"]=0,
            ["Arcane Crest"]=0,
            ["Dragon Breaker"]=0,
            ["Enfeebling Magic"]=10,
            ["Gambit"]=36,
            ["Hamanoha"]=0,
            ["Rayke"]=20,
            ["Sepulcher"]=20,
            ["Shadowbind"]=0,
            ["Singing"]=161,
            ["Tomahawk"]=60,
        },
    },
}