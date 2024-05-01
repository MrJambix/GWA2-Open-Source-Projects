; Create by Globeul back in 2009/10
; Kept alive by the community
; Moment of Silent for those no longer part of the Guild Wars Community.
;This Version is UpKept by MrJambix
#RequireAdmin
#AutoIt3Wrapper_UseX86=y

#include "GWA2.au3"
#include "GWA2_Headers.au3"
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include "GWA_AddOn.au3"
#include "CommonFunction.au3"
#include "VQLux.au3"
#include "VQKurz.au3"
#include "VQDel.au3"
#include "VQAsura.au3"
#include "VQNorn.au3"
#include "VQVang.au3"
#include "VQSS.au3"
#include "VQSSLB.au3"
#include "VQTHunter.au3"
#include "Skills.au3"


Global $DeadOnTheRun = 0
Global $GWA_CONST_UnyieldingAura = 268
Global $SS_begin, $LB_begin, $Asura_begin, $Deldrimor_begin, $Norn_begin, $Vanguard_begin, $Kurzick_begin, $Luxon_begin
Global $Map_To_Zone, $Map_To_Farm
Global $SS_Outpost = 396
Global $Deldrimor_Outpost = 639
Global $Asura_Outpost = 640
Global $Norn_Outpost = 645
Global $Vanguard_Outpost = 648
Global $SS_LB_Outpost = 545
Global $Treasure_Hunter_Outpost = 675
Global $Treasure_Huter_Map = 499
Global $Kurzick_Outpost = 77
Global $Luxon_Outpost = 389
Global $areaFerndale = 210
Global $what_we_donate = 0
Global $Abandonquest = False
Global $SS_Map = 395
Global $Deldrimor_Map = 781
Global $Asura_Map = 569
Global $Norn_Map = 553
Global $Vanguard_Map = 647
Global $SS_LB_Map = 444
Global $Kurzick_Map = 210
Global $Luxon_Map = 200
Global $RenderingEnabled = True
Global $selectedHeroNames[7]


While 1
If $g_bRun Then
	If $boolrun = true Then
		If $NumberRun = 0 Then ;first run
			AdlibRegister("status", 1000)
			$TimerTotal = TimerInit()
			FileOpen($File)
			$SS_begin = GetSunspearTitle()
			$LB_begin = GetLightbringerTitle()
			$Asura_begin = GetAsuraTitle()
			$Deldrimor_begin = GetDeldrimorTitle()
			$Norn_begin = GetNornTitle()
			$Vanguard_begin = GetVanguardTitle()
			$Kurzick_begin =  GetKurzickFaction()
			$Luxon_begin = GetLuxonFaction()

			If $Title = "Asura" Then
				$Map_To_Zone = $Asura_Outpost
				$Map_To_Farm = $Asura_Map
			ElseIf $Title = "Deldrimor" Then
				$Map_To_Zone = $Deldrimor_Outpost
				$Map_To_Farm = $Deldrimor_Map
			ElseIf $Title = "Vanguard" Then
				$Map_To_Zone = $Vanguard_Outpost
				$Map_To_Farm = $Vanguard_Map
			ElseIf $Title = "Norn" Then
				$Map_To_Zone = $Norn_Outpost
				$Map_To_Farm = $Norn_Map
			ElseIf $Title = "Kurzick" Then
				$Map_To_Zone = $Kurzick_Outpost
				$Map_To_Farm = $Kurzick_Map
			ElseIf $Title = "Luxon" Then
				$Map_To_Zone = $Luxon_Outpost
				$Map_To_Farm = $Luxon_Map
			ElseIf $Title = "SS and LB" Then
				$Map_To_Zone = $SS_LB_Outpost
				$Map_To_Farm = $SS_LB_Map
				$totalskills = 6
			ElseIf $Title = "SS" Then
				$Map_To_Zone = $SS_Outpost
				$Map_To_Farm = $SS_Map
			ElseIf $Title = "Treasure Hunter" then
				$Map_To_Zone = $Treasure_Hunter_Outpost
				$Map_To_Farm = $Treasure_Huter_Map
			EndIf

			If $Title = "Luxon" and $Bool_Donate Then
    MsgBox(48, "Warning", "You ticked the donate button. Be sure you are in a Luxon guild and you are also able to speak to the merchant in the outpost.")
