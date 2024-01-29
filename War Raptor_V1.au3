#cs
#################################
#                               #
#     Raptor Bot by Rattiev     #
#                               #
#   Modified from Vaettir Bot   #
#            by gigi            #
#                               #
#################################
#	Update by MrJambix - 2024   #
#		Added: Salvage			#	
#################################


#ce

#RequireAdmin
#NoTrayIcon
#include "GWA2_Headers.au3"
#include "GWA2.au3"
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <GuiEdit.au3>
Opt("GUIOnEventMode", True)
Opt("GUICloseOnESC", False)
Opt("MustDeclareVars", True)

#Region About;~
;~ Summary:  Farms Raptors from Rata Sum with W/N or N/W
;~	_____________________________________
;~
;~ This was tested using a W/N (may work with N/W) with the following info:
;~		This Build: OQQUc2YQ1qS0kqM9F5FWCjarF7gA (I am Unstoppable)

;~		Two Sentinels's Insignias
;~      Three Knight's Insignias
;~ 		+1 Tactics Helm w/ +3 Tactics Rune
;~ 		+50hp Rune
;~      Supperior Absorption Rune
;~      +2 Strength Rune
;~ 		480 Health
;~ 		35 Energy
;~      Sword +30hp
;~		Tactics Shield +30hp +10 vs Pierciing ("Through Thick and Thin"")
;~		Suggested Setup:
;~      Curses 11
;~      Strength 1+2
;~	    Tactics  10+4
;~		Swordsmanship 10

;~	_____________________________________
;~
;~ Note: Use Paragon Hero for this script
;~		 General Morghan Build:  OQijEqmMKODbe8O2Efjrx0bWMA  (add +3 Command Rune to headgear for best results)
;~  _____________________________________
;~
;~ Func HowToUseThisProgram()
;~		Download/Unzip files
;~		Put GWA2, GWA2 Headers and Raptor Farmer in same folder
;~		Start Guild Wars
;~ 		Log onto your Warrior
;~		Open your War Raptor 2021.au3 file in AutoIt
;~ 		Run the Raptor Farmer from AutoIt (Top left select tools, then select go or just F5)
;~      Select the character you want from the dropdown menu of the script that appears
;~ 		Click Start
;~ 		EndIf
;~ EndFunc;
;~________________________________________
;~
;
;~ ChangeLog v1.0
;~   Improved success rate to 70-75% on average (with ~100 runs total)
;~   Adjusted timing of skills
;~   Adjusted pathing
;~
;~ Notes
;~   Bot does not run properly after identifying and selling loot, restart code when this happens.

#EndRegion About

; ==== Constants ====
Global Enum $DIFFICULTY_NORMAL, $DIFFICULTY_HARD
Global Enum $INSTANCETYPE_OUTPOST, $INSTANCETYPE_EXPLORABLE, $INSTANCETYPE_LOADING
Global Enum $RANGE_ADJACENT=156, $RANGE_NEARBY=240, $RANGE_AREA=312, $RANGE_EARSHOT=1000, $RANGE_SPELLCAST = 1085, $RANGE_SPIRIT = 2500, $RANGE_COMPASS = 5000
Global Enum $RANGE_ADJACENT_2=156^2, $RANGE_NEARBY_2=240^2, $RANGE_AREA_2=312^2, $RANGE_EARSHOT_2=1000^2, $RANGE_SPELLCAST_2=1085^2, $RANGE_SPIRIT_2=2500^2, $RANGE_COMPASS_2=5000^2
Global Enum $PROF_NONE, $PROF_WARRIOR, $PROF_RANGER, $PROF_MONK, $PROF_NECROMANCER, $PROF_MESMER, $PROF_ELEMENTALIST, $PROF_ASSASSIN, $PROF_RITUALIST, $PROF_PARAGON, $PROF_DERVISH

Global Const $Town_ID_Ratasum = 640
Global Const $MAP_ID_Riven = 501

Global Const $Town_ID_Great_Temple_of_Balthazar = 248

#Region Global Items
Global Const $RARITY_Gold = 2624
Global Const $RARITY_Purple = 2626
Global Const $RARITY_Blue = 2623
Global Const $RARITY_White = 2621

;~ All Weapon mods
Global $Weapon_Mod_Array[25] = [893, 894, 895, 896, 897, 905, 906, 907, 908, 909, 6323, 6331, 15540, 15541, 15542, 15543, 15544, 15551, 15552, 15553, 15554, 15555, 17059, 19122, 19123]

;~ General Items
Global $General_Items_Array[6] = [2989, 2991, 2992, 5899, 5900, 22751]
Global Const $ITEM_ID_Lockpicks = 22751

;~ Dyes
Global Const $ITEM_ID_Dyes = 146
Global Const $ITEM_ExtraID_BlackDye = 10
Global Const $ITEM_ExtraID_WhiteDye = 12

;~ Alcohol
Global $Alcohol_Array[19] = [910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 19172, 19173, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682]
Global $OnePoint_Alcohol_Array[11] = [910, 5585, 6049, 6367, 6375, 15477, 19171, 19172, 19173, 22190, 28435]
Global $ThreePoint_Alcohol_Array[7] = [2513, 6366, 24593, 30855, 31145, 31146, 35124]
Global $FiftyPoint_Alcohol_Array[1] = [36682]

;~ Party
Global $Spam_Party_Array[5] = [6376, 21809, 21810, 21813, 36683]

;~ Sweets
Global $Spam_Sweet_Array[6] = [21492, 21812, 22269, 22644, 22752, 28436]

;~ Tonics
Global $Tonic_Party_Array[4] = [15837, 21490, 30648, 31020]

;~ DR Removal
Global $DPRemoval_Sweets[6] = [6370, 21488, 21489, 22191, 26784, 28433]

;~ Special Drops
Global $Special_Drops[7] = [5656, 18345, 21491, 37765, 21833, 28433, 28434]

;~ Stupid Drops that I am not using, but in here in case you want these to add these to the CanPickUp and collect in your chest
Global $Map_Piece_Array[4] = [24629, 24630, 24631, 24632]

;~ Stackable Trophies
Global $Stackable_Trophies_Array[1] = [27047]
Global Const $ITEM_ID_Glacial_Stones = 27047

;~ Materials
Global $All_Materials_Array[36] = [921, 922, 923, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945, 946, 948, 949, 950, 951, 952, 953, 954, 955, 956, 6532, 6533]
Global $Common_Materials_Array[11] = [921, 925, 929, 933, 934, 940, 946, 948, 953, 954, 955]
Global $Rare_Materials_Array[25] = [922, 923, 926, 927, 928, 930, 931, 932, 935, 936, 937, 938, 939, 941, 942, 943, 944, 945, 949, 950, 951, 952, 956, 6532, 6533]

;~ Tomes
Global $All_Tomes_Array[20] = [21796, 21797, 21798, 21799, 21800, 21801, 21802, 21803, 21804, 21805, 21786, 21787, 21788, 21789, 21790, 21791, 21792, 21793, 21794, 21795]
Global Const $ITEM_ID_Mesmer_Tome = 21797

;~ Scrolls
Global $All_Scrolls_Array[9] = [3746, 22280, 765, 767, 768, 1887, 857, 894, 895]

;~ Arrays for the title spamming (Not inside this version of the bot, but at least the arrays are made for you)
Global $ModelsAlcohol[100] = [910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682]
Global $ModelSweetOutpost[100] = [15528, 15479, 19170, 21492, 21812, 22644, 31150, 35125, 36681]
Global $ModelsSweetPve[100] = [22269, 22644, 28431, 28432, 28436]
Global $ModelsParty[100] = [6368, 6369, 6376, 21809, 21810, 21813]

Global $Array_pscon[40]=[910, 5585, 6366, 6375, 22190, 24593, 28435, 30855, 31145, 35124, 36682, 6376, 21809, 21810, 21813, 36683, 21492, 21812, 22269, 22644, 22752, 28436,15837, 21490, 30648, 31020, 6370, 21488, 21489, 22191, 26784, 28433, 5656, 18345, 21491, 37765, 21833, 28433, 28434, 27035] ;last one is saurian bones

Global $Array_Store_ModelIDs460[147] = [474, 476, 486, 522, 525, 811, 819, 822, 835, 610, 2994, 19185, 22751, 4629, 24630, 4631, 24632, 27033, 27035, 27044, 27046, 27047, 7052, 5123 _
		, 1796, 21797, 21798, 21799, 21800, 21801, 21802, 21803, 21804, 1805, 910, 2513, 5585, 6049, 6366, 6367, 6375, 15477, 19171, 22190, 24593, 28435, 30855, 31145, 31146, 35124, 36682 _
		, 6376 , 6368 , 6369 , 21809 , 21810, 21813, 29436, 29543, 36683, 4730, 15837, 21490, 22192, 30626, 30630, 30638, 30642, 30646, 30648, 31020, 31141, 31142, 31144, 1172, 15528 _
		, 15479, 19170, 21492, 21812, 22269, 22644, 22752, 28431, 28432, 28436, 1150, 35125, 36681, 3256, 3746, 5594, 5595, 5611, 5853, 5975, 5976, 21233, 22279, 22280, 6370, 21488 _
		, 21489, 22191, 35127, 26784, 28433, 18345, 21491, 28434, 35121, 921, 922, 923, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943 _
		, 944, 945, 946, 948, 949, 950, 951, 952, 953, 954, 955, 956, 6532, 6533]

#EndRegion Global Items



#Region Guild Hall Globals
Global $TEMPLATE = "OQQUc2YQ1qS0kqM9F5FWCjarF7gA"
#EndRegion Guild Hall Globals

; ================== CONFIGURATION ==================
; True or false to load the list of logged in characters or not
Global Const $doLoadLoggedChars = True
; ================ END CONFIGURATION ================

; ==== Bot global variables ====
Global $RenderingEnabled = True
Global $PickUpAll = True
Global $PickUpMapPieces = False
Global $PickUpSaurianBones = False

Global $RunCount = 0
Global $FailCount = 0
Global $BotRunning = False
Global $BotInitialized = False
Global $ChatStuckTimer = TimerInit()
Global $Return

Global $BAG_SLOTS[18] = [0, 20, 5, 10, 10, 20, 41, 12, 20, 20, 20, 20, 20, 20, 20, 20, 20, 9]

;~ Any pcons you want to use during a run
Global $pconsEgg_slot[0]
Global $useEgg = True ; set it on true and he use it

; ==== Build ====
Global Const $SkillBarTemplate = "OQQUc2YQ1qS0kqM9F5FWCjarF7gA"
; declare skill numbers to make the code WAY more readable (UseSkill($sf) is better than UseSkill(2))
Global Const $ds = 1
Global Const $pd = 2
Global Const $hb = 3
Global Const $ws = 4
Global Const $MoP = 5
Global Const $ss = 6
Global Const $sb = 7
Global Const $wa = 8


; Additional global variables for salvage options
Global $SalvageWeapons, $SalvageTrophies, $salvItemsInput, $salvItems = []

#Region GUI
Global $MATID, $RAREMATSBUY = False, $mFoundChest = False, $mFoundMerch = False, $Bags = 4, $PICKUP_GOLDS = False
Global $SELECT_TOWN = "Rata Sum|Start Run" ;|Identify & Sell
Global $RATASUM = False ;For resign preparation
Global $StartRun = False ;When just running bot
;Global $Identify_Sell = False


Global Const $mainGui = GUICreate("Raptor Bot", 500, 275)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_exit")
Global $Input
If $doLoadLoggedChars Then
	$Input = GUICtrlCreateCombo("", 8, 8, 129, 21)
		GUICtrlSetData(-1, GetLoggedCharNames())
Else
	$Input = GUICtrlCreateInput("character name", 8, 8, 129, 21)
EndIf
Global $LOCATION = GUICtrlCreateCombo("Location", 8, 35, 125, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlCreateLabel("Runs:", 8, 65, 70, 17)
Global Const $RunsLabel = GUICtrlCreateLabel($RunCount, 80, 65, 50, 17)
GUICtrlCreateLabel("Fails:", 8, 80, 70, 17)
Global Const $FailsLabel = GUICtrlCreateLabel($FailCount, 80, 80, 50, 17)
Global Const $Checkbox = GUICtrlCreateCheckbox("Disable Rendering", 8, 98, 129, 17)
	GUICtrlSetState( -1, $GUI_DISABLE)
	GUICtrlSetOnEvent( -1, "ToggleRendering")
Global Const $Button = GUICtrlCreateButton("Start", 8, 120, 131, 25)
	GUICtrlSetOnEvent(-1, "GuiButtonHandler")
Global Const $StatusLabel = GUICtrlCreateLabel("", 8, 148, 125, 17)
; Adjust the Y position of the checkboxes to be below the Start button

Global $SalvageTrophies = GUICtrlCreateCheckbox("Salvage Trophies", 8, 175, 150, 20) ; Adjusted position
    GUICtrlSetState($SalvageTrophies, $GUI_UNCHECKED)
Global $SalvageWeapons = GUICtrlCreateCheckbox("Salvage Weapons", 8, 200, 150, 20) ; Adjusted position
    GUICtrlSetState($SalvageWeapons, $GUI_UNCHECKED)
Global $GLOGBOX = GUICtrlCreateEdit("", 140, 8, 340, 240, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL))
GUICtrlSetColor($GLOGBOX, 65280)
GUICtrlSetBkColor($GLOGBOX, 0)
GUISetState(@SW_SHOW)
GUICtrlSetData($LOCATION, $SELECT_TOWN)

;~ Description: Handles the button presses
Func GuiButtonHandler()
	If $BotRunning Then
		GUICtrlSetData($Button, "Will pause after this run")
		GUICtrlSetState($Button, $GUI_DISABLE)
		$BotRunning = False
	ElseIf $BotInitialized Then
		GUICtrlSetData($Button, "Pause")
		$BotRunning = True
	Else
		Out("Initializing")
		Local $CharName = GUICtrlRead($Input)
		If $CharName=="" Then
			If Initialize(ProcessExists("gw.exe")) = False Then
				MsgBox(0, "Error", "Guild Wars is not running.")
				Exit
			EndIf
		Else
			If Initialize($CharName) = False Then
				MsgBox(0, "Error", "Could not find a Guild Wars client with a character named '"&$CharName&"'")
				Exit
			EndIf
		EndIf
		GUICtrlSetState($SalvageTrophies, $GUI_DISABLE)
		GUICtrlSetState($SalvageWeapons, $GUI_DISABLE)
		GUICtrlSetState($Checkbox, $GUI_ENABLE)
		GUICtrlSetState($Input, $GUI_DISABLE)
		GUICtrlSetData($Button, "Pause")
		WinSetTitle($mainGui, "", "VBot-" & GetCharname())
		Out("basepointer:" & Hex($mBasePointer, 8))
		$BotRunning = True
		$BotInitialized = True
	EndIf
EndFunc
#EndRegion GUI

Out("Modified from Vaettir code by gigi & fixed by Fishy")
Out("Some functions may not be 100% working")
Out("Waiting for input")

While Not $BotRunning
	Sleep(100)
WEnd

While True
	If (CountSlots() < 5) Then
		If Not $BotRunning Then
			Out("Bot Paused")
			GUICtrlSetState($Button, $GUI_ENABLE)
			GUICtrlSetData($Button, "Start")
			While Not $BotRunning
				Sleep(100)
			WEnd
		EndIf
		Inventory()
	EndIf

	If GUICtrlRead($LOCATION, "") == "Rata Sum" Then
		$RATASUM = True
	; ElseIf GUICtrlRead($LOCATION, "") == "Identify & Sell" Then
		; $Identify_Sell = True
	EndIf
	If $RATASUM Then MapR()
	; If $Identify_Sell Then
		; Out("Identifying")
		; Ident(1)
		; Ident(2)
		; Ident(3)
		; Ident(4)
	; EndIf
	If $RATASUM Then RunThereRatasum()
	If $StartRun Then RunStartRun()
	If (GetIsDead(-2)==True) Then ContinueLoop

	If GUICtrlRead(4) = 1 Then
		$PickUpAll = False
	Else
		$PickUpAll = True
	EndIf

	While (CountSlots() > 4)
		If Not $BotRunning Then
			Out("Bot Paused")
			GUICtrlSetState($Button, $GUI_ENABLE)
			GUICtrlSetData($Button, "Start")
			While Not $BotRunning
				Sleep(100)
			WEnd
		EndIf
		CombatLoop()
	WEnd

	If (CountSlots() < 6) Then
		If Not $BotRunning Then
			Out("Bot Paused")
			GUICtrlSetState($Button, $GUI_ENABLE)
			GUICtrlSetData($Button, "Start")
			While Not $BotRunning
				Sleep(100)
			WEnd
		EndIf
		Inventory()
	EndIf
WEnd

Func MapR()
;~ Checks if you are already in Rata Sum, if not then you travel to Sifhalla
	If (GetMapID() <> $Town_ID_Ratasum) Then
		Out("Travelling to Rata Sum")
;		RndTravel($Town_ID_Ratasum)
		TravelTo($Town_ID_Ratasum)
	EndIf
	Sleep(GetPing()+500)
EndFunc

;~ Description: Initiates run without preparing resign
Func RunStartRun()
	SwitchMode(1)
	AddHero(11)
	Out("Beginning Run")
EndFunc

Func DisableHeroSkills()
	For $i = 1 to 8
		DisableHeroSkillSlot(1, $i)
	Next
EndFunc

Func RunThereRatasum()
		SwitchMode(1)
		AddHero(11)
		;DisableHeroSkills()
		Out("Setting up Resign.")
		MoveTo(19649, 16791)
		Move(20084, 16854)
		Sleep(3000)
		Out("Travel: Riven Earth")
		WaitMapLoading($MAP_ID_RIVEN)
		Move(-26309, -4112)
		Sleep(3000)
		Out("Travel: Rata Sum")
		WaitMapLoading($Town_ID_Ratasum)
		Out("Resign preparation complete!")
		Out("Beginning Next Run")
EndFunc

Func MoveToBaseOfCave()
	Local $aitem
	Local $lme = GetAgentByID(-2)
	If GetMapID() <> $MAP_ID_RIVEN Then Return
	If GetIsDead(-2) Then Return
	Out("Moving to Cave")
	;Move(-23058, -6557)
	;RndSleep(Random(100, 300))
	Move(-22015, -7502)

	RndSleep(Random(500, 1000))
	UseHeroSkill(1, 3)
	RndSleep(Random(7000, 7800))
	UseSkill($ds, $lMe)
	Moveto(-21333, -8384)
	UseHeroSkill(1, 4, -2)
	Sleep(1800)
	;Rndsleep(Random(1250,1500))
	UseHeroSkill(1, 5, -2)
	Rndsleep(Random(20, 50))
	UseHeroSkill(1, 6)
	Rndsleep(Random(20, 50))
	UseHeroSkill(1, 7)
	Rndsleep(Random(20, 50))
	UseHeroSkill(1, 8, -2)
	Move(-20683, -9441, 40)
EndFunc

Func CheckRep()
	If GetMapID() <> $MAP_ID_RIVEN Then Return
	Out("Checking Asura Title.")
	Local $Asura = GetAsuraTitle()
	If $Asura > 160000 Then
		Sleep(200)
	Else
		GetBlessing()
	EndIf
	UseHeroSkill(1, 1)
	Sleep(200)
	UseHeroSkill(1, 1)
EndFunc

Func GetBlessing()
   Out("Getting blessing")
   GoNearestNPCToCoords(-20000, 3000)
   Dialog(132)
EndFunc

Func KillHero()
	If GetMapID() <> $MAP_ID_RIVEN Then Return
	Out("Killing Hero")
;	CommandAll(-19952, -6728)
	CommandAll(-25309, -4212)
	Sleep(Random(250, 500))
EndFunc

Func GetRaptors()
	If GetMapID() <> $MAP_ID_RIVEN Then Return

	Out("Gathering Raptors")
	Local $lMoPTarget = GetNearestEnemyToAgent(-2)
	Local $lme = GetAgentByID(-2)
	Local $CheckTarget

	MoveTo(-20851, -9501, 20)
	$lMoPTarget = GetNearestEnemyToAgent(-2)
	UseSkill($sb, -2)
	UseSkillEx($MoP, $lMoPTarget)

	$CheckTarget = TargetNearestEnemy()
	MoveTo(-20882, -9267, 50)
	MoveTo(-20707, -9176, 50)
	; Sleep(10)
	; MoveAggroing(-20002, -10281, 50, $CheckTarget)
	; MoveAggroing(-19750, -10735, 50, $CheckTarget)
	; MoveAggroing(-19766, -11315, 50, $CheckTarget)
	; MoveAggroing(-20572, -12201, 50, $CheckTarget)
	; MoveAggroing(-21010, -12151, 50, $CheckTarget)
	; MoveAggroing(-22000, -11877, 50, $CheckTarget)
	; MoveAggroing(-22780, -11949, 20, $CheckTarget)
	; MoveAggroing(-22978, -12120, 15, $CheckTarget)
	; MoveTo(-20042, -10251, 50)
	MoveAggroing(-20042, -10251, 50, $CheckTarget)
	; MoveTo(-19750, -10735, 50)
	MoveTo(-19810, -10735, 50)
	MoveTo(-19796, -11315, 50)
	MoveTo(-20572, -12201, 50)
	; MoveTo(-21010, -12151, 50)
	MoveAggroing(-21010, -12151, 50, $CheckTarget)
	MoveTo(-22000, -11927, 50)
	; MoveTo(-22780, -11949, 20)
	TargetNearestEnemy()
	MoveTo(-22850, -11990, 20)
	MoveTo(-22978, -12120, 15)
	; MoveAggroing(-22978, -12120, 15, $CheckTarget)
EndFunc

Func KillRaptors()
	Local $lMoPTarget
	Local $lMe = GetAgentByID(-2)
	Local $lRekoff

	If GetMapID() <> $MAP_ID_RIVEN Then Return

	If GetIsDead($lme) Then Return
	Out("Popping Raptors")
	UseSkill($ds, $lMe)
	Rndsleep(Random(30, 60))
	UseSkill($pd, $lMe)
	Rndsleep(Random(30, 60))
	UseSkill($hb, $lMe)
	Rndsleep(Random(600, 800))
	; Sleep(1000)
	UseSkill($ws, $lMe)
	Rndsleep(Random(400, 600))

	$lRekoff = (GetAgentByName("Rekoff Broodmother"))

	If ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), DllStructGetData($lRekoff, 'X'), DllStructGetData($lRekoff, 'Y')) > 1500 Then
		$lMoPTarget = GetNearestEnemyToAgent(-2)
	Else
		$lMoPTarget = GetNearestEnemyToAgent($lRekoff)
	EndIf

	If GetHasHex($lMoPTarget) Then
		TargetNextEnemy()
		$lMoPTarget = GetCurrentTarget()
	EndIf

	Local $lDistance
	Local $RANGE_SPELLCAST_2 = 1085^2
	Local $lSpellCastCount
	Local $lAgentArray

	$lAgentArray = GetAgentArray(0xDB)

	For $i=1 To $lAgentArray[0]
	$lDistance = GetPseudoDistance($lMe, $lAgentArray[$i])
		If $lDistance < $RANGE_SPELLCAST_2 Then
			$lSpellCastCount += 1
		EndIf
	Next

	If $lSpellCastCount	> 20 Then
		Sleep(1500)
	Elseif $lSpellCastCount < 21 Then
		Sleep(3500)
	EndIf

	UseSkill($MoP, $lMoPTarget)
	Rndsleep(Random(800, 1000))
	UseSkillEx($ss, $lMe)
	Rndsleep(Random(30, 60))
	UseSkill($sb, $lMe)
	Rndsleep(Random(30, 60))
	UseSkill($wa, GetNearestEnemyToAgent(-2))
	Sleep(GetPing()+1900)
	UseSkill($wa, GetNearestEnemyToAgent(-2))
	Sleep(GetPing()+3000)
	;Do
		;If GetIsDead(-2) Then Return
		;Sleep(GetPing()+150)
	;Until GetNumberOfFoesInRangeOfAgent(-2, 1000) <= 2
	Out("Picking up Loot")
	CustomPickUpLoot()
	Out("Looting Complete")
