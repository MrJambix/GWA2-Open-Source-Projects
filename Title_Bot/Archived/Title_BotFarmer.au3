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


global $DeadOnTheRun = 0
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
	If GetKurzickFaction() > GetMaxKurzickFaction() - 12000 Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func TurnInFactionKurzick()
    CurrentAction("Turning in faction")
    RndSleep(5000)
    GoNearestNPCToCoords(5390, 1524)

    $beforedone = GetKurzickFaction()

    If $Bool_Donate Then
        $donationAttempts = 0
        $maxAttempts = 3
        Do
            CurrentAction("Donate")
            $donationSuccess = DonateFaction("kurzick")
            RndSleep(1000)
            If Not $donationSuccess Then
                $donationAttempts += 1
                If $donationAttempts >= $maxAttempts Then
                    ; Fail check mechanism, reset location and attempts if donation fails 3 times
                    CurrentAction("Resetting location due to donation failure")
                    GoNearestNPCToCoords(5390, 1524)
                    RndSleep(2000) ; Adding a sleep to ensure the reset is acknowledged
                    $donationAttempts = 0 ; Reset the donation attempts counter
                EndIf
            Else
                ; Reset attempts if donation is successful
                $donationAttempts = 0
            EndIf
        Until GetKurzickFaction() < 5000
    Else
        CurrentAction("Donating Kurzick Faction for Amber")
        Dialog(131)
        RndSleep(550)
        $temp = Floor(GetKurzickFaction() / 5000)
        $id = 8388609 + ($temp * 256)
        Dialog($id)
        RndSleep(1000)
    EndIf

    $after_donate = GetKurzickFaction()
    $what_we_donate = $beforedone - $after_donate + $what_we_donate
    RndSleep(500)
EndFunc

Func FactionCheckLuxon()
	CurrentAction("Check Luxon point atm")
	RndSleep(250)

	If GetLuxonFaction() > GetMaxLuxonFaction() - 13000 Then
		Return True
	Else
		Return False
	EndIf
EndFunc

Func TurnInFactionLuxon()
	RndTravel(193)
	WaitForLoad()
	CurrentAction("grabing")
	GoNearestNPCToCoords(9076, -1111)

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
	GoNearestNPCToCoords(-23818, 13931)
	RndSleep(750)
	Dialog(8618497)
	RndSleep(750)
	GoNearestNPCToCoords(-23818, 13931)
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

#Region VQ

Func VQLuxon() ;

	CurrentAction("Taking blessing")
	$deadlock = 0

	if $Bool_cons then
		UseConsets()
	EndIf

GoNearestNPCToCoords(-8394, -9801)

If GetKurzickFaction() > GetLuxonFaction() Then
    Dialog(0x81)
    Sleep(1000)
    Dialog(0x2)
    Sleep(1000)
    Dialog(0x84)
	Sleep(1000)
	Dialog(0x86)
	Sleep(1000)
Else
    Dialog(0x85)
    Sleep(1000)
    Dialog(0x86)
    Sleep(1000)
EndIf

$enemy = "Yeti"
If GetAreaVanquished() = False Then AggroMoveTo(-13046, -9347, $enemy)

$enemy = "Yeti"
If GetAreaVanquished() = False Then AggroMoveTo(-17348, -9895, $enemy)
If GetAreaVanquished() = False Then AggroMoveTo(-17399, -10140, $enemy)

$enemy = "Oni and Wallows"
If GetAreaVanquished() = False Then AggroMoveTo(-14702, -6671, $enemy)

$enemy = "Oni and Wallows"
If GetAreaVanquished() = False Then AggroMoveTo(-11080, -6126, $enemy, 2000)

$enemy = "Yeti"
If GetAreaVanquished() = False Then AggroMoveTo(-13426, -2344, $enemy)

$enemy = "TomTom"
If GetAreaVanquished() = False Then AggroMoveTo(-15055, -3226, $enemy)

$enemy = "Guardian and Wallows"
If GetAreaVanquished() = False Then AggroMoveTo(-9448, -283, $enemy)

$enemy = "Yeti"
If GetAreaVanquished() = False Then AggroMoveTo(-9918, 2826, $enemy, 2000)

$enemy = "Yeti"
If GetAreaVanquished() = False Then AggroMoveTo(-8721, 7682, $enemy)

$enemy = "Yeti"
If GetAreaVanquished() = False Then AggroMoveTo(-3749, 8053, $enemy)
If GetAreaVanquished() = False Then AggroMoveTo(-2837, 8990, $enemy)

$enemy = "Guardian and Wallows"
If GetAreaVanquished() = False Then AggroMoveTo(-9666, 2625, $enemy)

$enemy = "Guardian and Wallows"
If GetAreaVanquished() = False Then AggroMoveTo(-7474, -1144, $enemy)

$enemy = "Guardian and Wallows"
If GetAreaVanquished() = False Then AggroMoveTo(-5895, -3959, $enemy)

$enemy = "Guardian and Wallows"
If GetAreaVanquished() = False Then AggroMoveTo(-7449, -4600, $enemy)

$enemy = "Patrol"
If GetAreaVanquished() = False Then AggroMoveTo(-3509, -8000, $enemy)

$enemy = "Oni"
If GetAreaVanquished() = False Then AggroMoveTo(-195, -9095, $enemy)

$enemy = "Oni"
If GetAreaVanquished() = False Then AggroMoveTo(6298, -8707, $enemy)

$enemy = "bridge"
If GetAreaVanquished() = False Then AggroMoveTo(3981, -3295, $enemy)

$enemy = "Naga"
If GetAreaVanquished() = False Then AggroMoveTo(496, -2581, $enemy, 2000)

$enemy = "Guardian and Wallows"
If GetAreaVanquished() = False Then AggroMoveTo(2069, 1127, $enemy)

 $enemy = "Guardian and Wallows"
If GetAreaVanquished() = False Then AggroMoveTo(5859, 1599, $enemy)

$enemy = "Guardian and Wallows"
If GetAreaVanquished() = False Then AggroMoveTo(5405, 5891, $enemy)

