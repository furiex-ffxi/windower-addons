--[[
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
]]

_addon.name = 'QuickTrade'
_addon.author = 'Valok@Asura (Update by Daneblood@Phoenix)'
_addon.version = '1.8.3 b190702'
_addon.command = 'qtr'

require('tables')
require('coroutine')
require('sets')
res = require('resources')


local Var_IonisNPC    = S{'Fleuricette', 'Quiri-Aliri'}
local Var_SigilNPC    = S{'Miliart, T.K.', 'Millard, I.M.', 'Mindala-Andola, C.C.'}
local Var_SanctionNPC = S{'Asrahd', 'Famatarthen', 'Falzuuk', 'Nabihwah'}
local Var_SignetNPC   = S{'Flying Axe, I.M.', 'Rabid Wolf, I.M.', 'Crying Wind, I.M.', 'Arpevion, T.K.', 'Aravoge, T.K.', 'Achantere, T.K.', 'Milma-Hapilma, W.W.', 'Puroiko-Maiko, W.W.', 'Harara, W.W.', 'Kochahy-Muwachahy', 'Alrauverat', 'Emitt', 'Morlepiche'}


exampleOnly = false
textSkipTimer = 1
lastNPC = ''

chatColor = 20

loopWait = 0
loopCount = 1
loopModeSet = false
loopable = false
loopMax = 0
loopCurrent = 0
lastLoopNPC = ''

ownedKeyItems = {}
ownedGeasFeteKeyItems = {}
tribulensOrRadialensFound = false




windower.register_event('addon command', function(...)
	loopCount = 1
	loopModeSet = false
	loopable = false
	loopMax = 0
	loopCurrent = 0
	lastLoopNPC = ''
	loopText = ''
	performLoopsAfterAll = 0

	if #arg > 0 and arg[1] == 'loop'then
		loopModeSet = true

		if #arg > 1 and arg[2] then
			if not tonumber(arg[2]) then
				print('Invalid Loop Count Entry: ' .. arg[2])
				return
			end

			loopMax = tonumber(arg[2])
		end
	end


	if loopMax == 0 then
		loopMax = 100000
	end

	while loopCount > 0 and loopCurrent < loopMax do
		loopCurrent = loopCurrent + 1
		quicktrade(arg)

		if loopCount > 0 then
			coroutine.sleep(loopWait)
		end
	end
	
	if performLoopsAfterAll > 0 and not loopModeSet and #arg > 1 and arg[2] == 'loop' then -- test
		print('Looping after All')
		windower.send_command('qtr loop')
	end
end)

