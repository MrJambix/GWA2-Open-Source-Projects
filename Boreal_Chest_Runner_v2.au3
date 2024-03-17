#RequireAdmin

#Region declarations
#include <ButtonConstants.au3>
#include "GWA2_Headers.au3"
#include "GWA2.au3"
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#EndRegion

Opt("GUIOnEventMode", True)
Opt("GUICloseOnESC", False)
;Opt("TrayIconHide", 1)

AutoItSetOption("TrayIconDebug", 1)


#cs
~Farms Chest from Boreal Station

Build:

1. Dwarven Stability
2. Dash
3. "I AM UNSTOPPABLE" (Optional, select in GUI)
4. None
5. None
6. None
7. None
8. None

Weapons & Equipment:
Any Armor
Any Staff w/ 20% Enchant

Upgrades by Zaishen/RiflemanX 3.19.19

~Updated v1.0
~Resized GUI
~Added Render
~Added PurgeHook
~Relocated Buttons
~Removed Time Stamp
~Added Drop-Down Login Box
~Added Lockpicks Remaining Counter
~Added Treasure Hunter display counter
~Removed unnecessary sleep times (10 seconds faster now)

Updated v1.
~Corrected merch functions
~Reduced load times (even faster now)
~Created Radio Buttons for Store/Merch Golds
~Reduced working inventory bags to first 3 bags
(Will only pickup, store, merch from first 3 bags)

Updated v1.2
~Corrected merch functions
~Removed unecessary functions
~Small edits for ID/Sell function
~Edited and upgraded Sell function
~Removed "Buy Lockpicks" checkbox from GUI
~Added "Bunny Boost!" Function. If selected, will use chocolate bunnies for 50% speed boost in outpost!
~(Choc. Bunnies do not need to be in your inventory as the function will use them from your Xunlai Storage Chest)

Updated  v1.3
~Updates by Malinkadink 3.3.19
~GUI: Changed version# to v1.3a
~$TimeCheck times have been adjusted
~Second cast of Dwarven Stability added to keep up Dash
~DllStructGetData($item, 'AgentID') = 1 <===Adjusted for testing

Updated  v1.3a
~Added sleep times before and after OpenChest()

If Not $WeAreDead then
	   Sleep(GetPing()+80)
	   OpenChest()
	   Sleep(GetPing()+80)
EndIf

4.4.19
Updated  v1.4
~Check Gold amount before merch
~Deposit/Withdraw gold to maintain balance of 50k - 60k: Deposit_Platinum()
~Adjusted CanSell function so it wont sell lockpicks, ecto, or shards by accident


Updated  v1.5 (8.2.19) ~Zaishen
~Updated GWA2 & Headers
~Updated Target Chest
~Added option to use "I AM UNSTOPABLE" Skill #3
~Changed UseSkill() function to improved UseSkillEx() function

Updated  2020 v1.6 (5.9.20) ~wearebor
~Updated GWA2 & Headers
~Added Lucky/Unlucky and Wisdom tracking
~Removed currently broken render

Updated  2020 v1.7 (5.9.20) ~Zaishen/RiflemanX
~Removed Purge Hook (Not needed if no render options)
~Added Random District Change after every merch session
~Added District Hopping Roll 1-5 (Rolls a dice 1 = change district 2-5 = no action)
~Removed unnecessary functions
~Minor GUI Adjustments for District Hop Checkbox

Updated  2020 v1.8 (5.13.20) ~Zaishen/RiflemanX
~Script edits to ensure return to starting district
~Script edits to ensure district hopping does not result in getting stuck near NPC Heroes
~Increased random roll for District Hop from 1-5 up to 1-7
~Removed District Hop after each merch session (Will only Dis Hop if checked)