$enemy = "Guardian and Wallows"
If GetAreaVanquished() = False Then AggroMoveTo(6412, 6572, $enemy)

$enemy = "Naga"
If GetAreaVanquished() = False Then AggroMoveTo(10507, 8140, $enemy)

$enemy = "Naga"
If GetAreaVanquished() = False Then AggroMoveTo(8526, 6528, $enemy)

$enemy = "Naga"
If GetAreaVanquished() = False Then AggroMoveTo(10747, 8484, $enemy)

$enemy = "Oni"
If GetAreaVanquished() = False Then AggroMoveTo(14403, 6938, $enemy)

$enemy = "Oni"
If GetAreaVanquished() = False Then AggroMoveTo(18080, 3127, $enemy)

$enemy = "Naga"
If GetAreaVanquished() = False Then AggroMoveTo(13518, -35, $enemy)

$enemy = "Naga"
If GetAreaVanquished() = False Then AggroMoveTo(13450, -6084, $enemy, 4000)

$enemy = "Naga"
If GetAreaVanquished() = False Then AggroMoveTo(13764, -4816, $enemy, 4000)


CurrentAction("Waiting to get reward")
Sleep(6000)
EndFunc

Func VQVanguard();

	$DeadOnTheRun = 0
	CurrentAction("Taking Blessing")
	GoNearestNPCToCoords(-14971.00, 11013.00)
	Sleep(1000)
	Dialog(0x84)
	Sleep(1000)

	if $Bool_cons then
		UseConsets()
	EndIf

	If  CurrentAction("Moving")
	If  MoveTo(-12373, 12899)
	If  AggroMoveTo(-9464, 15937, "Charr Group")
	If  CurrentAction("Moving")
	If  MoveTo(-9130, 13535)
	If  CurrentAction("Moving")
	If  MoveTo(-5532, 11281)
	If  AggroMoveTo(-3979, 9184, "Mantid Group")
	If  AggroMoveTo(-355, 9296, "Again mantid Group")
	If  AggroMoveTo(836, 12171, "Charr Patrol", 3000)
	If  AggroMoveTo(884, 15641, "Charr Group")
	If  AggroMoveTo(2956, 10496, "Mantid Group")
	If  AggroMoveTo(5160, 11032, "Moving")
	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(5816, 11687)
	If  Sleep(1000)
	If  CurrentAction("Moving")
	If  AggroMoveTo(5848, 11086, "Mantid Group", 3000)
	If  AggroMoveTo(7639, 11839, "Charr Patrol")
	If  AggroMoveTo(6494, 15729, "Charr Patrol")
	If  AggroMoveTo(5704, 17469, "Charr Group")
	If  AggroMoveTo(8572, 12365, "Moving Back")
	If  AggroMoveTo(13960, 13432, "Charr Group")
	If  AggroMoveTo(15385, 9899, "Going Charr")
	If  AggroMoveTo(17089, 6922, "Charr Group")
	If  AggroMoveTo(16363, 3809, "Moving Gain")
	If  AggroMoveTo(15635, 710, "Charr Group")
	If  AggroMoveTo(12754, 2740, "Charr Seeker")
	If  AggroMoveTo(10068, 2580, "Skale")
	If  AggroMoveTo(7663, 3236, "Charr Seeker")
	If  AggroMoveTo(6152, 1706, "Charr Seeker")
	If  AggroMoveTo(5086, -2187, "Charr on the way", 2500)
	If  AggroMoveTo(3449, -3693, "Charr Patrol", 2000)
	If  AggroMoveTo(7170, -4037, "Moving")
	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(8565, -3974)
	If  Sleep(1000)
	If  AggroMoveTo(8903, -1801, "Second Skale")
	If  AggroMoveTo(6790, -6124, "Moving")
	If  AggroMoveTo(3696, -9324, "Charr Patrol", 3000)
	If  AggroMoveTo(6790, -6124, "Moving")
	If  AggroMoveTo(8031, -10361, "Charr on the way")
	If  AggroMoveTo(9282, -12837, "Moving")
	If  AggroMoveTo(8817, -16314, "Charr Patrol", 3000)
	If  AggroMoveTo(13337, -14025, "Charr Patrol 2", 3000)

	If  AggroMoveTo(13675, -5513, "Charr Group", 3000)
	If  AggroMoveTo(14760, -2224, "Charr Group", 3000)
	If  AggroMoveTo(13378, -2577, "Charr Group")
	;If  AggroMoveTo(13675, -5513, "Charr Group")

	;If  AggroMoveTo(13337, -14025, "Charr Patrol 2")
	;If  AggroMoveTo(15290, -13688, "Charr Seeker")
	If  AggroMoveTo(17500, -11685, "Charr Group")
	If  AggroMoveTo(15290, -13688, "Charr Seeker")
	If  AggroMoveTo(15932, -14104, "Moving Back")
	If  AggroMoveTo(14934, -17261, "Moving")

	;If  AggroMoveTo(17500, -11685, "Charr Group")
	;If  AggroMoveTo(15932, -14104, "Moving Back")
	;If  AggroMoveTo(14934, -17261, "Moving")


	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(14891, -18146)
	If  Sleep(1000)
	If  AggroMoveTo(11509, -17586, "Moving")
	If  AggroMoveTo(6031, -17582, "Moving")
	If  AggroMoveTo(2846, -17340, "Charr Group")
	If  AggroMoveTo(-586, -16529, "Charr Seeker")
	If  AggroMoveTo(-4099, -14897, "Moving")
	If  AggroMoveTo(-4217, -12620, "Moving")

	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(-4014, -11504)
	If  Sleep(1000)
	If  AggroMoveTo(-8023, -13970, "Charr Seeker")
	If  AggroMoveTo(-7326, -8852, "Charr Seeker")
	If  AggroMoveTo(-8023, -13970, "Charr Patrol")

	If  AggroMoveTo(-9808, -15103, "Moving")
	If  AggroMoveTo(-10902, -16356, "Skale Place", 2000)
	If  AggroMoveTo(-11917, -18111, "Skale Place", 2000)
	If  AggroMoveTo(-13425, -16930, "Skale Boss")
	If  AggroMoveTo(-15218, -17460, "Skale Group")
	If  AggroMoveTo(-16084, -14159, "Skale Group")
	If  AggroMoveTo(-17395, -12851, "Skale Place")
	;charr on field
	If  AggroMoveTo(-18157, -9785, "Skale On the Way", 3000)
	If  AggroMoveTo(-18222, -6263, "Finish Skale", 3000)
	If  AggroMoveTo(-17239, -1933, "Moving")
	If  AggroMoveTo(-17509, 202, "Moving")

	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(-17546, 341)
	If  Sleep(1000)
	If  AggroMoveTo(-13853, -2427, "Charr Seeker")
	If  AggroMoveTo(-9313, -3786, "Charr Seeker")
	If  AggroMoveTo(-13228, 2083, "Charr Seeker")

	If  AggroMoveTo(-13622, 5476, "Moving")
	If  AggroMoveTo(-17705, 3079, "Mantid on the way")
	If  AggroMoveTo(-16565, 2528, "More Charr")
	If  AggroMoveTo(-17705, 3079, "Moving")

	If  AggroMoveTo(-12909, 6403, "Mantid on the way")
	If  AggroMoveTo(-10699, 5105, "Mantid Group")
	If  AggroMoveTo(-9016, 6958, "Mantid Group")
	If  AggroMoveTo(-8889, 9446, "Mantid Group")
	If  AggroMoveTo(-6869, 4604, "Mantid Monk Boss")
	If  AggroMoveTo(-8190, 6872, "Mantid")


	If  AggroMoveTo(-6181, 1837, "Mantid Group")

	If  AggroMoveTo(-4125, 2789, "Mantid Group")

	If  AggroMoveTo(-2875, 985, "Moving")

	If  AggroMoveTo(-769, 2047, "Charr Group")

	If  AggroMoveTo(1114, 1765, "Mantid and Charr")

	If  AggroMoveTo(6550, 7549, "Looking for Mantids", 3000)
	If  AggroMoveTo(8246, 8104, "Looking for Mantids", 3000)
	If  AggroMoveTo(6550, 7549, "Looking for Mantids", 3000)
	If  AggroMoveTo(1960, 4969, "Looking for Mantids", 3000)
	If  AggroMoveTo(621, 8056, "Looking for Mantids", 3000)
	If  AggroMoveTo(-4039, 8928, "Looking for Mantids", 3000)
	If  AggroMoveTo(-3299, 606, "Looking for Mantids", 3000)

	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(-2646, -452)
	If  Sleep(1000)


	If  AggroMoveTo(5219, -5017, "Charr Patrol")
	If  AggroMoveTo(7289, -9484, "Charr Patrol")
	If  AggroMoveTo(5219, -7017, "Charr Patrol")
	If  AggroMoveTo(1342, -9068, "Charr Patrol")

	If  AggroMoveTo(1606, 22, "Charr Patrol")


	If  AggroMoveTo(-276, -2566, "Going to Molotov")
	If  AggroMoveTo(-3337, -4323, "Molotov")
	If  AggroMoveTo(-4700, -4943, "Molotov")
	If  AggroMoveTo(-5561, -5483, "Molotov", 10000)


