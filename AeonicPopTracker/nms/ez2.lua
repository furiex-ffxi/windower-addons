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
    name = 'ez2',
	display_name = 'Escha - Zi\'Tah Tier II',
    item = 3031,--en="radialens"
    item_target_count = 1,
    pops = {
	{
		id = 2914,--en="Brittlis's ring"
		type = 'key item',
		dropped_from = {
			name = 'Brittlis',
			pops = { {
				id = 9060, --"Ethereal Incense"
				type = 'item',
				count = 5,
				dropped_from = { name = 'Borealis Shadow' }
			} }
		}
    },
	{
		id = 2911,--en="Ionos's webbing"
		type = 'key item',
		dropped_from = {
			name = 'Ionos',
			pops = { {
				id = 9057, --"Ayapec's Shell"
				type = 'item',
				count = 5,
				dropped_from = { name = 'Ayapec' }
			} }
		}
    },
	{
		id = 2915,--en="Kamohoalii's fin"
		type = 'key item',
		dropped_from = {
			name = 'Kamohoalii',
			pops = { {
				id = 9057, --"Ayapec's Shell"
				type = 'item',
				count = 5,
				dropped_from = { name = 'Ayapec' }
			} }
		}
    },
	{
		id = 2913,--en="Nosoi's feather"
		type = 'key item',
		dropped_from = {
			name = 'Nosoi',
			pops = { {
				id = 9057, --"Ayapec's Shell"
				type = 'item',
				count = 5,
				dropped_from = { name = 'Ayapec' }
			} }
		}
    },
	{
		id = 2912,--en="Sandy's lasher"
		type = 'key item',
		dropped_from = {
			name = 'Sensual Sandy',
			pops = { {
				id = 9060, --"Ethereal Incense"
				type = 'item',
				count = 5,
				dropped_from = { name = 'Borealis Shadow' }
			} }
		}
    },
	{
		id = 2916,--en="Umdhlebi's flower"
		type = 'key item',
		dropped_from = {
			name = 'Umdhlebi',
			pops = { {
				id = 9060, --"Ethereal Incense"
				type = 'item',
				count = 5,
				dropped_from = { name = 'Borealis Shadow' }
			} }
		}
    }
	
	}
}
