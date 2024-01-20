;###########################
;# 						   # 
;# GWCA Update By 3vcloud  #
;# C+ to LUA   By MrJambix #
;###########################

;GWCA: https://github.com/gwdevhub/GWCA

#include-once
; GAME_CMSG_ - Trade related
Global Const $HEADER_TRADE_ACKNOWLEDGE = 0x0000 ; Acknowledges a trade request or action
Global Const $HEADER_TRADE_CANCEL = 0x0001 ; Cancels an ongoing trade
Global Const $HEADER_TRADE_ADD_ITEM = 0x0002 ; Adds an item to the trade window
Global Const $HEADER_TRADE_SEND_OFFER = 0x0003 ; Sends a trade offer to the other party
Global Const $HEADER_TRADE_REMOVE_ITEM = 0x0005 ; Removes an item from the trade window
Global Const $HEADER_TRADE_CANCEL_OFFER = 0x0006 ; Cancels a previously sent trade offer
Global Const $HEADER_TRADE_ACCEPT = 0x0007 ; Accepts a trade offer
Global Const $HEADER_TRADE_INITIATE = 0x0047 ; Initiates a trade with another player
Global Const $HEADER_REQUEST_QUOTE = 0x004A ; Requests a quote or price for an item
Global Const $HEADER_TRANSACT_ITEMS = 0x004B ; Confirms a transaction involving items

; GAME_CMSG_ - Connection and Ping
Global Const $HEADER_DISCONNECT = 0x0008 ; Disconnects from the server or session
Global Const $HEADER_PING_REPLY = 0x0009 ; Sends a reply to a ping request
Global Const $HEADER_HEARTBEAT = 0x000A ; Sends a heartbeat signal to maintain connection
Global Const $HEADER_PING_REQUEST = 0x000B ; Requests a ping to check the connection status

; GAME_CMSG_ - Attributes and Skills
Global Const $HEADER_ATTRIBUTE_DECREASE = 0x000C ; Decreases a player's attribute level
Global Const $HEADER_ATTRIBUTE_INCREASE = 0x000D ; Increases a player's attribute level
Global Const $HEADER_ATTRIBUTE_LOAD = 0x000E ; Loads a set of player attributes
Global Const $HEADER_USE_SKILL = 0x0044 ; Triggers the use of a player's skill
Global Const $HEADER_SKILLBAR_SKILL_SET = 0x005A ; Sets a skill in the player's skill bar
Global Const $HEADER_SKILLBAR_LOAD = 0x005B ; Loads a complete skill bar setup
Global Const $HEADER_SKILLBAR_SKILL_REPLACE = 0x005C ; Replaces a skill in the skill bar

; GAME_CMSG_ - Quests
Global Const $HEADER_QUEST_ABANDON = 0x000F ; Abandons a selected quest
Global Const $HEADER_QUEST_REQUEST_INFOS = 0x0010 ; Requests information about a quest
Global Const $HEADER_QUEST_SET_ACTIVE_CONFIRMED = 0x0012 ; Confirms setting a quest as active

; GAME_CMSG_ - Heroes and NPCs
Global Const $HEADER_HERO_BEHAVIOR = 0x0013 ; Sets the behavior/aggression level of a hero
Global Const $HEADER_HERO_LOCK_TARGET = 0x0014 ; Locks a target for the hero
Global Const $HEADER_HERO_SKILL_TOGGLE = 0x0017 ; Toggles a hero's skill on or off
Global Const $HEADER_HERO_FLAG_SINGLE = 0x0018 ; Sets a position flag for a single hero
Global Const $HEADER_HERO_FLAG_ALL = 0x0019 ; Sets a position flag for all heroes
Global Const $HEADER_HERO_USE_SKILL = 0x001A ; Uses a skill as a hero
Global Const $HEADER_HERO_ADD = 0x001C ; Adds a hero to the party
Global Const $HEADER_HERO_KICK = 0x001D ; Removes a hero from the party

; GAME_CMSG_ - Targeting and Movement
Global Const $HEADER_TARGET_CALL = 0x0021 ; Calls a target without attacking
Global Const $HEADER_ATTACK_AGENT = 0x0024 ; Initiates an attack on a selected agent
Global Const $HEADER_CANCEL_MOVEMENT = 0x0026 ; Cancels the current movement or action
Global Const $HEADER_MOVE_TO_COORD = 0x003C ; Moves to specified coordinates
Global Const $HEADER_INTERACT_ITEM = 0x003D ; Interacts with an item in the environment
Global Const $HEADER_ROTATE_PLAYER = 0x003E ; Rotates the player character
Global Const $HEADER_DRAW_MAP = 0x0029 ; Draws on the map (for map pinging/markers)