EndFunc

Func VQSS();

	CurrentAction("Taking blessing")

	$deadlock = 0

	if $Bool_cons then
		UseConsets()
	EndIf


	GoNearestNPCToCoords(15773, -15302)
	Sleep(1000)
	Dialog(0x00000084)
	Dialog(0x00000085)
	Sleep(1000)

	$DeadOnTheRun = 0

	CurrentAction("Avoiding Stuck By Scout")

	MoveTo(16156, -15046)

	CurrentAction("Going To Farm Left Side")

	MoveTo(14627, -15003)
	MoveTo(9897, -15584)
	MoveTo(6995, -14597)

	$enemy = "First Group"
	If  AggroMoveTo(4543, -12928, $enemy)

	$enemy = "Second Group"
	If  AggroMoveTo(2361, -10638, $enemy)

	$enemy = "Third Group"
	If  AggroMoveTo(1218, -9046, $enemy, 1800)

	$enemy = "4 Group"
	If  AggroMoveTo(825, -5411, $enemy)

	$enemy = "Monk Boss Group"
	If  AggroMoveTo(-599, -3110, $enemy, 1600)

	If  CurrentAction("Moving Other Side")

	If  MoveTo(1785, -5534)

	If  MoveTo(3027, -5764)
	If  MoveTo(6122, -2189)
	If  MoveTo(9346, -3097)

	$enemy = "First Group"
	If  AggroMoveTo(10874, -5008, $enemy)

	$enemy = "Second Group"
	If  AggroMoveTo(10970, -7779, $enemy)

	$enemy = "Third Group"
	If  AggroMoveTo(14262, -7000, $enemy)

	$enemy = "E Boss Group"
	If  AggroMoveTo(16338, -6716, $enemy)
EndFunc

