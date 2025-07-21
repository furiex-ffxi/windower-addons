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
    name = 'final',
	display_name = 'Dynamis Items \n //apt weapon WEAPONNAME \n In order to Track a weapon',
    item = 3031,--en="radialens"
    item_target_count = 1,
    pops = {
	{
		id = 20515,--en="Godhands"
		type = 'item',
		dropped_from = {
			name = 'Godhands',
			pops = { {
				id = 1556, --"BAttestation of Might"
				type = 'item',
				dropped_from = { 
					name = 'Mildaunegeux - Dynamis - Beaucedine - (H-10)',
					pops = { {
						id = 3361, --"Villain's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Monk / Hydra Ninja / Hydra Thief' }
					 }				
					 },
				}
			}, 
			 {
				id = 1571, --"Mystic Fragment"
				type = 'item',
				dropped_from = { name = 'Animated Knuckles - Dynamis - Xarcabard - (H-8)' }
			}}
		}
    },
	{
		id = 20594,--en="Aeneas"
		type = 'item',
		dropped_from = {
			name = 'Aeneas',
			pops = { {
				id = 1557, --"Attestation of Celerity"
				type = 'item',
				dropped_from = { 
					name = 'Quiebitiel - Dynamis - Beaucedine - (G-11)' ,
					pops = { {
						id = 3360, --"Sadist's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Bard / Hydra Black Mage / Hydra White Mage' }
					 }				
					 },
				}
			}, 
			 {
				id = 1572, --Ornate Fragment
				type = 'item',
				dropped_from = { name = 'Animated Dagger - Dynamis - Xarcabard - (H-9)' }
			}}
		}
    },{
		id = 20695,--en="Sequence"
		type = 'item',
		dropped_from = {
			name = 'Sequence',
			pops = { {
				id = 1558, --"Attestation of Glory
				dropped_from = { 
					name = 'Goublefaupe - Dynamis - Beaucedine - (I-7)',
					pops = { {
						id = 3359, --"Despot's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Paladin / Hydra Red Mage / Hydra Warrior' }
					 }				
					 },				
				}
			}, 
			 {
				id = 1573, --Holy Fragment
				type = 'item',
				dropped_from = { name = 'Animated Longsword - Dynamis - Xarcabard - (G/H-8)' }
			}}
		}
    },{
		id = 21694,--en="Lionheart"
		type = 'item',
		dropped_from = {
			name = 'Lionheart',
			pops = { {
				id = 1559, --Attestation of Righteousness
				type = 'item',
				dropped_from = { 
					name = 'Goublefaupe - Dynamis - Beaucedine - (I-7)',
					pops = { {
						id = 3359, --"Despot's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Paladin / Hydra Red Mage / Hydra Warrior' }
					 }				
					 },				
				}
			}, 
			 {
				id = 1574, --Intricate Fragment
				type = 'item',
				dropped_from = { name = 'Animated Claymore - Dynamis - Xarcabard - (H-8)' }
			}}
		}
    },{
		id = 21753,--en="Tri-edge"
		type = 'item',
		dropped_from = {
			name = 'Tri-edge',
			pops = { {
				id = 1560, --Attestation of Bravery
				type = 'item',
				dropped_from = { 
					name = 'Dagourmarche - Dynamis - Beaucedine - (G-9)',
					pops = { {
						id = 3363, --"Traitor's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Beastmaster / Hydra Summoner / Hydra Dragoon' }
					 }				
					 },		
				}
			}, 
			 {
				id = 1575, --"	Runaeic Fragment
				type = 'item',
				dropped_from = { name = 'Animated Tabar - Dynamis - Xarcabard - (G-9)' }
			}}
		}
    },{
		id = 20843,--en="Chango"
		type = 'item',
		dropped_from = {
			name = 'Chango',
			pops = { {
				id = 1561, --Attestation of Force
				type = 'item',
				dropped_from = { 
					name = 'Goublefaupe - Dynamis - Beaucedine - (I-7)',
					pops = { {
						id = 3359, --"Despot's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Paladin / Hydra Red Mage / Hydra Warrior' }
					 }				
					 },				
				}
			}, 
			 {
				id = 1576, --	Seraphic Fragment
				type = 'item',
				dropped_from = { name = 'Animated Great Axe - Dynamis - Xarcabard - (G-9)' }
			}}
		}
    },{
		id = 20890,--en="Anguta"
		type = 'item',
		dropped_from = {
			name = 'Anguta',
			pops = { {
				id = 1562, --Attestation of Vigor
				type = 'item',
				dropped_from = { 
					name = 'Velosareon - Dynamis - Beaucedine - (J-8)',
					pops = { {
						id = 3362, --"Deluder's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Samurai / Hydra Dark Knight / Hydra Ranger' }
					 }				
					 },	
				}
			}, 
			 {
				id = 1577, --Tenebrous Fragment	
				type = 'item',
				dropped_from = { name = 'Animated Scythe - Dynamis - Xarcabard - (J-7)' }
			}}
		}
    },{
		id = 20935,--en="Trishula"
		type = 'item',
		dropped_from = {
			name = 'Trishula',
			pops = { {
				id = 1563, --Attestation of Fortitude
				type = 'item',
				dropped_from = { 
					name = 'Dagourmarche - Dynamis - Beaucedine - (G-9)',
					pops = { {
						id = 3363, --"Traitor's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Beastmaster / Hydra Summoner / Hydra Dragoon' }
					 }				
					 },		
				}
			}, 
			 {
				id = 1578, --Stellar Fragment
				type = 'item',
				dropped_from = { name = 'Animated Spear - Dynamis - Xarcabard - (G-8/9)' }
			}}
		}
    },{
		id = 20977,--en="Heishi Shorinken"
		type = 'item',
		dropped_from = {
			name = 'Heishi Shorinken',
			pops = { {
				id = 1564, --Attestation of Legerity
				type = 'item',
				dropped_from = { 
					name = 'Mildaunegeux - Dynamis - Beaucedine - (H-10)',
					pops = { {
						id = 3361, --"Villain's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Monk / Hydra Ninja / Hydra Thief' }
					 }				
					 },
				}
			}, 
			 {
				id = 1579, --Demoniac Fragment
				type = 'item',
				dropped_from = { name = 'Animated Kunai - Dynamis - Xarcabard - (G-8)' }
			}}
		}
    },{
		id = 21025,--en="Dojikiri Yasutsuna"
		type = 'item',
		dropped_from = {
			name = 'Dojikiri Yasutsuna',
			pops = { {
				id = 1565, --Attestation of Decisiveness
				type = 'item',
				dropped_from = { 
					name = 'Velosareon - Dynamis - Beaucedine - (J-8)',
					pops = { {
						id = 3362, --"Deluder's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Samurai / Hydra Dark Knight / Hydra Ranger' }
					 }				
					 },	
				}
			}, 
			 {
				id = 1580, --Divine Fragment
				type = 'item',
				dropped_from = { name = 'Animated Tachi - Dynamis - Xarcabard - (G-8)' }
			}}
		}
    },{
		id = 21082,--en="Tishtrya"
		type = 'item',
		dropped_from = {
			name = 'Tishtrya',
			pops = { {
				id = 1566, --	Attestation of Sacrifice
				type = 'item',
				dropped_from = { 
					name = 'Quiebitiel - Dynamis - Beaucedine - (G-11)' ,
					pops = { {
						id = 3360, --"Sadist's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Bard / Hydra Black Mage / Hydra White Mage' }
					 }				
					 },
				}
			}, 
			 {
				id = 1581, --Heavenly Fragment
				type = 'item',
				dropped_from = { name = 'Animated Hammer - Dynamis - Xarcabard - (I-10)' }
			}}
		}
    },{
		id = 21147,--en="Khatvanga"
		type = 'item',
		dropped_from = {
			name = 'Khatvanga',
			pops = { {
				id = 1567, --Attestation of Virtue
				type = 'item',
				dropped_from = { 
					name = 'Dagourmarche - Dynamis - Beaucedine - (G-9)',
					pops = { {
						id = 3363, --"Traitor's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Beastmaster / Hydra Summoner / Hydra Dragoon' }
					 }				
					 },		
				}
			}, 
			 {
				id = 1582, --Celestial Fragment
				type = 'item',
				dropped_from = { name = 'Animated Staff - Dynamis - Xarcabard - (H-8)' }
			}}
		}
    },{
		id = 22117,--en=" Fail-Not	"
		type = 'item',
		dropped_from = {
			name = 'Fail-Not',
			pops = { {
				id = 1568, --Attestation of Transcendence
				type = 'item',
				dropped_from = { 
					name = 'Velosareon - Dynamis - Beaucedine - (J-8)',
					pops = { {
						id = 3362, --"Deluder's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Samurai / Hydra Dark Knight / Hydra Ranger' }
					 }				
					 },	
				}
			}, 
			 {
				id = 1583, --Snarled Fragment
				type = 'item',
				dropped_from = { name = 'Animated Longbow - Dynamis - Xarcabard - (E-7)' }
			}}
		}
    },{
		id = 22143,--en="Fomalhaut"
		type = 'item',
		dropped_from = {
			name = 'Fomalhaut',
			pops = { {
				id = 1569, --Attestation of Accuracy
				type = 'item',
				dropped_from = { 
					name = 'Mildaunegeux - Dynamis - Beaucedine - (H-10)',
					pops = { {
						id = 3361, --"Villain's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Monk / Hydra Ninja / Hydra Thief' }
					 }				
					 },
				}
			}, 
			 {
				id = 1585, --	Ethereal Fragment
				type = 'item',
				dropped_from = { name = 'Animated Gun - Dynamis - Xarcabard - (E-8)' }
			}}
		}
    },{
		id = 21398,--en="Marsyas"
		type = 'item',
		dropped_from = {
			name = 'Marsyas',
			pops = { {
				id = 1570, --Attestation of Harmony
				type = 'item',
				dropped_from = { 
					name = 'Quiebitiel - Dynamis - Beaucedine - (G-11)' ,
					pops = { {
						id = 3360, --"Sadist's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Bard / Hydra Black Mage / Hydra White Mage' }
					 }				
					 },
				}
			}, 
			 {
				id = 1584, --Mysterial Fragment
				type = 'item',
				dropped_from = { name = 'Animated Horn - Dynamis - Xarcabard - (I-7)' }
			}}
		}
    },{
		id = 26403,--en="Srivatsa"
		type = 'item',
		dropped_from = {
			name = 'Srivatsa',
			pops = { {
				id = 1821, --Attestation of Invulnerability
				type = 'item',
				dropped_from = { 
					name = 'Goublefaupe - Dynamis - Beaucedine - (I-7)',
					pops = { {
						id = 3359, --"Despot's Fortune"
						type = 'item',
						dropped_from = { name = 'Hydra Paladin / Hydra Red Mage / Hydra Warrior' }
					 }				
					 },				
				}
			}, 
			 {
				id = 1822, --Supernal Fragment
				type = 'item',
				dropped_from = { name = 'Animated Shield - Dynamis - Xarcabard - (H-9)' }
			}}
		}
    },
	
	}
}