To Do:
~Conduct further testing v1.8
~Add function to keep rare skins
~Add optional settings to keep Q9 Golds
~Add fucntion to ID and salvage "Forget Me Not" Insignias
~Research bug that sometimes does not pickup gold drops from last chest
~Research bug that causes crash on pause/restart after clicking on Xunlai Chest
~Add optional settings to keep spears, scythes or other weapons needed for heroes
~Add optional pro build to increase survival when picking up items (especially last chest)
~Adjust OpenChest settings so the chest is opened from max distance (This way no needed to run to chest if no golds to pickup
~To increase speed of the run, rewrite chest function and make it go: Move(xxx-xxx) ---> CheckChest/Open Chest ---> MoveTo(xxx-xxx) ---> PickupLoot
~Fix render
#ce

;Make sure running skills for 1st two skill slots! (1 = Dwarven Stability 2 = Dash)

#cs
Automated Chest Farming and Loot Pickup Script

Key Updates and Functionality Changes:

~ Functionality Enhancements:
  1. CanPickUp Functionality
     - Introduced 'CanPickUp' function to filter loot based on specific criteria (e.g., rarity).
  2. PickUpLoot Integration
     - Developed 'PickUpLoot' function for enhanced loot processing, leveraging 'CanPickUp'.
  3. DoChest Adjustments
     - Modified 'DoChest' function to streamline chest opening and integrate 'PickUpLoot' for efficient item collection.

~ Code Optimization:
  - Removed unnecessary skill usage and energy checks from the loot pickup process.
  - Focused 'DoChest' function on chest interactions and delegated item pickups to 'PickUpLoot'.

~ Documentation and Cleanup:
  - Added comprehensive comments to document changes and the purpose of script components.
  - Streamlined code for better readability and maintenance.

~ Key Features:
  - Automated detection and pickup of desirable loot.
  - Efficient chest opening with post-interaction delay adjustments.
  - Modular design for easy updates and customization of loot filtering criteria.

~ Future Considerations:
  - Expand 'CanPickUp' to include more item criteria (e.g., specific skins, item types).
  - Optimize movement and interaction timings for increased efficiency.
  - Include error handling and recovery mechanisms for unexpected game states.

Updated by MrJambix - March 17th 2024
#ce


#Region Sweets
Global $Sweet_Town_Array[10] = [15528, 15479, 19170, 21492, 21812, 22644, 30208, 31150, 35125, 36681]
Global Const $ITEM_ID_Creme_Brulee =         15528
Global Const $ITEM_ID_Red_Bean_Cake =        15479
Global Const $ITEM_ID_Mandragor_Root_Cake =  19170
Global Const $ITEM_ID_Fruitcake =            21492
Global Const $ITEM_ID_Sugary_Blue_Drink =    21812
Global Const $ITEM_ID_Chocolate_Bunny =      22644
Global Const $ITEM_ID_Jar_of_Honey = 		 31150
Global Const $ITEM_ID_Krytan_Lokum = 	 	 35125
Global Const $ITEM_ID_Delicious_Cake =	     36681
Global Const $ITEM_ID_MiniTreats_of_Purity = 30208
#EndRegion Sweets

#Region
Global $bag_slots[5] = [0, 20, 5, 10, 10]
Global $TotalSeconds = 0
Global $GoldsCount = 0
Global $Seconds = 0
Global $Minutes = 0
Global $Hours = 0
Global $MerchOpened = False
Global $g_nMyId = 0
Global $g_nStrafe = 0
Global $lastX
Global $lastY
Global $strafeGo = False
Global $leftright = 0
Global $MoveToB = True
Global $BackTrack = True
Global $tSwitchtarget
Global $tLastTarget, $tRun, $tBlock
Global $TreasureTitle = 0
Global $LuckyTitle = 0
Global $UnluckyTitle = 0
Global $WisdomTitle = 0
Global $HWND

Global $Array_Store_ModelIDs[77] = [910, 2513, 5585, 6366, 6375, 22190, 24593, 28435, 30855, 31145, 36682 _ ; Alcohol
		, 21492, 21812, 22269, 22644, 22752, 28436, 36681 _ ; FruitCake, Blue Drink, Cupcake, Bunnies, Eggs, Pie, Delicious Cake
		, 6376, 21809, 21810, 21813, 36683 _ ; Party Spam
		, 6370, 21488, 21489, 22191, 26784, 28433 _ ; DP Removals
		, 15837, 21490, 30648, 31020 _ ; Tonics
		, 556, 18345, 21491, 37765, 21833, 28433, 28434, 522 _ ; CC Shards, Victory Token, Wayfarer, Lunar Tokens, ToTs, Dark Remains
		, 921, 922, 923, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945, 946, 948, 949, 950, 951, 952, 953, 954, 955, 956, 6532, 6533] ; All Materials

Global Const $RARITY_GOLD = 2624
Global Const $RARITY_PURPLE = 2626
Global Const $RARITY_BLUE = 2623
Global Const $RARITY_WHITE = 2621
Global $shardcount = 0
Global $winlabel = 0
Global $wins  = 0
Global $fails = 0
Global $Runs  = 0
Global $RenderingEnabled = True
Global $BotRunning = False
Global $BotInitialized = False
Global $DeadOnTheRun = 0,$tpspirit = 0, $WeAreDead
Global $intrun = 0, $pick_are_here
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Global Const $skill_id_shroud = 1031
Global Const $skill_id_iau = 2356
Global Const $skill_id_wd = 450
Global Const $skill_id_mb = 2417
Global Const $ds = 3
Global Const $sf = 2
Global Const $shroud = 1
Global Const $hos = 5
Global Const $wd = 4
Global Const $iau = 6
Global Const $de = 7
Global Const $mb = 8
; Store skills energy cost
Global $skillCost[9]
Global $ATTRIB_Swordsmanship
Global $ATTRIB_Strength
Global $ATTRIB_Tactics
Global $ATTRIB_Command
Global $ATTRIB_Motivation
Global $aItem

$skillCost[$ds] = 5
$skillCost[$sf] = 5
$skillCost[$shroud] = 10
$skillCost[$wd] = 4
$skillCost[$hos] = 5
$skillCost[$iau] = 5
$skillCost[$de] = 5
$skillCost[$mb] = 10
#EndRegion Globals

#Region GUI
Global $GUI = GUICreate("Boreal v1.8", 220, 340)
$Input = GUICtrlCreateCombo("", 08, 10, 100 , 20)
GUICtrlSetData(-1, GetLoggedCharNames())

GUICtrlCreateLabel("Total Runs:",  08, 35, 120, 17)
GUICtrlCreateLabel("Kits Bought:", 08, 50, 120, 17)
Global $LBL_Runs = GUICtrlCreateLabel($Runs, 70, 35, 50, 17)
Global $IDKitBought  = GUICtrlCreateLabel("0", 70, 50, 50, 17)

GUICtrlCreateGroup("Lockicks",    120, 04, 85, 30, BITOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))
$LPicks = GUICtrlCreateLabel("0", 128, 17, 72, 15, $SS_Center)

$DistHop   = GUICtrlCreateCheckbox("District Hop",028, 070, 80, 17)
$Hardmode= GUICtrlCreateCheckbox("Hard Mode",     028, 085, 80, 17)

GuiCtrlCreateGroup("", 120, 85, 42, 30)
$Sell    = GUICtrlCreateRadio   ("Sell",          116, 051, 36, 17)
$Store   = GUICtrlCreateRadio   ("Store",         160, 051, 40, 17)

$Breaks   = GUICtrlCreateCheckbox("Take Breaks",   120, 070, 80, 17)
$Bunny    = GUICtrlCreateCheckbox("Bunny Boost!",  120, 085, 80, 17)
$Use_IAU  = GUICtrlCreateCheckbox("Use Skill 3 - IAU", 120, 100, 98, 17)

;GUICtrlCreateGroup("Run Time",            090, 30, 100, 20, BitOr(1, $BS_CENTER))
$Run_Time = GUICTRLCREATELABEL("0:00:00", 120, 33, 85, 20, BITOR($SS_CENTER, $SS_CENTERIMAGE))
GUICTRLSETFONT(-1, 9, 700, 0)

GUICtrlCreateGroup("Treasure Hunter", 26, 120, 170, 35, BitOr(1, $BS_CENTER))
GUICtrlSetFont (-1,9, 800); bold
GUICtrlCreateGroup("Lucky", 26, 160, 170, 35, BitOr(1, $BS_CENTER))
GUICtrlSetFont (-1,9, 800); bold
GUICtrlCreateGroup("Unlucky", 26, 200, 170, 35, BitOr(1, $BS_CENTER))
GUICtrlSetFont (-1,9, 800); bold
GUICtrlCreateGroup("Wisdom", 26, 240, 170, 35, BitOr(1, $BS_CENTER))
GUICtrlSetFont (-1,9, 800); bold

Global Const $TreasureTitle_Lbl = GUICtrlCreateLabel("Rank: " & $TreasureTitle, 46, 134, 130, 17, BitOr(1, $BS_CENTER))
Global Const $LuckyTitle_Lbl = GUICtrlCreateLabel("Rank: " & $LuckyTitle, 46, 174, 130, 17, BitOr(1, $BS_CENTER))
Global Const $UnluckyTitle_Lbl = GUICtrlCreateLabel("Rank: " & $UnluckyTitle, 46, 214, 130, 17, BitOr(1, $BS_CENTER))
Global Const $WisdomTitle_Lbl = GUICtrlCreateLabel("Rank: " & $WisdomTitle, 46, 254, 130, 17, BitOr(1, $BS_CENTER))

Global $STATUS = GUICtrlCreateLabel("Ready to Start", 30, 275, 160, 17, $SS_Center)
GUICtrlCreateGroup("", -99, -99, 1, 1)

$Start = GUICtrlCreateButton("Start", 30, 296, 160, 35, $SS_Center)
GUICtrlSetFont (-1,9, 800); bold
GUICtrlSetOnEvent(-1, "GuiButtonHandler")
GUISetOnEvent($GUI_EVENT_CLOSE, "_exit")
GUICtrlSetState($Sell,     $GUI_CHECKED)
;GUICtrlSetState($BuyPick,  $GUI_DISABLE)
GUISetState(@SW_SHOW)
#EndRegion GUI

FileDelete (@ScriptDir & "\log.log")