Func VQSSLB();

	CurrentAction("Taking blessing")

	$deadlock = 0

	if $Bool_cons then
		UseConsets()
	EndIf


	CurrentAction("Taking Blessing")
	GoToNPC(GetNearestNPCToCoords(-704, 15988))
	Dialog(0x83)
	RndSleep(1000)
	Dialog(0x85)
	RndSleep(1000)

	MoveTo(-675, 13419)
	RndSleep(5000)
	TargetNearestItem()
	RndSleep(750)
	GoSignpost(-1)
	RndSleep(750)

	$enemy = "First Undead Group"
	AggroMoveTo(-1950, 9871, $enemy)

	$enemy = "Second Undead Group"
	AggroMoveTo(-3684, 11485, $enemy)
	AggroMoveTo(-4705, 11411, $enemy)

	$enemy = "Third Undead Group"
	MoveTo(-9661, 12374)
	MoveTo(-12856, 9128)
	AggroMoveTo(-13839, 7961, $enemy)

	CurrentAction("Taking Margonite Blessing")
	MoveTo(-17247, 5902)
	MoveTo(-19119, 6559)
	MoveTo(-19610, 7037)
	GoToNPC(GetNearestNPCToCoords(-20587, 7280))
	Sleep(1000)
	Dialog(0x85)
	Sleep(1000)


	$enemy = "First Margonite Group"
	AggroMoveTo(-22716, 11220, $enemy, 500)

	$enemy = "Djinn Group"
	MoveTo(-19668, 7022)
	MoveTo(-19266, 1867)
	AggroMoveTo(-22030, -651, $enemy, 2000)

	$enemy = "Undead Ritualist Boss Group"
	AggroMoveTo(-19332, -9200, $enemy)

	$enemy = "Second Margonite Group"
	AggroMoveTo(-22748, -10570, $enemy, 2000)
	AggroMoveTo(-22259, -13719, $enemy, 2000)

	CurrentAction("Picking Up Tome")
	MoveTo(-21219, -13860)
	RndSleep(250)
	TargetNearestItem()
	PickupItem(-1)
	RndSleep(250)
	PickupItem(-1)
	RndSleep(250)

	CurrentAction("Moving To Temple")
	$enemy = "Temple Monolith Groups"
	AggroMoveTo(-18239, -13084, $enemy)


	CurrentAction("Spawning Margonite Bosses")
	MoveTo(-18176, -13412)
	$shrine = GetNearestSignpostToCoords(-18176, -13412)
	RndSleep(1000)
	GoSignpost($shrine) ;trigger shrine
	RndSleep(1000)
	GoSignpost(-1) ;trigger shrine
	RndSleep(3000)

	$enemy = "Margonite Boss Group"
	AggroMoveTo(-18176, -13412, $enemy)
	RndSleep(1000)
EndFunc