function quicktrade(arg)
	-- Tables of the tradeable itemIDs that may be found in the player inventory
	local crystalIDs = {
		{id = 4096, name = 'fire crystal', count = 0, stacks = 0, stacksize = 12},
		{id = 4097, name = 'ice crystal', count = 0, stacks = 0, stacksize = 12},
		{id = 4098, name = 'wind crystal', count = 0, stacks = 0, stacksize = 12},
		{id = 4099, name = 'earth crystal', count = 0, stacks = 0, stacksize = 12},
		{id = 4100, name = 'lightning crystal', count = 0, stacks = 0, stacksize = 12},
		{id = 4101, name = 'water crystal', count = 0, stacks = 0, stacksize = 12},
		{id = 4102, name = 'light crystal', count = 0, stacks = 0, stacksize = 12},
		{id = 4103, name = 'dark crystal', count = 0, stacks = 0, stacksize = 12},
		{id = 4104, name = 'fire cluster', count = 0, stacks = 0, stacksize = 12},
		{id = 4105, name = 'ice cluster', count = 0, stacks = 0, stacksize = 12},
		{id = 4106, name = 'wind cluster', count = 0, stacks = 0, stacksize = 12},
		{id = 4107, name = 'earth cluster', count = 0, stacks = 0, stacksize = 12},
		{id = 4108, name = 'lightning cluster', count = 0, stacks = 0, stacksize = 12},
		{id = 4109, name = 'water cluster', count = 0, stacks = 0, stacksize = 12},
		{id = 4110, name = 'light cluster', count = 0, stacks = 0, stacksize = 12},
		{id = 4111, name = 'dark cluster', count = 0, stacks = 0, stacksize = 12},
	}
	
	local sealIDs = {
		{id = 1126, name = "beastmen's seal", count = 0, stacks = 0, stacksize = 99},
		{id = 1127, name = "kindred's seal", count = 0, stacks = 0, stacksize = 99},
		{id = 2955, name = "kindred's crest", count = 0, stacks = 0, stacksize = 99},
		{id = 2956, name = "high kindred's crest", count = 0, stacks = 0, stacksize = 99},
		{id = 2957, name = "sacred kindred's crest", count = 0, stacks = 0, stacksize = 99},
	}
	
	local moatCarpIDs = {
		{id = 4401, name = 'moat carp', count = 0, stacks = 0, stacksize = 12},
	}
	
	local copperVoucherIDs = {
		{id = 8711, name = 'copper voucher', count = 0, stacks = 0, stacksize = 99},
	}
	
	local silverVoucherIDs = {
		{id = 9277, name = 'Silver voucher', count = 0, stacks = 0, stacksize = 99},
	}

	local remsTaleIDs = {
		{id = 4064, name = "copy of rem's tale, chapter 1", count = 0, stacks = 0, stacksize = 12},
		{id = 4065, name = "copy of rem's tale, chapter 2", count = 0, stacks = 0, stacksize = 12},
		{id = 4066, name = "copy of rem's tale, chapter 3", count = 0, stacks = 0, stacksize = 12},
		{id = 4067, name = "copy of rem's tale, chapter 4", count = 0, stacks = 0, stacksize = 12},
		{id = 4068, name = "copy of rem's tale, chapter 5", count = 0, stacks = 0, stacksize = 12},
		{id = 4069, name = "copy of rem's tale, chapter 6", count = 0, stacks = 0, stacksize = 12},
		{id = 4070, name = "copy of rem's tale, chapter 7", count = 0, stacks = 0, stacksize = 12},
		{id = 4071, name = "copy of rem's tale, chapter 8", count = 0, stacks = 0, stacksize = 12},
		{id = 4072, name = "copy of rem's tale, chapter 9", count = 0, stacks = 0, stacksize = 12},
		{id = 4073, name = "copy of rem's tale, chapter 10", count = 0, stacks = 0, stacksize = 12},
	}

	local mellidoptWingIDs = {
		{id = 9050, name = 'mellidopt wing', count = 0, stacks = 0, stacksize = 12},
	}
	
	local lebondoptWingIDs = {
		{id = 4036, name = 'Lebondopt Wing', count = 0, stacks = 0, stacksize = 12},
	}		

	local salvagePlanIDs = {
		{id = 3880, name = 'copy of bloodshed plans', count = 0, stacks = 0, stacksize = 99},
		{id = 3881, name = 'copy of umbrage plans', count = 0, stacks = 0, stacksize = 99},
		{id = 3882, name = 'copy of ritualistic plans' , count = 0, stacks = 0, stacksize = 99},
		{id = 3883, name = 'Copy of tutelary plans' , count = 0, stacks = 0, stacksize = 99},
		{id = 3884, name = 'Copy of primacy plans' , count = 0, stacks = 0, stacksize = 99},
		
	}

	local alexandriteIDs = {
		{id = 2488, name = 'alexandrite', count = 0, stacks = 0, stacksize = 99},
	}

	local soulPlateIDs = {
		{id = 2477, name = 'soul plate', count = 0, stacks = 0, stacksize = 1}, -- Can only trade 10 per Vana'diel day
	}
	
	local spGobbieKeyIDs = {
		{id = 8973, name = 'special gobbiedial key', count = 0, stacks = 0, stacksize = 99},
		{id = 9217, name = 'Dial Key "#AB"', count = 0, stacks = 0, stacksize = 99},
	}

	local zincOreIDs = {
		{id = 642, name = 'zinc ore', count = 0, stacks = 0, stacksize = 12},
	}

	local yagudoNecklaceIDs = {
		{id = 498, name = 'yagudo necklace', count = 0, stacks = 0, stacksize = 12},
	}

	local mandragoraMadIDs = {
		{id = 17344, name = 'cornette', count = 0, stacks = 0, stacksize = 1},
		{id = 4369, name = 'four-leaf mandragora bud', count = 0, stacks = 0, stacksize = 1},
		{id = 1150, name = 'snobby letter', count = 0, stacks = 0, stacksize = 1},
		{id = 1154, name = 'three-leaf mandragora bud', count = 0, stacks = 0, stacksize = 1},
		{id = 934, name = 'pinch of yuhtunga sulfur', count = 0, stacks = 0, stacksize = 1},
	}

	local onlyTheBestIDs = {
		{id = 4366, name = 'la theine cabbage', count = 0, stacks = 0, stacksize = 12},
		{id = 629, name = 'millioncorn', count = 0, stacks = 0, stacksize = 12},
		{id = 919, name = 'boyahda moss', count = 0, stacks = 0, stacksize = 12},
	}
	
	local theDarksmithIDs = {
		{id = 645, name = 'Darksteel Ore', count = 0, stacks = 0, stacksize = 12, minimum = 2},
	}

	local jseCapeIDs = {
		{id = 28617, name = "mauler's mantle", count = 0, stacks = 0, stacksize = 1},
		{id = 28618, name = "anchoret's mantle", count = 0, stacks = 0, stacksize = 1},
		{id = 28619, name = 'mending cape', count = 0, stacks = 0, stacksize = 1},
		{id = 28620, name = 'bane cape', count = 0, stacks = 0, stacksize = 1},
		{id = 28621, name = 'ghostfyre cape', count = 0, stacks = 0, stacksize = 1},
		{id = 28622, name = 'canny cape', count = 0, stacks = 0, stacksize = 1},
		{id = 28623, name = 'weard mantle', count = 0, stacks = 0, stacksize = 1},
		{id = 28624, name = 'niht mantle', count = 0, stacks = 0, stacksize = 1},
		{id = 28625, name = "pastoralist's mantle", count = 0, stacks = 0, stacksize = 1},
		{id = 28626, name = "rhapsode's cape", count = 0, stacks = 0, stacksize = 1},
		{id = 28627, name = 'lutian cape', count = 0, stacks = 0, stacksize = 1},
		{id = 28628, name = 'takaha mantle', count = 0, stacks = 0, stacksize = 1},
		{id = 28629, name = 'yokaze mantle', count = 0, stacks = 0, stacksize = 1},
		{id = 28630, name = 'updraft mantle', count = 0, stacks = 0, stacksize = 1},
		{id = 28631, name = 'conveyance cape', count = 0, stacks = 0, stacksize = 1},
		{id = 28632, name = 'cornflower cape', count = 0, stacks = 0, stacksize = 1},
		{id = 28633, name = "gunslinger's cape", count = 0, stacks = 0, stacksize = 1},
		{id = 28634, name = 'dispersal mantle', count = 0, stacks = 0, stacksize = 1},
		{id = 28635, name = 'toetapper mantle', count = 0, stacks = 0, stacksize = 1},
		{id = 28636, name = "bookworm's cape", count = 0, stacks = 0, stacksize = 1},
		{id = 28637, name = 'lifestream cape', count = 0, stacks = 0, stacksize = 1},
		{id = 28638, name = "evasionist's cape", count = 0, stacks = 0, stacksize = 1},
		{id = 27596, name = 'mecistopins mantle', count = 0, stacks = 0, stacksize = 1},
	}

	local ancientBeastcoinIDs = {
		{id = 1875, name = 'ancient beastcoin', count = 0, stacks = 0, stacksize = 99},
	}

	local reisenjimaStones = {
		{id = 9210, name = 'pellucid stone', count = 0, stacks = 0, stacksize = 12},
		{id = 9211, name = 'fern stone', count = 0, stacks = 0, stacksize = 12},
		{id = 9212, name = 'taupe stone', count = 0, stacks = 0, stacksize = 12},
	}

	local befouledWaterIDs = {
		{id = 9008, name = 'befouled water', count = 0, stacks = 0, stacksize = 1},
	}

	local geasFeteZitahIDs = {
		{id = 4061, name = 'riftborn boulder', count = 0, stacks = 0, stacksize = 99, ki = 2917, minimum = 5}, -- "Fleetstalker's claw"
		{id = 4060, name = 'beitetsu', count = 0, stacks = 0, stacksize = 99, ki = 2918, minimum = 5}, -- "Shockmaw's blubber"
		{id = 4059, name = 'pluton', count = 0, stacks = 0, stacksize = 99, ki = 2919, minimum = 5}, -- "Urmahlullu's armor"
		{id = 9060, name = 'ethereal incense', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 5}, -- multiple options
		{id = 9057, name = "ayapec's shell", count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 5}, -- multiple options
		{id = 4398, name = 'fish mithkabob', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 6},
		{id = 16581, name = 'holy sword', count = 0, stacks = 0, stacksize = 1, ki = "", minimum = 1},
		{id = 16564, name = 'flame blade', count = 0, stacks = 0, stacksize = 1, ki = "", minimum = 1},
		{id = 745, name = 'gold ingot', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 2},
		{id = 829, name = 'silk cloth', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 2},
		{id = 717, name = 'mahogany lumber', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 3},
		{id = 654, name = 'darksteel ingot', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 2},
		{id = 1629, name = 'buffalo leather', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 2},
		{id = 13091, name = 'carapace gorget', count = 0, stacks = 0, stacksize = 1, ki = "", minimum = 1},
	}

	local geasFeteRuaunIDs = {
		{id = 9103, name = "vidmapire's claw", count = 0, stacks = 0, stacksize = 12, ki = 2939, minimum = 5}, -- "Palila's talon"
		{id = 9059, name = "azrael's eye", count = 0, stacks = 0, stacksize = 12, ki = 2940, minimum = 5}, -- "Hanbi's nail"
		{id = 9104, name = "centurio's armor", count = 0, stacks = 0, stacksize = 12, ki = 2941, minimum = 5}, -- "Yilan's scale"
		{id = 9097, name = "mhuufya's beak", count = 0, stacks = 0, stacksize = 12, ki = 2942, minimum = 5}, -- "Amymone's tooth"
		{id = 9051, name = "camahueto's fur", count = 0, stacks = 0, stacksize = 12, ki = 2943, minimum = 5}, -- "Naphula's bracelet"
		{id = 9031, name = "vedrfolnir's wing", count = 0, stacks = 0, stacksize = 12, ki = 2944, minimum = 5}, -- "Kammavaca's binding"
	--	{id = 4013, name = 'waktza crest', count = 0, stacks = 0, stacksize = 12, ki = 2945, minimum = 1}, -- "Pakecet's blubber"
	--	{id = 4015, name = 'yggdreant root', count = 0, stacks = 0, stacksize = 12, ki = 2946, minimum = 1}, -- "Duke Vepar's signet"
	--	{id = 8754, name = 'cehuetzi pelt', count = 0, stacks = 0, stacksize = 12, ki = 2947, minimum = 1}, -- "Vir'ava's stalk"
		{id = 4479, name = 'bhefhel marlin', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 1},
		{id = 4563, name = 'pamama tart', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 1},
		{id = 746, name = 'platinum ingot', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 2},
		{id = 652, name = 'steel ingot', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 2},
		{id = 719, name = 'ebony lumber', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 2},
		{id = 2124, name = 'catoblepas leather', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 2},
		{id = 931, name = 'cermet chunk', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 2},
		{id = 2288, name = 'karakul cloth', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 2},
		{id = 13981, name = 'turtle bangles', count = 0, stacks = 0, stacksize = 1, ki = "", minimum = 1},
	}

	local geasFeteReisenjimaIDs = {
		{id = 6286, name = "ymmr-ulvid's grand coffer", count = 0, stacks = 0, stacksize = 99, ki = 3003, minimum = 2}, -- "Strophadia's pearl"
		{id = 6288, name = "ignor-mnt's grand coffer", count = 0, stacks = 0, stacksize = 99, ki = 3004, minimum = 2}, -- "Gajasimha's mane"
		{id = 6290, name = "durs-vike's grand coffer", count = 0, stacks = 0, stacksize = 99, ki = 3005, minimum = 2}, -- "Ironside's maul"
		{id = 6292, name = "tryl-wuj's grand coffer", count = 0, stacks = 0, stacksize = 99, ki = 3006, minimum = 2}, -- "Sarsaok's hoard"
		{id = 6294, name = "liij-vok's grand coffer", count = 0, stacks = 0, stacksize = 99, ki = 3007, minimum = 2}, -- "Old Shuck's tuft"
		{id = 6296, name = "gramk-droog's grand coffer", count = 0, stacks = 0, stacksize = 99, ki = 3008, minimum = 1}, -- "Bashmu's trinket"
	--	{id = 9151, name = "sovereign behemoth's hide", count = 0, stacks = 0, stacksize = 12, ki = 3009, minimum = 1}, -- "Maju's claw"
	--	{id = 9149, name = "hidhaegg's scale", count = 0, stacks = 0, stacksize = 12, ki = 3010, minimum = 1}, -- "Yakshi's scroll"
	--	{id = 9150, name = "tolba's shell", count = 0, stacks = 0, stacksize = 12, ki = 3011, minimum = 1}, -- "Neak's treasure"
		{id = 4471, name = 'bladefish', count = 0, stacks = 0, stacksize = 1, ki = "", minimum = 1},
		{id = 12302, name = 'darksteel buckler', count = 0, stacks = 0, stacksize = 1, ki = "", minimum = 1},
		{id = 862, name = 'behemoth leather', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 1},
		{id = 720, name = 'ancient lumber', count = 0, stacks = 0, stacksize = 12, ki = "", minimum = 2},
		{id = 13206, name = 'gold obi', count = 0, stacks = 0, stacksize = 1, ki = "", minimum = 1},
		{id = 13983, name = 'gold bangles', count = 0, stacks = 0, stacksize = 1, ki = "", minimum = 1},
		{id = 17601, name = "demon's knife", count = 0, stacks = 0, stacksize = 1, ki = "", minimum = 1},
		{id = 16502, name = 'venom knife', count = 0, stacks = 0, stacksize = 1, ki = "", minimum = 1},
		{id = 4418, name = 'turtle soup', count = 0, stacks = 0, stacksize = 1, ki = "", minimum = 1},
	}

	local skirmishIDs = {
		{id = 3951, name = 'Wailing Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 3952, name = 'Wailing Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 3953, name = 'Wailing Stone +2', count = 0, stacks = 0, stacksize = 12},
		{id = 3954, name = 'Ghastly Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 3955, name = 'Ghastly Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 3956, name = 'Ghastly Stone +2', count = 0, stacks = 0, stacksize = 12},		
		{id = 4033, name = 'Verdigris St.', count = 0, stacks = 0, stacksize = 12},
		{id = 4034, name = 'Verdigris St. +1', count = 0, stacks = 0, stacksize = 12},
		{id = 4035, name = 'Verdigris St. +2', count = 0, stacks = 0, stacksize = 12},				
		{id = 8930, name = 'Snowslit Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8931, name = 'Snowslit Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8932, name = 'Snowslit Stone +2', count = 0, stacks = 0, stacksize = 12},
		{id = 8933, name = 'Leafslit Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8934, name = 'Leafslit Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8935, name = 'Leafslit Stone +2', count = 0, stacks = 0, stacksize = 12},
		{id = 8936, name = 'Duskslit Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8937, name = 'Duskslit Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8938, name = 'Duskslit Stone +2', count = 0, stacks = 0, stacksize = 12},
		{id = 8939, name = 'Snowtip Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8940, name = 'Snowtip Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8941, name = 'Snowtip Stone +2', count = 0, stacks = 0, stacksize = 12},		
		{id = 8942, name = 'Leaftip Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8943, name = 'Leaftip Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8944, name = 'Leaftip Stone +2', count = 0, stacks = 0, stacksize = 12},		
		{id = 8945, name = 'Dusktip Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8946, name = 'Dusktip Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8947, name = 'Dusktip Stone +2', count = 0, stacks = 0, stacksize = 12},
		{id = 8948, name = 'Snowdim Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8949, name = 'Snowdim Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8950, name = 'Snowdim Stone +2', count = 0, stacks = 0, stacksize = 12},
		{id = 8951, name = 'Leafdim Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8952, name = 'Leafdim Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8953, name = 'Leafdim Stone +2', count = 0, stacks = 0, stacksize = 12},		
		{id = 8954, name = 'Duskdim Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8955, name = 'Duskdim Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8956, name = 'Duskdim Stone +2', count = 0, stacks = 0, stacksize = 12},
		{id = 8957, name = 'Snoworb Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8958, name = 'Snoworb Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8959, name = 'Snoworb Stone +2', count = 0, stacks = 0, stacksize = 12},
		{id = 8960, name = 'Leaforb Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8961, name = 'Leaforb Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8962, name = 'Leaforb Stone +2', count = 0, stacks = 0, stacksize = 12},		
		{id = 8963, name = 'Duskorb Stone', count = 0, stacks = 0, stacksize = 12},
		{id = 8964, name = 'Duskorb Stone +1', count = 0, stacks = 0, stacksize = 12},
		{id = 8965, name = 'Duskorb Stone +2', count = 0, stacks = 0, stacksize = 12},
	}
	
	local delveEntranceIDs = {
		{id = 3960, name = 'Celadon Yggrete', count = 0, stacks = 0, stacksize = 1, ki = 2296, minimum = 1},
		{id = 3961, name = 'Zaffre Yggrete', count = 0, stacks = 0, stacksize = 1, ki = 22967, minimum = 1},
		{id = 3962, name = 'Alizarin Yggrete', count = 0, stacks = 0, stacksize = 1, ki = 2298, minimum = 1},
		{id = 8755, name = 'Phlox Yggrete', count = 0, stacks = 0, stacksize = 1},
		{id = 8756, name = 'Russet Yggrete', count = 0, stacks = 0, stacksize = 1},
		{id = 8757, name = 'Aster Yggrete', count = 0, stacks = 0, stacksize = 1},		
	}	
	
	local HPbayldIDs = {
		{id = 8798, name = 'H-P Bayld ', count = 0, stacks = 0, stacksize = 1},
	}
		
	local ancientCurrencyByneIDs = {
		{id = 1455, name = '1 Byne Bill', count = 0, stacks = 0, stacksize = 99, minimum = 100},
	}	
	
	local ancientCurrencyBronzeIDs = {
		{id = 1452, name = 'O. Bronzepiece' , count = 100, stacks = 0, stacksize = 99, minimum = 100},
	}	
	
	local ancientCurrencyWhiteshellIDs = {
		{id = 1449, name = 'T. Whiteshell', count = 0, stacks = 0, stacksize = 99, minimum = 100},
	}	
	
	local BonanzaIDs = {
		{id = 2559, name = 'Bonanza Marble', count = 0, stacks = 0, stacksize = 1, minimum = 1},
	}	
	
	local ExitSandyIDs = {
		{id = 958, name = 'Marguerite', count = 0, stacks = 0, stacksize = 1, minimum = 1},
	}	
	
	local ExitBastyIDs = {
		{id = 957, name = 'Amaryllis', count = 0, stacks = 0, stacksize = 1, minimum = 1},
	}	
	
	local ExitWindyIDs = {
		{id = 956, name = 'Lilac', count = 0, stacks = 0, stacksize = 1, minimum = 1},
	}	
	
	local MeeblesIDs = {
		{id = 3875, name = 'Diligence Grimoire', count = 0, stacks = 0, stacksize = 1, minimum = 1},
	}	
	
	local ArchaicMirrorIDs = {
		{id = 2174, name = 'Archaic Mirror', count = 0, stacks = 0, stacksize = 1, minimum = 1},
	}	
	

	
	local npcTable = {
		{name = 'Shami', idTable = sealIDs, tableType = 'Seals', loopable = true, loopWait = 3},
		{name = 'Ephemeral Moogle', idTable = crystalIDs, tableType = 'Crystals', loopable = true, loopWait = 9},
		{name = 'Waypoint', idTable = crystalIDs, tableType = 'Crystals', loopable = true, loopWait = 3},
		{name = 'Joulet', idTable = moatCarpIDs, tableType = 'Moat Carp', loopable = true, loopWait = 4},
		{name = 'Gallijaux', idTable = moatCarpIDs, tableType = 'Moat Carp', loopable = true, loopWait = 4},
		{name = 'Isakoth', idTable = copperVoucherIDs, tableType = 'Copper Vouchers', loopable = true, loopWait = 3},
		{name = 'Rolandienne', idTable = copperVoucherIDs, tableType = 'Copper Vouchers', loopable = true, loopWait = 3},
		{name = 'Fhelm Jobeizat', idTable = copperVoucherIDs, tableType = 'Copper Vouchers', loopable = true, loopWait = 3},
		{name = 'Eternal Flame', idTable = copperVoucherIDs, tableType = 'Copper Vouchers', loopable = true, loopWait = 3},
		{name = 'Monisette', idTable = remsTaleIDs, tableType = "Rem's Tales", loopable = true, loopWait = 3},
		{name = '???', idTable = mellidoptWingIDs, tableType = 'Mellidopt Wings', loopable = true, loopWait = 5},
		{name = 'Mrohk Sahjuuli', idTable = salvagePlanIDs, tableType = 'Salvage Plans', loopable = true, loopWait = 5},
		{name = 'Paparoon', idTable = alexandriteIDs, tableType = 'Alexandrite', loopable = true, loopWait = 5},
		{name = 'Mystrix', idTable = spGobbieKeyIDs, tableType = 'Special Gobbiedial Keys', loopable = true, loopWait = 14},
		{name = 'Habitox', idTable = spGobbieKeyIDs, tableType = 'Special Gobbiedial Keys', loopable = true, loopWait = 14},
		{name = 'Bountibox', idTable = spGobbieKeyIDs, tableType = 'Special Gobbiedial Keys', loopable = true, loopWait = 14},
		{name = 'Specilox', idTable = spGobbieKeyIDs, tableType = 'Special Gobbiedial Keys', loopable = true, loopWait = 14},
		{name = 'Arbitrix', idTable = spGobbieKeyIDs, tableType = 'Special Gobbiedial Keys', loopable = true, loopWait = 14},
		{name = 'Funtrox', idTable = spGobbieKeyIDs, tableType = 'Special Gobbiedial Keys', loopable = true, loopWait = 14},
		{name = 'Priztrix', idTable = spGobbieKeyIDs, tableType = 'Special Gobbiedial Keys', loopable = true, loopWait = 14},
		{name = 'Sweepstox', idTable = spGobbieKeyIDs, tableType = 'Special Gobbiedial Keys', loopable = true, loopWait = 14},
		{name = 'Wondrix', idTable = spGobbieKeyIDs, tableType = 'Special Gobbiedial Keys', loopable = true, loopWait = 14},
		{name = 'Rewardox', idTable = spGobbieKeyIDs, tableType = 'Special Gobbiedial Keys', loopable = true, loopWait = 14},
		{name = 'Winrix', idTable = spGobbieKeyIDs, tableType = 'Special Gobbiedial Keys', loopable = true, loopWait = 14},
		{name = 'Talib', idTable = zincOreIDs, tableType = 'Zinc Ore', loopable = true, loopWait = 3},
		{name = 'Nanaa Mihgo', idTable = yagudoNecklaceIDs, tableType = 'Yagudo Necklaces', loopable = true, loopWait = 10},
		{name = 'Yoran-Oran', idTable = mandragoraMadIDs, tableType = 'Mandragora Mad Items', loopable = true, loopWait = 8},
		{name = 'Melyon', idTable = onlyTheBestIDs, tableType = 'Only the Best Items', loopable = true, loopWait = 10},
		{name = 'Sanraku', idTable = soulPlateIDs, tableType = 'Soul Plates', loopable = true, loopWait = 10},
		{name = 'A.M.A.N. Reclaimer', idTable = jseCapeIDs, tableType = 'JSE Capes', loopable = true, loopWait = 4},
		{name = 'Makel-Pakel', idTable = jseCapeIDs, tableType = 'JSE Capes x3', loopable = false, loopWait = 0},
		{name = 'Sagheera', idTable = ancientBeastcoinIDs, tableType = 'Ancient Beastcoins', loopable = true, loopWait = 3},
		{name = 'Oseem', idTable = reisenjimaStones, tableType = 'Reisenjima Stones', loopable = true, loopWait = 5},
		{name = 'Odyssean Passage', idTable = befouledWaterIDs, tableType = 'Befouled Water', loopable = false, loopWait = 10},
		{name = 'Affi', idTable = geasFeteZitahIDs, tableType = "Geas Fete Zi'Tah Items", loopable = false, loopWait = 0},
		{name = 'Dremi', idTable = geasFeteRuaunIDs, tableType = "Geas Fete Ru'Aun Items", loopable = false, loopWait = 0},
		{name = 'Shiftrix', idTable = geasFeteReisenjimaIDs, tableType = "Geas Fete Reisenjima Items", loopable = true, loopWait = 5},
		{name = 'Divainy-Gamainy', idTable = skirmishIDs, tableType = "Skirmish Stones", loopable = false, loopWait = 0},
		{name = 'Greyson', idTable = silverVoucherIDs, tableType = 'Silver Vouchers', loopable = true, loopWait = 3},
		{name = 'Mighty Fist', idTable = theDarksmithIDs, tableType = 'The Darksmith Items', loopable = true, loopWait = 5},
		{name = 'Lola', idTable = lebondoptWingIDs, tableType = 'Lebondopt Wings', loopable = false, loopWait = 5},
		{name = 'Anomaly Expert', idTable = delveEntranceIDs, tableType = 'Delve Entrace Items', loopable = False, loopWait = 0},
		{name = 'Geosuke', idTable = HPbayldIDs, tableType = 'HPbayld', loopable = true, loopWait = 5},
		
		{name = 'Haggleblix', idTable = ancientCurrencyByneIDs, tableType = '1 Byne Bill', loopable = true, loopWait = 3},
		{name = 'Lootblox', idTable = ancientCurrencyBronzeIDs, tableType = 'O. Bronzepiece', loopable = false, loopWait = 0},
		{name = 'Antiqix', idTable = ancientCurrencyWhiteshellIDs, tableType = 'Tukuku Whiteshell', loopable = false, loopWait = 0},
		
		{name = 'Bonanza Moogle', idTable = bonanzaIDs, tableType = 'Bonanza Marbles', loopable = false, loopWait = 0},
		{name = 'Kuu Mohzolhi', idTable = ExitSandyIDs, tableType = 'Quest item', loopable = false, loopWait = 0},
		{name = 'Valah Molkot', idTable = ExitBastyIDs, tableType = 'Quest item', loopable = false, loopWait = 0},
		{name = 'Ojha Rhawash', idTable = ExitWindyIDs, tableType = 'Quest item', loopable = false, loopWait = 0},
		{name = 'Burrow Researcher', idTable = MeeblesIDs, tableType = 'Mebbles Grimoire', loopable = false, loopWait = 0},
		
	}

	local idTable = {}
	local tableType = ''
	local target = windower.ffxi.get_mob_by_target('t')
	
	if not target then
		windower.send_command('input /targetnpc')
		coroutine.sleep(0.3)
		target = windower.ffxi.get_mob_by_target('t')

		if not target then