While 1
	If $Botrunning = true Then
		GUICtrlSetData($LPicks, GetPicksCount())
		Local $Treasure = GetTreasureTitle()
		Local $Lucky = GetLuckyTitle()
		Local $Unlucky = GetUnluckyTitle()
		Local $Wisdom = GetWisdomTitle()
		GUICtrlSetData($TreasureTitle_Lbl, GetTreasureTitle())
		GUICtrlSetData($LuckyTitle_Lbl, GetLuckyTitle())
		GUICtrlSetData($UnluckyTitle_Lbl, GetUnluckyTitle())
		GUICtrlSetData($WisdomTitle_Lbl, GetWisdomTitle())
		If $Runs = 0 Then
			AdlibRegister("TimeUpdater", 1000)
			$TimerTotal = TimerInit()
		EndIf
		If GetMapID() <> 675 Then
			Out("Travelling: Boreal Station")
			RndTravelEx(675)
			;ZoneMap(675, 0) ;Boreal Station
			;WaitForLoad()
			$intrun = 0
		EndIf

		;If Getchecked ($Purge) Then ;Need to repair render and reinstate purge function
		;PurgeHook()
		;EndIf

		GUICtrlSetData($LPicks, GetPicksCount())
        If CheckIfInventoryIsFull() Then
		   SellItemToMerchant()
		   MoveTo(7603, -27423)
	    EndIf

		$Runs = $Runs +1
		$intrun = $intrun + 1

	    If GetChecked ($DistHop) Then
			RollDistrictHop()
	    EndIf

		If GUICtrlRead($Breaks) = $GUI_CHECKED Then
			$RandomBreak = Random(1, 30, 1)
			If $RandomBreak = 10 Then
				Out("Break")
				Switch (Random(1, 3, 1))
					Case 1
						Sleep(Random(10000, 20000))
					Case 2
						Sleep(Random(20000, 30000))
					Case 3
						Sleep(Random(30000, 50000))
				EndSwitch
			ElseIf $RandomBreak = 20 Then
				Out("Big Break")
				Sleep(Random(45000, 60000))
				;If Getchecked ($Purge) Then
				;PurgeHook()
	 ;EndIf
			EndIf
		EndIf
		Out("Begin Run Number " & $Runs)
		GUICtrlSetData($Lbl_Runs, $Runs)
		If CheckIfInventoryIsFull() then
		   SellItemToMerchant()
		   MoveTo(7603, -27423)
	    EndIf

		$pick_are_here = False
		CheckIfInventoryPick(1, 20)
		CheckIfInventoryPick(2, 5)
		CheckIfInventoryPick(3, 10)
		CheckIfInventoryPick(4, 10)

		If GetChecked ($Bunny) Then ;======Bunny Boost!"===========
	    Use_Choc_Bunny()
	    EndIf
		GoOut()
		ChestRun()
		HandlePause()
	EndIf
	sleep(50)
WEnd

Func WriteLog($sLog)
	$file = fileOpen(@ScriptDir & "\log.log", 1)
	_FileWriteLog($file, $sLog)
	fileClose($file)
EndFunc

Func GuiButtonHandler()
	If $BotRunning Then
		GUICtrlSetData($Start, "Will Pause After Run")
		GUICtrlSetState($Start, $GUI_DISABLE)
		$BotRunning = False
	ElseIf $BotInitialized Then
		GUICtrlSetData($Start, "Pause")
		$BotRunning = True
	Else
		Out("Initializing")
		AdlibRegister("TimeUpdater", 1000)
		Local $CharName = GUICtrlRead($Input)
		If $CharName == "" Then
			If Initialize(ProcessExists("gw.exe")) = False Then
				MsgBox(0, "Error", "Guild Wars is not running.")
				Exit
			EndIf
		Else
			If Initialize($CharName) = False Then
				MsgBox(0, "Error", "Could not find a Guild Wars client with a character named '" & $CharName & "'")
				Exit
			EndIf
		EndIf
		;GUICtrlSetState($Checkbox2, $GUI_ENABLE)
		GUICtrlSetState($Input, $GUI_DISABLE)
		GUICtrlSetData($Start, "Pause")
		$BotRunning = True
		$BotInitialized = True
		setmaxmemory()
	EndIf
EndFunc   ;==>GuiButtonHandler

Func HandlePause()
   If Not $WeAreDead then WriteLog("HandlePause Begin")
   While Not $BotRunning
	  Sleep(100)
	  GUICtrlSetData($Start, "Resume")
	  GUICtrlSetState($Start, $GUI_ENABLE)
   WEnd
   GUICtrlSetData($Start, "Pause")
   If Not $WeAreDead then WriteLog("HandlePause End")
EndFunc

Func CheckIfInventoryPick($bagIndex, $numOfSlots)
	For $i = 1 To $numOfSlots
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, 'ID') <> 0 And DllStructGetData($aitem, 'ModelID') = 22751 Then
			$pick_are_here = True
		EndIf
	Next
EndFunc

Func GoOut()
	If Not $WeAreDead then WriteLog("GoOut Switch Mode")
	Out("Switch Mode")
	If GUICtrlRead($Hardmode) = $GUI_CHECKED Then
		SwitchMode(1)
	Else
		SwitchMode(0)
	 EndIf

	 Deposit_Platinum()

	If $intrun = 1 Then
		MoveTo(7603, -27423)
	EndIf

	If Not $WeAreDead then WriteLog("GoOut Going Out")
	Out("Going Out")
	Switch (Random(1, 8, 1))
		Case 1
			Move(4733.52, -27842.97)
		Case 2
			Move(4730.40, -27788.09)
		Case 3
			Move(4700.77, -27976.07)
		Case 4
			Move(4720.88, -27892.77)
		Case 5
			Move(4720.72, -27858.23)
		Case 6
			Move(4725.52, -27856.53)
		Case 7
			Move(4729.92, -27858.23)
		Case 8
			Move(4738.72, -27877.23)
		 EndSwitch

	If Not $WeAreDead then WriteLog("GoOut WaitForLoad")
	WaitForLoad()
	If Not $WeAreDead then WriteLog("GoOut rndslp")
	rndslp(5000)
	Out("Moving Back")
	If $intrun = 1 Then
		Move(4776, -27888)
		WaitForLoad()
		rndslp(5000)
		Out("Going Out")
		Switch (Random(1, 8, 1))
			Case 1
				Move(4733.52, -27842.97)
			Case 2
				Move(4730.40, -27788.09)
			Case 3
				Move(4700.77, -27976.07)
			Case 4
				Move(4720.88, -27892.77)
			Case 5
				Move(4720.72, -27858.23)
			Case 6
				Move(4725.52, -27856.53)
			Case 7
				Move(4729.92, -27858.23)
			Case 8
				Move(4738.72, -27877.23)
		EndSwitch
		WaitForLoad()
		rndslp(5000)
	EndIf
EndFunc

