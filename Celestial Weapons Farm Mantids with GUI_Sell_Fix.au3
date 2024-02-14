#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=C:\Users\vvc\Pictures\1449010880_2016-social-vimeo.ico
#AutoIt3Wrapper_Outfile=Skalflossen.Exe
#AutoIt3Wrapper_Compression=4
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****



;~ #include "GWA2Gigi.au3"
#include "GWA2.au3"
#include "GWA2_Headers.au3"
#include "botConstants.au3"
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

#Region GUI
Global Const $mainGui = GUICreate("Mantid", 350, 175)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_exit")
Global $Input
If $doLoadLoggedChars Then
	$Input = GUICtrlCreateCombo("", 8, 8, 129, 21)
		GUICtrlSetData(-1, GetLoggedCharNames())
Else
	$Input = GUICtrlCreateInput("character name", 8, 8, 129, 21)
EndIf

GUICtrlCreateLabel("Successful Run:", 8, 50, 70, 17)
Global Const $RunsLabel = GUICtrlCreateLabel($RunCount, 80, 50, 50, 17)
GUICtrlCreateLabel("Failed Run:", 8, 65, 70, 17)
Global Const $FailsLabel = GUICtrlCreateLabel($FailCount, 80, 65, 50, 17)
Global Const $Checkbox = GUICtrlCreateCheckbox("Stop Rendering", 8, 125, 129, 17)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetOnEvent(-1, "ToggleRendering")
Global Const $Button = GUICtrlCreateButton("Start", 8, 145, 131, 25)
	GUICtrlSetOnEvent(-1, "GuiButtonHandler")
Global Const $StatusLabel = GUICtrlCreateLabel("", 8, 190, 125, 17)

Global $GLOGBOX = GUICtrlCreateEdit("", 140, 8, 200, 165, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL))
GUICtrlSetColor($GLOGBOX, 65280)
GUICtrlSetBkColor($GLOGBOX, 0)
GUISetState(@SW_SHOW)

;~ Description: Handles the button presses
Func GuiButtonHandler()
	If $BotRunning Then
		GUICtrlSetData($Button, "Pauses after this round")
		GUICtrlSetState($Button, $GUI_DISABLE)
		$BotRunning = False
	ElseIf $BotInitialized Then
		GUICtrlSetData($Button, "Pause")
		$BotRunning = True
	Else
		Out("Starting")
		Local $CharName = GUICtrlRead($Input)
		If $CharName=="" Then
			If Initialize(ProcessExists("gw.exe"), True, True, True) = False Then
				MsgBox(0, "Error", "GW is not open")
				Exit
			EndIf
			WinSetTitle($mainGui, "", "Celestial Weapons Farm Bot_" & GetCharname())
		Else
			If Initialize($CharName, True, True, True) = False Then ;
				MsgBox(0, "Error", "Cannot find character: '"&$CharName&"'")
				Exit
			EndIf
			WinSetTitle($mainGui, "", "Celestial Weapons Farm Bot_" & $CharName)
		EndIf
		GUICtrlSetState($Checkbox, $GUI_ENABLE)
		GUICtrlSetData($Button, "Pause")
		$BotRunning = True
		$BotInitialized = True 
	EndIf
EndFunc
#EndRegion GUI

Out("Waiting for input")

While Not $BotRunning
	Sleep(100)
 WEnd
  If GetMapID() <> $MAP_ID_NAHPUI Then
		Out("Travelling to nahpui")
		TravelTo($MAP_ID_NAHPUI)

EndIf

SwitchMode(1)

While 1
   Global $Me = GetAgentById(-2)
   If GetIsDeadEx() Then ContinueLoop


   While CountFreeSlots() > 4
	  CombatLoop()
   WEnd

   Merchant()

WEnd
Func Kill()
   If GetIsDeadEx() Then Return
   Local $EnemyID3 = GetNearestAgentToCoords(-00253.713897, -14348.154296)
   If IsRecharged($dc) Then
	  UseSkillEx($dc, $EnemyID3)
   Else
	  MoveAggroing(-00253.713897, -14348.154296)
   EndIf
   Attack($EnemyID3)
   UseSkill($eoe, -2)
   WaitFor(100)
   UseSkillStance($whirling)
   WaitFor(10000)