EndFunc

Func UpdateStats()
	Local $lMe
	Local $RANGE_ADJACENT_2 = 156^2
	Local $lAdjacentCount, $lDistance
	Local $lAgentArray

	$lAgentArray = GetAgentArray(0xDB)

	For $i=1 To $lAgentArray[0]
	$lDistance = GetPseudoDistance($lMe, $lAgentArray[$i])
		If $lDistance < $RANGE_ADJACENT_2 Then
			$lAdjacentCount += 1
		EndIf
	Next

	If GetIsDead(-2) Then
		Out("Ouch, we died!")
		$FailCount += 1
		GUICtrlSetData($FailsLabel, $FailCount)
	ElseIf $lAdjacentCount > 2 Then
		Out("Not enough Raptors killed!")
		$FailCount += 1
		GUICtrlSetData($FailsLabel, $FailCount)
	Else
		$RunCount += 1
		GUICtrlSetData($RunsLabel, $RunCount)
	EndIf
EndFunc

; Func _PurgeHook()
	; Out("Purging Engine Hook")
	; ToggleRendering()
	; Sleep(Random(2000, 2500))
	; ClearMemory()
	; Sleep(Random(2000, 2500))
	; ToggleRendering()
; EndFunc

Func GetChecked($GUICtrl)
	Return (GUICtrlRead($GUICtrl)==$GUI_Checked)
