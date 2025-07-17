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
    name = 'r3',
	display_name = 'Reisenjima Tier III',
    item = 3031,--en="radialens"
    item_target_count = 1,
    pops = {
	{
		id = 3009,--en="Maju's claw"
		type = 'key item',
		dropped_from = {
			name = 'Maju',
			pops = { {
				id = 9151, --"Sovereign's Hide"
				type = 'item',
				dropped_from = { name = 'UNM - Sovereign Behemoth' }
			} }
		}
    },
	{
		id = 3011,--en="Neak's treasure"
		type = 'key item',
		dropped_from = {
			name = 'Neak',
			pops = { {
				id = 9150, --"Tolba's Shell"
				type = 'item',
				dropped_from = { name = 'UNM - Tolba' }
			} }
		}
    },
	{
		id = 3010,--en="Yakshi's scroll"
		type = 'key item',
		dropped_from = {
			name = 'Yakshi',
			pops = { {
				id = 9149, --"Hidhaegg's Scale"
				type = 'item',
				dropped_from = { name = 'UNM - Hidhaegg' }
			} }
		}
    }
	
	}
}