EndFunc
Func WaitFor($lMs)
   If GetIsDeadEx() Then Return
   Local $lTimer = TimerInit()
   Do
	  RndSleep(100)
	  If GetIsDeadEx() Then Return
	  If IsRecharged($sf) Then
		 UseSkillEx($sf)
	  EndIf
   Until TimerDiff($lTimer) > $lMs
EndFunc
Func MoveAggroingNoDash($lDestX, $lDestY, $lRandom = 250)
   If GetIsDeadEx() Then Return
   Local $lMe = GetAgentById(-2)
   Local $lBlocked = 0
   If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
	  $lBlocked += 1
	  Move($lDestX, $lDestY)
   EndIf
   If $lBlocked = 5 Then
	  StrafeLeft(1)
	  WaitFor(500)
	  StrafeLeft(0)
	  AntiBlock()
   EndIf
   Do
	  $lMe = GetAgentByID(-2)
	  RndSleep(100)
	  Move($lDestX, $lDestY, $lRandom)
	  If GetIsDeadEx() Then Return
	  If IsRecharged($sf) Then
		 UseSkillEx($sf)
	  EndIf
    Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < $lRandom * 1.5

EndFunc
Func SpecialMoves()
   If GetIsDeadEx() Then Return
   Do
     If GetIsDeadEx() Then Return
	 Local $NearestEnemy = GetNearestEnemyToAgent(-2)
	 Local $DistanceToEnemy = GetDistance($NearestEnemy)
	 Move(000561.803222, -15936.115234)
	 RndSleep(100)
   Until $DistanceToEnemy < 1300
   UseSkillStance($sq)
   UseSkillEx($sod)
   UseSkillEx($sf)
   Local $EnemyID1 = GetNearestAgentToCoords(000906.164184, -16503.773437)
   If GetIsDeadEx() Then Return
   UseSkillEx($dc, $EnemyID1)
   Local $lDeadlock = TimerInit()
   Do
     If GetIsDeadEx() Then Return
	 Sleep(50)
	 If TimerDiff($lDeadlock) > 5000 Then Return
   Until IsRecharged($dc) == False
   Local $EnemyID2 = GetNearestAgentToCoords(-01086.659667, -16456.222656)
   ChangeTarget($EnemyID2)
   Do
     Local $lMe = GetAgentById(-2)
     If GetIsDeadEx() Then Return
	 RndSleep(100)
	 Move(-01086.659667, -16456.222656)
	 If IsRecharged($dash) Then
	    UseSkillStance($dash)
	 EndIf
	 Local $Distance = GetDistance(-1, -2)
   Until $Distance < 900 Or ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), -01086.659667, -16456.222656) < 250
EndFunc

Func SpecialMoves2()
   If GetIsDeadEx() Then Return
   Local $EnemyID4 = GetNearestAgentToCoords(-01386.235717, -14546.714843)
   ChangeTarget($EnemyID4)
   Do
     If GetIsDeadEx() Then Return
	 RndSleep(100)
	 Local $lMe = GetAgentByID(-2)
	 Move(-01386.235717, -14546.714843)
	 ;If IsRecharged($dash) Then
	    ;UseSkillStance($dash)
	 ;EndIf
	 Local $Distance2 = GetDistance(-1, -2)
   Until $Distance2 < 900 Or ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), -01386.235717, -14546.714843) < 250
EndFunc
Func CountFreeSlots()
   Local $temp = 0
   Local $bag
   $bag = GetBag(1)
   $temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
   $bag = GetBag(2)
   $temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
   $bag = GetBag(3)
   $temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
   Return $temp
EndFunc
; Uses a skill
; It will not use if I am dead, if the skill is not recharged, or if I don't have enough energy for it
; It will sleep until the skill is cast, then it will wait for aftercast.


Func UseSkillStance($aSkillSlot, $aTarget = -2)
   Local $lDeadlock = TimerInit()
   If GetIsDeadEx() Then Return
   If Not IsRecharged($aSkillSlot) Then Return
	$lDeadlock = TimerInit()
	USESKILL($aSkillSlot, $aTarget)
	Do
		Sleep(50)
		If GetIsDeadEx() = True Then Return
     Until GetSkillBarSkillRecharge($aSkillSlot) <> 0 Or TimerDiff($lDeadlock) > 6000