Func VQNorn()
    Local $waypoints[4][2] = [ _
        [-2484.73, 118.55], _
        [-3059.12, -419.00], _
        [-3301.01, -2008.23], _
        [-2034, -4512] _
    ]

    CurrentAction("Taking blessing")
    If $Bool_cons Then
        UseConsets()
    EndIf

    ; Navigate through each waypoint
    For $i = 0 To UBound($waypoints) - 1
        $x = $waypoints[$i][0]
        $y = $waypoints[$i][1]
        CurrentAction("Moving to waypoint: " & $x & ", " & $y & @CRLF)

        MoveTo($x, $y)


        RndSleep(500)
    Next

    GoNearestNPCToCoords(-2034, -4512)
    Dialog(0x00000084)
    RndSleep(1000)

	Do
		$DeadOnTheRun = 0
		If  $enemy = "Berzerker"
		If  AggroMoveTo(-5278, -5771, $enemy)
		If  AggroMoveTo(-5456, -7921, $enemy)
		If  AggroMoveTo(-8793, -5837, $enemy)

		If  $enemy = "Vaettir and Berzerker"
		If  AggroMoveTo(-14092, -9662, $enemy)
		If  AggroMoveTo(-17260, -7906, $enemy)

		If  $enemy = "Jotun "
		If  AggroMoveTo(-21964, -12877, $enemy, 2500)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(-21964, -12877, 1000)

	CurrentAction("Taking blessing")
	GoNearestNPCToCoords(-25272.89, -11968.49)
	RndSleep(1000)

	Do
		$DeadOnTheRun = 0
		If  MoveTo(-22275, -12462)

		If  $enemy = "Berzerker"
		If  AggroMoveTo(-21671, -2163, $enemy)
		If  AggroMoveTo(-19592, 772, $enemy)
		If  AggroMoveTo(-13795, -751, $enemy)
		If  AggroMoveTo(-17012, -5376, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(-17012, -5376, 1000)

	CurrentAction("Taking blessing")
	GoNearestNPCToCoords(-12071, -4274)
	RndSleep(1000)

	Do
		$DeadOnTheRun = 0
		If  $enemy = "Berzerker"
		If  AggroMoveTo(-8351, -2633, $enemy)
		If  MoveTo(-4362, -1610)

		If  $enemy = "Lake"
		If  AggroMoveTo(-4316, 4033, $enemy)
		If  AggroMoveTo(-8809, 5639, $enemy)
		If  AggroMoveTo(-14916, 2475, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(-14916, 2475, 1000)

	CurrentAction("Taking blessing")
	GoNearestNPCToCoords(-11282, 5466)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		If  $enemy = "Elemental"
		If  AggroMoveTo(-16051, 6492, $enemy)
		If  AggroMoveTo(-16934, 11145, $enemy)
		If  AggroMoveTo(-19378, 14555, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(-19378, 14555, 1000)

		CurrentAction("Taking blessing")
		GoNearestNPCToCoords(-22751, 14163)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		If  AggroMoveTo(-15932, 9386, $enemy)
		If  MoveTo(-13777, 8097)

		If  $enemy = "Lake"
		If  AggroMoveTo(-4729, 15385, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(-4729, 15385, 1000)

	CurrentAction("Taking blessing")
	GoNearestNPCToCoords(-2290, 14879)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		If  $enemy = "Modnir"
		If  AggroMoveTo(-1810, 4679, $enemy)

		If  $enemy = "Boss"
		If  MoveTo(-6911, 5240)
		If  AggroMoveTo(-15471, 6384, $enemy)
		If  moveTo(-411, 5874)

		If  $enemy = "Modniir "
		If  AggroMoveTo(2859, 3982, $enemy)

		If  $enemy = "Ice Imp"
		If  AggroMoveTo(4909, -4259, $enemy)
		If  AggroMoveTo(7514, -6587, $enemy)

		If  $enemy = "Berserker"
		If  AggroMoveTo(3800, -6182, $enemy)
		If  AggroMoveTo(7755, -11467, $enemy)

		If  $enemy = "Elementals and Griffins"
		If  AggroMoveTo(15403, -4243, $enemy)
		If  AggroMoveTo(21597, -6798, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(21597, -6798, 1000)
	
	CurrentAction("Taking blessing")
	GoNearestNPCToCoords(24522, -6532)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		If  AggroMoveTo(22883, -4248, $enemy)
		If  AggroMoveTo(18606, -1894, $enemy)
		If  AggroMoveTo(14969, -4048, $enemy)
		If  AggroMoveTo(13599, -7339, $enemy)

		If  $enemy = "Ice Imp"
		If  AggroMoveTo(10056, -4967, $enemy)
		If  AggroMoveTo(10147, -1630, $enemy)
		If  AggroMoveTo(8963, 4043, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(8963, 4043, 1000)

	CurrentAction("Taking blessing")
	GoNearestNPCToCoords(8963, 4043)
	RndSleep(1000)

	Do
		$DeadOnTheRun = 0
		If  $enemy = ""
		If  AggroMoveTo(15576, 7156, $enemy)

		If  $enemy = "Berserker"
		If  AggroMoveTo(22838, 7914, $enemy, 2500)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(22838, 7914, 1000)

	CurrentAction("Taking blessing")
	GoNearestNPCToCoords(22961, 12757)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		If  $enemy = "Modniir and Elemental"
		If  MoveTo(18067, 8766)
		If  AggroMoveTo(13311, 11917, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(13311, 11917, 1000)

	CurrentAction("Taking blessing")
	GoNearestNPCToCoords(13714, 14520)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		If  $enemy = "Modniir and Elemental"
		If  AggroMoveTo(11126, 10443, $enemy)
		If  AggroMoveTo(5575, 4696, $enemy, 2500)

		If  $enemy = "Modniir and Elemental 2"
		If  AggroMoveTo(-503, 9182, $enemy)
		If  AggroMoveTo(1582, 15275, $enemy, 2500)
		If  AggroMoveTo(7857, 10409, $enemy, 2500)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(7857, 10409, 1000)
EndFunc

Func VQKurzick();

	$deadlock = 0

	if $Bool_cons then
		UseConsets()
	EndIf

	CurrentAction("Taking blessing")
	GoNearestNPCToCoords(-12909, 15616)

If GetLuxonFaction() > GetKurzickFaction() Then
    Dialog(0x81)
    Sleep(1000)
    Dialog(0x2)
    Sleep(1000)
    Dialog(0x84)
	Sleep(1000)
	Dialog(0x86)
	Sleep(1000)
Else
    Dialog(0x85)
    Sleep(1000)
    Dialog(0x86)
    Sleep(1000)
EndIf


	Local $iFoesKilled = GetFoesKilled()
	
	$enemy = "Mantis Group"
	
	AggroMoveTo(-11733, 16729, $enemy)
	AggroMoveTo(-11942, 18468, $enemy)
	AggroMoveTo(-11178, 20073, $enemy)
	AggroMoveTo(-11008, 16972, $enemy)
	AggroMoveTo(-11238, 15226, $enemy)
	CurrentAction("Foes Killed: " & $iFoesKilled)
	
	AggroMoveTo(-8458.45, 19618, $enemy)
	AggroMoveTo(-9179.54, 15281, $enemy)
	AggroMoveTo(-8799.17, 14159, $enemy)
	AggroMoveTo(-9454.66, 13399, $enemy)	
	AggroMoveTo(-9122, 14794, $enemy)
	AggroMoveTo(-10965, 13496, $enemy)
	AggroMoveTo(-10570, 11789, $enemy)	
	AggroMoveTo(-10138, 10076, $enemy)
	CurrentAction("Foes Killed: " & $iFoesKilled)
	
	$enemy = "Dredge Boss Warrior"
	AggroMoveTo(-10289, 8329, $enemy)
	AggroMoveTo(-8587, 8739, $enemy)
	AggroMoveTo(-6853, 8496, $enemy)

	$enemy = "Dredge Patrol"
	AggroMoveTo(-5211, 7841, $enemy)

	$enemy = "Missing Dredge Patrol"
	AggroMoveTo(-4059, 11325, $enemy)

	$enemy = "Oni and Dredge Patrol"
	AggroMoveTo(-4328, 6317, $enemy)
	AggroMoveTo(-4454, 4558, $enemy)

	$enemy = "Dredge Patrol Again"
	AggroMoveTo(-4650, 2812, $enemy)

	$enemy = "Missing Patrol"
	AggroMoveTo(-9326,1601, $enemy)
	AggroMoveTo(-11000,2219, $enemy, 5000)
	AggroMoveTo(-6313,2778, $enemy)
	CurrentAction("Foes Killed: " & $iFoesKilled)
	
	$enemy = "Dreadge Patrol"
	AggroMoveTo(-4447, 1055, $enemy, 3000)

	$enemy = "Warden and Dredge Patrol"
	AggroMoveTo(-3832, -586, $enemy, 3000)
	AggroMoveTo(-3143, -2203, $enemy, 3000)
	AggroMoveTo(-5780, -4665, $enemy, 3000)
	CurrentAction("Foes Killed: " & $iFoesKilled)
	
	$enemy = "Warden Group / Mesmer Boss"
	AggroMoveTo(-2541, -3848, $enemy, 5000)
	AggroMoveTo(-2108, -5549, $enemy, 5000)
	AggroMoveTo(-1649, -7250, $enemy, 4500)

	$enemy = "Dredge Patrol and Mesmer Boss"
	AggroMoveTo(-666, -8708, $enemy, 5500)

	$enemy = "Warden Group"
	AggroMoveTo(526, -10001, $enemy)
	AggroMoveTo(1947, -11033, $enemy)
	AggroMoveTo(3108, -12362, $enemy)

	$enemy = "Kirin Group"
	AggroMoveTo(2932, -14112, $enemy)
	AggroMoveTo(2033, -15621, $enemy)
	AggroMoveTo(1168, -17145, $enemy)	
	AggroMoveTo(-254, -18183, $enemy)
	AggroMoveTo(-1934, -18692, $enemy)

	$enemy = "Warden Patrol"
	AggroMoveTo(-3676, -18939, $enemy)
	AggroMoveTo(-5433, -18839, $enemy, 5000)
	AggroMoveTo(-3679, -18830, $enemy)
	AggroMoveTo(-1925, -18655, $enemy)
	AggroMoveTo(-274, -18040, $enemy)
	AggroMoveTo(1272, -17199, $enemy)
	AggroMoveTo(2494, -15940, $enemy)
	AggroMoveTo(3466, -14470, $enemy)
	AggroMoveTo(4552, -13081, $enemy)
	AggroMoveTo(6279, -12777, $enemy)
	AggroMoveTo(7858, -13545, $enemy)
	AggroMoveTo(8396, -15221, $enemy)
	AggroMoveTo(9117, -16820, $enemy)
	AggroMoveTo(10775, -17393, $enemy, 5000)
	AggroMoveTo(9133, -16782, $enemy)
	AggroMoveTo(8366, -15202, $enemy)
	AggroMoveTo(8083, -13466, $enemy)
	AggroMoveTo(6663, -12425, $enemy)
	AggroMoveTo(5045, -11738, $enemy)
	AggroMoveTo(4841, -9983, $enemy)
	AggroMoveTo(5262, -8277, $enemy)
	AggroMoveTo(5726, -6588, $enemy)

	$enemy = "Dredge Patrol / Bridge / Boss"
	AggroMoveTo(5076, -4955, $enemy)
	AggroMoveTo(4453, -3315, $enemy, 5000)

	$enemy = "Dedge Patrol"
	AggroMoveTo(5823, -2204, $enemy)
	AggroMoveTo(7468, -1606, $enemy)
	AggroMoveTo(8591, -248, $enemy, 5000)
	AggroMoveTo(8765, 1497, $enemy)
	AggroMoveTo(9756, 2945, $enemy)
	AggroMoveTo(11344, 3722, $enemy)
	AggroMoveTo(12899, 2912, $enemy, 3000)
	AggroMoveTo(12663, 4651, $enemy)
	AggroMoveTo(13033, 6362, $enemy)
	AggroMoveTo(13018, 8121, $enemy)
	AggroMoveTo(11596, 9159, $enemy)
	AggroMoveTo(11880, 10895, $enemy)
	AggroMoveTo(11789, 12648, $enemy)
	AggroMoveTo(10187, 13369, $enemy)
	AggroMoveTo(8569, 14054, $enemy, 3000)
	AggroMoveTo(8641, 15803, $enemy, 3000)
	AggroMoveTo(10025, 16876, $enemy, 3000)
	AggroMoveTo(11318, 18944, $enemy, 3000)
	AggroMoveTo(8621, 15831, $enemy, 3000)
	AggroMoveTo(7382, 14594, $enemy, 3000)
	AggroMoveTo(6253, 13257, $enemy, 3000)
	AggroMoveTo(5531, 11653, $enemy, 3000)
	AggroMoveTo(6036, 8799, $enemy)
	AggroMoveTo(4752, 7594, $enemy)
	AggroMoveTo(3630, 6240, $enemy)
	AggroMoveTo(4831, 4966, $enemy)
	AggroMoveTo(6390, 4141, $enemy)
	AggroMoveTo(4833, 4958, $enemy)
	AggroMoveTo(3167, 5498, $enemy)
	AggroMoveTo(2129, 4077, $enemy, 3000)
	AggroMoveTo(3151, 5502, $enemy)
	AggroMoveTo(-2234, 311, $enemy, 3000)
	AggroMoveTo(2474, 4345, $enemy, 3000)
	AggroMoveTo(3294, 5899, $enemy, 3000)
	AggroMoveTo(3072, 7643, $enemy, 3000)
	AggroMoveTo(1836, 8906, $enemy, 3000)
	AggroMoveTo(557, 10116, $enemy, 3000)
	AggroMoveTo(-545, 11477, $enemy, 5000)
	AggroMoveTo(-1413, 13008, $enemy, 5000)
	AggroMoveTo(-2394, 14474, $enemy, 5000)
	AggroMoveTo(-3986, 15218, $enemy, 5000)
	AggroMoveTo(-5319, 16365, $enemy, 5000)
	AggroMoveTo(-5238, 18121, $enemy, 5000)
	AggroMoveTo(-7916, 19630, $enemy, 5000)
	AggroMoveTo(-3964, 19324, $enemy, 5000)
	AggroMoveTo(-2245, 19684, $enemy, 5000)
	AggroMoveTo(-802, 18685, $enemy, 5000)
	AggroMoveTo(74, 17149, $enemy, 5000)
	AggroMoveTo(611, 15476, $enemy, 5000)
	AggroMoveTo(2139, 14618, $enemy, 5000)
	AggroMoveTo(3883, 14448, $enemy, 5000)
	AggroMoveTo(5624, 14226, $enemy, 5000)
	AggroMoveTo(7384, 14094, $enemy, 5000)
	AggroMoveTo(8223, 12552, $enemy, 5000)
	AggroMoveTo(7148, 11167, $enemy, 5000)
	AggroMoveTo(5427, 10834, $enemy, 10000)
    
	CurrentAction("Waiting to get reward")
	Sleep(6000)
EndFunc

Func VQDeldrimor();

	CurrentAction("Taking blessing")

	$deadlock = 0
	if $Bool_cons then
		UseConsets()
	EndIf


	GoNearestNPCToCoords(-14103, 15457)
	RndSleep(1000)
	Dialog(0x00000084)
	RndSleep(1000)

	Do
		$DeadOnTheRun = 0
		If  $enemy = "Snowmen at begining"
		If  AggroMoveTo(-15988, 10018, $enemy)

		If  CurrentAction("Avoiding snowball")
		If  AggroMoveTo(-17986, 6483)
		If  RndSleep(1000)

		If  $enemy = "Snowmen"
		If  AggroMoveTo(-17574, 2190, $enemy)

		If  $enemy = "Cleaning way"
		If  AggroMoveTo(-15361, 2551, $enemy)

		If  $enemy = "Going to shrine"
		If  AggroMoveTo(-14596, 2612, $enemy)
		If  AggroMoveTo(-14506, 3963, $enemy)
		If  $DeadOnTheRun = 1 then Sleep(15000)
	Until CheckArea(-14506, 3963, 1000)


	CurrentAction("Taking blessing")
	GoNearestNPCToCoords(-12512, 3919)
	RndSleep(500)

	Do
		$DeadOnTheRun = 0
		If  $enemy = "Snowman on the way"
		If  CurrentAction("Moving away")
		If  AggroMoveTo(-14556, 4065)
		If  AggroMoveTo(-14596, 2612)
		If  CurrentAction("Avoiding Icy")
		If  AggroMoveTo(-14583, 1896)
		If  AggroMoveTo(-14262, 974)
		If  AggroMoveTo(-13759, -552)
		If  AggroMoveTo(-13306, -1211)
		If  AggroMoveTo(-12570, -2997)


		If  $enemy = "Snowman"
		If  AggroMoveTo(-13114, -6255, $enemy)
		If  AggroMoveTo(-14367, -9244, $enemy)
		If  $DeadOnTheRun = 1 then Sleep(15000)
	Until CheckArea(-14367, -9244, 100)

	CurrentAction("Taking blessing")
	GoNearestNPCToCoords(-16025, -10702, 100)
	RndSleep(500)

	Do
		$DeadOnTheRun = 0
		If  $enemy = "Ennemy near door"
		If  AggroMoveTo(-15396, -10850, $enemy)
		If  Moveto(-13970, -9719)
		If  Moveto(-13047, -10683)
		If  $enemy = "Angry Snowman"
		If  AggroMoveTo(-10097, -11373, $enemy)
		If  $DeadOnTheRun = 1 then Sleep(15000)
	Until CheckArea(-10097, -11373, 1000)

	$enemy = "Grabing Key"
	Moveto(-9852, -11078)
	RndSleep(500)
	PickUpLoot()
	RndSleep(2000)
	MoveTo(-9547, -10960)
	RndSleep(500)
	PickUpLoot()
	Sleep(1000)

	CurrentAction("Going to open the door")
	Moveto(-11464, -11034)
	Moveto(-14162, -9527)
	Moveto(-15284, -10824)
	Moveto(-15454, -12245)
	RndSleep(500)
	$door = GetNearestSignpostToAgent()
	RndSleep(500)
	GoSignpost($door)
	RndSleep(500)
	Moveto(-15869, -12119)

	Do
		$DeadOnTheRun = 0
		If  $enemy = "Snowman"
		If  AggroMoveTo(-17287, -13895, $enemy)

		If  $enemy = "Boss and others"
		If  AggroMoveTo(-15483, -16565, $enemy)
		If  AggroMoveTo(-13362, -17430, $enemy)
		If  $DeadOnTheRun = 1 then Sleep(15000)
	Until CheckArea(-13362, -17430, 1000)

	CurrentAction("Grabing boss key")
	Moveto(-12974, -17414)
	RndSleep(500)
	PickUpLoot()

	CurrentAction("Going to open door")
	Moveto(-11215, -18002)
	$door = GetNearestSignpostToAgent()
	RndSleep(500)
	GoSignpost($door)
	RndSleep(500)

	Moveto(-11300, -18290)
	CurrentAction("Going in")
	Moveto(-9618, -19271)
	CurrentAction("Move to chest")
	Moveto(-7856, -19136)
	Moveto(-7560, -18592)

	EnsureEnglish(True)

	CurrentAction("Waiting on Chest")
	local $chestspawn = False
	local $TimerGuynotThere = TimerInit()
	Do
		TargetNearestItem()
		Sleep(500)
		If DllStructGetData(GetCurrentTarget(), 'ID') <> 32 Then $chestspawn = True
		If TimerDiff($TimerGuynotThere) > 215000 Then
			CurrentAction("Apparently, Koris is stuck somewhere on the dungeon, go again")
			Sleep(2000)
			Return
		EndIf
	Until $chestspawn = True

	RndSleep(500)

	CurrentAction("Opening Chest")
	$chest = GetNearestSignpostToAgent()
	RndSleep(500)
	GoSignpost($chest)
	RndSleep(1000)

	CurrentAction("Picking")
	PickUpLoot()
	RndSleep(500)
	;id=251
	;(-7594, -18657)

	WaitForLoad()
	RndTravel($Map_To_Zone)

	CurrentAction("Drop Quest")
	Sleep(5000)
	AbandonQuest(898)
	Sleep(500)
	SwapDistricts()
EndFunc

Func VQAsura();

	$DeadOnTheRun = 0

	CurrentAction("Taking Blessing")
	GoNearestNPCToCoords(14796, 13170)
	Sleep(1000)
	Dialog(0x83)
	Sleep(1000)
	Dialog(0x84)
	Sleep(1000)
	Dialog(0x85)
	Sleep(5000)
	$DeadOnTheRun = 0

	if $Bool_cons then
		UseConsets()
	EndIf

	If  CurrentAction("Moving")
	If  MoveTo(16722, 11774)
	If  CurrentAction("Moving")
	If  MoveTo(17383, 8685)

	If  AggroMoveTo(18162, 6670, "First Spider Group")
	If  AggroMoveTo(18447, 4537, "Second Spider Group")
	If  AggroMoveTo(18331, 2108, "Spider Pop")
	If  AggroMoveTo(17526, 143, "Spider Pop 2")
	If  AggroMoveTo(17205, -1355, "Third Spider Group")
	If  AggroMoveTo(17366, -5132, "Krait Group")
	If  AggroMoveTo(18111, -8030, "Krait Group")

	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(18409, -8474)
	If  Sleep(2000)
	If  AggroMoveTo(18613, -11799, "Froggy Group")
	If  AggroMoveTo(17154, -15669, "Krait Patrol")
	If  AggroMoveTo(14250, -16744, "Second Patrol")
	If  AggroMoveTo(12186, -14139, "Krait Patrol")
	If  AggroMoveTo(12540, -13440, "Krait Patrol")
	If  AggroMoveTo(13234, -9948, "Krait Group")
	If  AggroMoveTo(8875, -9065, "Krait Group")
	If  AggroMoveTo(4671, -8699, "Krait Patrol")
	If  AggroMoveTo(1534, -5493, "Krait Group")
	If  CurrentAction("Moving")
	If  MoveTo(1052, -7074)
	If  AggroMoveTo(-1029, -8724, "Spider Group")
	If  AggroMoveTo(-3439, -10339, "Krait Group")
	If  AggroMoveTo(-3024, -12586, "Spider Cave")
	Sleep(1000)
	If  AggroMoveTo(-2797, -13645, "Spider Cave")
	If  AggroMoveTo(-3393, -15633, "Spider Cave")
	If  AggroMoveTo(-4635, -16643, "Spider Pop")
	If  AggroMoveTo(-7814, -17796, "Spider Group")

	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(-10109, -17520)
	If  Sleep(2000)
	If  CurrentAction("Moving")
	If  MoveTo(-9111, -17237)
	If  AggroMoveTo(-10963, -15506, "Ranger Boss Group")
	If  AggroMoveTo(-12885, -14651, "Froggy Group")
	If  AggroMoveTo(-13975, -17857, "Corner Spiders")
	If  AggroMoveTo(-11912, -10641, "Froggy Group")
	If  AggroMoveTo(-8760, -9933, "Krait Boss Warrior")
	If  AggroMoveTo(-14030, -9780, "Froggy Coing Group")
	If  AggroMoveTo(-12368, -7330, "Froggy Group")
	If  AggroMoveTo(-16527, -8175, "Froggy Patrol")
	If  AggroMoveTo(-17391, -5984, "Froggy Group")
	If  AggroMoveTo(-15704, -3996, "Froggy Patrol")
	If  CurrentAction("Moving")
	If  MoveTo(-16609, -2607)
	If  CurrentAction("Moving")
	If  MoveTo(-15476, 186)
	If  AggroMoveTo(-16480, 2522, "Krait Group")
	If  AggroMoveTo(-17090, 5252, "Krait Group")

	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(-19292, 8994)
	If  Sleep(2000)
	If  CurrentAction("Moving")
	If  MoveTo(-18640, 8724)
	If  AggroMoveTo(-18484, 12021, "Krait Patrol")
	If  AggroMoveTo(-17180, 13093, "Krait Patrol")
	If  AggroMoveTo(-15072, 14075, "Froggy Group")
	If  AggroMoveTo(-11888, 15628, "Froggy Group")
	If  AggroMoveTo(-12043, 18463, "Froggy Boss Warrior")
	If  AggroMoveTo(-8876, 17415, "Froggy Group")
	If  AggroMoveTo(-5778, 19838, "Froggy Group")
	If  AggroMoveTo(-10970, 16860, "Moving Back")
	If  AggroMoveTo(-9301, 15054, "Moving")
	If  AggroMoveTo(-5379, 16642, "Krait Group")
	If  AggroMoveTo(-4430, 17268, "Krait Group")
	If  AggroMoveTo(-2974, 14197, "Krait Group")
	If  AggroMoveTo(-5228, 12475, "Boss Patrol")
	If  AggroMoveTo(-3468, 10837, "Lonely Patrol")

	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(-2037, 10758)
	If  Sleep(2000)

	If  AggroMoveTo(-3804, 8017, "Krait Group")
	If  AggroMoveTo(-1346, 12360, "Moving")
	If  CurrentAction("Moving")
	If  MoveTo(874, 14367)
	If  AggroMoveTo(3572, 13698, "Krait Group Standing")
	If  AggroMoveTo(5899, 14205, "Moving")
	If  AggroMoveTo(7407, 11867, "Krait Group")
	If  AggroMoveTo(9541, 9027, "Rider")
	If  AggroMoveTo(12639, 7537, "Rider Group")
	If  AggroMoveTo(9064, 7312, "Rider")
	If  AggroMoveTo(7986, 4365, "Krait group")
	If  AggroMoveTo(6341, 3029, "Krait Group")
	If  AggroMoveTo(7097, 92, "Krait Group")

	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(4893, 445)
	If  Sleep(2000)
	If  AggroMoveTo(8943, -985, "Krait Boss")
	If  AggroMoveTo(10949, -2056, "Krait Patrol")
	If  AggroMoveTo(13780, -5667, "Rider Patrol", 2000)

	;If  AggroMoveTo(10566, -3196, "Moving Back")
	If  AggroMoveTo(12444, -793, "Moving Back",3000)
	;If  AggroMoveTo(10752, 991, "Moving Back")

	If  AggroMoveTo(8193, -841, "Moving Back",3000)
	If  AggroMoveTo(3284, -1599, "Krait Group")
	If  AggroMoveTo(-76, -1498, "Krait Group")
	If  AggroMoveTo(578, 719, "Krait Group")
	If  AggroMoveTo(316, 2489, "Krait Group")
	If  AggroMoveTo(-1018, -1235, "Moving Back")
	If  AggroMoveTo(-3195, -1538, "Krait Patrol")
	If  AggroMoveTo(-6322, -2565, "Krait Group")

	If  CurrentAction("Taking Blessing")
	If  GoNearestNPCToCoords(-9231, -2629)
	If  Sleep(3000)

	If  AggroMoveTo(-11414, 4055, "Leftovers Krait")
	If  AggroMoveTo(-6907, 8461, "Moving")
	If  AggroMoveTo(-8689, 11227, "Leftovers Krait and Rider",10000)

EndFunc

Func VQTreasure_Hunter()
	$DeadOnTheRun = 0

	Sleep(1000)
	_Run(2728, -25294)
  	_Run(2900, -22272)
  	_Run(-1000, -19801)
  	_Run(-2570, -17208)
  	_Run(-4218, -15219)
	CurrentAction("Checking Chests")
			CheckForChest()
			PickUpLoot()
	_Run(-2437.75, -14134.97)
			CheckForChest()
			PickUpLoot()
	_Run(1814.24, -14472.84)
			CheckForChest()
			PickUpLoot()
	_Run(4535.45, -16012.80)
			CheckForChest()
			PickUpLoot()
	CurrentAction("Completed Run")
	RndSleep(2000)
	Return True
EndFunc	;==>VQTreasureHunte
#EndRegion

Func SwapDistricts()
	CurrentAction("Moving GH")

	TravelGH()
	RndSleep(3000)
	CurrentAction("Leaving GH")
	LeaveGH()

	RndSleep(3000)
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