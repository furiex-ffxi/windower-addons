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
    name = 'r2',
	display_name = 'Reisenjima Tier II',
    item = 3031,--en="radialens"
    item_target_count = 1,
    pops = {
	{
		id = 3008,--en="Bashmu's trinket"
		type = 'key item',
		dropped_from = {
			name = 'Bashmu',
			pops = { {
				id = 6296, --"Gramk-Droog's Grand Coffer"
				type = 'item',
				dropped_from = { name = 'Incursion - Gramk-Droog' }
			} }
		}
    },
	{
		id = 3004,--en="Gajasimha's mane"
		type = 'key item',
		dropped_from = {
			name = 'Gajasimha',
			pops = { {
				id = 6288, --"Ignor-Mnt's grand coffer"
				type = 'item',
				count = 2,
				dropped_from = { name = 'Incursion - Ignor-Mnt' }
			} }
		}
    },
	{
		id = 3005,--en="Ironside's maul"
		type = 'key item',
		dropped_from = {
			name = 'Ironside',
			pops = { {
				id = 6290, --"Durs-Vike's grand coffer"
				type = 'item',
				count = 2,
				dropped_from = { name = 'Incursion - Durs-Vike' }
			} }
		}
    },
	{
		id = 3007,--en="Old Shuck's tuft"
		type = 'key item',
		dropped_from = {
			name = 'Old Shuck',
			pops = { {
				id = 6294, --"Liij-Vok's grand coffer"
				type = 'item',
				count = 2,
				dropped_from = { name = 'Incursion - Liij-Vok' }
			} }
		}
    },
	{
		id = 3006,--en="Sarsaok's hoard"
		type = 'key item',
		dropped_from = {
			name = 'Sarsaok',
			pops = { {
				id = 6292, --"Tryl-Wuj's grand coffer"
				type = 'item',
				count = 2,
				dropped_from = { name = 'Incursion - Tryl-Wuj' }
			} }
		}
    },
	{
		id = 3003,--en="Strophadia's pearl"
		type = 'key item',
		dropped_from = {
			name = 'Strophadia',
			pops = { {
				id = 6286, --"Ymmr-Ulvid's grand coffer"
				type = 'item',
				count = 2,
				dropped_from = { name = 'Incursion - Ymmr-Ulvid' }
			} }
		}
    }
	
	}
}