EndFunc

;~ Func IsRecharged($lSkill)
;~ 	Return GetSkillBarSkillRecharge($lSkill)==0
;~ EndFunc

Func MoveRunning($lDestX, $lDestY, $lRandom = 250)
   If GetIsDeadEx() Then Return
   Local $lBlocked = 0

   Do
	  If GetIsDeadEx() Then Return
	  RndSleep(100)
	  Move($lDestX, $lDestY, $lRandom)
	  Local $lMe = GetAgentByID(-2)
	  If IsRecharged($dash) Then
		 UseSkillStance($dash)
	  EndIf
    Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < $lRandom * 1.5

EndFunc

;~ If GetMapLoading() == $INSTANCETYPE_OUTPOST Then LoadSkillTemplate("OAej8NiMJTOOdilTXTNTrl3lNQA")
Sleep(2000)

While True
	If $RunCount = 0 and $FailCount = 0 then
	  LoadSkillTemplate($Template)
	  sleep(500)
	EndIf

	If GetMapId() <> $MAP_ID_NAHPUI Then
		RndTravel($MAP_ID_NAHPUI) ;town MAP ID
		WaitMapLoading($MAP_ID_WAJJUN)
	EndIf

	If Not $BotRunning Then
		Out("Paused")
		GUICtrlSetState($Button, $GUI_ENABLE)
		GUICtrlSetData($Button, "Start")
		While Not $BotRunning
			Sleep(100)
		WEnd
	EndIf

	CombatLoop()

WEnd

Func CombatLoop()

	 $Me = GetAgentById(-2)

   MoveTo(-22519.162109375, 11482.9755859375)

   Move(-21799.478515, 014847.574218)
   WaitMapLoading($MAP_ID_WAJJUN)
   Global $Me = GetAgentById(-2)

   Out("Running to mantids")
   MoveRunning(007330.191406, -18014.404296)
   MoveRunning(003021.682373, -16771.634765)

   Out("Getting aggro")
   SpecialMoves()
   MoveAggroing(-00860.679138, -15715.822265)
   SpecialMoves2()
   MoveAggroingNoDash(-00882.065551, -15936.000000)
   MoveAggroingNoDash(-00860.679138, -14909.244140)
   MoveAggroingNoDash(-00620.464904, -14909.244140, 5)
   UseSkillStance($soh)
   MoveAggroingNoDash(-00479.886474, -14272.292968)

   Out("Balling")
   MoveAggroingNoDash(001169.562866, -14196.305664, 5)
   WaitFor(1500)
   UseSkillStance($dash)
   Sleep(50)
   ReverseDirection()
   WaitFor(3000)

   Out("Killing")
   Kill()

   Out("Looting")
   PickUpLoot()

   Out("Returning to Outpost")
   If GetIsDead(-2) Then
		$FailCount += 1
		GUICtrlSetData($FailsLabel, $FailCount)
	Else
		$RunCount += 1
		GUICtrlSetData($RunsLabel, $RunCount)
	EndIf

   While GetMapID() = $MAP_ID_WAJJUN
	 Resign()
	 Sleep(3500)
	 ReturnToOutpost()
	 WaitMapLoading($MAP_ID_NAHPUI)
   WEnd
EndFunc

Func killDerv($recastVos = False)
	UseSkillEx($SAND_SHARDS, -2)
	UseSkillEx($VOW_OF_STRENGTH, -2)
	While GetNumberOfFoesInRangeOfAgent(-2, 1250) > 0
		TargetNearestEnemy()
		Sleep(250)
		ChangeTarget(-1)
		If IsRecharged($FARMERS) Then
			UseSkillEx($FARMERS, -1)
		EndIf
		Attack(-1)
		Sleep(100)
		If IsRecharged($SAND_SHARDS) Then
			UseSkillEx($SAND_SHARDS, -2)
		EndIf
		If $recastVos = True And IsRecharged($VOW_OF_STRENGTH) Then
			UseSkillEx($VOW_OF_STRENGTH, -2)
		EndIf
	WEnd
	Sleep(200)