Func Running_Old()  ;Old function without 2nd cast of Dwarven Stability
	local $me = GetAgentByID(-2)
	If DllStructGetData(GetSkillbar(), 'Recharge2') = 0 AND  DllStructGetData($me, 'EnergyPercent') >= 0.10 And $WeAreDead = False Then
		UseSkill(2, 0) ;Dash
		rndslp(500)
	EndIf
 EndFunc

 Func Running()    ;New function with 2nd cast of Dwarven Stability
	local $me = GetAgentByID(-2)
	If DllStructGetData(GetSkillbar(), 'Recharge2') = 0 AND  DllStructGetData($me, 'EnergyPercent') >= 0.10 And $WeAreDead = False Then
		If Not $WeAreDead then WriteLog("Running Use Skills")
        Sleep(GetPing()+80)
	    UseSkillEx(1, 0) ;Dwarven Stability
        Sleep(GetPing()+80)
		UseSkillEx(2, 0) ;Dash
		If GetChecked ($Use_IAU) Then
           Sleep(GetPing()+80)
		   UseSkillEx(3, 0) ;I Am Unstoppable
        EndIf
	EndIf
EndFunc

Func ChestRun()
	If Not $WeAreDead then WriteLog("ChestRun Begin")
	$WeAreDead = False
	AdlibRegister("CheckDeath", 1000)
	AdlibRegister("Running", 1000)

	WriteLog("ChestRun Waypoint 1")
	If Not $WeAreDead then Out("Waypoint 1")
	local $me = GetAgentByID(-2)
	If DllStructGetData(GetSkillbar(), 'Recharge1') = 0 AND  DllStructGetData($me, 'EnergyPercent') >= 0.10 And $WeAreDead = False Then
		UseSkill(1, 0)
		rndslp(800)
	EndIf

	Switch (Random(1, 5, 1))
		Case 1
			Dim $wp[2] = [2942, -25733]
		Case 2
			Dim $wp[2] = [2884.05, -25826.86]
		Case 3
			Dim $wp[2] = [2876.13, -25690.62]
		Case 4
			Dim $wp[2] = [2899.05, -25801.86]
		Case 5
			Dim $wp[2] = [2913.13, -25745.62]
	EndSwitch

	If Not $WeAreDead then MoveTo($wp[0], $wp[1])

	If Not $WeAreDead then WriteLog("ChestRun Waypoint 2")
	If Not $WeAreDead then Out("Waypoint 2")

	Switch (Random(1, 5, 1))
		Case 1
			Dim $wp[2] = [434, -20716]
		Case 2
			Dim $wp[2] = [427, -20705]
		Case 3
			Dim $wp[2] = [445, -20729]
		Case 4
			Dim $wp[2] = [420, -20710]
		Case 5
			Dim $wp[2] = [438, -20720]
	EndSwitch
	If Not $WeAreDead then MoveTo($wp[0], $wp[1])

	If Not $WeAreDead then WriteLog("ChestRun Waypoint 3")
	If Not $WeAreDead then Out("Waypoint 3")
	GUICtrlSetData($TreasureTitle_Lbl, GetTreasureTitle())
	GUICtrlSetData($LuckyTitle_Lbl, GetLuckyTitle())
	GUICtrlSetData($UnluckyTitle_Lbl, GetUnluckyTitle())
	GUICtrlSetData($WisdomTitle_Lbl, GetWisdomTitle())

	Switch (Random(1, 5, 1))
		Case 1
			Dim $wp[2] = [-3391, -18043]
		Case 2
			Dim $wp[2] = [-3380, -18033]
		Case 3
			Dim $wp[2] = [-3399, -18055]
		Case 4
			Dim $wp[2] = [-3384, -18020]
		Case 5
			Dim $wp[2] = [-3405, -18060]
	EndSwitch
	If Not $WeAreDead then MoveTo($wp[0], $wp[1])

	If Not $WeAreDead then WriteLog("ChestRun Waypoint 3 TargetNearestItem")
	If Not $WeAreDead then TargetNearestItem()
	If Not $WeAreDead then rndslp(500)
	If DllStructGetData(GetCurrentTarget(), 'Type') = 512 and $WeAreDead = False Then
		If Not $WeAreDead then DoChest()
		If Not $WeAreDead then rndslp(800)
	EndIf

	If Not $WeAreDead then WriteLog("ChestRun Waypoint 4")
	If Not $WeAreDead then Out("Waypoint 4")
	GUICtrlSetData($TreasureTitle_Lbl, GetTreasureTitle())
	GUICtrlSetData($LuckyTitle_Lbl, GetLuckyTitle())
	GUICtrlSetData($UnluckyTitle_Lbl, GetUnluckyTitle())
	GUICtrlSetData($WisdomTitle_Lbl, GetWisdomTitle())
	Switch (Random(1, 5, 1))
		Case 1
			Dim $wp[2] = [-4950, -14890]
		Case 2
			Dim $wp[2] = [-4937, -14877]
		Case 3
			Dim $wp[2] = [-4965, -14911]
		Case 4
			Dim $wp[2] = [-4944, -14900]
		Case 5
			Dim $wp[2] = [-4959, -14906]
	EndSwitch
	If Not $WeAreDead then MoveTo($wp[0], $wp[1])

	If Not $WeAreDead then WriteLog("ChestRun Waypoint 4 TargetNearestItem")
	If Not $WeAreDead then TargetNearestItem()
	If Not $WeAreDead then rndslp(500)
	If DllStructGetData(GetCurrentTarget(), 'Type') = 512 and $WeAreDead = False Then
		If Not $WeAreDead then DoChest()
		If Not $WeAreDead then rndslp(800)
	EndIf

	If Not $WeAreDead then WriteLog("ChestRun Waypoint 5")
	If Not $WeAreDead then Out("Waypoint 5")
	GUICtrlSetData($TreasureTitle_Lbl, GetTreasureTitle())
	GUICtrlSetData($LuckyTitle_Lbl, GetLuckyTitle())
	GUICtrlSetData($UnluckyTitle_Lbl, GetUnluckyTitle())
	GUICtrlSetData($WisdomTitle_Lbl, GetWisdomTitle())
	Switch (Random(1, 5, 1))
		Case 1
			Dim $wp[2] = [-5725, -12445]
		Case 2
			Dim $wp[2] = [-5745, -12430]
		Case 3
			Dim $wp[2] = [-5700, -12442]
		Case 4
			Dim $wp[2] = [-5712, -12453]
		Case 5
			Dim $wp[2] = [-5732, -12425]
	EndSwitch
	If Not $WeAreDead then MoveTo($wp[0], $wp[1])

	If Not $WeAreDead then WriteLog("ChestRun Waypoint 5 TargetNearestItem")
	If Not $WeAreDead then TargetNearestItem()
	If Not $WeAreDead then rndslp(500)
	If DllStructGetData(GetCurrentTarget(), 'Type') = 512 and $WeAreDead = False Then
		If Not $WeAreDead then DoChest()
		If Not $WeAreDead then rndslp(800)
	EndIf
    GUICtrlSetData($TreasureTitle_Lbl, GetTreasureTitle())
    GUICtrlSetData($LuckyTitle_Lbl, GetLuckyTitle())
    GUICtrlSetData($UnluckyTitle_Lbl, GetUnluckyTitle())
    GUICtrlSetData($WisdomTitle_Lbl, GetWisdomTitle())
	AdlibUnRegister("CheckDeath")
	AdlibUnRegister("Running")

	If Not $WeAreDead then WriteLog("ChestRun Resign")
	Do
		Resign()
		rndslp(2700)
	Until GetIsDead(-2) = 1
	rndslp(3800)
	ReturnToOutpost()
	WaitForLoad()