EndFunc

Func BackToTown()
	UpdateStats()
	; If Getchecked ($Purge_CBX) Then
	; _PurgeHook()
	; EndIf

	If GetMapID() = $MAP_ID_RIVEN Then
		Resign()
		Sleep(3400)
		;PingSleep(2000)  ;Ping Sleep cuases crash.  Review Function and make edits.
		Out("Travel: Rata Sum")
		ReturnToOutpost()
		WaitMapLoading($Town_ID_Ratasum)
	EndIf
EndFunc

; Description: This is pretty much all, take bounty, kill, rezone
Func CombatLoop()
;	If Not $RenderingEnabled Then ClearMemory()
	Sleep(Random(GetPing()+2000, GetPing()+5000))
	Out("Travel: Riven")
	Move(20084, 16854)
	Sleep(GetPing()+1000)
	UseHeroSkill(1, 2)
	WaitMapLoading($MAP_ID_RIVEN)
	UseHeroSkill(1, 2)
	Out("Loaded Riven, ready to run!")
	CheckRep()
;	SendChat("")
	UseHeroSkill(1, 1)
	DisplayCounts()
;	Sleep(GetPing()+200)
	MoveToBaseOfCave()
	KillHero()
	GetRaptors()
	KillRaptors()
;	Out("Killing")
;	Kill()