EndFunc

Func MoveAggroing($lDestX, $lDestY, $lRandom = 150)
	If GetIsDead(-2) Then Return

	Local $lMe, $lAgentArray
	Local $lBlocked

	Local $lAngle
	Local $stuckTimer = TimerInit()

	Move($lDestX, $lDestY, $lRandom)
	Do
		RndSleep(50)

		$lMe = GetAgentByID(-2)

		$lAgentArray = GetAgentArray(0xDB)

		If GetIsDead($lMe) Then Return False

		If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then

			$lBlocked += 1
			If $lBlocked < 4 Then
				Move($lDestX, $lDestY, $lRandom)
			Elseif $lBlocked < 8 then
				$lAngle += 40
				Move(DllStructGetData($lMe, 'X')+300*sin($lAngle), DllStructGetData($lMe, 'Y')+300*cos($lAngle))
			elseif $lBlocked >= 8 Then
				killDerv()
			EndIf


		elseIf $lBlocked > 0 Then

			If TimerDiff($ChatStuckTimer) > 3000 Then	; use a timer to avoid spamming /stuck
				SendChat("stuck", "/")
				$ChatStuckTimer = TimerInit()
			EndIf
			$lBlocked = 0
			TargetNearestEnemy()
			sleep(1000)
			If GetDistance() > 1100 Then ; target is far, we probably got stuck.
				If TimerDiff($ChatStuckTimer) > 3000 Then ; dont spam
					SendChat("stuck", "/")
					$ChatStuckTimer = TimerInit()
					RndSleep(GetPing())
				EndIf
			EndIf
		EndIf

	Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < $lRandom*1.5
	Return True
EndFunc

;Func quitround()
	;if TimerDiff($SkaleFinTimer) > $StuckTimeLimit then
	;	$FailCount += 1
	;	GUICtrlSetData($FailsLabel, $FailCount)
	;	Out("Starting Next Round")
	;	Sleep(Random(3000,5000))
	;	Resign()
	;	Sleep(Random(5000,6000))
	;	ReturnToOutpost()
	;	WaitMapLoading()
	;endif
;EndFunc

; Returns a good target for watrels
; Takes the agent array as returned by GetAgentArray(..)
Func GetGoodTarget(Const ByRef $lAgentArray)
	Local $lMe = GetAgentByID(-2)
	For $i=1 To $lAgentArray[0]
		If DllStructGetData($lAgentArray[$i], "Allegiance") <> 0x3 Then ContinueLoop
		If DllStructGetData($lAgentArray[$i], "HP") <= 0 Then ContinueLoop
		If GetDistance($lMe, $lAgentArray[$i]) > $RANGE_NEARBY Then ContinueLoop
		If GetHasHex($lAgentArray[$i]) Then ContinueLoop
		If Not GetIsEnchanted($lAgentArray[$i]) Then ContinueLoop
		Return DllStructGetData($lAgentArray[$i], "ID")
	Next
EndFunc



; Checks if skill given (by number in bar) is recharged. Returns True if recharged, otherwise False.


;~ Description: standard pickup function, only modified to increment a custom counter when taking stuff with a particular ModelID
Func PickUpLoot()
Local $lAgent
	Local $lItem
	Local $lDeadlock
	If GetIsDeadEx() Then Return
	For $i = 1 To GetMaxAgents()
		If GetIsDeadEx() Then Return
		$lAgent = GetAgentByID($i)
		If DllStructGetData($lAgent, 'Type') <> 0x400 Then ContinueLoop
		$lItem = GetItemByAgentID($i)
		If CanPickup($lItem) Then
			PickUpItem($lItem)
			$lDeadlock = TimerInit()
			While GetAgentExists($i)
				Sleep(100)
				If GetIsDeadEx() Then Return
				If TimerDiff($lDeadlock) > 10000 Then ExitLoop
			WEnd
		EndIf
	Next

EndFunc   ;==>PickUpLoot