; GAME_CMSG_ - Inventory and Items
Global Const $HEADER_DROP_ITEM = 0x002A ; Drops an item from the inventory to the ground
Global Const $HEADER_DROP_GOLD = 0x002D ; Drops gold from the inventory
Global Const $HEADER_EQUIP_ITEM = 0x002E ; Equips an item from the inventory
Global Const $HEADER_UNEQUIP_ITEM = 0x004D ; Unequips an item
Global Const $HEADER_INTERACT_GADGET = 0x004F ; Interacts with a gadget or device in the game
Global Const $HEADER_SEND_SIGNPOST_DIALOG = 0x0051 ; Sends a dialog or interaction to a signpost
Global Const $HEADER_EQUIP_VISIBILITY = 0x0055 ; Toggles the visibility of equipped items
Global Const $HEADER_ITEM_DESTROY = 0x0067 ; Destroys an item
Global Const $HEADER_ITEM_APPLY_DYE = 0x0068 ; Applies dye to an item
Global Const $HEADER_ITEM_IDENTIFY = 0x006A ; Identifies an item
Global Const $HEADER_TOME_UNLOCK_SKILL = 0x006B ; Unlocks a skill using a tome
Global Const $HEADER_ITEM_MOVE = 0x0070 ; Moves an item within the inventory
Global Const $HEADER_ITEM_ACCEPT_ALL = 0x0071 ; Accepts all items in a loot or reward screen
Global Const $HEADER_ITEM_SPLIT_STACK = 0x0073 ; Splits a stack of items
Global Const $HEADER_ITEM_SALVAGE_SESSION_OPEN = 0x0075 ; Opens a salvage session
Global Const $HEADER_ITEM_SALVAGE_SESSION_CANCEL = 0x0076 ; Cancels a salvage session
Global Const $HEADER_ITEM_SALVAGE_SESSION_DONE = 0x0077 ; Completes a salvage session
Global Const $HEADER_ITEM_SALVAGE_MATERIALS = 0x0078 ; Salvages materials from an item
Global Const $HEADER_ITEM_SALVAGE_UPGRADE = 0x0079 ; Salvages upgrades from an item
Global Const $HEADER_ITEM_CHANGE_GOLD = 0x007A ; Moves gold between the player and storage
Global Const $HEADER_ITEM_USE = 0x007C ; Uses an item from the inventory

; GAME_CMSG_ - Instance Management
Global Const $HEADER_INSTANCE_LOAD_REQUEST_SPAWN = 0x0086 ; Requests spawn in an instance
Global Const $HEADER_INSTANCE_LOAD_REQUEST_PLAYERS = 0x008E ; Requests player information in an instance
Global Const $HEADER_INSTANCE_LOAD_REQUEST_ITEMS = 0x008F ; Requests item information in an instance
Global Const $HEADER_PARTY_SET_DIFFICULTY = 0x0099 ; Sets the difficulty level for a party
Global Const $HEADER_PARTY_ACCEPT_INVITE = 0x009A ; Accepts a party invitation
Global Const $HEADER_PARTY_ACCEPT_CANCEL = 0x009B ; Cancels an acceptance of a party invite
Global Const $HEADER_PARTY_ACCEPT_REFUSE = 0x009C ; Refuses a party invitation
Global Const $HEADER_PARTY_INVITE_NPC = 0x009D ; Invites an NPC to the party
Global Const $HEADER_PARTY_INVITE_PLAYER = 0x009E ; Invites a player to the party
Global Const $HEADER_PARTY_INVITE_PLAYER_NAME = 0x009F ; Invites a player to the party by name
Global Const $HEADER_PARTY_LEAVE_GROUP = 0x00A0 ; Leaves the current party or group
Global Const $HEADER_PARTY_CANCEL_ENTER_CHALLENGE = 0x00A1 ; Cancels entry into a challenge or mission
Global Const $HEADER_PARTY_ENTER_CHALLENGE = 0x00A3 ; Enters a challenge or mission
Global Const $HEADER_PARTY_RETURN_TO_OUTPOST = 0x00A5 ; Returns the party to the outpost
Global Const $HEADER_PARTY_KICK_NPC = 0x00A6 ; Removes an NPC from the party
Global Const $HEADER_PARTY_KICK_PLAYER = 0x00A7 ; Kicks a player from the party
Global Const $HEADER_PARTY_SEARCH_SEEK = 0x00A8 ; Seeks members for party formation
Global Const $HEADER_PARTY_SEARCH_CANCEL = 0x00A9 ; Cancels a party search
Global Const $HEADER_PARTY_SEARCH_REQUEST_JOIN = 0x00AA ; Requests to join a party search
Global Const $HEADER_PARTY_SEARCH_REQUEST_REPLY = 0x00AB ; Replies to a party search join request
Global Const $HEADER_PARTY_SEARCH_TYPE = 0x00AC ; Sets the type of party search
Global Const $HEADER_PARTY_READY_STATUS = 0x00AD ; Indicates ready status in a party
Global Const $HEADER_PARTY_ENTER_GUILD_HALL = 0x00AE ; Enters a guild hall
Global Const $HEADER_PARTY_TRAVEL = 0x00AF ; Travels to a different location
Global Const $HEADER_PARTY_LEAVE_GUILD_HALL = 0x00B0 ; Leaves