;	WaitFor(1200)

;	Out("Looting")
;	CustomPickUpLoot()
	BackToTown()

EndFunc

;~ Description: Move to destX, destY, while staying alive vs vaettirs
Func MoveAggroing($lDestX, $lDestY, $lRandom, $CheckTarget)
	If GetIsDead(-2) Then Return

	Local $lMe
	Local $ChatStuckTimer
	Local $lBlocked
	Local $RANGE_ADJACENT_2 = 156^2
	Local $lAdjacentCount, $lDistance
	Local $lAgentArray


	Move($lDestX, $lDestY, $lRandom)

	$lAgentArray = GetAgentArray(0xDB)

	For $i=1 To $lAgentArray[0]
	$lDistance = GetPseudoDistance($lMe, $lAgentArray[$i])
		If $lDistance < $RANGE_ADJACENT_2 Then
			$lAdjacentCount += 1
		EndIf
	Next

	If $lAdjacentCount > 10 Then
		$Return += 1
	EndIf

	Do
		Sleep(50)

		$lMe = GetAgentByID(-2)

		If GetIsDead($lMe) Then Return

		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
			$lBlocked += 1
			Move($lDestX, $lDestY, $lRandom)
		EndIf

		If $lBlocked > 3 Then
			If TimerDiff($ChatStuckTimer) > 2500 Then	; use a timer to avoid spamming /stuck
				SendChat("stuck", "/")
				$ChatStuckTimer = TimerInit()
				$Return += 1
			EndIf
		EndIf

		If GetDistance() > 1500 Then ; target is far, we probably got stuck.
			If TimerDiff($ChatStuckTimer) > 2500 Then ; dont spam
				SendChat("stuck", "/")
				$ChatStuckTimer = TimerInit()
				RndSleep(GetPing())
				Attack($CheckTarget)
				$Return += 1
			EndIf
		EndIf

		If $Return > 0 Then Return

	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < $lRandom*1.5
EndFunc