; Checks if should pick up the given item. Returns True or False
Func CanPickUp($aItem)
Local $lModelID = DllStructGetData(($aItem), 'ModelID')
	Local $lRarity = GetRarity($aItem)
	If $lModelID == 2511 And GetGoldCharacter() < 99000 Then Return True	; gold coins (only pick if character has less than 99k in inventory)
	If $lModelID > 21785 And $lModelID < 21806 Then Return True	; Elite/Normal Tomes
    If $lRarity == $RARITY_GOLD 			Then Return True
	If $lModelID == $ITEM_ID_DYES Then	; if dye
		Switch DllStructGetData($aItem, "ExtraID")
			Case $ITEM_EXTRAID_BLACKDYE, $ITEM_EXTRAID_WHITEDYE ; only pick white and black ones
				Return True
			Case Else
				Return False
		EndSwitch
	 EndIf
	 If StackableReturnTrue($lModelID) Then Return True

	Return False
 EndFunc   ;==>

 Func Merchant()
   GoToMerchant()
   Ident(1)
   Ident(2)
   Ident(3)
   Sell(1)
   Sell(2)
   Sell(3)
EndFunc

Func GoToMerchant()
   Local $npc = GetNearestNPCToCoords(-18693, 10132)
   GoToNPC($npc)
EndFunc

;~ Identify all items in selected bags
Func IdentifyBags($UseBags = 4)
	For $lBag = 1 To $UseBags
		IdentifyBag($lBag)
	Next
EndFunc   ;==>IdentifyBags

Func IDENT($bagIndex)
    Local $bag = GetBag($bagIndex)
    Local $aitem  ; Declare $aitem here
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

Func Sell($BAGINDEX)
	Local $AITEM
	Local $BAG = GETBAG($BAGINDEX)
	Local $NUMOFSLOTS = DllStructGetData($BAG, "slots")
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "Id") == 0 Then ContinueLoop
		If CANSELL($AITEM) Then
			SELLITEM($AITEM)
		EndIf
		Sleep(GetPing()+250)
	Next
EndFunc

Func CanSell($aitem)
	local $m = DllStructGetData($aitem, 'ModelID')
	local $i = DllStructGetData($aitem, 'extraId')
	If $m = 0 Then
		Return False
	ElseIf $m > 21785 And $m < 21806 Then ;Elite/Normal Tomes
		Return False
	ElseIf $m = 146 Then
		If $i = 10 OR $i = 12 Then ;black and white
			Return False
		Else
			Return True
		EndIf
	ElseIf $m =  6533 Then
		Return False    ;jade
	ElseIf $m =  19198 Then
		Return False    ;jade
	ElseIf $m =  934 Then
		Return False    ;jade
	ElseIf $m =  929 Then
		Return False    ;jade
	ElseIf $m = 22751 Then
		return False
	Else
		Return True
	EndIf
EndFunc   ;==>CanSell

Func ValEquipReturnTrue($aItem)
   Local $ModStruct = GetModStruct($aItem)
   Local $lModelID = DllStructGetData($aItem, 'ModelID')
   Local $WeaponType = DllStructGetData($aItem, 'Type')
   If IsGoodSkin($lModelID) Then Return True
   If IsMartial($WeaponType) Then
	  If IsDualVamp($ModStruct) Then Return True
	  If IsDualZealous($ModStruct) Then Return True
	  Local $lReq = GetItemReq($aItem)
	  If $lReq == 9 Then
		 If IsStrengthAndHonor($ModStruct) Or IsGuidedByFate($ModStruct) Or IsDanceWithDeath($ModStruct) Or IsIHaveThePower($ModStruct) Then Return True
	  EndIf
   EndIf
   If IsStaff($WeaponType) Then
	  If IsHCT20($ModStruct) Then Return True
	  Local $lReq = GetItemReq($aItem)
	  If $lReq == 9 Then
		 If IsHaleAndHearty($ModStruct) Or IsHaveFaith($ModStruct) Or IsHCT10($ModStruct) Then Return True
	  EndIf
   EndIf
   If IsWandFocusShield($WeaponType) Then
	  If HasTwoUsefulMods($ModStruct) Then Return True
   EndIf
EndFunc