EndFunc

Func DoChest()
    If Not $WeAreDead Then
        WriteLog("ChestRun DoChest Begin")
        Out("Opening Chest")
        GoSignpost(-1)
        Local $TimeCheck = TimerInit()
        Local $chest = GetCurrentTarget()
        Local $oldCoordsX = DllStructGetData($chest, "X")
        Local $oldCoordsY = DllStructGetData($chest, "Y")

        ; Wait for some condition around the chest or a timeout
        Do
            rndslp(500)
        Until CheckArea($oldCoordsX, $oldCoordsY) Or TimerDiff($TimeCheck) > 1000 Or $WeAreDead

        rndslp(2000) ; Additional sleep before opening the chest

        WriteLog("ChestRun DoChest OpenChest")
        Sleep(GetPing() + 1000)
        OpenChest()
        Sleep(GetPing() + 1000)

        ; Now, instead of picking up items here, call PickUpLoot
        PickUpLoot()
	

        WriteLog("ChestRun DoChest End")
    EndIf
EndFunc   ;==>DoChest

Func CheckDeath()
	If Death() = 1 Then
		$WeAreDead = True
		Out("We Are Dead")
	EndIf
EndFunc   ;==>CheckDeath

Func TimeUpdater()
	$Seconds += 1
	If $Seconds = 60 Then
		$Minutes += 1
		$Seconds = $Seconds - 60
	EndIf
	If $Minutes = 60 Then
		$Hours += 1
		$Minutes = $Minutes - 60
	EndIf
	If $Seconds < 10 Then
		$L_Sec = "0" & $Seconds
	Else
		$L_Sec = $Seconds
	EndIf
	If $Minutes < 10 Then
		$L_Min = "0" & $Minutes
	Else
		$L_Min = $Minutes
	EndIf
	If $Hours < 10 Then
		$L_Hour = "0" & $Hours
	Else
		$L_Hour = $Hours
	EndIf
	GUICtrlSetData($Run_Time, $L_Hour & ":" & $L_Min & ":" & $L_Sec)
EndFunc

#Region funcs
Func _exit()
	Exit
EndFunc   ;==>_exit

Func Out($msg)
	GUICtrlSetData($Status, "" & $msg)
EndFunc   ;==>Out

Func Out2($msg) ;Original Function with Timestamp
	GUICtrlSetData($Status, "[" & @HOUR & ":" & @MIN & "]  " & $msg)
EndFunc   ;==>Out

Func PickUpLoot()
    If CountSlots() < 1 Then Return ; Full inventory, don't try to pick up
    If GetIsDead(-2) Then Return ; Player is dead, exit the function

    Local $lAgent, $lItem, $lDeadlock
    For $i = 1 To GetMaxAgents() ; Loop through all agents
        $lAgent = GetAgentByID($i) ; Get agent data

        If DllStructGetData($lAgent, 'Type') <> 0x400 Then ContinueLoop
        
        $lItem = GetItemByAgentID($i) 
        If CanPickUp($lItem) Then ; Check if the item can be picked up
            PickUpItem($lItem) ; Attempt to pick up the item
            $lDeadlock = TimerInit() ; Initialize a timer for deadlock prevention

            While GetAgentExists($i)
                Sleep(100) ; Short sleep to prevent high CPU usage
                If GetIsDead(-2) Then Return ; Check again if the player is dead
                If TimerDiff($lDeadlock) > 15000 Then ExitLoop ; Timeout after 10 seconds to prevent infinite loop
            WEnd
        EndIf
    Next
EndFunc   ;==>PickUpLoot


Func CanPickUp($aItem)
    Local $lModelID = DllStructGetData($aItem, 'ModelId')
    Local $t = DllStructGetData($aItem, 'Type')
    Local $aExtraID = DllStructGetData($aItem, 'ExtraId')
    Local $lRarity = GetRarity($aItem) 
    Local $Requirement = GetItemReq($aItem)

    If $lModelID == 2511 Then
        Return GetGoldCharacter() < 100000
    EndIf

    ; Gold rarity items
    If $lRarity == $RARITY_GOLD Then Return True
	
    Return False
EndFunc   ;==>CanPickUp

Func isagenthuman($aAgent)
	If DllStructGetData($aAgent, 'Allegiance') <> 1 Then Return
	$thename = GetPlayerName($aAgent)
	If $thename = "" Then Return
	Return True
EndFunc   ;==>isagenthuman

#Region Getting Gold
Func CheckGoldLevel()
	If GetGoldCharacter() < 1000 Then
;=========================================NEED TO DOUBLE CHECK AND TEST GOLD WITHDRAW AND GOLD DEPOSIT. SEEMS GLITCHY======================================
#cs
Here is the section to pull gold from storage. Pretty easy  to do. You will uncomment this section and comment the rest of the function out.
		If GetGoldStorage() > 20000 Then
			WithdrawGold(20000) ; Can change it to any amount you select by changing the stuff in the (). Should not be larger than the amount in the line above.
		EndIf
#ce


TravelGH()
		;RareMaterialTrader()
		StoreItems()
		Sleep(GetPing()+500)
		If GetChecked($Store) Then
			StoreGolds
		EndIf
		If GetChecked ($Sell) Then
			Sell()
		EndIf
		Sleep(GetPing()+500)
		LeaveGH()
	EndIf
EndFunc   ;==>CheckGoldLevel

Func CheckBagSpaceLeft()
	If CountSlots() < 5 Then
		TravelGH()
		If GetChecked($Store) Then
			Sleep(GetPing()+500)
			StoreGolds()
		EndIf
		Sleep(GetPing()+500)
		StoreItems()
		LeaveGH()
	EndIf
EndFunc   ;==>CheckBagSpaceLeft

Func Inventory()
     Identify()
     Sell()
EndFunc

Func Identify()
	Local $aitem, $lBag
	For $i = 1 To 4
		$lBag = GetBag($i)
		For $j = 1 To DllStructGetData($lBag, 'Slots')
			Out("IDing item: " & $i & ", " & $j)
			$aitem = GetItemBySlot($lBag, $j)
			If FindIDKit2() = 0 Then
				If GetGoldCharacter() < 500 And GetGoldStorage() > 499 Then
					WithdrawGold(500)
					Sleep(GetPing()+250)
				EndIf
				Local $K = 0
				Do
					BuyItem(6, 1, 500)
					Sleep(GetPing()+250)
					$K = $K + 1
				Until FindIDKit2() <> 0 Or $K = 3
				If $K = 3 Then ExitLoop
				Sleep(GetPing()+250)
			EndIf
			If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
			If CanIdentify($aitem) Then
				IdentifyItem($AITEM)
				Sleep(GetPing()+250)
			EndIf
		Next
	Next
EndFunc