Func GoNearestNPCToCoords($x, $y)
	Local $guy, $Me
	Do
		RndSleep(250)
		$guy = GetNearestNPCToCoords($x, $y)
	Until DllStructGetData($guy, 'Id') <> 0
	ChangeTarget($guy)
	RndSleep(250)
	GoNPC($guy)
	RndSleep(250)
	Do
		RndSleep(500)
		Move(DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y'), 40)
		RndSleep(500)
		GoNPC($guy)
		RndSleep(250)
		$Me = GetAgentByID(-2)
	Until ComputeDistance(DllStructGetData($Me, 'X'), DllStructGetData($Me, 'Y'), DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y')) < 250
	RndSleep(1000)
EndFunc   ;==>GoNearestNPCToCoords

;~ Description: standard pickup function, only modified to increment a custom counter when taking stuff with a particular ModelID
Func CustomPickUpLoot()
	Local $lAgent
	Local $lItem
	Local $lDeadlock
	For $i = 1 To GetMaxAgents()
		If CountSlots() < 1 Then Return ;full inventory dont try to pick up
		If GetIsDead(-2) Then Return
		$lAgent = GetAgentByID($i)
		If DllStructGetData($lAgent, 'Type') <> 0x400 Then ContinueLoop
		$lItem = GetItemByAgentID($i)
		If CustomCanPickup($lItem) Then
			PickUpItem($lItem)
			$lDeadlock = TimerInit()
			While GetAgentExists($i)
				Sleep(Random(50,100))
				If GetIsDead(-2) Then Return
				If TimerDiff($lDeadlock) > 10000 Then ExitLoop
			WEnd
		EndIf
	Next
EndFunc   ;==>PickUpLoot

; Checks if should pick up the given item. Returns True or False
Func CustomCanPickUp($aItem)
	Local $lModelID = DllStructGetData(($aItem), 'ModelId')
	Local $aExtraID = DllStructGetData($aItem, 'ExtraId')
	Local $lRarity = GetRarity($aItem)
	Local $Requirement = GetItemReq($aItem)
	If ($lModelID == 2511) Then
		If (GetGoldCharacter() < 99000) Then
			Return True	; gold coins (only pick if character has less than 99k in inventory)
		Else
			Return False
		EndIf
	ElseIf ($lModelID == $ITEM_ID_Dyes) Then	; if dye
		If (($aExtraID == $ITEM_ExtraID_BlackDye) Or ($aExtraID == $ITEM_ExtraID_WhiteDye)) Then ; only pick white and black ones
			Return True
		EndIf
	ElseIf ($lRarity == $RARITY_Gold) Then ; gold items
		Return True

	ElseIf($lModelID == $ITEM_ID_Lockpicks) Then
		Return True ; Lockpicks
	; ElseIf($lModelID == $ITEM_ID_Glacial_Stones) Then
		; Return True ; glacial stones
	ElseIf CheckArrayPscon($lModelID) Then ; ==== Pcons ==== or all event items
		Return True
	; ElseIf CheckArrayMapPieces($lModelID) Then ; ==== Map Pieces ====
		; Return $PickUpMapPieces
	ElseIf ($lRarity == $RARITY_White) And $PickUpAll Then ; White items
		Return False
	Else
		Return False
	EndIf
EndFunc   ;==>CustomCanPickUp

Func CheckGold()
	Local $GCHARACTER = GetGoldCharacter()
	Local $GSTORAGE = GetGoldStorage()
	Local $GDIFFERENCE = ($GSTORAGE - $GCHARACTER)
	If $GCHARACTER <= 1000 Then
		Switch $GSTORAGE
			Case 100000 To 1000000
				WithdrawGold(100000 - $GCHARACTER)
				Sleep(500 + 3 * GetPing())
			Case 1 To 99999
				WithdrawGold($GDIFFERENCE)
				Sleep(500 + 3 * GetPing())
			Case 0
				Out("Out of cash, beginning farm")
				Return False
		EndSwitch
	EndIf
	Return True
EndFunc   ;==>CHECKGOLD

#Region Inventory
#CS

#CE
Func Inventory($aBags = 4)
	Out("travel map ")
	ZoneMap(642)
	WaitMapLoading()
	GoNearestNPCToCoords(-2748.00, 1019.00)
	
	Out("Salvage")
	
	Sleep(GetPing() + 600)
	
	If GUICtrlRead($SalvageWeapons) == $GUI_CHECKED Then
		IdBackpack()
	EndIf
	
	SalvageBackpack()

	Sleep(GetPing()+1000)
	If GetGoldCharacter() > 80000 Then
		out("Yes Master +80K")
		DepositGold(80000)
	EndIf

	ZoneMap(640)
	WaitMapLoading(1000)
	RunThereRatasum()
    $BotRunning = True
    $BotInitialized = True
EndFunc


;======================>NewSalvageKitFunc<=================
Func CountFreeSlots($NumOfBags)
	Local $Slots
	For $Bag = 1 To $NumOfBags
		$Slots += DllStructGetData(GetBag($Bag), 'Slots')
		$Slots -= DllStructGetData(GetBag($Bag), 'ItemsCount')
	Next
	Return $Slots
 EndFunc   ;==>CountFreeSlots

Func IdBackPack()
	For $Bag = 1 to $UseBags
		For $Slot = 1  to DllStructGetData(GetBag($Bag), 'Slots')
			Local $sItem = GetItemBySlot($Bag, $Slot);
			If FindId() == 0 Then
				BuyId()
				Sleep(GetPing() + 600)
			EndIf
			Local $sItemID = DllStructGetData($sItem, 'ID')
			Local $kit = FindId()
			Local $rarity = GetRarity($sItem)
			If $rarity <> $rarity_blue And $rarity <> $rarity_purple And $rarity <> $rarity_gold Then ContinueLoop
			Identify($sItemID, $kit)
			Sleep(GetPing() + 600)
		Next
	Next
EndFunc

Func BuyId()
	If CountFreeSlots($UseBags) > 0 Then
		If GetGoldCharacter() > 500 Then
			BuyItem(6, 1, 500)
		Else
			If GetGoldCharacter() + GetGoldStorage() > 500 Then
				WithdrawGold(500 - GetGoldCharacter())
			Else 
				Out("Out of Gold")
				$BotRunning = False;
			EndIf
		EndIf
	Else
		Out("Inventory full")
		$BotRunning = false
	EndIf	
EndFunc

Func FindId()
	If GetMapLoading() == $INSTANCETYPE_LOADING Then Disconnected()
	Local $Item
	Local $Kit = 0
	For $Bag = 1 To $UseBags
		For $Slot = 1 To DllStructGetData(GetBag($Bag), 'Slots')
			$Item = GetItemBySlot($Bag, $Slot)
			Switch DllStructGetData($Item, 'ModelID')
				Case 5899
					$Kit = DllStructGetData($Item, 'ID')
					ExitLoop 2
				Case Else
					ContinueLoop
			EndSwitch
		Next
	Next
	Return $Kit
EndFunc   ;==>FindSalvageKit

Func SalvageBackpack()
	Local $UseBags = 4
	For $Bag = 1 to $UseBags
		For $Slot = 1  to DllStructGetData(GetBag($Bag), 'Slots')
			Local $sItem = GetItemBySlot($Bag, $Slot);
			While CanSalvage($sItem) And $BotRunning
				If FindSalvage() == 0 Then
					BuySalvage()
					Sleep(GetPing() + 600)
				EndIf
				Local $sItemID = DllStructGetData($sItem, 'ID')
				Local $kit = FindSalvage()
				Local $rarity = GetRarity($sItem)
				If CountFreeSlots($UseBags) > 0 Then
					Salvage($sItemID, $kit)
				Else
					Out("Inventory full")
					$BotRunning = false
				EndIf
				Sleep(GetPing() + 600)
				If $rarity <> $rarity_white And $rarity <> $rarity_blue Then
					ControlSend(GetWindowHandle(), "", "", "{Enter}")
					Sleep(GetPing() + 600)
				EndIf
				$sItem = GetItemBySlot($Bag, $Slot)
			WEnd
		Next
	Next
EndFunc

Func BuySalvage()
	If CountFreeSlots($UseBags) > 0 Then
		If GetGoldCharacter() > 100 Then
			BuyItem(3, 1, 100)  ; BuyItem(3, 1, 100) bei gtob
		Else
			If GetGoldCharacter() + GetGoldStorage() > 100 Then
				WithdrawGold(100 - GetGoldCharacter())
			Else 
				Out("Out of Gold")
				$BotRunning = False;
			EndIf
		EndIf
	Else
		Out("Inventory full")
		$BotRunning = false
	EndIf
EndFunc
	

Func FindSalvage()
	If GetMapLoading() == $INSTANCETYPE_LOADING Then Disconnected()
	Local $Item
	Local $Kit = 0
	For $Bag = 1 To $UseBags
		For $Slot = 1 To DllStructGetData(GetBag($Bag), 'Slots')
			$Item = GetItemBySlot($Bag, $Slot)
			Switch DllStructGetData($Item, 'ModelID')
				Case 2992
					$Kit = DllStructGetData($Item, 'ID')
					ExitLoop 2
				Case Else
					ContinueLoop
			EndSwitch
		Next
	Next
	Return $Kit
EndFunc   ;==>FindSalvageKit

Func CanSalvage($sItem)
	;27047 
	If GUICtrlRead($SalvageWeapons) == $GUI_CHECKED Then 
		Local $lType = DllStructGetData($sItem, 'Type')
		If WantToSalvageWeapons($lType) Then
			return True
		EndIf
	EndIf
	If GUICtrlRead($SalvageTrophies) == $GUI_CHECKED Then
		If DllStructGetData($sItem, 'Type') == 30 And GetRarity($sItem) == 2621 Then
			return True
		EndIf
	EndIf
	Local $ItemID = DllStructGetData($sItem, 'ModelID')
	If  _ArraySearch($salvItems, $ItemID) <> - 1 Then
		Return True
	EndIf
	
	Return False
EndFunc

Func Salvage($sItemID, $sKit)
	Local $lOffset[4] = [0, 0x18, 0x2C, 0x690]
	Local $lSalvageSessionID = MemoryReadPtr($mBasePointer, $lOffset)

	DllStructSetData($mSalvage, 2, $sItemID)
	DllStructSetData($mSalvage, 3, $sKit)
	DllStructSetData($mSalvage, 4, $lSalvageSessionID[1])

	Enqueue($mSalvagePtr, 16)
EndFunc 
	
Func Identify($aItemID, $kitID)
	If GetIsIDed($aItemID) Then Return

	SendPacket(0xC, $HEADER_ITEM_ID, $kitID, $aItemID)

	Local $lDeadlock = TimerInit()
	Do
		Sleep(20)
	Until GetIsIDed($aItemID) Or TimerDiff($lDeadlock) > 5000
	If Not GetIsIDed($aItemID) Then Identify($aItemID, $kitID)
EndFunc

;======================>EndOfNewSalvageKitFunc<=================


Func Sell($BAGINDEX)
	Local $AITEM
	Local $BAG = GETBAG($BAGINDEX)
	Local $NUMOFSLOTS = DllStructGetData($BAG, "slots")
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "Id") == 0 Then ContinueLoop
		If CANSELL($AITEM) Then
			Out("Selling item: " & $BAGINDEX & ", " & $I)
			SELLITEM($AITEM)
		EndIf
		Sleep(GetPing()+250)
	Next
EndFunc

Func CanSell($aItem)
	Local $LMODELID = DllStructGetData($aitem, "ModelId")
	Local $LRARITY = GetRarity($aitem)
	Local $Requirement = GetItemReq($aItem)
	If $LRARITY == $RARITY_Gold Then
		Return True
	EndIf
	If $LRARITY == $RARITY_Purple Then
		Return True
	EndIf
;~ Leaving Blues and Whites as false for now. Going to make it salvage them at some point in the future. It does not currently pick up whites or blues
	If $LRARITY == $RARITY_Blue Then
		Return True
	EndIf
	If $LMODELID == $ITEM_ID_Dyes Then
		Switch DllStructGetData($aitem, "ExtraId")
			Case $ITEM_ExtraID_BlackDye, $ITEM_ExtraID_WhiteDye
				Return False
			Case Else
				Return True
		EndSwitch
	EndIf
	If CheckArrayTomes($lModelID)					Then Return False
	If CheckArrayMaterials($lModelID)				Then Return False
	If CheckArrayScrolls($lModelID)					Then Return False
	; All weapon mods
	If CheckArrayWeaponMods($lModelID)				Then Return False
	; ==== General ====
	If CheckArrayGeneralItems($lModelID)			Then Return False ; Lockpicks, Kits
	If $lModelID == $ITEM_ID_Glacial_Stones 		Then Return False
	If CheckArrayPscon($lModelID)					Then Return False
	; ==== Stupid Drops =
	If CheckArrayMapPieces($lModelID)				Then Return False
	;DONT SELL CANDY CANE SHARDS!!!
	If $lModelID == 556 							Then Return False
	If $LRARITY == $RARITY_White 					Then Return True
	Return True
EndFunc   ;==>CanSell

#Region Arrays
Func CheckArrayPscon($lModelID)
	For $p = 0 To (UBound($Array_pscon) -1)
		If ($lModelID == $Array_pscon[$p]) Then Return True
	Next
EndFunc

Func CheckArrayGeneralItems($lModelID)
	For $p = 0 To (UBound($General_Items_Array) -1)
		If ($lModelID == $General_Items_Array[$p]) Then Return True
	Next
EndFunc

Func CheckArrayWeaponMods($lModelID)
	For $p = 0 To (UBound($Weapon_Mod_Array) -1)
		If ($lModelID == $Weapon_Mod_Array[$p]) Then Return True
	Next
EndFunc

Func CheckArrayTomes($lModelID)
	For $p = 0 To (UBound($All_Tomes_Array) -1)
		If ($lModelID == $All_Tomes_Array[$p]) Then Return True
	Next
EndFunc

Func CheckArrayMaterials($lModelID)
	For $p = 0 To (UBound($All_Materials_Array) -1)
		If ($lModelID == $All_Materials_Array[$p]) Then Return True
	Next
EndFunc

Func CheckArrayScrolls($lModelID)
	For $p = 0 To (UBound($All_Scrolls_Array) -1)
		If ($lModelID == $All_Scrolls_Array[$p]) Then Return True
	Next
EndFunc

Func CheckArrayMapPieces($lModelID)
	For $p = 0 To (UBound($Map_Piece_Array) -1)
		If ($lModelID == $Map_Piece_Array[$p]) Then Return True
	Next
EndFunc
#EndRegion Arrays


#CS
	If GetHoneyCombCount() > 49 Then

#CE

#Region Display/Counting Things
#CS
Each section can be commented out entirely or each individual line. Basically put here for reference and use.

I put the Display > 0 so that it won't list everything. Better for each event I think.

CountSlots and CountSlotsChest are used by the Storage and the bot to know how much it can put in there
and when to start an inventory cycle.

GetxxxxxxCount() are to count what is in your Inventory at that time. Say if you want to track each of these items
either by the Message display or a section of your GUI.

Does Not track how many you put in the storage chest!!!
#CE
Func DisplayCounts()
;	Standard Vaettir Drops excluding Map Pieces
   Local $CurrentGold = GetGoldCharacter()
;   Local $GlacialStones = GetItemCountInventory(27047)
;   Local $MesmerTomes = GetItemCountInventory(21797)
   Local $Lockpicks = GetItemCountInventory(22751)
   Local $BlackDye = GetItemCountInventory(146, 10)
   Local $WhiteDye = GetItemCountInventory(146, 12)
   Local $EmptyBag = CountSlots()
;   Event Items
   Local $AgedDwarvenAle = GetItemCountInventory(24593)
   Local $AgedHuntersAle = GetItemCountInventory(31145)
   Local $BattleIslandIcedTea = GetItemCountInventory(36682)
   Local $BirthdayCupcake = GetItemCountInventory(22269)
   Local $CandyCaneShards = GetItemCountInventory(556)
   Local $GoldenEgg = GetItemCountInventory(22752)
   Local $Grog = GetItemCountInventory(30855)
   Local $HoneyCombs = GetItemCountInventory(26784)
   Local $KrytanBrandy = GetItemCountInventory(35124)
   Local $PartyBeacon = GetItemCountInventory(36683)
   Local $PumpkinPies = GetItemCountInventory(28436)
   Local $SpikedEggnog = GetItemCountInventory(6366)
   Local $TrickOrTreats = GetItemCountInventory(28434)
   Local $VictoryToken = GetItemCountInventory(18345)
   Local $WayfarerMark = GetItemCountInventory(37765)
;   RareMaterials
   ; Local $EctoCount = GetItemCountInventory(930)
   ; Local $ObShardCount = GetItemCountInventory(945)
   ; Local $FurCount = GetItemCountInventory(941)
   ; Local $LinenCount = GetItemCountInventory(926)
   ; Local $DamaskCount = GetItemCountInventory(927)
   ; Local $SilkCount = GetItemCountInventory(928)
   ; Local $SteelCount = GetItemCountInventory(949)
   ; Local $DSteelCount = GetItemCountInventory(950)
   ; Local $MonClawCount = GetItemCountInventory(923)
   ; Local $MonEyeCount = GetItemCountInventory(931)
   ; Local $MonFangCount = GetItemCountInventory(932)
   ; Local $RubyCount = GetItemCountInventory(937)
   ; Local $SapphireCount = GetItemCountInventory(938)
   ; Local $DiamondCount = GetItemCountInventory(935)
   ; Local $OnyxCount = GetItemCountInventory(936)
   ; Local $CharcoalCount = GetItemCountInventory(922)
   ; Local $GlassVialCount = GetItemCountInventory(939)
   ; Local $LeatherCount = GetItemCountInventory(942)
   ; Local $ElonLeatherCount = GetItemCountInventory(943)
   ; Local $VialInkCount = GetItemCountInventory(944)
   ; Local $ParchmentCount = GetItemCountInventory(951)
   ; Local $VellumCount = GetItemCountInventory(952)
   ; Local $SpiritwoodCount = GetItemCountInventory(956)
   ; Local $AmberCount = GetItemCountInventory(6532)
   ; Local $JadeCount = GetItemCountInventory(6533)
   Local $YuletideTonic = GetItemCountInventory(21490)
   Local $AppleCider = GetItemCountInventory(28435) ;Hard Apple Cider

;regular materials
	Local $Bones = GetItemCountInventory(921);Bones
	Local $Cloth = GetItemCountInventory(925);Cloth
	Local $Dust = GetItemCountInventory(929);Dust
	Local $Feather = GetItemCountInventory(933);=Feather
	Local $PlantFibers = GetItemCountInventory(934);=Plant Fibers
	Local $TannedHide= GetItemCountInventory(940);=Tanned Hide
	Local $WoodPlank = GetItemCountInventory(946);= Wood Plank
	Local $IronIngot = GetItemCountInventory(948);=Iron Ingot
	Local $Scale = GetItemCountInventory(953);=Scale
	Local $Chitin = GetItemCountInventory(954);=Chitin
	Local $GraniteSlab = GetItemCountInventory(955);=Granite Slab

;   Standard Vaettir Drops excluding Map Pieces
   ;If $CurrentGold > 0 Then
   Out("Current Gold:" & $CurrentGold)
;   If $GlacialStones > 0 Then Out("Glacial Count:" & $GlacialStones)
;   If $MesmerTomes > 0 Then Out("Mesmer Tomes:" & $MesmerTomes)
   If $Lockpicks > 0 Then Out ("Lockpicks:" & $Lockpicks)
;dyes
   If $BlackDye > 0 Then Out ("Black Dyes:" & $BlackDye)
   If $WhiteDye > 0 Then Out ("White Dyes:" & $WhiteDye)
;   Rare Materials
   ; If $FurCount > 0 Then Out ("Fur Squares:" & $FurCount)
   ; If $LinenCount > 0 Then Out ("Linen:" & $LinenCount)
   ; If $DamaskCount > 0 Then Out ("Damask:" & $DamaskCount)
   ; If $SilkCount > 0 Then Out ("Silk:" & $SilkCount)
   ; If $EctoCount > 0 Then Out("Ecto Count:" & $EctoCount)
   ; If $SteelCount > 0 Then Out ("Steel:" & $SteelCount)
   ; If $DSteelCount > 0 Then Out ("Deldrimor Steel:" & $DSteelCount)
   ; If $MonClawCount > 0 Then Out ("Monstrous Claw:" & $MonClawCount)
   ; If $MonEyeCount > 0 Then Out ("Monstrous Eye:" & $MonEyeCount)
   ; If $MonFangCount > 0 Then Out ("Monstrous Fang:" & $MonFangCount)
   ; If $RubyCount > 0 Then Out ("Ruby:" & $RubyCount)
   ; If $SapphireCount > 0 Then Out ("Sapphire:" & $SapphireCount)
   ; If $DiamondCount > 0 Then Out ("Diamond:" & $DiamondCount)
   ; If $OnyxCount > 0 Then Out ("Onyx:" & $OnyxCount)
   ; If $CharcoalCount > 0 Then Out ("Charcoal:" & $CharcoalCount)
   ; If $ObShardCount > 0 Then Out("Obby Count:" & $ObShardCount)
   ; If $GlassVialCount > 0 Then Out ("Glass Vial:" & $GlassVialCount)
   ; If $LeatherCount > 0 Then Out ("Leather Square:" & $LeatherCount)
   ; If $ElonLeatherCount > 0 Then Out ("Elonian Leather:" & $ElonLeatherCount)
   ; If $VialInkCount > 0 Then Out ("Vials of Ink:" & $VialInkCount)
   ; If $ParchmentCount > 0 Then Out ("Parchment:" & $ParchmentCount)
   ; If $VellumCount > 0 Then Out ("Vellum:" & $VellumCount)
   ; If $SpiritwoodCount > 0 Then Out ("Spiritwood Planks:" & $SpiritwoodCount)
   ; If $AmberCount > 0 Then Out ("Amber:" & $AmberCount)
   ; If $JadeCount > 0 Then Out ("Jade:" & $JadeCount)

;   Event Items
   If $AgedDwarvenAle > 0 Then Out("Aged Dwarven Ale:" & $AgedDwarvenAle)
   If $AgedHuntersAle > 0 Then Out("Aged Hunter's Ale:" & $AgedHuntersAle)
   If $BattleIslandIcedTea > 0 Then Out("Iced Tea:" & $BattleIslandIcedTea)
   If $BirthdayCupcake > 0 Then Out("Cupcakes:" & $BirthdayCupcake)
   If $CandyCaneShards > 0 Then Out("CC Shards:" & $CandyCaneShards)
   If $GoldenEgg > 0 Then Out("Golden Eggs:" & $GoldenEgg)
   If $Grog > 0 Then Out("Grog Arrr:" & $Grog)
   If $HoneyCombs > 0 Then Out("Honeycombs:" & $HoneyCombs)
   If $KrytanBrandy > 0 Then Out("Krytan Brandy:" & $KrytanBrandy)
   If $PartyBeacon > 0 Then Out("Jesus Beams:" & $PartyBeacon)
   If $PumpkinPies > 0 Then Out("Pumpkin Pies:" & $PumpkinPies)
   If $SpikedEggnog > 0 Then Out("Spiked Eggnog:" & $SpikedEggnog)
   If $TrickOrTreats > 0 Then Out("ToTs:" & $TrickOrTreats)
   If $VictoryToken > 0 Then Out("Victory Tokens:" & $VictoryToken)
   If $WayfarerMark > 0 Then Out("Wayfarer Marks:" & $WayfarerMark)
   If $YuletideTonic > 0 Then Out("Yuletide Tonics:" & $YuletideTonic)
   If $AppleCider > 0 Then Out("Hard Apple Ciders:" & $AppleCider)

   ;regular materials

	If $Bones > 0 Then Out("Bones:" & $Bones);Bones
	If $Cloth > 0 Then Out("Cloth:" & $Cloth);Cloth
	If $Dust > 0 Then Out("Dust:" & $Dust);Dust
	If $Feather> 0 Then Out("Feathers:" & $Feather);=Feather
	If $PlantFibers> 0 Then Out("Plant Fibers:" & $PlantFibers);=Plant Fibers
	If $TannedHide > 0 Then Out("Tanned Hides:" & $TannedHide);=Tanned Hide
	If $WoodPlank > 0 Then Out("Wood Planks:" & $WoodPlank);= Wood Plank
	If $IronIngot> 0 Then Out("Iron Ingots:" & $IronIngot);=Iron Ingot
	If $Scale > 0 Then Out("Scales:" & $Scale);=Scale
	If $Chitin> 0 Then Out("Chitins:" & $Chitin);=Chitin
	If $GraniteSlab > 0 Then Out("Granite Slabs:" & $GraniteSlab);=Granite Slab
	Out("Empty Inventory:" & $EmptyBag)
EndFunc

Func GetItemCountInventory( $aModelID, $aExtraID = 0)
	Local $aAMOUNT
	Local $aBag
	Local $aItem
	Local $i
	For $i = 1 To 4
		$aBag = GetBag($i)
		For $j = 1 To DllStructGetData($aBag, "Slots")
			$aItem = GetItemBySlot($aBag, $j)
			If DllStructGetData($aItem, "ModelID") == $aModelID Then
				If $aExtraID <> 0 Then
					If $aExtraID = DllStructGetData($aItem, "ExtraID") Then $aAMOUNT += DllStructGetData($aItem, "Quantity")
				Else
					$aAMOUNT += DllStructGetData($aItem, "Quantity")
				EndIf
			Else
				ContinueLoop
			EndIf
		Next
	Next
	Return $aAMOUNT
EndFunc

Func CountSlots()
	Local $bag
	Local $temp = 0
	$bag = GetBag(1)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(2)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(3)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(4)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	Return $temp
EndFunc ; Counts open slots in your Imventory

Func CountSlotsChest()
	Local $bag
	Local $temp = 0
	$bag = GetBag(8)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(9)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(10)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(11)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(12)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(13)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(14)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(15)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(16)
	$temp += DllStructGetData($bag, 'Slots') - DllStructGetData($bag, 'ItemsCount')
	Return $temp
EndFunc ; Counts open slots in the storage chest
#EndRegion Counting Things

#Region Storing Stuff
; Big function that calls the smaller functions below
Func StoreItems()
	StackableDrops(1, 20)
	StackableDrops(2, 5)
	StackableDrops(3, 10)
	StackableDrops(4, 10)
	Alcohol(1, 20)
	Alcohol(2, 5)
	Alcohol(3, 10)
	Alcohol(4, 10)
	Party(1, 20)
	Party(2, 5)
	Party(3, 10)
	Party(4, 10)
	Sweets(1, 20)
	Sweets(2, 5)
	Sweets(3, 10)
	Sweets(4, 10)
	Scrolls(1, 20)
	Scrolls(2, 5)
	Scrolls(3, 10)
	Scrolls(4, 10)
	EliteTomes(1, 20)
	EliteTomes(2, 5)
	EliteTomes(3, 10)
	EliteTomes(4, 10)
	Tomes(1, 20)
	Tomes(2, 5)
	Tomes(3, 10)
	Tomes(4, 10)
	DPRemoval(1, 20)
	DPRemoval(2, 5)
	DPRemoval(3, 10)
	DPRemoval(4, 10)
	SpecialDrops(1, 20)
	SpecialDrops(2, 5)
	SpecialDrops(3, 10)
	SpecialDrops(4, 10)
EndFunc ;~ Includes event items broken down by type

Func StoreMaterials()
	Materials(1, 20)
	Materials(2, 5)
	Materials(3, 10)
	Materials(4, 10)
EndFunc ;~ Common and Rare Materials

Func StoreUNIDGolds()
	UNIDGolds(1, 20)
	UNIDGolds(2, 5)
	UNIDGolds(3, 10)
	UNIDGolds(4, 10)
EndFunc ;~ UNID Golds

Func StoreMods()
	Mods(1, 20)
	Mods(2, 5)
	Mods(3, 10)
	Mods(4, 10)
EndFunc ;~ Mods I want to keep

Func StoreWeapons()
	Weapons(1, 20)
	Weapons(2, 5)
	Weapons(3, 10)
	Weapons(4, 10)
EndFunc

Func Weapons($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		Local $aitem = GetItemBySlot($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		Local $ModStruct = GetModStruct($aitem)
		Local $Energy = StringInStr($ModStruct, "0500D822", 0, 1) ;~String for +5e mod
		Switch DllStructGetData($aitem, "Type")
			Case 2, 5, 15, 27, 32, 35, 36
				If $Energy > 0 Then
					Do
						For $BAG = 8 To 12
							$SLOT = FindEmptySlot($BAG)
							$SLOT = @extended
							If $SLOT <> 0 Then
								$FULL = False
								$NSLOT = $SLOT
								ExitLoop 2
							Else
								$FULL = True
							EndIf
							Sleep(400)
						Next
					Until $FULL = True
					If $FULL = False Then
						MOVEITEM($AITEM, $BAG, $NSLOT)
						Sleep(Random(450, 550))
					EndIf
				EndIf
		EndSwitch
	Next
EndFunc

Func StackableDrops($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $Q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		$M = DllStructGetData($AITEM, "ModelID")
		$Q = DllStructGetData($AITEM, "quantity")
		If ($M = 460 Or $M = 474 Or $M = 476 Or $M = 486 Or $M = 522 Or $M = 525 Or $M = 811 Or $M = 819 Or $M = 822 Or $M = 835 Or $M = 1610 Or $M = 2994 Or $M = 19185 Or $M = 22751 Or $M = 24629 Or $M = 24630 Or $M = 24631 Or $M = 24632 Or $M = 27033 Or $M = 27035 Or $M = 27044 Or $M = 27046 Or $M = 27047 Or $M = 27052 Or $M = 35123 Or $M = 37765 Or $M = 27035) And $Q = 250 Then ;last one is saurian bones
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc ;~ like Suarian Bones, lockpicks, Glacial Stones, etc

Func EliteTomes($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $Q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		$M = DllStructGetData($AITEM, "ModelID")
		$Q = DllStructGetData($AITEM, "quantity")
		If ($M = 21796 Or $M = 21797 Or $M = 21798 Or $M = 21799 Or $M = 21800 Or $M = 21801 Or $M = 21802 Or $M = 21803 Or $M = 21804 Or $M = 21805) And $Q = 250 Then
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc ;~ non-Elite tomes only

Func Tomes($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $Q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		$M = DllStructGetData($AITEM, "ModelID")
		$Q = DllStructGetData($AITEM, "quantity")
		If ($M = 21796 Or $M = 21797 Or $M = 21798 Or $M = 21799 Or $M = 21800 Or $M = 21801 Or $M = 21802 Or $M = 21803 Or $M = 21804 Or $M = 21805) And $Q = 250 Then
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc ;~ non-Elite tomes only

Func Alcohol($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $Q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		$M = DllStructGetData($AITEM, "ModelID")
		$Q = DllStructGetData($AITEM, "quantity")
		If ($M = 910 Or $M = 2513 Or $M = 5585 Or $M = 6049 Or $M = 6366 Or $M = 6367 Or $M = 6375 Or $M = 15477 Or $M = 19171 Or $M = 22190 Or $M = 24593 Or $M = 28435 Or $M = 30855 Or $M = 31145 Or $M = 31146 Or $M = 35124 Or $M = 36682) And $Q = 250 Then
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc

Func Party($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $Q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		$M = DllStructGetData($AITEM, "ModelID")
		$Q = DllStructGetData($AITEM, "quantity")
		If ($M = 6376 Or $M = 6368 Or $M = 6369 Or $M = 21809 Or $M = 21810 Or $M = 21813 Or $M = 29436 Or $M = 29543 Or $M = 36683 Or $M = 4730 Or $M = 15837 Or $M = 21490 Or $M = 22192 Or $M = 30626 Or $M = 30630 Or $M = 30638 Or $M = 30642 Or $M = 30646 Or $M = 30648 Or $M = 31020 Or $M = 31141 Or $M = 31142 Or $M = 31144 Or $M = 31172) And $Q = 250 Then
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc

Func Sweets($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $Q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		$M = DllStructGetData($AITEM, "ModelID")
		$Q = DllStructGetData($AITEM, "quantity")
		If ($M = 15528 Or $M = 15479 Or $M = 19170 Or $M = 21492 Or $M = 21812 Or $M = 22269 Or $M = 22644 Or $M = 22752 Or $M = 28431 Or $M = 28432 Or $M = 28436 Or $M = 31150 Or $M = 35125 Or $M = 36681) And $Q = 250 Then
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc

Func Scrolls($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $Q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		$M = DllStructGetData($AITEM, "ModelID")
		$Q = DllStructGetData($AITEM, "quantity")
		If ($M = 3746 Or $M = 765 Or $M = 767 Or $M = 768 Or $M = 1887 Or $M = 857 Or $M = 894 Or $M = 895 Or $M = 22280) And $Q = 250 Then
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc

Func DPRemoval($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $Q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		$M = DllStructGetData($AITEM, "ModelID")
		$Q = DllStructGetData($AITEM, "quantity")
		If ($M = 6370 Or $M = 21488 Or $M = 21489 Or $M = 22191 Or $M = 35127 Or $M = 26784 Or $M = 28433) And $Q = 250 Then
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc

Func SpecialDrops($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $Q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		$M = DllStructGetData($AITEM, "ModelID")
		$Q = DllStructGetData($AITEM, "quantity")
		If ($M = 18345 Or $M = 21491 Or $M = 21833 Or $M = 28434 Or $M = 35121) And $Q = 250 Then
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc

Func Materials($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $Q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "Id") = 0 Then ContinueLoop
		$M = DllStructGetData($AITEM, "ModelId")
		$Q = DllStructGetData($AITEM, "Quantity")
		If ($M = 921 Or $M = 922 Or $M = 923 Or $M = 925 Or $M = 926 Or $M = 927 Or $M = 928 Or $M = 929 Or $M = 930 Or $M = 931 Or $M = 932 Or $M = 933 Or $M = 934 Or $M = 935 Or $M = 936 Or $M = 937 Or $M = 938 Or $M = 939 Or $M = 940 Or $M = 941 Or $M = 942 Or $M = 943 Or $M = 944 Or $M = 945 Or $M = 946 Or $M = 948 Or $M = 949 Or $M = 950 Or $M = 951 Or $M = 952 Or $M = 953 Or $M = 954 Or $M = 955 Or $M = 956 Or $M = 6532 Or $M = 6533) And $Q = 250 Then
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc

; Keeps all Golds
Func UNIDGolds($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $R
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		$R = GetRarity($AITEM)
		$M = DllStructGetData($AITEM, "ModelID")
		If $R = 2624 Then
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc ;~ UNID golds

; Stores the mods that I am salvaging out to keep for Hero weapons
Func Mods($BAGINDEX, $NUMOFSLOTS)
	Local $AITEM
	Local $M
	Local $Q
	Local $bag
	Local $SLOT
	Local $FULL
	Local $NSLOT
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
		$M = DllStructGetData($AITEM, "ModelID")
		$Q = DllStructGetData($AITEM, "quantity")
		If ($M = 896 Or $M = 908 Or $M = 15554 Or $M = 15551 Or $M = 15552 Or $M = 894 Or $M = 906 Or $M = 897 Or $M = 909 Or $M = 893 Or $M = 905 Or $M = 6323 Or $M = 6331 Or $M = 895 Or $M = 907 Or $M = 15543 Or $M = 15553 Or $M = 15544 Or $M = 15555 Or $M = 15540 Or $M = 15541 Or $M = 15542 Or $M = 17059 Or $M = 19122 Or $M = 19123) Then
			Do
				For $BAG = 8 To 12
					$SLOT = FINDEMPTYSLOT($BAG)
					$SLOT = @extended
					If $SLOT <> 0 Then
						$FULL = False
						$NSLOT = $SLOT
						ExitLoop 2
					Else
						$FULL = True
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MOVEITEM($AITEM, $BAG, $NSLOT)
				Sleep(GetPing()+500)
			EndIf
		EndIf
	Next
EndFunc

; This searches for empty slots in your storage
Func FindEmptySlot($BAGINDEX)
	Local $LITEMINFO, $ASLOT
	For $ASLOT = 1 To DllStructGetData(GETBAG($BAGINDEX), "Slots")
		Sleep(40)
		$LITEMINFO = GETITEMBYSLOT($BAGINDEX, $ASLOT)
		If DllStructGetData($LITEMINFO, "ID") = 0 Then
			SetExtended($ASLOT)
			ExitLoop
		EndIf
	Next
	Return 0
EndFunc
#EndRegion Storing Stuff
#EndRegion Inventory

;~ Description: Toggle rendering and also hide or show the gw window

Func ToggleRendering()
	$RenderingEnabled = Not $RenderingEnabled
	If $RenderingEnabled Then
		EnableRendering()
		WinSetState(GetWindowHandle(), "", @SW_SHOW)
	Else
		DisableRendering()
		WinSetState(GetWindowHandle(), "", @SW_HIDE)
		ClearMemory()
	EndIf
EndFunc   ;==>ToggleRendering


;~ Description: Print to console with timestamp
Func Out($TEXT)
	Local $TEXTLEN = StringLen($TEXT)
	Local $CONSOLELEN = _GUICtrlEdit_GetTextLen($GLOGBOX)
	If $TEXTLEN + $CONSOLELEN > 30000 Then GUICtrlSetData($GLOGBOX, StringRight(_GUICtrlEdit_GetText($GLOGBOX), 30000 - $TEXTLEN - 1000))
	_GUICtrlEdit_AppendText($GLOGBOX, @CRLF & "[" & @HOUR & ":" & @MIN & ":" & @SEC & "] " & $TEXT)
	_GUICtrlEdit_Scroll($GLOGBOX, 1)
EndFunc   ;==>OUT

;~ Description: guess what?
Func _exit()
	Exit
EndFunc

#Region Pcons
Func UseEgg()
	If $useEgg Then
		pconsScanInventory()
		If (GetMapLoading() == 1) And (GetIsDead(-2) == False) Then
			If $pconsEgg_slot[0] > 0 And $pconsEgg_slot[1] > 0 Then
				If DllStructGetData(GetItemBySlot($pconsEgg_slot[0], $pconsEgg_slot[1]), "ModelID") == 22752 Then
					UseItemBySlot($pconsEgg_slot[0], $pconsEgg_slot[1])
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc
;~ This searches the bags for the specific pcon you wish to use.
Func pconsScanInventory()
	Local $bag
	Local $size
	Local $slot
	Local $item
	Local $ModelID
	$pconsEgg_slot[0] = $pconsEgg_slot[1] = 0
	For $bag = 1 To 4 Step 1
		If $bag == 1 Then $size = 20
		If $bag == 2 Then $size = 5
		If $bag == 3 Then $size = 10
		If $bag == 4 Then $size = 10
		For $slot = 1 To $size Step 1
			$item = GetItemBySlot($bag, $slot)
			$ModelID = DllStructGetData($item, "ModelID")
			Switch $ModelID
				Case 0
					ContinueLoop
				Case 22752
					$pconsEgg_slot[0] = $bag
					$pconsEgg_slot[1] = $slot
			EndSwitch
		Next
	Next
EndFunc   ;==>pconsScanInventory
;~ Uses the Item from UseEgg()
Func UseItemBySlot($aBag, $aSlot)
	Local $item = GetItemBySlot($aBag, $aSlot)
	SENDPACKET(8, $HEADER_ITEM_USE, DllStructGetData($item, "ID"))
EndFunc   ;==>UseItemBySlot

Func arrayContains($array, $item)
	For $i = 1 To $array[0]
		If $array[$i] == $item Then
			Return True
		EndIf
	Next
	Return False
EndFunc   ;==>arrayContains
#EndRegion Pcons

Func RndTravel($aMapID)
	Local $UseDistricts = 7 ; 7=eu, 8=eu+int, 11=all(incl. asia)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, int, asia-ko, asia-ch, asia-ja
	Local $Region[11] = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
	MoveMap($aMapID, $Region[$Random], 0, $Language[$Random])
	WaitMapLoading($aMapID, 30000)
	Sleep(GetPing()+3000)
EndFunc   ;==>RndTravel

Func GenericRandomPath($aPosX, $aPosY, $aRandom = 50, $STOPSMIN = 1, $STOPSMAX = 5, $NUMBEROFSTOPS = -1)
	If $NUMBEROFSTOPS = -1 Then $NUMBEROFSTOPS = Random($STOPSMIN, $STOPSMAX, 1)
	Local $lAgent = GetAgentByID(-2)
	Local $MYPOSX = DllStructGetData($lAgent, "X")
	Local $MYPOSY = DllStructGetData($lAgent, "Y")
	Local $DISTANCE = ComputeDistance($MYPOSX, $MYPOSY, $aPosX, $aPosY)
	If $NUMBEROFSTOPS = 0 Or $DISTANCE < 200 Then
		MoveTo($aPosX, $aPosY, $aRandom)
	Else
		Local $M = Random(0, 1)
		Local $N = $NUMBEROFSTOPS - $M
		Local $STEPX = (($M * $aPosX) + ($N * $MYPOSX)) / ($M + $N)
		Local $STEPY = (($M * $aPosY) + ($N * $MYPOSY)) / ($M + $N)
		MoveTo($STEPX, $STEPY, $aRandom)
		GenericRandomPath($aPosX, $aPosY, $aRandom, $STOPSMIN, $STOPSMAX, $NUMBEROFSTOPS - 1)
	EndIf
EndFunc   ;==>GENERICRANDOMPATH