;====================NO CHANGES FROM HERE DOWN=======================================

;=QUEST=
Global Const $HEADER_QUEST_ACCEPT = 0x39 ;Accepts a quest from the NPC
Global Const $HEADER_QUEST_REWARD = 0x39 ;Retrieves Quest reward from NPC

;=HERO=
Global Const $HEADER_HERO_AGGRESSION = 0x13 ;Sets the heroes aggression level
Global Const $HEADER_HERO_LOCK = 0x14 ;Locks the heroes target
Global Const $HEADER_HERO_TOGGLE_SKILL = 0x17 ;Enables or disables the heroes skill
Global Const $HEADER_HERO_PLACE_FLAG = 0x18 ;Sets the heroes position flag, hero runs to position
Global Const $HEADER_HERO_CLEAR_FLAG = 0x18 ;Clears the heroes position flag
Global Const $HEADER_USE_HERO_SKILL = 0x1A ;For use with UseHeroSkillByPacket() only

;=PARTY=
Global Const $HEADER_PARTY_PLACE_FLAG = 0x19 ;Sets the party position flag, all party-npcs runs to position
Global Const $HEADER_PARTY_CLEAR_FLAG = 0x19 ;Clears the party position flag
Global Const $HEADER_HENCHMAN_ADD = 0x9D ;Adds henchman to party
Global Const $HEADER_PARTY_LEAVE = 0xA0 ;Leaves the party
Global Const $HEADER_HENCHMAN_KICK = 0xA6 ;Kicks a henchman from party
Global Const $HEADER_INVITE_TARGET = 0x9E ;Invite target player to party
Global Const $HEADER_INVITE_CANCEL = 0x9B ;Cancel invitation of player
Global Const $HEADER_INVITE_ACCEPT = 0x9A ;Accept invitation to party

;=TARGET (Enemies or NPC)=
Global Const $HEADER_CALL_TARGET = 0x21 ;Calls the target without attacking (Ctrl+Shift+Space)
Global Const $HEADER_ATTACK_AGENT = 0x24 ;Attacks agent (Space IIRC)
Global Const $HEADER_CANCEL_ACTION = 0x26 ;Cancels the current action
Global Const $HEADER_AGENT_FOLLOW = 0x31 ;Follows the agent/npc. Ctrl+Click triggers "I am following Person" in chat
Global Const $HEADER_NPC_TALK = 0x37 ;talks/goes to npc
Global Const $HEADER_SIGNPOST_RUN = 0x4F ;Runs to signpost

Global Const $HEADER_OPEN_CHEST = 0x0051

;=DROP=
Global Const $HEADER_ITEM_DROP = 0x2A ;Drops item from inventory to ground
Global Const $HEADER_GOLD_DROP = 0x2D ;Drops gold from inventory to ground

;=BUFFS=
Global Const $HEADER_STOP_MAINTAIN_ENCH = 0x27 ;Drops buff, cancel enchantmant, whatever you call it

;=ITEMS=
Global Const $HEADER_ITEM_EQUIP = 0x2E ;Equips item from inventory/chest/no idea
Global Const $HEADER_ITEM_PICKUP = 0x3D ;Picks up an item from ground
Global Const $HEADER_ITEM_DESTROY = 0x67 ;Destroys the item
Global Const $HEADER_ITEM_ID = 0x6A ;Identifies item in inventory
Global Const $HEADER_ITEM_MOVE = 0x70 ;Moves item in inventory
Global Const $HEADER_ITEMS_ACCEPT_UNCLAIMED = 0x71 ;Accepts ITEMS not picked up in missions
Global Const $HEADER_ITEM_MOVE_EX = 0x73 ;Moves an item, with amount to be moved.
Global Const $HEADER_SALVAGE_MATS = 0x78 ;Salvages materials from item
Global Const $HEADER_SALVAGE_MODS = 0x79 ;Salvages mods from item
Global Const $HEADER_SALVAGE_SESSION = 0x75 ;Salvages mods from item
Global Const $HEADER_ITEM_USE = 0x7C ;Uses item from inventory/chest
Global Const $HEADER_ITEM_UNEQUIP = 0x4D ;Unequip item
Global Const $HEADER_UPGRADE = 0x86 ;used by gwapi. is it even useful? NOT TESTED
Global Const $HEADER_UPGRADE_ARMOR_1 = 0x83 ;used by gwapi. is it even useful? NOT TESTED
Global Const $HEADER_UPGRADE_ARMOR_2 = 0x86 ;used by gwapi. is it even useful? NOT TESTED
Global Const $HEADER_EQUIP_BAG = 0x70
;Global Const $HEADER_USE_ITEM = 0x85