;~ Description: Returns item ID of ID kit in inventory.
Func FindIDKit2()
	Local $lItem
	Local $lKit = 0
	Local $lUses = 101
	For $i = 1 To 4
		For $j = 1 To DllStructGetData(GetBag($i), 'Slots')
			$lItem = GetItemBySlot($i, $j)
			Switch DllStructGetData($lItem, 'ModelID')
				Case 2989
					If DllStructGetData($lItem, 'Value') / 2 < $lUses Then
						$lKit = DllStructGetData($lItem, 'ID')
						$lUses = DllStructGetData($lItem, 'Value') / 2
					EndIf
				Case 5899
					If DllStructGetData($lItem, 'Value') / 2.5 < $lUses Then
						$lKit = DllStructGetData($lItem, 'ID')
						$lUses = DllStructGetData($lItem, 'Value') / 2.5
					EndIf
				Case Else
					ContinueLoop
			EndSwitch
		Next
	Next
	Return $lKit
EndFunc   ;==>FindIDKit

Func CanIdentify($aItem)
	Local $m = DllStructGetData($aitem, "ModelID")
	Local $r = GetRarity($aitem)
	Switch $r
		Case $Rarity_Gold; Remove the gold one if you intend to store them unid and sell later
			Return True
		Case Else
			Return False
	EndSwitch
EndFunc

Func Sell()
	Local $aitem, $lBag
	For $i = 1 To 3
		$lBag = Getbag($i)
		For $j = 1 To DllStructGetData($lBag, 'Slots')
			Out("Selling item: " & $i & ", " & $j)
			$aitem = GetItemBySlot($lBag, $j)
			If DllStructGetData($aitem, "ID") = 0 Then ContinueLoop
			If CanSell($aitem) Then
				SellItem($aitem)
				Sleep(GetPing()+250)
			EndIf
		Next
	Next
EndFunc

Func CanSell($aItem)
	Local $m = DllStructGetData($aitem, "ModelID")
	Local $r = GetRarity($aitem)
	Switch $r
		Case $Rarity_Gold
			If $m = 2624 Then ; Golds
				Return False
			Else
			Return True
		 EndIf
		Case $Rarity_White
			If $m = 22751 or $m = 930 or $m = 945 or $m = 146 Or $m = 5971 Or $m = 5899 Or $m = 5900 Then ; Lockpicks, Ecto, Obby Shards, Dyes, Obby keys, Sup ID kit, Sup Salvage kit
				Return False
			ElseIf CheckArrayAllDrops($m) Then ; Event Items, materials
				Return False
			Else
				Return True
			EndIf
		Case Else
			Return True
	EndSwitch
EndFunc   ;==>CanSell

Func CheckArrayAllDrops($m)
	For $p = 0 To (UBound($Array_Store_ModelIDs) -1)
		If ($m == $Array_Store_ModelIDs[$p]) Then Return True
	Next
	Return False
EndFunc


Func MoveEx($x, $y, $random = 150)
	Move($x, $y, $random)
EndFunc   ;==>MoveEx
#EndRegion Getting Gold


#Region Storage
Func StoreItems()
	Out("Storing Items")
	Local $AITEM, $m, $Q, $lbag, $SLOT, $FULL, $NSLOT
	For $i = 1 To 4
		$lbag = GetBag($i)
		For $j = 1 To DllStructGetData($lbag, 'Slots')
			$AITEM = GetItemBySlot($lbag, $j)
			If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
			$m = DllStructGetData($AITEM, "ModelID")
			$Q = DllStructGetData($AITEM, "quantity")
			For $z = 0 To (UBound($Array_Store_ModelIDs) - 1)
				If (($m == $Array_Store_ModelIDs[$z]) And ($Q = 250)) Then
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
						MoveItem($AITEM, $BAG, $NSLOT)
						Sleep(GetPing() + 500)
					EndIf
				EndIf
			Next
		Next
	Next
EndFunc   ;==>StoreItems

Func StoreGolds()
	Out("Storing Golds")
	Local $AITEM, $lItem, $m, $Q, $r, $lbag, $SLOT, $FULL, $NSLOT
	For $i = 1 To 4
		$lbag = GetBag($i)
		For $j = 1 To DllStructGetData($lbag, 'Slots')
			$AITEM = GetItemBySlot($lbag, $j)
			If DllStructGetData($AITEM, "ID") = 0 Then ContinueLoop
			$m = DllStructGetData($AITEM, "ModelID")
			$r = GetRarity($lItem)
			If CanStoreGolds($AITEM) Then
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
					MoveItem($AITEM, $BAG, $NSLOT)
					Sleep(GetPing() + 500)
				EndIf
			EndIf
		Next
	Next
EndFunc   ;==>StoreGolds

Func CanStoreGolds($AITEM)
	Local $m = DllStructGetData($AITEM, "ModelID")
	Local $r = GetRarity($AITEM)
	Switch $r
		Case $RARITY_GOLD
			If $m = 22280 Then
				Return False
			Else
				Return True
			EndIf
	EndSwitch
EndFunc   ;==>CanStoreGolds

Func FindEmptySlot($bagIndex)
	Local $LITEMINFO, $aslot
	For $aslot = 1 To DllStructGetData(GetBag($bagIndex), "Slots")
		Sleep(40)
		$LITEMINFO = GetItemBySlot($bagIndex, $aslot)
		If DllStructGetData($LITEMINFO, "ID") = 0 Then
			SetExtended($aslot)
			ExitLoop
		EndIf
	Next
	Return 0
EndFunc   ;==>FindEmptySlot

Func CountSlots()
	Local $BAG
	Local $temp = 0
	$BAG = GetBag(1)
	$temp += DllStructGetData($BAG, 'Slots') - DllStructGetData($BAG, 'ItemsCount')
	$BAG = GetBag(2)
	$temp += DllStructGetData($BAG, 'Slots') - DllStructGetData($BAG, 'ItemsCount')
	$BAG = GetBag(3)
	$temp += DllStructGetData($BAG, 'Slots') - DllStructGetData($BAG, 'ItemsCount')
	$BAG = GetBag(4)
	$temp += DllStructGetData($BAG, 'Slots') - DllStructGetData($BAG, 'ItemsCount')
	Return $temp
EndFunc   ;==>CountSlots
#EndRegion Storage


Func GetTime()
   Local $Time = GetInstanceUpTime()
   Local $Seconds = Floor($Time/1000)
   Local $Minutes = Floor($Seconds/60)
   Local $Hours = Floor($Minutes/60)
   Local $Second = $Seconds - $Minutes*60
   Local $Minute = $Minutes - $Hours*60
   If $Hours = 0 Then
	  If $Second < 10 Then $InstTime = $Minute&':0'&$Second
	  If $Second >= 10 Then $InstTime = $Minute&':'&$Second
   ElseIf $Hours <> 0 Then
	  If $Minutes < 10 Then
		 If $Second < 10 Then $InstTime = $Hours&':0'&$Minute&':0'&$Second
		 If $Second >= 10 Then $InstTime = $Hours&':0'&$Minute&':'&$Second
	  ElseIf $Minutes >= 10 Then
		 If $Second < 10 Then $InstTime = $Hours&':'&$Minute&':0'&$Second
		 If $Second >= 10 Then $InstTime = $Hours&':'&$Minute&':'&$Second
	  EndIf
   EndIf
   Return $InstTime
EndFunc


Func GetChecked($GUICtrl)
	Return (GUICtrlRead($GUICtrl)==$GUI_Checked)
EndFunc

