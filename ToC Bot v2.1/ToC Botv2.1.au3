#include <ButtonConstants.au3>
#include <GWA2.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region declarations
Opt("GUIOnEventMode", True)
Opt("GUICloseOnESC", False)
Global $bag_slots[5] = [0, 20, 5, 10, 10]
Global $spawned = False
Global $ensuresafety = True ; will zone  until it finds empty dis , and wont kneel if people in town
Global Const $champion = 1947
Global Const $fow = 34
Global Const $chantry = 393
Global Const $toa = 138
Global Const $scroll = 22280
Global Const $savsuds_Is_Cool = True
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
Global $town = $toa ;start town
Global $shardcount = 0
Global $wins = 0
Global $fails = 0
Global $RenderingEnabled = True
Global $BotRunning = False
Global $BotInitialized = False
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
$skillCost[$ds] = 5
$skillCost[$sf] = 5
$skillCost[$shroud] = 10
$skillCost[$wd] = 4
$skillCost[$hos] = 5
$skillCost[$iau] = 5
$skillCost[$de] = 5
$skillCost[$mb] = 10
#EndRegion declarations
#Region ### START Koda GUI section ### Form=c:\users\dada\documents\fowbot.kxf
$Form1 = GUICreate("ToC Ranger Bot", 320, 375, 1031, 651)

; Centered and organized controls
$Checkbox1 = GUICtrlCreateCheckbox("ensure safety", 112, 192, 97, 17)
GUICtrlSetState(-1, $gui_checked)
GUICtrlSetOnEvent(-1, "safety")

$Combo1 = GUICtrlCreateCombo("", 107, 8, 105, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, GetLoggedCharNames())

$Button1 = GUICtrlCreateButton("Start", 106, 32, 107, 17)
GUICtrlSetOnEvent(-1, "GuiButtonHandler")

$Group1 = GUICtrlCreateGroup("Runs", 107, 56, 105, 75, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER))

; Labels and counters
$Label1 = GUICtrlCreateLabel("wins :", 112, 67, 31, 17)
GUICtrlSetColor(-1, 0x008000)
$Label2 = GUICtrlCreateLabel("fails : ", 112, 89, 31, 17)
GUICtrlSetColor(-1, 0xFF0000)
$Label3 = GUICtrlCreateLabel("shards : ", 112, 111, 31, 17)
GUICtrlSetColor(-1, 0x008000)

$shardlabel = GUICtrlCreateLabel("0", 147, 111, 20, 17)
GUICtrlSetColor(-1, 0xFF0000)
$winlabel = GUICtrlCreateLabel("0", 147, 67, 20, 17)
GUICtrlSetColor(-1, 0x008000)
$faillabel = GUICtrlCreateLabel("0", 147, 89, 20, 17)
GUICtrlSetColor(-1, 0xFF0000)

