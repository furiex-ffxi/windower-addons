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
    name = 'er2',
	display_name = 'Escha - Ru\'Aun Tier II',
    item = 3031,--en="radialens"
    item_target_count = 1,
    pops = {
	{
		id = 2942,--en="Amymone's tooth"
		type = 'key item',
		dropped_from = {
			name = 'Amymone',
			pops = { {
				id = 9097, --"Mhuufya's Beak"
				type = 'item',
				count = 5,
				dropped_from = { name = 'UNM - Kubool Ja\'s Mhuufya' }
			} }
		}
    },
	{
		id = 2940,--en="Hanbi's nail"
		type = 'key item',
		dropped_from = {
			name = 'Hanbi',
			pops = { {
				id = 9059, --"Azrael's Eye"
				type = 'item',
				count = 5,
				dropped_from = { name = 'UNM - Azrael' }
			} }
		}
    },
	{
		id = 2944,--en="Kammavaca's binding"
		type = 'key item',
		dropped_from = {
			name = 'Kammavaca',
			pops = { {
				id = 9031, --"Vedrfolnir's Wing"
				type = 'item',
				count = 5,
				dropped_from = { name = 'UNM - Vedrfolnir' }
			} }
		}
    },
	{
		id = 2943,--en="Naphula's bracelet"
		type = 'key item',
		dropped_from = {
			name = 'Naphula',
			pops = { {
				id = 9051, --"Camahueto's Fur"
				type = 'item',
				count = 5,
				dropped_from = { name = 'UNM - Camahueto' }
			} }
		}
    },
	{
		id = 2939,--en="Palila's talon"
		type = 'key item',
		dropped_from = {
			name = 'Palila',
			pops = { {
				id = 9103, --"Vidmapire's Claw"
				type = 'item',
				count = 5,
				dropped_from = { name = 'UNM - Vidmapire' }
			} }
		}
    },
	{
		id = 2941,--en="Yilan's scale"
		type = 'key item',
		dropped_from = {
			name = 'Yilan',
			pops = { {
				id = 9104, --"Centurio's Armor"
				type = 'item',
				count = 5,
				dropped_from = { name = 'UNM - Centurio' }
			} }
		}
    }
	
	}
}