;=TRADE=
Global Const $HEADER_TRADE_PLAYER = 0x47 ;Send trade request to player
Global Const $HEADER_TRADE_OFFER_ITEM = 0x02 ;Add item to trade window
Global Const $HEADER_TRADE_SUBMIT_OFFER = 0x03 ;Submit offer
Global Const $HEADER_TRADE_CHANGE_OFFER = 0x06 ;Change offer

;=TRAVEL=
Global Const $HEADER_MAP_TRAVEL = 0xAF ;Travels to outpost via worldmap
Global Const $HEADER_GUILDHALL_TRAVEL = 0xAE ;Travels to guild hall
Global Const $HEADER_GUILDHALL_LEAVE = 0xB0 ;Leaves Guildhall

;=FACTION=
Global Const $HEADER_FACTION_DONATE = 0x0033 ;Donates kurzick/luxon faction to ally

;=DIALOG=
Global Const $HEADER_DIALOG = 0x39 ;Sends a dialog to NPC
Global Const $HEADER_CINEMATIC_SKIP = 0x61 ;Skips the cinematic
Global Const $HEADER_HOM_DIALOG = 0x58

;=SKILL / BUILD=
Global Const $HEADER_SET_SKILLBAR_SKILL = 0x5C ;Changes a skill on the skillbar
Global Const $HEADER_LOAD_SKILLBAR = 0x5B ;Loads a complete build
Global Const $HEADER_CHANGE_SECONDARY = 0x48 ;Changes Secondary class (from Build window, not class changer)
Global Const $HEADER_SKILL_USE_ALLY = 0x4B ;used by gwapi. appears to have changed
Global Const $HEADER_SKILL_USE_FOE = 0x4B ;used by gwapi. appears to have changed
Global Const $HEADER_SKILL_USE_ID = 0x4B ;
Global Const $HEADER_SET_ATTRIBUTES = 0x0E ;hidden in init stuff like sendchat
Global Const $HEADER_OPEN_SKILLS = 0x40
Global Const $HEADER_USE_SKILL = 0x44
Global Const $HEADER_PROFESSION_ULOCK = 0x40

;=CHEST=
Global Const $HEADER_CHEST_OPEN = 0x51 ;Opens a chest (with key AFAIK)
Global Const $HEADER_CHANGE_GOLD = 0x7A ;Moves Gold (from chest to inventory, and otherway around IIRC)

;=MISSION=
Global Const $HEADER_MODE_SWITCH = 0x99 ;Toggles hard- and normal mode
Global Const $HEADER_MISSION_ENTER = 0xA3 ;Enter a mission/challenge
Global Const $HEADER_MISSION_FOREIGN_ENTER = 0xAE ;Enters a foreign mission/challenge (no idea honestly)
Global Const $HEADER_OUTPOST_RETURN = 0xA5 ;Returns to outpost after /resign

;=CHAT=
Global Const $HEADER_SEND_CHAT = 0x62 ;Needed for sending messages in chat

;=MOVEMENT=
Global Const $HEADER_MOVEMENT_TICK = 0x1E

;=OTHER CONSTANTS=
Global Const $HEADER_MAX_ATTRIBUTES_CONST_5 = 0x03 ;constant at word 5 of max attrib packet. Changed from 3 to four in most recent update
Global Const $HEADER_MAX_ATTRIBUTES_CONST_22 = 0x03 ;constant at word 22 of max attrib packet. Changed from 3 to four in most recent update
Global Const $HEADER_OPEN_GB_WINDOW = 0x9E
Global Const $HEADER_CLOSE_GB_WINDOW = 0x9F
Global Const $HEADER_START_RATING_GVG = 0xA8

;=NEW CONSTANTS=
Global Const $HEADER_TITLE_UPDATE = 0x00F4 
Global Const $HEADER_TITLE_TRACK_INFO = 0x0075 
Global Const $HEADER_PLAYER_ATTR_UPDATE = 0x0086 
Global Const $HEADER_PLAYER_ATTR_SET = 0x0097 