; Entrance method group
$Group2 = GUICtrlCreateGroup("entrance method", 107, 128, 105, 57)
$kneelm = GUICtrlCreateRadio("Kneel", 107, 144, 113, 17)
GUICtrlSetState(-1, $gui_checked)
$scrollm = GUICtrlCreateRadio("Scroll", 107, 160, 113, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
; Status label group adjusted to match the width of the GUI
$Group3 = GUICtrlCreateGroup("", 8, 232, 304, 135)  ; Width increased to 304

; Status label adjusted to be wider
$slabel = GUICtrlCreateLabel("waiting on action     ", 54, 286, 230, 57)  ; Width increased
GUICtrlSetFont(-1, 12, 400, 0, "MS Serif")


; Other checkboxes and settings
$Checkbox2 = GUICtrlCreateCheckbox("disable rendering", 112, 216, 97, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "ToggleRendering")

GUISetOnEvent($GUI_EVENT_CLOSE, "_exit")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


#Region funcs
Func _exit()
	Exit
EndFunc   ;==>_exit

Func GuiButtonHandler()
	If $BotRunning Then
		GUICtrlSetData($Button1, "Will pause after this run")
		GUICtrlSetState($Button1, $GUI_DISABLE)
		$BotRunning = False
	ElseIf $BotInitialized Then
		GUICtrlSetData($Button1, "Pause")
		$BotRunning = True
	Else
		Out("Initializing")
		Local $CharName = GUICtrlRead($Combo1)
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
		GUICtrlSetState($Checkbox2, $GUI_ENABLE)
		GUICtrlSetState($Combo1, $GUI_DISABLE)
		GUICtrlSetData($Button1, "Pause")
		$BotRunning = True
		$BotInitialized = True
		setmaxmemory()
	EndIf
EndFunc   ;==>GuiButtonHandler

Func safety()
	If GUICtrlRead($Checkbox1) = $gui_checked Then
		$ensuresafety = True
		out("safe mode")
	Else
		$ensuresafety = False
		out("will ignore people")
	EndIf
EndFunc   ;==>safety

Func Out($msg)
	GUICtrlSetData($slabel, "[" & @HOUR & ":" & @MIN & "]" & $msg)
EndFunc   ;==>Out

Func UseSF()
	If IsRecharged($sf) Then
		UseSkillEx($sf)
	EndIf
	If isrecharged($shroud) And GetEffectTimeRemaining($skill_id_iau) > 1 Then
		useSkillEx($shroud)
	EndIf
	If GetEffectTimeRemaining($skill_id_shroud) < 10 Then
		useSkillEx($shroud)
	EndIf
EndFunc   ;==>UseSF

Func MoveRunning($lDestX, $lDestY)
	If GetIsDead(-2) Then Return False

	Local $lMe, $lTgt
	Local $lBlocked = 0
	Local $ChatStuckTimer = TimerInit()

	Move($lDestX, $lDestY)

	Do
		RndSleep(500)

		TargetNearestEnemy()
		$lMe = GetAgentByID(-2)
		$lTgt = GetAgentByID(-1)

		If GetIsDead($lMe) Then Return False
		If $lBlocked > 1 Then
			If TimerDiff($ChatStuckTimer) > 3000 Then
				SendChat("stuck", "/")
				$ChatStuckTimer = TimerInit()
			EndIf
		EndIf
		UseSF()
		If $lBlocked = 5 Then
			UseSkillEx($hos, -1)
			Sleep(100)
			Move($lDestX, $lDestY)
			If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
				$lBlocked = 1
			Else
				$lBlocked = 0
			EndIf
		EndIf
		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
			$lBlocked += 1
			Move($lDestX, $lDestY)
		EndIf

		If DllStructGetData($lMe, 'hp') < 0.2 Then
			UseSkillEx($hos)
		EndIf
		If gethascondition($lMe) And DllStructGetData($lMe, 'hp') < 0.4 Then
			UseSkillEx($hos)
		EndIf
		If GetDistance() > 1100 Then ;
			If TimerDiff($ChatStuckTimer) > 3000 Then ;
				SendChat("stuck", "/")
				$ChatStuckTimer = TimerInit()
				RndSleep(GetPing())
			EndIf
		EndIf

	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < 250
	Return True
EndFunc   ;==>MoveRunning

Func WaitFor($lMs, $class = 1) ;class cause we dont want to hos @ rangers
	If GetIsDead(-2) Then Return
	$lMe = GetAgentByID(-2)
	Local $lTimer = TimerInit()
	If $class = 1 Then
		Do
			If GetEffectTimeRemaining($skill_id_wd) < 1 Then Return
			Sleep(100)
			If GetIsDead(-2) Then Return
			If IsRecharged($iau) Then
				UseSkillEx($iau)
			EndIf

			If DllStructGetData($lMe, 'hp') < 0.3 Then
				UseSkillEx($hos)
			EndIf
			If gethascondition($lMe) And DllStructGetData($lMe, 'hp') < 0.4 Then
				UseSkillEx($hos)
			EndIf
			UseSF()
			If isrecharged($mb) And geteffecttimeremaining($skill_id_mb) = 0 Then
				useskillex($mb)
			EndIf
		Until TimerDiff($lTimer) > $lMs Or GetIsDead(-2)
	Else
		Do
			Sleep(100)
			If GetIsDead(-2) Then Return
			If IsRecharged($iau) Then
				UseSkillEx($iau)
			EndIf
			UseSF()
		Until TimerDiff($lTimer) > $lMs
	EndIf
EndFunc   ;==>WaitFor

Func useitembyslot($abag, $aslot)
	Local $item = getitembyslot($abag, $aslot)
	Return sendpacket(8, 119, DllStructGetData($item, "ID"))
EndFunc   ;==>useitembyslot

While 1
	Sleep(50)
	clearmemory()
	While Not $BotRunning
		Sleep(100)
	WEnd
	enterfow()
	loop()
	If Not $BotRunning Then
		Out("Bot was paused")
		TravelGH()
		GUICtrlSetData($Button1, "Start")
		GUICtrlSetState($Button1, $GUI_ENABLE)
	EndIf
WEnd

Func loop()
	If Not $RenderingEnabled Then ClearMemory()
	If getmapid() <> $fow Then Return
	out("moving to first spot")
	UseSkillEx($sf)
	UseSkillEx($ds)
	UseSkillEx($de)
	moveto(-21131, -2390)
	MoveRunning(-16494, -3113)
	out("starting to ball abbys")
	Sleep(1000)
	UseSkillEx($iau)
	If IsRecharged($ds) Then
		UseSkillEx($ds)
	EndIf
	If IsRecharged($ds) Then
		UseSkillEx($ds)
	EndIf
	useskillex($mb)
	MoveRunning(-14453, -3536)
	UseSkillEx($ds)
	UseSkillEx($wd)
	$whirletimer = TimerInit()
	MoveRunning(-13684, -2077)
	MoveRunning(-14113, -418) ; Put something after here for HoS use to tighten the ball a tad
	out("whirling abbys")
	waitfor(38000 - TimerDiff($whirletimer))
	out("abbys dead, Looting") ; Changed by me
	PickUpLoot() ; Added by me
	MoveRunning(-13684, -2077)
	out("balling rangers")
	MoveRunning(-15826, -3046)
	rndsleep(1500)
	moveto(-16002, -3031)
	out("checking skills")
	Do
		If getisdead(-2) Then Return
		WaitFor(1500)
	Until IsRecharged($mb) And isrecharged($wd)
	moveto(-16004, -3202)
	MoveRunning(-15272, -3004)
	UseSkillEx($iau)
	UseSkillEx($ds)
	UseSkillEx($mb)
	If IsRecharged($wd) Then
		UseSkillEx($wd)
	EndIf
	If IsRecharged($mb) Then
		UseSkillEx($mb)
	EndIf
	out("killing rangers")
	MoveRunning(-14453, -3536)
	moverunning(-14209, -2935)
	moverunning(-14535, -2615)
	waitfor(27000, 2)
	moveto(-14506, -2633)
	out("looting")
	PickUpLoot()
	If Not getisdead(-2) Then
		$wins = $wins + 1
		GUICtrlSetData($winlabel, $wins)
	EndIf
	If GetIsDead(-2) Then
		$fails = $fails + 1
		GUICtrlSetData($faillabel, $fails)
	EndIf
	$spawned = False
;	RndTravel($town)
EndFunc   ;==>loop

Func PickUpLoot()
	Local $lMe
	Local $lBlockedTimer
	Local $lBlockedCount = 0
	Local $lItemExists = True
	For $i = 1 To GetMaxAgents()
		$lMe = GetAgentByID(-2)
		If DllStructGetData($lMe, 'HP') <= 0.0 Then Return -1
		$lAgent = GetAgentByID($i)
		If Not GetIsMovable($lAgent) Then ContinueLoop
		If Not GetCanPickUp($lAgent) Then ContinueLoop
		$lItem = GetItemByAgentID($i)
		If canpickup($lItem) Then
			Do
				If $lBlockedCount > 2 Then
					useskillex($hos)
				EndIf
;~ 				If GetDistance($lItem) > 150 Then Move(DllStructGetData($lItem, 'X'), DllStructGetData($lItem, 'Y'), 100)
				PickUpItem($lItem)
				Sleep(GetPing())
				Do
					Sleep(100)
					$lMe = GetAgentByID(-2)
				Until DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0
				$lBlockedTimer = TimerInit()
				Do
					Sleep(3)
					$lItemExists = IsDllStruct(GetAgentByID($i))
				Until Not $lItemExists Or TimerDiff($lBlockedTimer) > Random(5000, 7500, 1)
				If $lItemExists Then $lBlockedCount += 1
			Until Not $lItemExists Or $lBlockedCount > 5
		EndIf
	Next
EndFunc   ;==>PickUpLoot

;~ Basically I opened up the pickup to pickup everything. Modify line 447 to remove blue, purple, white, golds if you like.
Func CanPickUp($lItem)
	Local $m = DllStructGetData($lItem, 'ModelId')
	Local $t = DllStructGetData($lItem, 'Type')
	Local $c = DllStructGetData($lItem, 'ExtraID')
	Local $r = GetRarity($lItem)
	Switch $m
		Case 522 ; Dark Remains
			Return True
		Case 910, 2513, 5585, 6366, 6375, 22190, 24593, 28435, 30855, 31145, 36682 _ ; Alcohol
				, 21492, 21812, 22269, 22644, 22752, 28436, 36681 _ ; FruitCake, Blue Drink, Cupcake, Bunnies, Eggs, Pie, Delicious Cake
				, 6376, 21809, 21810, 21813, 36683 _ ; Party Spam
				, 6370, 21488, 21489, 22191, 26784, 28433 _ ; DP Removals
				, 15837, 21490, 30648, 31020 _ ; Tonics
				, 556, 18345, 21491, 37765, 21833, 28433, 28434 _ ; CC Shards, Victory Token, Wayfarer, Lunar Tokens, ToTs
				, 921, 922, 923, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 946, 948, 949, 950, 951, 952, 953, 954, 955, 956, 6532, 6533 ; Materials
			Return True
		Case 945
			$shardcount = $shardcount + 1
			GUICtrlSetData($shardlabel, $shardcount)
			Return True
		Case 2511 ; Gold
			Return True
		Case 5971, 22280 ; Obsidian Key and Fissure Scrolls
			Return True
		Case 146 ; Dyes
			Switch $c
				Case 10, 12 ; Only Black/White
					Return True
			EndSwitch
	EndSwitch
 Switch $r
        Case $RARITY_GOLD, $RARITY_PURPLE, $RARITY_BLUE
            Return True
        Case $RARITY_WHITE
            Return False
    EndSwitch
;	Return False ; Used when you don't want to pickup everything
EndFunc   ;==>canpickup

Func FindFoWScroll()
	Local $lItem
	For $I = 1 To 4
		For $j = 1 To DllStructGetData(GetBag($I), 'Slots')
			$lItem = GetItemBySlot($I, $j)
			Switch DllStructGetData($lItem, 'ModelID')
				Case 22280
					Return $lItem
				Case Else
					ContinueLoop
			EndSwitch
		Next
	Next
	Return 0
EndFunc   ;==>Find FoW Scrolls

Func UseItembyModelID($amodelid = 22280)
    Local $lItem
    For $lbag = 1 To 4
        For $lslot = 1 To $bag_slots[$lbag]
            $lItem = getitembyslot($lbag, $lslot)
            If DllStructGetData($lItem, "ModelID") == $amodelid Then 
                Return sendpacket(8, 119, DllStructGetData($lItem, "ID"))
            EndIf
        Next
    Next
    Return False
EndFunc   ;==>useitembymodelid

Func EnterFoW()
	CheckGoldLevel()
	CheckBagSpaceLeft()
	Sleep(GetPing()+500)
	If GetMapID() <> $town Then
		TravelTo($town)
	EndIf
	EnterKneel()
	WaitMapLoading($fow)
EndFunc   ;==>enterfow#

Func EnterKneel()
	If Not IsDisEmpty() Then
		Do
			rndtravel($town)
			rndsleep(200)
		Until isdisempty()
	EndIf
	If getmapid() = $chantry Then
		out("zoning to chantry")
		rndsleep(400)
		kneel(-9979, 1171)
	ElseIf getmapid() = $toa Then
		out("zoning to toa")
		rndsleep(200)
		kneel(-2522, 18731)
	EndIf
EndFunc   ;==>EnterKneel


Func moveandcheckdis($ax, $ay, $arandom = 65) ; for noids , replace this with moveto() in kneel,will change dis as soon as it detect s1
	Local $lBlocked = 0
	Local $lMe
	Local $lMapLoading = GetMapLoading(), $lMapLoadingOld
	Local $lDestX = $ax + Random(-$arandom, $arandom)
	Local $lDestY = $ay + Random(-$arandom, $arandom)
	$notalone = False
	Move($lDestX, $lDestY, 0)

	Do
		Sleep(100)
		$lMe = GetAgentByID(-2)

		If DllStructGetData($lMe, 'HP') <= 0 Then ExitLoop

		$lMapLoadingOld = $lMapLoading
		$lMapLoading = GetMapLoading()
		If $lMapLoading <> $lMapLoadingOld Then ExitLoop

		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
			$lBlocked += 1
			$lDestX = $ax + Random(-$arandom, $arandom)
			$lDestY = $ay + Random(-$arandom, $arandom)
			Move($lDestX, $lDestY, 0)
		EndIf
		If Not isdisempty() Then
			enterfow()
		EndIf
	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < 100 Or $lBlocked > 14

EndFunc   ;==>moveandcheckdis

Func kneel($one, $two)
	$Avatar = GetNearestNPCToCoords($one, $two) ;
	Local $FailPops = 0
	$spawned = False
	If Not $spawned Then
		moveto($one, $two)
		If DllStructGetData($Avatar, "PlayerNumber") <> $champion Then
			If $ensuresafety Then
				If Not isdisempty() Then
					enterfow()
				EndIf
			EndIf
			If getmapid() <> $town Then Return
			Out("kneeling")
			SendChat("kneel", "/")
			Local $lDeadlock = TimerInit()
			Do
				If getmapid() <> $town Then Return
				Sleep(1500) ; .
				$Avatar = GetNearestNPCToCoords($one, $two)

				If TimerDiff($lDeadlock) > 5000 Then
					moveto($one, $two)
					SendChat("kneel", "/")
					$lDeadlock = TimerInit()
					$FailPops += 1
				EndIf
			Until DllStructGetData($Avatar, "PlayerNumber") == $champion Or $FailPops = 2;
		EndIf

		If $FailPops > 2 Then
			$spawned = False
			If $town = $chantry Then
				$town = $toa
			Else
				$town = $chantry
			EndIf
			enterfow()
		Else
			$spawned = True
		EndIf
	EndIf
	If getmapid() <> $town Then Return
	If $spawned Then
		Out("entering fow")
		GoNpc($Avatar)
		Sleep(500)
		Dialog(0x85) ;
		Sleep(400)
		DIALOG(0x86)
		Sleep(100)
	EndIf
EndFunc   ;==>kneel

Func isdisempty()
	Local $peoplecount = -1
	$lAgentArray = GetAgentArray()
	For $i = 1 To $lAgentArray[0]
		$aAgent = $lAgentArray[$i]
		If isagenthuman($aAgent) Then
			$peoplecount += 1
		EndIf
	Next
	If $peoplecount > 0 Then

		If $town = $chantry Then
			out("dis not empty, going toa")
			$town = $toa
		Else
			out("dis not empty, going  chaantry")
			$town = $chantry
		EndIf
		Return False
	Else
		out("dis empty")
		Return True
	EndIf

EndFunc   ;==>isdisempty

Func isagenthuman($aAgent)
	If DllStructGetData($aAgent, 'Allegiance') <> 1 Then Return
	$thename = GetPlayerName($aAgent)
	If $thename = "" Then Return
	Return True
EndFunc   ;==>isagenthuman

Func RndTravel($aMapID)
	Local $UseDistricts = 11 ; 7=eu-only, 8=eu+int, 11=all(excluding America)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, us-en, int, asia-ko, asia-ch, asia-ja
	Local $Region[11] = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
	MoveMap($aMapID, $Region[$Random], 0, $Language[$Random])
	waitmaploading($aMapID)
EndFunc   ;==>RndTravel

#Region Getting Gold
Func CheckGoldLevel()
	If GetGoldCharacter() < 1000 Then
		If GetGoldStorage() > 20000 Then
			WithdrawGold(20000) ; Can change it to any amount you select by changing the stuff in the (). Should not be larger than the amount in the line above.
		EndIf
#ce
		TravelGH()
		RareMaterialTrader()
		StoreItems()
		Sleep(GetPing()+500)
		StoreGolds()
		Sleep(GetPing()+500)
		LeaveGH()
	EndIf
EndFunc   ;==>CheckGoldLevel

Func CheckBagSpaceLeft()
	If CountSlots() < 8 Then
		TravelGH()
		RareMaterialTrader()
		StoreItems()
		Sleep(GetPing()+500)
		StoreGolds()
		Sleep(GetPing()+500)
		LeaveGH()
	EndIf
EndFunc   ;==>CheckBagSpaceLeft

Func RareMaterialTrader()
	;~Time to Id and sell crap golds/purples/blues/whites
	CheckGuildHallMerchant()
	Inventory()
	;~Moves to the Rare Trader
	CheckGuildHallRareTrader()
	;~This section does the Selling
	SellShards(1)
	StoreItems()
	StoreGolds()
EndFunc   ;==>RareMaterialTrader

Func CheckGuildHallMerchant()
	Local $gMap = GetMapID()
	Out("Going to Merchant")
	Switch $gMap
		Case 4 ; Warriors
			MoveTo(4159, 8540)
			GoNearestNPCToCoords(5575, 9054)
		Case 5 ; Hunters
			MoveTo(5156, 7789)
			GoNearestNPCToCoords(4416, 5656)
		Case 6 ; Wizards
			MoveTo(4288, 8263)
			GoNearestNPCToCoords(3583, 9040)
		Case 52 ; Burning
			MoveTo(-4439, -2088)
			MoveTo(-4772, -362)
			MoveTo(-3637, 1088)
			GoNearestNPCToCoords(-2506, 988)
		Case 176 ; Frozen
			MoveTo(99, 2660)
			MoveTo(71, 834)
			GoNearestNPCToCoords(-299, 79)
		Case 177 ; Nomads
			GoNearestNPCToCoords(5129, 4748)
		Case 178 ; Druids
			GoNearestNPCToCoords(-2037, 2964)
		Case 179 ; Dead
			GoNearestNPCToCoords(-4066, -1203)
		Case 275 ; Weeping
			MoveTo(-3095, 8535)
			GoNearestNPCToCoords(-3988, 7588)
		Case 276 ; Jade
			MoveTo(8825, 3384)
			GoNearestNPCToCoords(10142, 3116)
		Case 359 ; Imperial
			MoveTo(1415, 12448)
			GoNearestNPCToCoords(1746, 11516)
		Case 360 ; Meditation
			MoveTo(-331, 8084)
			MoveTo(-1745, 8681)
			GoNearestNPCToCoords(-2197, 8076)
		Case 529 ; Uncharted
			GoNearestNPCToCoords(1503, -2830)
		Case 530 ; Wurms
			GoNearestNPCToCoords(8284, 3578)
		Case 537 ; Corrupted
			GoNearestNPCToCoords(-4670, 5630)
		Case 538 ; Solitude
			GoNearestNPCToCoords(2970, 1532)
	EndSwitch
EndFunc

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
		Case $Rarity_Gold, $Rarity_Purple, $Rarity_Blue ; Remove the gold one if you intend to store them unid and sell later
			Return True
		Case Else
			Return False
	EndSwitch
EndFunc   ;==>CanSell

Func Sell()
	Local $aitem, $lBag
	For $i = 1 To 4
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
			If $m = 22280 Then ; Fissure scrolls
				Return False
			Else
				Return True
			EndIf
		Case $Rarity_Purple
			If $m = 37765 Then ; Wayfarer Marks
				Return False
			Else
				Return True
			EndIf
		Case $Rarity_Blue
			Return True
		Case $Rarity_White
			If $m = 146 Or $m = 5971 Or $m = 5899 Or $m = 5900 Then ; Dyes, Obby keys, Sup ID kit, Sup Salvage kit
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

Func CheckGuildHallRareTrader()
	Local $gMap = GetMapID()
	Out("Going to Rare Trader")
	Switch $gMap
		Case 4 ; Warriors
			MoveTo(4108, 8404)
			MoveTo(3403, 6583)
			GoNearestNPCToCoords(3415, 5617)
		Case 5 ; Hunters
			GoNearestNPCToCoords(3267, 6557)
		Case 6 ; Wizards
			GoNearestNPCToCoords(3610, 9619)
		Case 52 ; Burning
			MoveTo(-3793, 1069)
			GoNearestNPCToCoords(-2798, -74)
		Case 176 ; Frozen
			MoveTo(71, 834)
			MoveTo(99, 2660)
			MoveTo(-385, 3254)
			GoNearestNPCToCoords(-983, 3195)
		Case 177 ; Nomads
			MoveTo(1930, 4129)
			GoNearestNPCToCoords(462, 4094)
		Case 178 ; Druids
			GoNearestNPCToCoords(-989, 4493)
		Case 179 ; Dead
			GoNearestNPCToCoords(-3415, -1658)
		Case 275 ; Weeping
			MoveTo(-3988, 7588)
			MoveTo(-3095, 8535)
			MoveTo(-2431, 7946)
			GoNearestNPCToCoords(-1618, 8797)
		Case 276 ; Jade
			MoveTo(8919, 3459)
			MoveTo(6789, 2781)
			GoNearestNPCToCoords(6566, 2248)
		Case 359 ; Imperial
			GoNearestNPCToCoords(759, 11465)
		Case 360 ; Meditation
			MoveTo(-2197, 8076)
			MoveTo(-1745, 8681)
			MoveTo(-331, 8084)
			MoveTo(422, 8769)
			GoNearestNPCToCoords(549, 9531)
		Case 529 ; Uncharted
			GoNearestNPCToCoords(2530, -2403)
		Case 530 ; Wurms
			MoveTo(8353, 2995)
			GoNearestNPCToCoords(6708, 3093)
		Case 537 ; Corrupted
			MoveTo(-4424, 5645)
			GoNearestNPCToCoords(-4443, 4679)
		Case 538 ; Solitude
			MoveTo(3172, 3728)
			MoveTo(3221, 4789)
			GoNearestNPCToCoords(3745, 4542)
	EndSwitch
EndFunc

Func SellShards($bagIndex)
	Local $ShardID = 945
	$bag = GetBag($bagIndex)
	$numOfSlots = DllStructGetData($bag, 'slots')
	For $I = 1 To $numOfSlots
		$item = GetItemBySlot($bagIndex, $I)
		If DllStructGetData($item, 'ID') <> 0 And DllStructGetData($item, 'ModelID') == $ShardID Then
			Do
				TraderRequestSell($item)
				Sleep(GetPing()+500); neccessary sleep for server response
				TraderSell()
			Until GetGoldCharacter() > 90000
		EndIf
	Next
EndFunc   ;==>Sell

Func GoNearestNPCToCoords($x, $y)
	Do
		RndSleep(250)
		$guy = GetNearestNPCToCoords($x, $y)
	Until DllStructGetData($guy, 'Id') <> 0
	ChangeTarget($guy)
	RndSleep(250)
	MoveEx(DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y'), 0)
	RndSleep(500)
	GoNPC($guy)
	RndSleep(250)
	Do
		RndSleep(500)
		MoveEx(DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y'), 0)
		RndSleep(500)
		GoNPC($guy)
		RndSleep(250)
		$Me = GetAgentByID(-2)
	Until ComputeDistance(DllStructGetData($Me, 'X'), DllStructGetData($Me, 'Y'), DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y')) < 250
	RndSleep(1000)
EndFunc   ;==>GoNearestNPCToCoords

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
#EndRegion funcs