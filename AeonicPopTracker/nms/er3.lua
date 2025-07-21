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
    name = 'er3',
	display_name = 'Escha - Ru\'Aun Tier III',
    item = 3031,--en="radialens"
    item_target_count = 1,
    pops = {
	{
		id = 2946,--en="Duke Vepar's signet"
		type = 'key item',
		dropped_from = {
			name = 'Duke Vepar',
			pops = { {
				id = 4015, --"Yggdreant Root"
				type = 'item',
				dropped_from = { name = 'AH - Materials - Alchemy 1' }
			} }
		}
    },
	{
		id = 2945,--en="Pakecet's blubber"
		type = 'key item',
		dropped_from = {
			name = 'Pakecet',
			pops = { {
				id = 4013, --"Waktza Crest"
				type = 'item',
				dropped_from = { name = 'AH - Materials - Clothcraft' }
			} }
		}
    },
	{
		id = 2947,--en="Vir'ava's stalk"
		type = 'key item',
		dropped_from = {
			name = 'Vir\'ava',
			pops = { {
				id = 8754, --"Cehuetzi Pelt"
				type = 'item',
				dropped_from = { name = 'AH - Materials - Leathercraft' }
			} }
		}
    }
	
	}
}