---			print('QuickTrade: No target selected')
			loopCount = 0
			return
		end
	end

	for i = 1, #npcTable do
		if target.name == npcTable[i].name then
			idTable = npcTable[i].idTable
			tableType = npcTable[i].tableType
			loopable = npcTable[i].loopable
			loopWait = npcTable[i].loopWait
			break
		end
	end

--	Extra stuff by Daneblood.  Really need to clean it all up
	
	if Var_IonisNPC:contains(target.name) then
		windower.send_command('setkey enter down;wait 0.1;setkey enter up;wait 2;setkey enter down;wait 0.1;setkey enter up;wait 0.3;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up');	
	elseif Var_SanctionNPC:contains(target.name) then
		windower.send_command('setkey enter down;wait 0.1;setkey enter up;wait 2;setkey enter down;wait 0.1;setkey enter up;wait 0.3;setkey enter down;wait 0.1;setkey enter up')
	elseif Var_SigilNPC:contains(target.name) then
		windower.send_command('setkey enter down;wait 0.1;setkey enter up;wait 2;setkey enter down;wait 0.1;setkey enter up;wait 0.3;setkey enter down;wait 0.1;setkey enter up')
	elseif Var_SignetNPC:contains(target.name) then
		windower.send_command('setkey enter down;wait 0.1;setkey enter up;wait 2;setkey enter down;wait 0.1;setkey enter up')


	elseif target.name == 'Incantrix' then
		windower.send_command('setkey enter down;wait 0.1;setkey enter up;wait 2;setkey enter down;wait 0.1;setkey enter up')
	elseif target.name == 'Cruor Prospector' then
		windower.send_command('setkey enter down;wait 0.1;setkey enter up;wait 2;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.2;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.2;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up')
	elseif target.name == 'Atma Infusionist' then
		windower.send_command('setkey enter down;wait 0.1;setkey enter up;wait 2;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.3;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey down down;wait 0.1;setkey down up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.3;setkey up down;wait 0.1;setkey up up;wait 0.1;setkey enter down;wait 0.1;setkey enter up;wait 0.3;')	

	
	elseif target.name == '???' then
		local var_thiszone = windower.ffxi.get_info()['zone']
		windower.add_to_chat(chatColor, target.x)
		
		if var_thiszone == 15 then 			-- Abyssea-Konschtat 
			windower.send_command('TradeNPC 1 "Giant Bugard Tusk"')	-- Kukulkan
			windower.send_command('TradeNPC 1 "Armored Dragonhorn"')
			windower.send_command('TradeNPC 1 "Clouded Lens"')
			windower.send_command('TradeNPC 1 "Tiny Morbol Vine"') 	-- Misc
			
		elseif var_thiszone == 45 then		-- Abyssea-Tahrongi
			windower.send_command('TradeNPC 1 " H.Q. Cli. Wing"')	-- Chloris
			windower.send_command('TradeNPC 1 "H.Q. Lim. Pincer  "')
			windower.send_command('TradeNPC 1 "Bloodshot Hecteye" 1 "Shriveled Wing" 1 "Tarnished Pincer"')
			windower.send_command('TradeNPC 1 "Baleful Skull"')
			windower.send_command('TradeNPC 1 "Exorcised Skull" 1 "Bloody Fang"')
			windower.send_command('TradeNPC 1 "Alkaline Humus"')
			windower.send_command('TradeNPC 1 "Acidic Humus" 1 " V. Scorp. Stinger  "')
			windower.send_command('TradeNPC 1 "Eft Egg"')	-- Glavoid
			windower.send_command('TradeNPC 1 "Quiv. Eft Egg" 1 "Ctrice. Tailmeat"')
			windower.send_command('TradeNPC 1 "Shocking Whisker"')			
			windower.send_command('TradeNPC 1 "Smooth Whisker" 1 "Resilient Mane"')
			
		elseif var_thiszone == 132 then		-- Abyssea-La_Theine
			windower.send_command('TradeNPC 1 "Trophy Shield"')	-- Briareus
			windower.send_command('TradeNPC 1 "Oversized Sock"')
			windower.send_command('TradeNPC 1 "Massive Armband"')
			windower.send_command('TradeNPC 1 "Tr. Insect Wing "')	-- Carabosse
			windower.send_command('TradeNPC 1 "Piceous Scale"')	
			windower.send_command('TradeNPC 1 "Raw Mutton Chop')	-- Misc
			windower.send_command('TradeNPC 1 "Gargantuan Black Tiger Fang"')	
		
		elseif var_thiszone == 215 then		-- Abyssea-Attohwa 
			windower.send_command('TradeNPC 1 "Withered Cocoon"')
			windower.send_command('TradeNPC 1 "Eruca Egg"')
			windower.send_command('TradeNPC 1 "Undying Ooze"')
			windower.send_command('TradeNPC 1 "Bone Chips"')
			windower.send_command('TradeNPC 1 "Wailing Rags"')
			windower.send_command('TradeNPC 1 "Blanched Silver"')
			windower.send_command('TradeNPC 1 "Cracked Dragonscale"')
			windower.send_command('TradeNPC 1 "Mangled Cockatrice Skin"')
			windower.send_command('TradeNPC 1 "Coeurl Round"')
			windower.send_command('TradeNPC 1 "Gory Pincer"')
			windower.send_command('TradeNPC 1 "Withered Bud"')
			windower.send_command('TradeNPC 1 "Great Root*"')
			windower.send_command('TradeNPC 1 "Extended Eyestalk"')
		
		elseif var_thiszone == 216 then		-- Abyssea-Misareaux
			windower.send_command('TradeNPC 1 "Orobon Cheekmeat"')
			windower.send_command('TradeNPC 1 "Apkallu Down"')
			windower.send_command('TradeNPC 1 "Avian Remex"')
			windower.send_command('TradeNPC 1 "Bewitching Tusk"')
			windower.send_command('TradeNPC 1 "Handful of molt scraps"')
			windower.send_command('TradeNPC 1 "Spheroid Plate"')
			windower.send_command('TradeNPC 1 "High-quality crab meat"')
			windower.send_command('TradeNPC 1 "High-Quality Rock Salt"')
			windower.send_command('TradeNPC 1 "Mocking Beak"')
			windower.send_command('TradeNPC 1 "Hardened Raptor Skin"')
			windower.send_command('TradeNPC 1 "Worm-Eaten Bud"')
			windower.send_command('TradeNPC 1 "Black Rabbit Tail"')
			windower.send_command('TradeNPC 1 "Spotted Flyfrond "')
		
		elseif var_thiszone == 217 then		-- Abyssea-Vunkerl
			windower.send_command('TradeNPC 1 "Gargouille Stone"')
			windower.send_command('TradeNPC 1 "Gnarled Taurus Horn"')
			windower.send_command('TradeNPC 1 "Dented Skull"')
			windower.send_command('TradeNPC 1 "Stiffened Tentacle"')
			windower.send_command('TradeNPC 1 "Black Whisker"')
			windower.send_command('TradeNPC 1 "Moonbeam Clam"')

		elseif var_thiszone == 218 then		-- Abyssea-Altepa
			windower.send_command('TradeNPC 1 "High-Quality Dhalmel Hide" 1 "Sharabha Hide" 1 "Tiger King\'s Hide"')
			windower.send_command('TradeNPC 1 "Sabulous Clay"')
			windower.send_command('TradeNPC 1 "High-quality Cockatrice Skin"')
			windower.send_command('TradeNPC 1 "Oasis Water" 1 "Giant Mistletoe"')
			windower.send_command('TradeNPC 1 "Smoldering Arm" 1 "Tablilla Mercury"')
			windower.send_command('TradeNPC 1 "Sand-caked fang"')
			windower.send_command('TradeNPC 1 "Vadleany Fluid" 1 "High-Quality Scorpion Claw"')
			windower.send_command('TradeNPC 1 "Sandy Shard"')
			windower.send_command('TradeNPC 1 "Ladybird Leaf"')
			windower.send_command('TradeNPC 1 "Puppet\'s Blood"')

		elseif var_thiszone == 253 then		-- Abyssea-Uleguerand  
			windower.send_command('TradeNPC 1 "Whiteworm Clay"')
			windower.send_command('TradeNPC 1 "High-Quality Buffalo Horn"')
			windower.send_command('TradeNPC 1 "Trade Rimed Wing" 1 "Benumbed Eye"')
			windower.send_command('TradeNPC 1 "Imp Sentry\'s Horn"')
			windower.send_command('TradeNPC 1 "High-Quality Marid Hide" 1 "Sisyphus Fragment" 1 "Snow God Core"')
			windower.send_command('TradeNPC 1 "Bevel Gear" 1 "Gear Fluid"')
			windower.send_command('TradeNPC 1 "Helical Gear"')
			windower.send_command('TradeNPC 1 "Gelid Arm"')
			windower.send_command('TradeNPC 1 "Ice Wyvern Scale"')
			windower.send_command('TradeNPC 1 "High-Quality Black Tiger Hide" 1 "Audumbla Hide"')
		
		elseif var_thiszone == 254 then		-- Abyssea-Grauberg 
			windower.send_command('TradeNPC 1 "Goblin Oil" 1 "Goblin Gunpowder"')
			windower.send_command('TradeNPC 1 "Goblin Rope"')
			windower.send_command('TradeNPC 1 "High-Quality Pugil Scale"')
			windower.send_command('TradeNPC 1 "Teekesselchen Fragment" 1 "Darkflame Arm"')
			windower.send_command('TradeNPC 1 "Fay Teardrop"')
			windower.send_command('TradeNPC 1 "Pursuer\'s Wing"')
			windower.send_command('TradeNPC 1 "High-Quality Wivre Hide" 1 "Jaculus Wing" 1 "Minaruja Skull"')
			windower.send_command('TradeNPC 1 "Bubbling Oil"')
			windower.send_command('TradeNPC 1 "Unseelie Eye" 1 "Naiad\'s Lock"')
			windower.send_command('TradeNPC 1 "Decaying Molar"')

			
		elseif var_thiszone == 51 then		-- Wajaom_Woodlands
			windower.send_command('TradeNPC 1 "Hellcage Butterfly"')
			windower.send_command('TradeNPC 1 "Senorita pamama"')
			windower.send_command('TradeNPC 1 "Sheep Botfly"')
		elseif var_thiszone == 52 then		-- Bhaflau_Thickets
			windower.send_command('TradeNPC 1 "Olzhiryan Cactus"')
		elseif var_thiszone == 54 then		-- Arrapago_Reef
			windower.send_command('TradeNPC 1 "Golden Teeth"')
			windower.send_command('TradeNPC 1 "Greenling"')
			windower.send_command('TradeNPC 1 "Merrow No. 11 Molting"')
			windower.send_command('TradeNPC 1 "Rose Scampi"')
		elseif var_thiszone == 61 then		-- Mount_Zhayolm
			windower.send_command('TradeNPC 1 "Pectin"')
			windower.send_command('TradeNPC 1 "Raw Buffalo"')
			windower.send_command('TradeNPC 1 "Shadeleaf"')
			windower.send_command('TradeNPC 1 "Vinegar Pie"')
		elseif var_thiszone == 65 then		-- Mamook
			windower.send_command('TradeNPC 1 "Floral Nectar"')	
			windower.send_command('TradeNPC 1 "Samariri Corpsehair"')
		elseif var_thiszone == 68 then		--  Aydeewa_Subterrane
			windower.send_command('TradeNPC 1 "Pure Blood"')	
			windower.send_command('TradeNPC 1 "Spoilt Blood"')	
		elseif var_thiszone == 72 then		-- Alzadaal_Undersea_Ruins
			windower.send_command('TradeNPC 1 "Cog Lubricant"')
			windower.send_command('TradeNPC 1 "Ferrite"')
			windower.send_command('TradeNPC 1 "Opalus Gem" ')
			windower.send_command('TradeNPC 1 "Rodent Cheese"')
		elseif var_thiszone == 79 then		-- Caedarva_Mire
			windower.send_command('TradeNPC 1 "Exorcism Treatise"')
		end
		
		
	elseif target.name == 'Treasure Coffer' then
		local var_thiszone = windower.ffxi.get_info()['zone']
		windower.add_to_chat(chatColor, target.x)
		
		if var_thiszone == 12 then		-- Newton_Movalpolos
			windower.send_command('TradeNPC 1 "Newton Coffer Key"')
		elseif var_thiszone == 144 then			-- Beadeaux
			windower.send_command('TradeNPC 1 "Beadeaux Coffer Key"')
		elseif var_thiszone == 130 then		-- Ru'Aun_Gardens 
			windower.send_command('TradeNPC 1 "Ru\'Aun Coffer Key "')
		elseif var_thiszone == 150 then		-- Monastic_Cavern
			windower.send_command('TradeNPC 1 "Davoi Coffer Key"')
		elseif var_thiszone == 151 then		-- Castle_Oztroja
			windower.send_command('TradeNPC 1 "Oztroja Coffer Key"')
		elseif var_thiszone == 153 then		-- The_Boyahda_Tree
			windower.send_command('TradeNPC 1 "Boyahda Coffer Key"')
		elseif var_thiszone == 160 then		-- Den_of_Rancor 
			windower.send_command('TradeNPC 1 "Den Coffer Key"')
		elseif var_thiszone == 161 then		-- Castle_Zvahl_Baileys
			windower.send_command('TradeNPC 1 "Zvahl Coffer Key"')
		elseif var_thiszone == 169 then		-- Toraimarai_Canal  
			windower.send_command('TradeNPC 1 "Toraimarai Coffer Key"')
		elseif var_thiszone == 174 then		--  	Kuftal_Tunnel 
			windower.send_command('TradeNPC 1 "Kuftal Coffer Key"')
		elseif var_thiszone == 176 then		-- Sea_Serpent_Grotto 
			windower.send_command('TradeNPC 1 "Grotto Coffer Key')
		elseif var_thiszone == 177 then		-- Ve'Lugannon_Palace
			windower.send_command('TradeNPC 1 "Ve\'Lugannon Coffer Key"')
		elseif var_thiszone == 195 then		-- The_Eldieme_Necropolis 
			windower.send_command('TradeNPC 1 "Eldieme Coffer Key"')
		elseif var_thiszone == 197 then		-- Crawlers_Nest
			windower.send_command('TradeNPC 1 "Nest Coffer Key"')
		elseif var_thiszone == 200 then		-- Garlaige_Citadel  
			windower.send_command('TradeNPC 1 "Garlaige Coffer Key"')
		elseif var_thiszone == 205 then		-- Ifrits_Cauldron 
			windower.send_command('TradeNPC 1 "Cauldron Coffer Key"')
		elseif var_thiszone == 208 then		-- Quicksand_Caves 
			windower.send_command('TradeNPC 1 "Quicksand Coffer Key"')
		elseif var_thiszone == 259 then		-- Temple_of_Uggalepih  
			windower.send_command('TradeNPC 1 "Uggalepih Coffer Key"')
		end
	end

	-- FOR TESTING WITHOUT NPC PRESENT!!!!!!!!!!!!!
	--idTable = table.copy(geasFeteRuaunIDs)
	--tableType = "Geas Fete Ru'Aun Items"
	--exampleOnly = true

	if #idTable == 0 or tableType == '' then