Func GetItemCountByID($ID)
   If GetMapLoading() == 2 Then Disconnected()
   Local $Item
   Local $Quantity = 0
   For $Bag = 1 to 4
	  For $Slot = 1 to DllStructGetData(GetBag($Bag), 'Slots')
		 $Item = GetItemBySlot($Bag,$Slot)
		 If DllStructGetData($Item,'ModelID') = $ID Then
			$Quantity += DllStructGetData($Item, 'Quantity')
		 EndIf
	  Next
   Next
   Return $Quantity
EndFunc

Func GetGoldsCount();Counts Gold Items in your inventory (Need to fix so it does not count stackable golds like scrolls)
	Local $AmountGolds
	Local $aBag
	Local $aItem
	Local $iw
	For $i = 1 To 4 ;change 1 To 16 if you want to count storage also or 1 to 4 for just personal inv.  Will display on GUI
		$aBag = GetBag($i)
		For $j = 1 To DllStructGetData($aBag, "Slots")
			$aItem = GetItemBySlot($aBag, $j)
			;If DllStructGetData($aItem, "ModelID") == 2624 Then
			If DllStructGetData($aItem, 'ModelID') <> 0 And GetRarity($aItem) = $RARITY_Gold Then
				$AmountGolds += DllStructGetData($aItem, "Quantity")
			Else
				ContinueLoop
			EndIf
		Next
	Next
	Return $AmountGolds
EndFunc   ; Counts Golds in your inventory to include chest



Func PurgeHook()
	Out("Purging Engine Hook")
	Sleep(Random(2000, 2500))
	Sleep(Random(2000, 2500))
    ClearMemory()
	Sleep(Random(2000, 2500))
EndFunc

Func Use_Man_Cake()
	$item = GetItemByModelID($ITEM_ID_Mandragor_Root_Cake)
	Out("Speed Boost 50%")
	If DllStructGetData($item, 'Bag') <> 0 Then
		UseItem($item)
		Sleep(100)
		Return
	EndIf
EndFunc

Func Use_Blue_Sugary_Drink()
	$item = GetItemByModelID($ITEM_ID_Sugary_Blue_Drink)
	Out("Speed Boost 25%")
	If DllStructGetData($item, 'Bag') <> 0 Then
		UseItem($item)
		Sleep(100)
		Return
	EndIf
EndFunc

Func Use_Fruit_Cake()
	$item = GetItemByModelID($ITEM_ID_Fruitcake)
	Out("Speed Boost 25%")
	If DllStructGetData($item, 'Bag') <> 0 Then
		UseItem($item)
		Sleep(100)
		Return
	EndIf
EndFunc

Func Use_Choc_Bunny()
	$item = GetItemByModelID($ITEM_ID_Chocolate_Bunny)
	Out("Speed Boost 50%")
	If DllStructGetData($item, 'Bag') <> 0 Then
		UseItem($item)
		Sleep(100)
		Return
	EndIf
 EndFunc

 Func Strafe()
	$strafeTimer = TimerInit()
	Out("Strafing")
	ToggleAutoRun()
	Sleep(GetPing()+250)
	;If $leftright = 0 Then
		StrafeRight(1)
		Sleep(2000)
		Sleep(GetPing()+750)
		StrafeRight(0)
		ToggleAutoRun()
		MoveTo(-3851, 17388, 100)
		Sleep(5000)
		MoveTo(-3444, 17820, 100)
		;$leftright = 1
	;Else
		;StrafeLeft(1)
		;Sleep(GetPing()+750)
		;StrafeLeft(0)
		;$leftright = 0
	;EndIf
	;Move($RunWayPoints[$currentWP][0], $RunWayPoints[$currentWP][1])
 EndFunc   ;==>Strafe


Func Rndslp($val)
	$wert = Random($val * 0.95, $val * 1.05, 1)
	If $wert > 45000 Then
		For $i = 0 To 6
			Sleep($wert / 6)
			Death()
		Next
	ElseIf $wert > 36000 Then
		For $i = 0 To 5
			Sleep($wert / 5)
			Death()
		Next
	ElseIf $wert > 27000 Then
		For $i = 0 To 4
			Sleep($wert / 4)
			Death()
		Next
	ElseIf $wert > 18000 Then
		For $i = 0 To 3
			Sleep($wert / 3)
			Death()
		Next
	ElseIf $wert >= 9000 Then
		For $i = 0 To 2
			Sleep($wert / 2)
			Death()
		Next
	Else
		Sleep($wert)
		Death()
	EndIf
 EndFunc   ;==>RndSlp

 Func WaitForLoad()
	Out("Loading zone")
	WriteLog("T1")
	InitMapLoad()
	WriteLog("T2")
	$deadlock = 0
	WriteLog("T3")
	Do
		WriteLog("T4")
		Sleep(100)
		$deadlock += 100
		WriteLog("T5")
		$load = GetMapLoading()
		WriteLog("T6")
		$lMe = GetAgentByID(-2)
		WriteLog("T7")

	Until $load = 2 And DllStructGetData($lMe, 'X') = 0 And DllStructGetData($lMe, 'Y') = 0 Or $deadlock > 20000
	WriteLog("T8")
	$deadlock = 0
	Do
		WriteLog("T9")
		Sleep(100)
		$deadlock += 100
		$deadlock += 100
		$load = GetMapLoading()
		WriteLog("T10")
		$lMe = GetAgentByID(-2)
		WriteLog("T11")

	Until $load <> 2 And DllStructGetData($lMe, 'X') <> 0 And DllStructGetData($lMe, 'Y') <> 0 Or $deadlock > 30000
	WriteLog("T12")
	Out("Load complete")
	rndslp(3000)
 EndFunc   ;==>WaitForLoad

 Func CheckIfInventoryIsFull()
	If CountSlots() <= 2 Then       ;Adjusted to allow for ID kits, previous:  If CountSlots() = 0 Then
		Out("Inventory Is Full")
		return true
	Else
		return false
	EndIf
 EndFunc   ;==>CheckIfInventoryIsFull

 Func SellItemToMerchant()

	If GetGoldCharacter()>90000 Then  ;If more than 90k then deposit
			Out("Depositing Gold")
			DepositGold(10000)         ;Deposit 10k
    EndIf

	Out("Storing Gold Unid")
	If GetChecked ($Bunny) Then
	   Use_Choc_Bunny()
    EndIf
	If GUICtrlRead($Store) = $GUI_CHECKED Then StoreGolds()
	RNDSLP(1000)
	Out("Going to merchant")
	$merchant = GetNearestNPCToCoords(7319, -24874)
	Rndslp(1000)
	MoveTo(7603, -27423)
	GoToNPC($merchant)
	BuyIDKit()
	$IDKitBought = $IDKitBought + 1
	RNDSLP(1000)
	Out("ID Inventory...")
	Out("ID Bag-1")
	Ident(1)
	Out("ID Bag-2")
	Ident(2)
	Out("ID Bag-3")
	Ident(3)
	If GetChecked($Sell) Then
	    Out("Selling...")
		Sell()
		;Sell(2)
		;Sell(3)
	EndIf
	moveto(7603, -27423)
 EndFunc  ;==>SellItemToMerchant

 Func Ident($bagIndex)
	$bag = GetBag($bagIndex)
	For $i = 1 To DllStructGetData($bag, 'slots')
		If FindIDKit() = 0 Then
			If GetGoldCharacter() < 500 And GetGoldStorage() > 499 Then
				WithdrawGold(500)
				Sleep(Random(200, 300))
			EndIf
			local $J = 0
			Do
				BuyIDKit()
				RndSleep(500)
				$J = $J+1
			Until FindIDKit() <> 0 OR $J = 3
			If $J = 3 Then ExitLoop
			RndSleep(500)
		EndIf
		$aitem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aitem, 'ID') = 0 Then ContinueLoop
		IdentifyItem($aitem)
		Sleep(Random(400, 750))
	Next
 EndFunc   ;==>IDENT

 Func Death()
	If DllStructGetData(GetAgentByID(-2), "Effects") = 0x0010 Then
		Return 1	; Whatever you want to put here in case of death
	Else
		Return 0
	EndIf
