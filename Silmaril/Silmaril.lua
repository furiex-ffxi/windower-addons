_addon.name = 'Silmaril'
_addon.author = 'Mirdain'
_addon.version = '4.0 Main'
_addon.description = 'A multi-boxer tool'
_addon.commands = {'silmaril','sm'}

extdata = require 'extdata'
texts = require 'texts'

require 'tables'
require 'strings'
require 'coroutine'
require 'pack'

require 'lib./Windower' -- Handles all the windower resources

-- Core components
require 'lib./Abilities' --Gets information about the player abilities
require 'lib./Addons' -- Manages the addons
require 'lib./Buffs' --Used to process incoming buff packets for other party members
require 'lib./Burst' --Selects and returns the spell to burst
require 'lib./Commands' --Handles addon commands
require 'lib./Connection' --Send and Receive information
require 'lib./Engine' -- Core of the program is ran from this
require 'lib./Display' --Send and Receive information
require 'lib./Helpers' --Common libraries
require 'lib./Input' --Receive commands to execute
require 'lib./Inventory' --Build the inventory information
require 'lib./IPC' --Handles any IPC messages that are being sent
require 'lib./Hover' -- Handles Hover shot movement
require 'lib./Maps' -- Remaps the windower resources before sending to Silmaril
require 'lib./Mirror' -- Allows all members to mirror the main players actions
require 'lib./Moving' --Controls moving of charater
require 'lib./Packets' --Handles packet messages
require 'lib./Party' --Gets information about the current party and alliance
require 'lib./Player' --Gets information about the player
require 'lib./Skillchain' --Monitors action packets to build skillchains with
require 'lib./Spells' --Gets information about the player spells
require 'lib./Sync' --Gets information about ffxi and sends to the Silmaril
require 'lib./Update' --Sets pace and updates globals form windower
require 'lib./Weaponskills' --Gets information about weaponskills
require 'lib./World' --Gets information about the world
require 'lib./Protection' -- Credit goes to witnessprotection for the idea - 'Lili'

-- Addons
require 'lib./Addons./Sortie' -- Addon to help track objectives
require 'lib./Addons./Insight' -- Replacement for TP part to make windower4 more efficient
require 'lib./Addons./Augmentation' -- Automates the augmentation process for Alluvian Skirmish gear and JSE Capes

windower_hook()