---		print('QuickTrade: Invalid target')
		lastNPC = ''
		lastLoopNPC = ''
		loopCount = 0
		return
	end

	mogSackTable = table.copy(idTable)
	mogCaseTable = table.copy(idTable)

	-- Scan the mog sack for each item in idTable
	local mogSack = windower.ffxi.get_items('sack')

	if not mogSack then
		print('mogSack read error')
	else
		for i = 1, #mogSackTable do
			for k, v in ipairs(mogSack) do
				if v.id == mogSackTable[i].id then
					mogSackTable[i].count = mogSackTable[i].count + v.count -- Updates the total number of items of each type
					mogSackTable[i].stacks = mogSackTable[i].stacks + 1 -- Updates the total number of stacks of each type
				end
			end
		end
	end

	-- Scan the mog case for each item in idTable
	local mogCase = windower.ffxi.get_items('case')

	if not mogCase then
		print('mogCase read error')
	else
		for i = 1, #mogCaseTable do
			for k, v in ipairs(mogCase) do
				if v.id == mogCaseTable[i].id then
					mogCaseTable[i].count = mogCaseTable[i].count + v.count -- Updates the total number of items of each type
					mogCaseTable[i].stacks = mogCaseTable[i].stacks + 1 -- Updates the total number of stacks of each type
				end
			end
		end
	end

	-- Uses the Itemizer addon to move tradable items from the mog case/sack into the player's inventory
	if arg[1] == 'all' and mogCase and mogSack then
		inventory = windower.ffxi.get_items('inventory')
		
		for i = 1, #idTable do
			for k, v in ipairs(inventory) do
				if v.id == idTable[i].id then
					idTable[i].count = idTable[i].count + v.count -- Updates the total number of items of each type
					idTable[i].stacks = idTable[i].stacks + 1 -- Updates the total number of stacks of each type
				end
			end
		end

		for i = 1, #mogSackTable do
			if mogSackTable[i].count + mogCaseTable[i].count > 0 then
				inventory = windower.ffxi.get_items('inventory')

				if inventory.count + mogSackTable[i].stacks + mogCaseTable[i].stacks <= inventory.max then
					if exampleOnly then
						print('get "' .. mogSackTable[i].name ..  '" ' .. idTable[i].count + mogSackTable[i].count + mogCaseTable[i].count)
					else
						windower.add_to_chat(chatColor, 'QuickTrade: Please wait - Using Itemizer to transfer ' .. mogSackTable[i].count + mogCaseTable[i].count .. ' ' .. mogSackTable[i].name .. ' to inventory')
						windower.send_command('get "' .. mogSackTable[i].name ..  '" ' .. idTable[i].count + mogSackTable[i].count + mogCaseTable[i].count)
						performLoopsAfterAll = performLoopsAfterAll + 1
						coroutine.sleep(2.5)
					end
				else
					windower.add_to_chat(chatColor, 'QuickTrade: Not enough inventory space to pull ' .. mogSackTable[i].count + mogCaseTable[i].count .. ' ' .. mogSackTable[i].name)
				end
			end
		end

		if #arg > 1 and #arg[2] == 'loop' and performLoopsAfterAll > 0 then
			loopCount = 0
			return
		end

		for i = 1, #idTable do
			idTable[i].count = 0
			idTable[i].stacks = 0
		end
	else
		if target.name ~= lastNPC then
			lastNPC = target.name

			if loopModeSet then
				if lastLoopNPC == '' then
					lastLoopNPC = target.name
				else
					print('New NPC detected after trade loop started. Aborting to prevent accidental trades.')
					loopCount = 0
					return
				end
			end

			local mogCount = 0

			for i = 1, #mogSackTable do
				mogCount = mogCount + mogSackTable[i].count + mogCaseTable[i].count
			end
			
			if mogCount > 0 then
				windower.add_to_chat(chatColor, 'QuickTrade: ' .. mogCount .. ' of these items are in your mog sack/case. Type "//qtr all" if you wish to move them into your inventory and trade them. Requires Itemizer')
			end
		end
	end

	-- Read the player inventory
	inventory = windower.ffxi.get_items('inventory')

	if not inventory then
		print('QuickTrade: Unable to read inventory')
		loopCount = 0
		return
	end

	if tableType == 'Special Gobbiedial Keys' and inventory.count == inventory.max then
		windower.add_to_chat(chatColor, 'QuickTrade: Inventory full. Cancelling Special Gobbiedial Key Trades.')
		loopCount = 0
		return
	end

	-- Scan the inventory for each item in idTable
	for i = 1, #idTable do
		for k, v in ipairs(inventory) do
			if v.id == idTable[i].id then
				idTable[i].count = idTable[i].count + v.count -- Updates the total number of items of each type
				idTable[i].stacks = idTable[i].stacks + 1 -- Updates the total number of stacks of each type
			end
		end
	end
	
	local numTrades = 0 -- Number of times //qtr needs to be run to empty the player inventory
	local availableTradeSlots = 8

	if tableType == 'Crystals' then
		if target.name == 'Ephemeral Moogle' then
			for i = 1, 8 do
				if idTable[i].stacks > 0 or idTable[i + 8].stacks > 0 then
					numTrades = numTrades + math.ceil((idTable[i].stacks + idTable[i + 8].stacks) / 8)
				end
			end
		else
			for i = 1, 8 do
				if idTable[i].stacks > 0 or idTable[i + 8].stacks > 0 then
					numTrades = numTrades + idTable[i].stacks + idTable[i + 8].stacks
				end
			end

			numTrades = math.ceil(numTrades / 8)
		end
	elseif tableType == 'Zinc Ore' or tableType == 'Yagudo Necklaces' then -- 4 at a time
		numTrades = math.floor(idTable[1].count / 4)
	elseif tableType == 'Mandragora Mad Items' or tableType == 'JSE Capes' or tableType == 'Special Gobbiedial Keys' or tableType == 'Soul Plates' then -- 1 at a time
		for i = 1, #idTable do
			numTrades = numTrades + idTable[i].count
		end
	elseif tableType == 'JSE Capes x3' then -- 3 of the same kind
		for i = 1, #idTable do
			if idTable[i].count >= 3 then
				numTrades = numTrades + math.min(1, math.floor(idTable[i].count / 3))
			end
		end
	elseif tableType == 'Only the Best Items' then -- Unique for this quest
		numTrades = numTrades + math.floor(idTable[1].count / 5)
		numTrades = numTrades + math.floor(idTable[2].count / 3)
		numTrades = numTrades + idTable[3].count
	elseif tableType == 'Reisenjima Stones' then -- Can trade all types at once
		numTrades = math.ceil((idTable[1].stacks + idTable[2].stacks + idTable[3].stacks) / 8)
	elseif tableType == "Geas Fete Zi'Tah Items" or tableType == "Geas Fete Ru'Aun Items" or tableType == "Geas Fete Reisenjima Items" then
		for i = 1, #idTable do
			if idTable[i].count >= idTable[i].minimum then
				numTrades = numTrades + math.floor(idTable[i].count / idTable[i].minimum)
			end
		end
	else
		for i = 1, #idTable do
			if idTable[i].stacks > 0 then
				numTrades = numTrades + math.ceil(idTable[i].stacks / 8)
			end
		end
	end

	if exampleOnly then
		print(numTrades .. ' total trades')
	end

	-- Prepare and send command through TradeNPC if there are trades to be made
	if numTrades > 0 then
		local tradeString = 'tradenpc '
		local tradeList = ''
		availableTradeSlots = 8
		
		if tableType == 'Crystals' then
			tradeString = 'tradenpc'

			for i = 1, 8 do
				-- Build the string that will be used as the command

				if idTable[i].count > 0 then
					tradeString = tradeString .. ' ' .. math.min(availableTradeSlots * idTable[i].stacksize, idTable[i].count) .. ' "' .. idTable[i].name .. '"'
					availableTradeSlots = math.max(0, availableTradeSlots - idTable[i].stacks)
				end
				
				if availableTradeSlots > 0 and idTable[i + 8].count > 0 then
					tradeString = tradeString .. ' ' .. math.min(availableTradeSlots * idTable[i + 8].stacksize, idTable[i + 8].count) .. ' "' .. idTable[i + 8].name .. '"'
					availableTradeSlots = math.max(0, availableTradeSlots - idTable[i].stacks)
				end

				if (target.name == 'Ephemeral Moogle' and (idTable[i].count > 0 or idTable[i + 8].count > 0)) or availableTradeSlots < 1 then
					break
				end
			end
		elseif tableType == 'Special Gobbiedial Keys' or tableType == 'Soul Plates' then -- 1 item at a time
			tradeString = 'tradenpc  1 "' .. idTable[1].name .. '"'
		elseif tableType == 'Zinc Ore' or tableType == 'Yagudo Necklaces' then -- 4 items at a time
			if idTable[1].count >= 4 then
				tradeString = 'tradenpc 4 "' .. idTable[1].name .. '"'
			end
		elseif tableType == 'Mandragora Mad Items' or tableType == 'JSE Capes' then
			for i = 1, #idTable do
				tradeString = 'tradenpc '

				if idTable[i].count > 0 then
					tradeString = tradeString .. '1 "' .. idTable[i].name .. '"'
					break
				end
			end
		elseif tableType == 'JSE Capes x3' then
			for i = 1, #idTable do
				tradeString = 'tradenpc '

				if idTable[i].count >= 3 then
					tradeString = tradeString .. '3 "' .. idTable[i].name .. '"'
					break
				end
			end
		elseif tableType == 'Only the Best Items' then
			for i = 1, #idTable do
				tradeString = 'tradenpc '

				if idTable[1].count >= 5 then
					tradeString = tradeString .. '5 "' .. idTable[1].name .. '"'
					break
				end

				if idTable[2].count >= 3 then
					tradeString = tradeString .. '3 "' .. idTable[2].name .. '"'
					break
				end

				if idTable[3].count > 0 then
					tradeString = tradeString .. '1 "' .. idTable[3].name .. '"'
					break
				end
			end
		elseif tableType == 'Reisenjima Stones' then
			tradeString = 'tradenpc'

			for i = 1, #idTable do
				if idTable[i].count > 0 then
					if availableTradeSlots > 0 then
						tradeString = tradeString .. ' ' .. math.min(availableTradeSlots * idTable[i].stacksize, idTable[i].count) .. ' "' .. idTable[i].name .. '"'
						availableTradeSlots = math.max(0, availableTradeSlots - idTable[i].stacks)
					else
						break
					end
				end
			end
		elseif tableType == "Geas Fete Zi'Tah Items" or tableType == "Geas Fete Ru'Aun Items" or tableType == "Geas Fete Reisenjima Items" then
			local keyItemFound = false
			local validTradeFound = false
			local possibleTrades = 0

			if getGeasFeteKeyItems() then
				for i = 1, #idTable do
					keyItemFound = false

					if idTable[i].count >= idTable[i].minimum then
						possibleTrades = possibleTrades + 1

						for o = 1, #ownedGeasFeteKeyItems do
							if ownedGeasFeteKeyItems[o].id == idTable[i].ki then
								keyItemFound = true
								break
							end
						end

						if not keyItemFound then
							validTradeFound = true
							tradeString = 'tradenpc ' .. idTable[i].minimum .. ' "' .. idTable[i].name .. '"'
							tradeList = idTable[i].minimum .. ' ' .. idTable[i].name
							break
						end
					end
				end
			end
			
			if possibleTrades > 0 and not validTradeFound then
				windower.add_to_chat(chatColor, 'QuickTrade: You but you already possess all possible pop items.')
			end
		
		elseif tableType == "1 Byne Bill" then -- Added by DaneBlood
				if idTable[1].count >= 100 then
				tradeString = 'tradenpc 100 "' .. idTable[1].name .. '"'
				end