EndFunc   ;==>Death

Func GetPicksCount();Counts Lockpicks in your inventory
	Local $AmountPicks
	Local $aBag
	Local $aItem
	Local $iw
	For $i = 1 To 4 ;change 1 To 16 if you want to count storage also or 1 to 4 for just personal inv.  Will display on GUI
		$aBag = GetBag($i)
		For $j = 1 To DllStructGetData($aBag, "Slots")
			$aItem = GetItemBySlot($aBag, $j)
			If DllStructGetData($aItem, "ModelID") == 22751 Then
				$AmountPicks += DllStructGetData($aItem, "Quantity")
			Else
				ContinueLoop
			EndIf
		Next
	Next
	Return $AmountPicks
EndFunc   ; Counts Lockpicks in your inventory to include chest

Func HasValue ($aItem)
	Local $ModelID = DllStructGetData($aItem, "ModelID")
	Local $ExtraID = DllStructGetData($aItem, "ExtraID")

	Switch $ModelID
    Case 18345, 22269, 21491, 37765, 21833, 28433, 28434
	   Return True ; Special - Four Leaf Clover, ToT, Cupcake, etc
    Case 22751
	   Return True ; Lockpicks

    Case 146
	   If $ExtraID = 10 Or $ExtraID = 12 Then
		  Return True ; Black & White Dye
	   Else
		  Return False
	   EndIf

    Case 3746, 22280
	   Return True ; Underworld & FOW Scroll

	Case 765, 767, 768, 1887
	   Return True ; Heros_Insight = 765, Berserkers_Insight = 767, Slayers_Insight = 768, Lightbringers_Insight = 1887

	Case 857, 894, 895
	   Return True ; Adventurers_Insight = 857, Rampagers_Insight = 894, Hunters_Insight = 895 (Blue XP Scrolls

    EndSwitch
	Return False
 EndFunc

 Func Deposit_Platinum()
	 Out("Checking Gold")
	If GetGoldCharacter() < 5000 Then
	   WithdrawGold(50000)
	   Sleep(GetPing()+50)
    EndIf
    If GetGoldCharacter() > 90000 Then
	   Out("Depositing Gold")
	   DepositGold(40000)
	   Sleep(GetPing()+50)
    EndIf
		Sleep(GetPing()+50)
EndFunc

Func CheckGold()
	Out("Checking Gold")
	If GetGoldCharacter() > 90000 Then ;and GetGoldStorage() <= 99*1000*10 Then
	    Out("Deposit Gold")
		Sleep(50)
		DepositGold(9000)
		Sleep(Random(200,300))
	EndIf
 EndFunc

 Func RndTravel($aMapID)
	Local $UseDistricts = 11 ; 7=eu-only, 8=eu+int, 11=all(excluding America)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, us-en, int, asia-ko, asia-ch, asia-ja
	Local $Region[11] = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
	MoveMap($aMapID, $Region[$Random], 0, $Language[$Random])
	Waitmaploading($aMapID)
EndFunc   ;==>RndTravel

 Func RndTravelEx($aMapID)
	Local $UseDistricts = 7
	; 7=eu, 8=eu+int, 11=all(incl. asia)
	; Old Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, int, asia-ko, asia-ch, asia-ja
	; New Region/Language order: eu-it, eu-sp, eu-po, eu-ru, asia-ko, asia-ch, asia-ja
	Local $ComboDistrict[7][2]=[[2, 4], [2, 5],[2, 9],[2, 10],[1, 0], [3, 0], [4, 0]]
	;Local $Region[11] = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	;Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
	MoveMap($aMapID, $ComboDistrict[$Random][0], 0, $ComboDistrict[$Random][1])
	WaitMapLoading($aMapID, 15000) ;Reduced loading times from 30 seconds down to 22 seconds then down to 15 sec
	Sleep(GetPing() + 1000) ;For safety to ensure full load based off lag
 EndFunc ;==>RndTravel

;~ Description: ;Roll Dice 1-5 for random district hop
Func RollDistrictHop()
   Out("Rolling District Hop")
   Switch (Random(1, 7, 1))    ;<<<<<<<<<<<<<<<<<<<<<<<< NOTICE:  MAKE SURE TO CHANGE THIS TO THE NUMBER OF RANDOM  HOPS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.
   Case 1
	     Out("Roll-1 District Change")
		 RndTravelEx(675) ;Added to district hop to help prevent over botting district (Boreal Station Map ID)
		 MoveTo(7603, -27423)
		 Out("Going Out")

	Switch (Random(1, 8, 1)) ;8 Random Paths, will roll random and select an option of the below 8 paths
		Case 1
			Move(4733.52, -27842.97)
		Case 2
			Move(4730.40, -27788.09)
		Case 3
			Move(4700.77, -27976.07)
		Case 4
			Move(4720.88, -27892.77)
		Case 5
			Move(4720.72, -27858.23)
		Case 6
			Move(4725.52, -27856.53)
		Case 7
			Move(4729.92, -27858.23)
		Case 8
			Move(4738.72, -27877.23)
		 EndSwitch

	WaitForLoad()
	Rndslp(2000)
	Out("Moving Back")
	Out("Moving Back")

		Move(4776, -27888)
		WaitForLoad()
		rndslp(3000)
		Out("Going Out")
		Switch (Random(1, 8, 1))
			Case 1
				Move(4733.52, -27842.97)
			Case 2
				Move(4730.40, -27788.09)
			Case 3
				Move(4700.77, -27976.07)
			Case 4
				Move(4720.88, -27892.77)
			Case 5
				Move(4720.72, -27858.23)
			Case 6
				Move(4725.52, -27856.53)
			Case 7
				Move(4729.92, -27858.23)
			Case 8
				Move(4738.72, -27877.23)
		EndSwitch
		WaitForLoad()
		rndslp(5000)
	  Case 2
		 Out("Roll-2 No District Hop ")
	  Case 3
		 Out("Roll-3 No District Hop")
	  Case 4
		 Out("Roll-4 No District Hop")
	  Case 5
		 Out("Roll-5 No District Hop")
	  Case 6
		 Out("Roll-6 No District Hop")
	  Case 7
		 Out("Roll-7 No District Hop")
	EndSwitch
EndFunc   ;Roll Dice 1-5 for random district hop

#EndRegion funcs