Func IsGoodSkin($lModelID)
   If $lModelID == $CeleStr Then Return True
   If $lModelID == $CeleTact Then Return True
   If $lModelID == $BladedShieldStr Then Return True
   If $lModelID == $BladedShieldTact Then Return True
   If $lModelID == $FanFastCast Then Return True
   If $lModelID == $FanSoulReap Then Return True
   If $lModelID == $FanEnergyStorage Then Return True
   If $lModelID == $FanDivine Then Return True
   If $lModelID == $FanSpawning Then Return True
   If $lModelID == $JugDivine Then Return True
   If $lModelID == $JugSoul Then Return True
   If $lModelID == $JugES Then Return True
   If $lModelID == $CeleStaff Then Return True
   If $lModelID == $CockaStaff Then Return True
   If $lModelID == $EternalFlameW Then Return True
   If $lModelID == $KoiScepterAir Then Return True
   If $lModelID == $WailingStaff Then Return True
   If $lModelID == $BanefulScepter Then Return True
   If $lModelID == $DarkTendrilStaff Then Return True
   If $lModelID == $CeleScepter Then Return True
   If $lModelID == $PaperLantern Then Return True
   If $lModelID == $DivineScroll Then Return True
   If $lModelID == $CanthanFireStaff Then Return True
   If $lModelID == $CanthanWaterStaff Then Return True
   If $lModelID == $CanthanAirStaff Then Return True
   If $lModelID == $EyeFlameArtifact Then Return True
   If $lModelID == $CanthanEarthStaff Then Return True
   If $lModelID == $DivineStaff Then Return
EndFunc

Func IsMartial($WeaponType)
   If $WeaponType == 2 Then Return True
   If $WeaponType == 5 Then Return True
   If $WeaponType == 15 Then Return True
   If $WeaponType == 27 Then Return True
   If $WeaponType == 32 Then Return True
EndFunc

Func IsStaff($WeaponType)
   If $WeaponType == 26 Then Return True
EndFunc

Func IsWandFocusShield($WeaponType)
   If $WeaponType == 22 Then Return True
   If $WeaponType == 12 Then Return True
   If $WeaponType == 24 Then Return True
EndFunc

Func IsDualVamp($ModStruct)
   Local $Vampiric3 = StringInStr($ModStruct, "00032825", 0 ,1)
   Local $Vampiric5 = StringInStr($ModStruct, "00052825", 0 ,1)
   Local $HealthRegen = StringInStr($ModStruct, "0100E820", 0 ,1) ; Health regeneration -1
   If (($HealthRegen - $Vampiric3 - $Vampiric5) > 0) Then Return True
EndFunc

Func IsDualZealous($ModStruct)
   Local $Zealous = StringInStr($ModStruct, "01001825", 0 ,1) ; Damage +15%
   Local $EnergyRegen = StringInStr($ModStruct, "0100C820", 0 ,1) ; Energy regeneration -1
   If (($EnergyRegen - $Zealous) > 0) Then Return True
EndFunc

Func IsStrengthAndHonor($ModStruct)
   Local $StrengthAndHonor = StringInStr($ModStruct, "0F327822", 0 ,1) ; Damage +15% (while Health is above 50%)
   If $StrengthAndHonor > 0 Then Return True
EndFunc

Func IsGuidedByFate($ModStruct)
   Local $GuidedByFate = StringInStr($ModStruct, "0F006822", 0 ,1) ; Damage +15% (while Enchanted)
   If $GuidedByFate > 0 Then Return True
EndFunc

Func IsDanceWithDeath($ModStruct)
   Local $DanceWithDeath = StringInStr($ModStruct, "0F00A822", 0 ,1) ; Damage +15% (while in a Stance)
   If $DanceWithDeath > 0 Then Return True
EndFunc

Func IsIHaveThePower($ModStruct)
   Local $EnergyAlways5 = StringInStr($ModStruct, "0500D822", 0 ,1) ; Energy +5
   If $EnergyAlways5 > 0 Then Return True
EndFunc

Func IsHCT20($ModStruct)
   Local $aHCT20[19] = ["01141822", "02141822", "03141822", "04141822", "05141822", "06141822", "07141822", "08141822", "09141822", "0A141822", "0B141822", "0D141822", "0E141822", "0F141822", "10141822", "20141822", "21141822", "22141822", "24141822"]
   Local $NumHCT20 = 18
   For $i = 0 to $NumHCT20
	  Local $lHCT20 = StringInStr($ModStruct, $aHCT20[$i], 0 ,1) ; Halves casting time of spells of item's attribute (Chance: 20%)
	  If $lHCT20 > 0 Then Return True
   Next
