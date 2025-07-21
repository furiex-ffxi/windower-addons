--[[
Copyright © 2020, Dean James (Xurion of Bismarck)
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Empy Pop Tracker nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Dean James (Xurion of Bismarck) BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

return {
    name = 'rh',
	display_name = 'Reisenjima Helm',
    item = 3031,--en="radialens"
    item_target_count = 1,
    pops = {
	{
		id = 3016,--en="Albumen's flower"
		type = 'key item',
		dropped_from = {
			name = 'Albumen',
			pops = { {
				id = 9078, --"Ashweed"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			},{
				id = 3990, --"Coalition Humus"
				type = 'item',
				dropped_from = { name = 'Western Adoulin (J-9) - Ceciliotte' }
			},{
				id = 9215, --"Void Grass"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			},{
				id = 17894, --"Vermihumus"
				type = 'item',
				dropped_from = { name = 'AH - Weapons - Ammo&Misc. - Pet Items' }
			} }
		}
    },
	{
		id = 3018,--en="Erinys's beak"
		type = 'key item',
		dropped_from = {
			name = 'Erinys',
			pops = { {
				id = 9078, --"Ashweed"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			},{
				id = 5265, --"Mistmelt"
				type = 'item',
				dropped_from = { name = 'AH - Materials - Goldsmithing' }
			},{
				id = 4816, --"Tornado"
				type = 'item',
				dropped_from = { name = 'Lower Jeuno (H-9) - Susu' }
			},{
				id = 9216, --"Voidsnapper"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			} }
		}
    },
	{
		id = 3017,--en="Onychophora's soil"
		type = 'key item',
		dropped_from = {
			name = 'Onychophora',
			pops = { {
				id = 3523, --"Titanite"
				type = 'item',
				count = 10,
				dropped_from = { name = 'AH - Materials - Goldsmithing' }
			},{
				id = 9214, --"Void Crystal"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			},{
				id = 9215, --"Void Grass"
				type = 'item',
				count = 5,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			},{
				id = 1831, --"Worm Mulch"
				type = 'item',
				dropped_from = { name = 'AH - Others - Misc. 1' }
			} }
		}
    },
	{
		id = 3015,--en="Schah's gambit"
		type = 'key item',
		dropped_from = {
			name = 'Schah',
			pops = { {
				id = 9076, --"Gravewood Log"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			},{
				id = 419, --"Leisure Table"
				type = 'item',
				dropped_from = { name = 'AH - Furnishings' }
			},{
				id = 5870, --"Trump Card Case"
				type = 'item',
				dropped_from = { name = 'Nashmau (G-7) - Jajaroon' }
			},{
				id = 9216, --"Voidsnapper"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			} }
		}
    },
	{
		id = 3012,--en="Teles's hymn"
		type = 'key item',
		dropped_from = {
			name = 'Teles',
			pops = { {
				id = 5074, --"Maiden's Virelai"
				type = 'item',
				dropped_from = { name = 'AH - Scrolls - Song' }
			},{
				id = 1313, --"Siren's Hair"
				type = 'item',
				dropped_from = { name = 'AH - Materials - Clothcraft' }
			},{
				id = 9214, --"Void Crystal"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			},{
				id = 9216, --"Voidsnapper"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			} }
		}
    },
	{
		id = 3014,--en="Vinipata's blade"
		type = 'key item',
		dropped_from = {
			name = 'Vinipata',
			pops = { {
				id = 880, --"Bone Chip"
				type = 'item',
				count = 10,
				dropped_from = { name = 'Green Thumb Moogle' }
			},{
				id = 9077, --"Duskcrawler"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			},{
				id = 687, --"Scarletite Ingot"
				type = 'item',
				dropped_from = { name = 'AH - Materials  - Smithing' }
			},{
				id = 9214, --"Void Crystal"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			} }
		}
    },
	{
		id = 3013,--en="Zerde's cup"
		type = 'key item',
		dropped_from = {
			name = 'Zerde',
			pops = { {
				id = 9146, --"Ashen Crayfish"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			},{
				id = 5552, --"Black Pudding"
				type = 'item',
				dropped_from = { name = 'AH - Food - Meals - Sweets' }
			},{
				id = 2175, --"Flan Meat"
				type = 'item',
				count = 10,
				dropped_from = { name = 'AH - Materials - Alchemy 1' }
			},{
				id = 9215, --"Void Grass"
				type = 'item',
				count = 3,
				dropped_from = { name = 'AH - Others - Misc. 2' }
			} }
		}
    }
	
	}
}
