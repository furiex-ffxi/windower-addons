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
    name = 'erh',
	display_name = 'Escha - Ru\'Aun Heavenly Beasts',
    item = 3031,--en="radialens"
    item_target_count = 1,
    pops = {
	{
		id = 2948,--en="Byakko's Pride"
		type = 'key item',
		dropped_from = {
			name = 'Byakko',
			pops = { {
				id = 3278, --"Byakko Scrap"
				type = 'item',
				count = 3,
				dropped_from = { name = 'Bazaar' }
			} }
		}
    },
	{
		id = 2949,--en="Genbu's Honor"
		type = 'key item',
		dropped_from = {
			name = 'Genbu',
			pops = { {
				id = 3275, --"Genbu Scrap"
				type = 'item',
				count = 3,
				dropped_from = { name = 'Bazaar' }
			} }
		}
    },
	{
		id = 2952,--en="Kirin's Fervor"
		type = 'key item',
		dropped_from = {
			name = 'Kirin',
			pops = { {
				id = 3278, --"Byakko Scrap"
				type = 'item',
				count = 5,
				dropped_from = { name = 'Bazaar' }
			},{
				id = 3275, --"Genbu Scrap"
				type = 'item',
				count = 5,
				dropped_from = { name = 'Bazaar' }
			},{
				id = 3277, --"Seiryu Scrap"
				type = 'item',
				count = 5,
				dropped_from = { name = 'Bazaar' }
			},{
				id = 3276, --"Suzaku Scrap"
				type = 'item',
				count = 5,
				dropped_from = { name = 'Bazaar' }
			} }
		}
    },
	{
		id = 2950,--en="Seiryu's Nobility"
		type = 'key item',
		dropped_from = {
			name = 'Seiryu',
			pops = { {
				id = 3277, --"Seiryu Scrap"
				type = 'item',
				count = 3,
				dropped_from = { name = 'Bazaar' }
			} }
		}
    },
	{
		id = 2951,--en="Suzaku's Benefaction"
		type = 'key item',
		dropped_from = {
			name = 'Suzaku',
			pops = { {
				id = 3276, --"Suzaku Scrap"
				type = 'item',
				count = 3,
				dropped_from = { name = 'Bazaar' }
			} }
		}
    }
	
	}
}