EndFunc

Func IsHaleAndHearty($ModStruct)
   Local $HaleAndHearty = StringInStr($ModStruct, "05320823", 0 ,1) ; Energy +5 (while health is above 50%)
	If $HaleAndHearty > 0 Then Return True
EndFunc

Func IsHaveFaith($ModStruct)
   Local $HaveFaith = StringInStr($ModStruct, "0500F822", 0 ,1) ; Energy +5 (while Enchanted)
   If $HaveFaith > 0 Then Return True
EndFunc

Func IsHCT10($ModStruct)
   Local $HCT10 = StringInStr($ModStruct, "000A0822", 0 ,1) ; Halves casting time of spells (Chance: 10%)
   If $HCT10 > 0 Then Return True
EndFunc

Func HasTwoUsefulMods($ModStruct)
   Local $UsefulMods = 0
   Local $aModStrings[159] = ["05320823", "0500F822", "0F00D822", "000A0822", "000AA823", "00140828", "00130828", "0A0018A1", "0A0318A1", "0A0B18A1", "0A0518A1", "0A0418A1", "0A0118A1", "0A0218A1", "02008820", "0200A820", "05147820", "05009821", "000AA823", "00142828", "00132828", "0100E820", "000AA823", "00142828", "00132828", "002D6823", "002C6823", "002B6823", "002D8823", "002C8823", "002B8823", "001E4823", "001D4823", "001C4823", "14011824", "13011824", "14021824", "13021824", "14031824", "13031824", "14041824", "13041824", "14051824", "13051824", "14061824", "13061824", "14071824", "13071824", "14081824", "13081824", "14091824", "13091824", "140A1824", "130A1824", "140B1824", "130B1824", "140D1824", "130D1824", "140E1824", "130E1824", "140F1824", "130F1824", "14101824", "13101824", "14201824", "13201824", "14211824", "13211824", "14221824", "13221824", "14241824", "13241824", "0A004821", "0A014821", "0A024821", "0A034821", "0A044821", "0A054821", "0A064821", "0A074821", "0A084821", "0A094821", "0A0A4821", "01131822", "02131822", "03131822", "04131822", "05131822", "06131822", "07131822", "08131822", "09131822", "0A131822", "0B131822", "0D131822", "0E131822", "0F131822", "10131822", "20131822", "21131822", "22131822", "24131822", "01139823", "02139823", "03139823", "04139823", "05139823", "06139823", "07139823", "08139823", "09139823", "0A139823", "0B139823", "0D139823", "0E139823", "0F139823", "10139823", "20139823", "21139823", "22139823", "24139823"]
   Local $NumMods = 158
   For $i = 0 to $NumMods
	  Local $ModStr = StringInStr($ModStruct, $aModStrings[$i], 0, 1);
	  If ($ModStr <= 0) Then
		 $UsefulMods += 1
	  EndIf
   Next
   If $UsefulMods == 2 Then Return True
EndFunc