ElseIf $Title = "Kurzick" and $Bool_Donate Then
    MsgBox(48, "Warning", "You ticked the donate button. Be sure you are in a Kurzick guild and you are also able to speak to the merchant in the outpost.")
ElseIf $Title = "SS and LB" Then
				MsgBox(48, "Warnning", "You choose SS and LB bot, dont forget that you need the 2 quest for that and rune of doom in inventory.")
			EndIf
		EndIf

		If GetMapID() <> $Map_To_Zone Then
			CurrentAction("Moving to Outpost")
			local $out = 0
			Do
				RndTravel($Map_To_Zone)
				WaitForLoad()
				$out = $out + 1
			Until GetMapID() = $Map_To_Zone or $out = 6
		EndIf
		Sleep(3000)
		If $Title = "Kurzick" Then
			If FactionCheckKurzick() Then TurnInFactionKurzick()
		ElseIf $Title = "Luxon" Then
			If FactionCheckLuxon() Then TurnInFactionLuxon()
		EndIf

		CurrentAction("Begin run number " & $NumberRun)
		If $Bool_HM Then
			SwitchMode(1)
		Else
			SwitchMode(0)
		EndIf
			
		If CheckIfInventoryIsFull() then SellItemToMerchant()

		GoOut()

		VQ()
		
		$NumberRun = $NumberRun +1
	EndIf
	Sleep(50)
EndIf
WEnd

Func FactionCheckKurzick()
	CurrentAction("Checking faction")
	RndSleep(1250)
	If GetKurzickFaction() > GetMaxKurzickFaction() - 16000 Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func TurnInFactionKurzick()
	CurrentAction("Turning in faction")
	RndSleep(1000)
	GoNearestNPCToCoords(5390, 1524)

	$beforedone = GetKurzickFaction()

	If $Bool_Donate Then
		Do
			CurrentAction("Donate")
			DonateFaction("kurzick")
			RndSleep(500)
		Until GetKurzickFaction() < 5000
	Else
		CurrentAction("Donating Kurzick Faction for Amber")
		Dialog(131)
		RndSleep(550)
		$temp = Floor(GetKurzickFaction() / 5000)
		$id = 8388609 + ($temp * 256)
		Dialog($id)
        RndSleep(550)
	EndIf

	$after_donate = GetKurzickFaction()
	$what_we_donate = $beforedone - $after_donate + $what_we_donate
	RndSleep(500)
EndFunc


Func FactionCheckLuxon()
	CurrentAction("Check Luxon point atm")
	RndSleep(250)

	If GetLuxonFaction() > GetMaxLuxonFaction() - 16000 Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func TurnInFactionLuxon()
	RndTravel(193)
	WaitForLoad()
	CurrentAction("grabing")
	GetNearestNPCToCoords(9076, -1111)

	$beforedone = GetLuxonFaction()

	If $Bool_Donate Then
		Do
			CurrentAction("Donate")
			DonateFaction(1)
			RndSleep(250)
		Until GetLuxonFaction() < 5000
	Else
		CurrentAction("Grabbing Jade Shards")
		Dialog(131)
		RndSleep(500)
		$temp = Floor(GetLuxonFaction() / 5000)
		$id = 8388609 + ($temp * 256)
		Dialog($id)
	EndIf
	RndSleep(500)
	$after_donate = GetLuxonFaction()
	$what_we_donate = $beforedone - $after_donate + $what_we_donate
	RndSleep(500)
	RndTravel(389)
	WaitForLoad()
EndFunc

Func DebugMsg($msg)
    MsgBox(0, "Debug Message", $msg)
EndFunc


Func GoOut()
	RndSleep(250)

; This loop captures selected hero names from the dropdowns
For $i = 0 To 6
    ; Check if the dropdown has a selection and is not simply default or disabled
    $selectedHeroNames[$i] = GUICtrlRead($heroDropdowns[$i])
    If $selectedHeroNames[$i] == "" Or GUICtrlGetState($heroDropdowns[$i]) = $GUI_DISABLE Then
        $selectedHeroNames[$i] = "" ; Assign an empty string if no selection or if disabled
    EndIf
Next

; This loop maps the selected hero names to their IDs and adds the heroes to the party
For $i = 0 To UBound($selectedHeroNames) - 1
    If $selectedHeroNames[$i] <> "" Then ; Ensure there's a selection
        Local $selectedHeroId = GetHeroIdByName($selectedHeroNames[$i])
        If $selectedHeroId <> -1 Then
            AddHero($selectedHeroId) ; Call the function to add the hero to the party
        EndIf
    EndIf