--	windower.send_command('TradeNPC 100 "1 byne bill";wait 1;setkey enter down;wait 0.1;setkey enter up ')
		else
			for i = 1, #idTable do
				loopable = true -- May not work for everything

				tradeString = 'tradenpc '
				availableTradeSlots = 8
				
				if idTable[i].count > 0 then
					tradeString = tradeString .. math.min(availableTradeSlots * idTable[i].stacksize, idTable[i].count) .. ' "' .. idTable[i].name .. '"'
					break
				end
			end
		end

		if loopModeSet and loopable then
			loopCount = numTrades

			if loopMax ~= 100000 then
				numTrades = loopMax - loopCurrent + 1
				loopText = ' Loop: ' .. loopCurrent .. '/' .. loopMax
			else
				loopMax = numTrades
				loopText = ' Loop: ' .. loopCurrent .. '/' .. numTrades
			end
		else
			loopCount = 0
			loopText = ''
		end

		if tradeString ~= 'tradenpc ' and not (#arg > 1 and #arg[2] == 'loop' and performLoopsAfterAll > 0) then
			if numTrades - 1 == 0 then
				windower.add_to_chat(chatColor, 'QuickTrade: Trading Complete.' .. loopText)
			else
				windower.add_to_chat(chatColor, 'QuickTrade: Trades Remaining: ' .. (numTrades - 1) .. loopText)
			end
			
			if exampleOnly then
				print(tradeString)
			else
				if tableType ~= 'JSE Capes x3' and not string.find(tableType, 'Geas Fete') then
					textSkipTimer = os.time()
				end
				
				windower.send_command(tradeString)
			end

			if string.find(tableType, 'Geas Fete') then
				windower.add_to_chat(chatColor, 'QuickTrade: Trading '.. tradeList)
			end

			if loopModeSet then
				loopCount = loopCount - 1
			end
		end

		if string.find(tableType, 'Geas Fete') then
			if tribulensOrRadialensFound then
				windower.add_to_chat(chatColor, "QuickTrade: You already possess a Tribulens or Radialens!")
			else
				windower.add_to_chat(chatColor, "QuickTrade: Don't forget your Tribulens or Radialens!")
			end
		end
	else
		if arg[1] == 'all' then
			windower.add_to_chat(chatColor, "QuickTrade: No " .. tableType .. " in inventory, mog case, or mog sack")
		else
			windower.add_to_chat(chatColor, "QuickTrade: No " .. tableType .. " in inventory")
		end

		loopCount = 0
		loopModeSet = false
	end
end

function getGeasFeteKeyItems()
    -- This provides a list of all key items in resources that are under the category "Geas Fete"
	ownedGeasFeteKeyItems = {}
	tribulensOrRadialensFound = false

	if getOwnedKeyItems() then
    	for _, keyItem in pairs(res.key_items) do
	        if keyItem.category == 'Geas Fete' then
				for o = 1, #ownedKeyItems do
					if keyItem.id == ownedKeyItems[o] then
						table.insert(ownedGeasFeteKeyItems, {['id'] = keyItem.id, ['name'] = keyItem.en})
						--print(ownedGeasFeteKeyItems[#ownedGeasFeteKeyItems].id, ownedGeasFeteKeyItems[#ownedGeasFeteKeyItems].name)

						if keyItem.en == 'Radialens' or keyItem.en == 'Tribulens' or keyItem.id == 3031 or keyItem.id == 2894 then
							tribulensOrRadialensFound = true
						end

						break
					end
				end
        	end
		end

		if #ownedGeasFeteKeyItems > 0 then
			return true
		else
			return false
		end
	end
end

function getOwnedKeyItems()
    ownedKeyItems = windower.ffxi.get_key_items()

    if not ownedKeyItems or #ownedKeyItems == 0 then
       print('Error reading key items. Try again in a moment')
       ownedKeyItems = {}
       return false
    end

    return true
end

windower.register_event('incoming text', function(original, modified, mode)
	-- Allow the addon to skip the conversation text for up to 10 seconds after the trade
	if os.time() - textSkipTimer > 10 then
		return
	end
	
	if mode == 150 or mode == 151 then
		modified = modified:gsub(string.char(0x7F, 0x31), '')
	end
	
	return modified
end)