Func StackableReturnTrue($lModelID)
    ;If $lModelID == 954						Then Return True //zangen
    ;If $lModelID == 854						Then Return True //und chitin
    If $lModelID == $ITEM_ID_LOCKPICKS 		Then Return True
    If $lModelID == $ITEM_ID_ID_KIT			Then Return True
    If $lModelID == $ITEM_ID_MEYES			Then Return True
    If $lModelID == $ITEM_ID_RUBY			Then Return True
    If $lModelID == $ITEM_ID_AMBER			Then Return True
	; ==== Pcons ====
	If $lModelID == $ITEM_ID_TOTS 			Then Return True
	If $lModelID == $ITEM_ID_GOLDEN_EGGS 	Then Return True
	If $lModelID == $ITEM_ID_BUNNIES 		Then Return True
	If $lModelID == $ITEM_ID_GROG 			Then Return True
	If $lModelID == $ITEM_ID_CLOVER 		Then Return True
	If $lModelID == $ITEM_ID_PIE			Then Return True
	If $lModelID == $ITEM_ID_CIDER			Then Return True
	If $lModelID == $ITEM_ID_POPPERS		Then Return True
	If $lModelID == $ITEM_ID_ROCKETS		Then Return True
	If $lModelID == $ITEM_ID_CUPCAKES		Then Return True
	If $lModelID == $ITEM_ID_SPARKLER		Then Return True
	If $lModelID == $ITEM_ID_HONEYCOMB		Then Return True
	If $lModelID == $ITEM_ID_VICTORY_TOKEN	Then Return True
	If $lModelID == $ITEM_ID_LUNAR_TOKEN	Then Return True
	If $lModelID == $ITEM_ID_HUNTERS_ALE	Then Return True
	If $lModelID == $ITEM_ID_LUNAR_TOKENS	Then Return True
	If $lModelID == $ITEM_ID_KRYTAN_BRANDY	Then Return True
	If $lModelID == $ITEM_ID_BLUE_DRINK		Then Return True
EndFunc

 Func GetIsDeadEx()
	Local $lMe = GetAgentByID(-2)
	If GetIsDead($lMe) Then Return True
    If ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), 003953.247802, -18649.464843) < 1000 Then Return True
EndFunc

;~ Description: Toggle rendering and also hide or show the gw window
;~ Func ToggleRendering()
;~ 	$RenderingEnabled = Not $RenderingEnabled
;~ 	If $RenderingEnabled Then
;~ 		EnableRendering()
;~ 		WinSetState(GetWindowHandle(), "", @SW_SHOW)
;~ 	Else
;~ 		DisableRendering()
;~ 		WinSetState(GetWindowHandle(), "", @SW_HIDE)
;~ 		ClearMemory()
;~ 	EndIf
;~ EndFunc   ;==>ToggleRendering

;~ Description: Print to console with timestamp
Func Out($TEXT)
	;If $BOTRUNNING Then FileWriteLine($FLOG, @CRLF & "[" & @HOUR & ":" & @MIN & ":" & @SEC & "] " & $TEXT)
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

;=================================================================================================
; Function:			SetDisplayedTitle($aTitle = 0)
; Description:		Set the currently displayed title.
; Parameter(s):		Parameter = $aTitle
;								No Title		= 0x00
;								Spearmarshall 	= 0x11
;								Lightbringer 	= 0x14
;								Asuran 			= 0x26
;								Dwarven 		= 0x27
;								Ebon Vanguard 	= 0x28
;								Norn 			= 0x29
;; Requirement(s):	GW must be running and Memory must have been scanned for pointers (see Initialize())
; Return Value(s):	Returns displayed Title
; Author(s):		Skaldish
;=================================================================================================

;~ Func SetDisplayedTitle($aTitle = 0)
;~ 	If $aTitle Then
;~ 		Return SendPacket(0x8, 0x50, $aTitle)
;~ 	Else
;~ 		Return SendPacket(0x4, 0x51)
;~ 	EndIf
;~ EndFunc   ;==>SetDisplayedTitle

Func RndTravel($aMapID)
	Local $UseDistricts = 11
	; 7=eu, 8=eu+int, 11=all(incl. asia)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, int, asia-ko, asia-ch, asia-ja
	Local $ComboDistrict[11][2]=[[2, 0],[2, 2],[2, 3],[2, 4], [2, 5],[2, 9],[2, 10],[-2, 0],[1, 0], [3, 0], [4, 0]]
	;Local $Region[11] = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	;Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
	MoveMap($aMapID, $ComboDistrict[$Random][0], 0, $ComboDistrict[$Random][1])
	WaitMapLoading($aMapID, 30000)
	Sleep(GetPing() + 1500)
EndFunc ;==>RndTravel

;~ Func _PurgeHook()
;~    _ToggleHook()
;~    Sleep(Random(2000,2500))
;~    _ToggleHook()
;~ EndFunc   ;==>_PurgeHook

Func _ToggleHook()
   $RenderingEnabled = Not $RenderingEnabled
   If $RenderingEnabled Then
	  EnableRendering()
   Else
	  DisableRendering()
	  ClearMemory()
   EndIf
EndFunc