Next

RndSleep(2000)

	If GetGoldCharacter() < 100 AND GetGoldStorage() > 100 Then
		CurrentAction("Grabbing gold for shrine")
		RndSleep(250)
		WithdrawGold(1000)
		RndSleep(250)
	EndIf

	CurrentAction("Going out")

	If $Title = "Deldrimor" Then
		TakeQuestDeldrimor()
		WaitForLoad()
	Else
		Do
			If $Title = "Asura" Then
				MoveTo(16342, 13855)
				Move(16450, 13300)
				WaitForLoad()
			ElseIf $Title = "Vanguard" Then
				MoveTo(-16009, 14596)
				Move(-15200, 13500)
				WaitForLoad()
			ElseIf $Title = "Norn" Then
				MoveTo(-609, 1372)
				Sleep(Random(200,350))
				Move(-1440, 1170)
				WaitForLoad()
				Sleep(Random(500,750))

			ElseIf $Title = "Kurzick" Then
				MoveTo(7810,-726)
				Do
					MoveTo(10042,-1173)
					RndSleep(500)
					Move(10446, -1147, 5)
					WaitForLoad()
				Until GetMapID() = $areaFerndale
			ElseIf $Title = "Luxon" Then
				MoveTo(-4268, 11628)
				Do
					Move(-5493, 13712)
					RndSleep(500)
					WaitForLoad()
				Until GetMapID() = $Luxon_Map
			ElseIf $Title = "SS and LB" Then
				MoveTo(1527, -4114)
				Move(1970, -4353)
				WaitForLoad()
			ElseIf $Title = "Treasure Hunter" Then
				MoveTo(5444, -27900)
				MoveTo(4065, -27734)
				WaitForLoad()
			ElseIf $Title = "SS" Then
				MoveTo(-204, 3665)
				Move(-490, 4995)
				WaitForLoad()
			EndIf
			Sleep(2000)
		Until GetMapID() = $Map_To_Farm
	EndIf

EndFunc

Func TakeQuestDeldrimor()
	CurrentAction("Taking quest")
	GetNearestNPCToCoords(-23818, 13931)
	RndSleep(750)
	Dialog(8618497)
	RndSleep(750)
	GetNearestNPCToCoords(-23818, 13931)
	RndSleep(750)
	Dialog(0x00000083);
	Dialog(0x00000084); Address for Entering the Dungeon
	Sleep(200)
EndFunc

Func status()
	$time = TimerDiff($TimerTotal)
	$string = StringFormat("min: %03u  sec: %02u ", $time/1000/60, Mod($time/1000,60))
	GUICtrlSetData($label_stat, $string)
EndFunc    ;==>status

Func CheckDeath()
	If Death() = 1 Then
		CurrentAction("We Are Dead")
	EndIf
EndFunc   ;==>CheckDeath

Func CheckPartyDead()
	$DeadParty = 0
	For $i =1 to GetHeroCount()
		If GetIsDead(GetHeroID($i)) = True Then
			$DeadParty +=1
		EndIf
		If $DeadParty >= 5 Then
			$DeadOnTheRun = 1
			CurrentAction("We Wipe, going back oupost to save time")
		EndIf
	Next
EndFunc

Func VQ()

	$DeadOnTheRun = 0

	If $Title = "Asura" Then

		AdlibRegister("CheckPartyDead", 2000)
		AdlibRegister("AsuraPoint", 5000)
		VQAsura()
		AdlibUnRegister("CheckPartyDead")
		AdlibUnRegister("AsuraPoint")

	ElseIf $Title = "Deldrimor" Then

		AdlibRegister("DeldrimorPoint", 5000)
		VQDeldrimor()
		AdlibUnRegister("DeldrimorPoint")

	ElseIf $Title = "Vanguard" Then

		AdlibRegister("CheckPartyDead", 2000)
		AdlibRegister("Vanguardpoint", 5000)
		VQVanguard()
		AdlibUnRegister("CheckPartyDead")
		AdlibUnRegister("Vanguardpoint")

	ElseIf $Title = "Norn" Then

		AdlibRegister("CheckPartyDead", 2000)
		AdlibRegister("Nornpoint", 5000)
		VQNorn()
		AdlibUnRegister("CheckPartyDead")
		AdlibUnRegister("Nornpoint")

	ElseIf $Title = "Kurzick" Then

		AdlibRegister("CheckPartyDead", 2000)
		AdlibRegister("Kurzickpoint", 5000)
		VQKurzick()
		AdlibUnRegister("CheckPartyDead")
		AdlibUnRegister("Kurzickpoint")

	ElseIf $Title = "Luxon" Then

		AdlibRegister("CheckPartyDead", 2000)
		AdlibRegister("Luxonpoint", 5000)
		VQLuxon()
		AdlibUnRegister("CheckPartyDead")
		AdlibUnRegister("Luxonpoint")

	ElseIf $Title = "SS and LB" Then
		AdlibRegister("CheckPartyDead", 2000)
		AdlibRegister("SSLBpoint", 5000)
		VQSSLB()
		AdlibUnRegister("CheckPartyDead")
		AdlibUnRegister("SSLBpoint")

	ElseIf $Title = "Treasure Hunter" Then
	
		AdlibRegister("CheckPartyDead", 2000)
		AdlibRegister("SSLBpoint", 5000)
		VQTreasure_Hunter()
		AdlibRegister("CheckPartyDead", 2000)

	ElseIf $Title = "SS" Then

		AdlibRegister("CheckPartyDead", 2000)
		AdlibRegister("SSpoint", 5000)
		VQSS()
		AdlibUnRegister("CheckPartyDead")
		AdlibUnRegister("SSpoint")

	EndIf
	CurrentAction("Waiting...")
	Sleep(5000)
EndFunc

Func AsuraPoint()
	$Temp = GetAsuraTitle()
	$point_earn = $Temp - $Asura_begin
	GUICtrlSetData($Pt_Asura, $point_earn)
EndFunc

Func DeldrimorPoint()
	$Temp = GetDeldrimorTitle()
	$point_earn = $Temp - $Deldrimor_begin
	GUICtrlSetData($Pt_Deldrimor, $point_earn)
EndFunc

Func Vanguardpoint()
	$Temp = GetVanguardTitle()
	$point_earn = $Temp - $Vanguard_begin
	GUICtrlSetData($Pt_Vanguard, $point_earn)
EndFunc

Func Nornpoint()
	$Temp = GetNornTitle()
	$point_earn = $Temp - $Norn_begin
	GUICtrlSetData($Pt_Norn, $point_earn)
EndFunc

Func Kurzickpoint()
	$Temp = GetKurzickFaction()
	$point_earn = $Temp - $Kurzick_begin + $what_we_donate
	GUICtrlSetData($Pt_Kurzick, $point_earn)
EndFunc

Func Luxonpoint()
	$Temp = GetLuxonFaction()
	$point_earn = $Temp - $Luxon_begin + $what_we_donate
	GUICtrlSetData($Pt_Luxon, $point_earn)
EndFunc

Func SSLBpoint()
	$Temp = GetSunspearTitle()
	$point_earn = $Temp - $SS_begin
	GUICtrlSetData($Pt_SS, $point_earn)
	$Temp = GetLightbringerTitle()
	$point_earn = $Temp - $LB_begin
	GUICtrlSetData($Pt_LB, $point_earn)
EndFunc

Func SSpoint()
	$Temp = GetSunspearTitle()
	$point_earn = $Temp - $SS_begin
	GUICtrlSetData($Pt_SS, $point_earn)
EndFunc


Func _Run ($aX, $aY, $aRandom = 75)
    If GetIsDead(-2) Then Return
    If Not $Bool_Uselockpicks Then Return

    Local $lBlocked = 0
    Local $lMe = GetAgentByID(-2) ; Get the agent ID of the player
    Local $lDestX = $aX + Random(-$aRandom, $aRandom)
    Local $lDestY = $aY + Random(-$aRandom, $aRandom)

    Move($lDestX, $lDestY, 0)

    Do
        Sleep(250)
        $lMe = GetAgentByID(-2)

        If DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0 Then
            $lBlocked += 1
            $lDestX = $aX + Random(-$aRandom, $aRandom)
            $lDestY = $aY + Random(-$aRandom, $aRandom)
            Move($lDestX, $lDestY, 0)
        EndIf

        If DllStructGetData($lMe, 'HP') <= 0 Or $lBlocked > 14 Then ExitLoop
    Until ComputeDistance(DllStructGetData($lMe, 'X'), DllStructGetData($lMe, 'Y'), $lDestX, $lDestY) < 100

EndFunc   ;==>_Run