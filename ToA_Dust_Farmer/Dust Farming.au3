#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include "GWA2.au3"
#include "GWAAddsOn.au3"
#include "CommonFunction.au3"


global $DeadOnTheRun = 0,$tpspirit = 0, $WeAreDead


While 1
	If $boolrun = true Then
		If $NumberRun = 0 Then
			AdlibRegister("status", 1000)
			$TimerTotal = TimerInit()
			FileOpen($File)
		EndIf
		If GetMapID() <> 138 Then
			CurrentAction("Moving to Outpost")
			ZoneMap(138, 0)
			WaitForLoad()
			rndslp(4000)
		EndIf
		rndslp(3000)
		$NumberRun = $NumberRun +1
		CurrentAction("Begin run number " & $NumberRun)
		If CheckIfInventoryIsFull() then SellItemToMerchant()
		StoreDust()
		GoOut()
		RunToSpot()
		Farm()
	EndIf
	sleep(50)
WEnd

Func StoreDust()
	Dust(1, 20)
	Dust(2, 5)
	Dust(3, 10)
	Dust(4, 10)
EndFunc

Func Dust($bagIndex, $numOfSlots)
	For $i = 1 To $numOfSlots
		$aItem = GetItemBySlot($bagIndex, $i)
		If DllStructGetData($aItem, 'ID') = 0 Then ContinueLoop
		$m = DllStructGetData($aItem, 'ModelID')
		$q = DllStructGetData($aItem, 'quantity')
		If ($m = 929 or $m = 441) And $q = 250 Then
			Do
				For $bag = 8 To 12; Storage panels are form 8 till 16 (I have only standard amount plus aniversary one)
					$slot = FindEmptySlot($bag)
					$slot = @extended
					If $slot <> 0 Then
						$FULL = False
						$nSlot = $slot
						ExitLoop 2; finding first empty $slot in $bag and jump out
					Else
						$FULL = True; no empty slots :(
					EndIf
					Sleep(400)
				Next
			Until $FULL = True
			If $FULL = False Then
				MoveItem($aItem, $bag, $nSlot)
				Sleep(Random(450, 550))
			EndIf
		EndIf
	Next
EndFunc   ;==>GoldIs

Func GoOut()
	RndSleep(250)
	CurrentAction("Going out")
	Move(-5242, 15691)
	WaitForLoad()
	rndslp(5000)
EndFunc

Func RunToSpot()
	$WeAreDead = False
	AdlibRegister("CheckDeath", 1000)
	AdlibRegister("HealYourself", 2000)
	If Not $WeAreDead then CurrentAction("Waypoint 1")
	If Not $WeAreDead then MoveTo(-6948, 14664)
	If Not $WeAreDead then CurrentAction("Waypoint 2")
	If Not $WeAreDead then MoveTo(-7796, 12417)
	If Not $WeAreDead then CurrentAction("Waypoint 3")
	If Not $WeAreDead then MoveTo(-8083, 7860)
	If Not $WeAreDead then CurrentAction("Waypoint 4")
	If Not $WeAreDead then MoveTo(-7961, 6137)
	If Not $WeAreDead then CurrentAction("Waypoint 5")
	If Not $WeAreDead then MoveTo(-5914, 4919)
	If Not $WeAreDead then CurrentAction("Waypoint 6")
	If Not $WeAreDead then MoveTo(-5025, 3833)
	If Not $WeAreDead then CurrentAction("Casting Spirit To Avoid")
	If Not $WeAreDead then UseSkill(1, 0)
	If Not $WeAreDead then rndslp(1200)
	If Not $WeAreDead then UseSkill(2, 0)
	If Not $WeAreDead then rndslp(800)
	If Not $WeAreDead then CurrentAction("Waypoint 7")
	If Not $WeAreDead then MoveTo(-2882, 2839)
	If Not $WeAreDead then CurrentAction("Casting Spirit To Avoid")
	If Not $WeAreDead then UseSkill(3, 0)
	If Not $WeAreDead then rndslp(1200)
	If Not $WeAreDead then UseSkill(5, 0)
	If Not $WeAreDead then rndslp(1200)
	If Not $WeAreDead then CurrentAction("Waypoint 8")
	If Not $WeAreDead then MoveTo(-479, 1967)
	If Not $WeAreDead then CurrentAction("Waypoint 9")
	If Not $WeAreDead then MoveTo(2490, -61)
	If Not $WeAreDead then CurrentAction("Waypoint 10")
	If Not $WeAreDead then MoveTo(3531, -1480)
	If Not $WeAreDead then CurrentAction("Waypoint 11")
	If Not $WeAreDead then MoveTo(4920, -2596)
	If Not $WeAreDead then CurrentAction("Waiting Full Life and Energy")
	local $timertobethebest = TimerInit()
	If Not $WeAreDead then
		Do
			rndslp(500)
			$me2 = GetAgentByID(-2)
		Until (DllStructGetData($me2, 'EnergyPercent') = 1 And DllStructGetData($me2, 'HP') = 1) or TimerDiff($timertobethebest) > 40000
	EndIf
EndFunc

Func Farm()
	If Not $WeAreDead Then CurrentAction("Nightmare group 1/3")
	If Not $WeAreDead Then Engage()
	If Not $WeAreDead Then CollectObject()
	If CheckIfInventoryIsFull() and Not $WeAreDead then $WeAreDead = True
	If Not $WeAreDead Then CurrentAction("Nightmare group 2/3")
	If Not $WeAreDead Then Engage()
	If Not $WeAreDead Then CollectObject()
	If CheckIfInventoryIsFull() and Not $WeAreDead then $WeAreDead = True
	If Not $WeAreDead then MoveTo(7321, -3438)
	If Not $WeAreDead Then CurrentAction("Nightmare group 3/3")
	If Not $WeAreDead Then Engage()
	If Not $WeAreDead Then CollectObject()
	If CheckIfInventoryIsFull() and Not $WeAreDead then $WeAreDead = True
	If Not $WeAreDead Then $enemy = "Pop On The Way"
	If Not $WeAreDead Then AggroMoveToEx(10338, -5940, $enemy)
	If CheckIfInventoryIsFull() and Not $WeAreDead then $WeAreDead = True
	If Not $WeAreDead Then $enemy = "Pop On The Way 2"
	If Not $WeAreDead Then AggroMoveToEx(12720, -5286, $enemy)
	If CheckIfInventoryIsFull() and Not $WeAreDead then $WeAreDead = True
	If Not $WeAreDead Then $enemy = "Nightmare group"
	If Not $WeAreDead Then AggroMoveToEx(12588, -818, $enemy)
	If CheckIfInventoryIsFull() and Not $WeAreDead then $WeAreDead = True
	If Not $WeAreDead Then $enemy = "Nightmare group"
	If Not $WeAreDead Then AggroMoveToEx(12432, 1077, $enemy)
	If CheckIfInventoryIsFull() and Not $WeAreDead then $WeAreDead = True
	If Not $WeAreDead Then $enemy = "Nightmare group"
	If Not $WeAreDead Then AggroMoveToEx(10303, 980, $enemy)
	If CheckIfInventoryIsFull() and Not $WeAreDead then $WeAreDead = True
	If Not $WeAreDead Then $enemy = "Nightmare group"
	If Not $WeAreDead Then AggroMoveToEx(9720, 2245, $enemy)
	AdlibUnRegister("CheckDeath")
	AdlibUnRegister("HealYourself")
	CurrentAction("End Of Run")
	rndslp(2000)
EndFunc

Func CollectObject()
	rndslp(1000)
	If Not $WeAreDead Then CurrentAction("Pickup Loot From Nightmare")
	PickupItems()
	CheckIfInventoryIsFull()
	If Not $WeAreDead Then CurrentAction("Little Break/Waiting Bar Recast")
 	Do
		local $NearestAgent = GetNearestEnemyToAgent(-2)
		$distance = @extended
		If $distance < 1020 Then
			Fight2()
			CollectObject()
		EndIf
 		If Not $WeAreDead Then RndSlp(500)
 	Until (DllStructGetData(GetAgentByID(-2), 'EnergyPercent') >= 0.7 and DllStructGetData(GetSkillbar(), 'Recharge3') = 0 And DllStructGetData(GetSkillbar(), 'Recharge4') = 0 And DllStructGetData(GetSkillbar(), 'Recharge1') = 0) OR $WeAreDead
EndFunc   ;==>CollectObject

Func Engage()
	local $NearestAgent = GetNearestEnemyToAgent(-2)
	$distance = @extended
	If $distance < 4000 Then
		local $timer = TimerInit()
		If Not $WeAreDead Then Attack(DllStructGetData($NearestAgent,'ID'))
		Do
			If Not $WeAreDead Then RNDSLP(100)
			$NearestAgent = GetNearestEnemyToAgent(-2)
			$distance = @extended
		Until $distance < 1000 OR TimerDiff($timer) > 15000 OR $WeAreDead
		If TimerDiff($timer) < 15000 Then
			If Not $WeAreDead Then Fight2()
		EndIf
	EndIf
EndFunc   ;==>Engage

Func Fight2()
	If Not $WeAreDead Then UseSkill(6, -2)
	If Not $WeAreDead Then RndSlp(1000)
	If Not $WeAreDead Then UseSkill(1, -2)
	If Not $WeAreDead Then RNDSLP(1400)
	If Not $WeAreDead Then UseSkill(2, -2)
	If Not $WeAreDead Then RNDSLP(1500)
	If Not $WeAreDead Then UseSkill(3, -2)
	If Not $WeAreDead Then RNDSLP(1500)
	If Not $WeAreDead Then UseSkill(4, -2)
	If Not $WeAreDead Then RNDSLP(1500)
	If Not $WeAreDead Then UseSkill(5, -2)
	If Not $WeAreDead Then RNDSLP(1500)
	If Not $WeAreDead Then UseSkill(6, -2)
	If Not $WeAreDead Then RndSlp(1000)
	If Not $WeAreDead Then UseSkill(7, -2)
	If Not $WeAreDead Then RndSlp(1500)
	If Not $WeAreDead Then CheckAllDeath()
EndFunc   ;==>FIGHT

Func checkalldeath()
	Local $nearest
	local $TimerDeath = TimerInit()
	Do
		$nearest = GetNearestEnemyToAgent(-2)
		$distance = @extended
		If Not $WeAreDead Then RNDSLP(500)
		If Not $WeAreDead Then
			For $i = 1 to 7
				$nearest = GetNearestEnemyToAgent(-2)
				$distance = @extended
				If $distance > 1020 then ExitLoop
				If DllStructGetData(GetSkillbar(), 'Recharge' & $i) = 0 Then
					If $i = 6 Then
						rndslp(3000)
					EndIf
					If Not $WeAreDead Then UseSkill($i, -2)
					If Not $WeAreDead Then RndSlp(1500)
				EndIf
			Next
		EndIf
;~ 		If DllStructGetData(GetAgentByID(-2), 'HP') <= 0.75 Then
;~ 			MoveBackward(True)
;~ 		EndIf
	Until ($distance > 1020) OR (TimerDiff($TimerDeath)) > 90000 OR $WeAreDead
EndFunc

Func HealYourself()
	local $me = GetAgentByID(-2)
	If DllStructGetData(GetSkillbar(), 'Recharge8') = 0 AND  DllStructGetData($me, 'EnergyPercent') >= 0.10 And DllStructGetData($me, 'HP') <= 0.75 And $WeAreDead = False Then
		UseSkill(8, 0)
		rndslp(1200)
	EndIf
EndFunc

Func status()
	$time = TimerDiff($TimerTotal)
	$string = StringFormat("min: %03u  sec: %02u ", $time/1000/60, Mod($time/1000,60))
	GUICtrlSetData($label_stat, $string)
EndFunc    ;==>status

Func CheckDeath()
	If Death() = 1 Then
		$WeAreDead = True
		CurrentAction("We Are Dead")
	EndIf
EndFunc   ;==>CheckDeath

Func AggroMoveToEx($x, $y, $s = "", $z = 1450)
	local $TimerToKill = TimerInit()
	CurrentAction("Hunting " & $s)
	$random = 50
	$iBlocked = 0

	Move($x, $y, $random)

	$lMe = GetAgentByID(-2)
	$coordsX =DllStructGetData($lMe, "X")
	$coordsY = DllStructGetData($lMe, "Y")

	Do
		rndslp(50)
		$oldCoordsX = $coordsX
		$oldCoordsY = $coordsY
		$nearestenemy = GetNearestEnemyToAgent(-2)
		$lDistance = GetDistance($nearestenemy, -2)
		If $lDistance < $z AND DllStructGetData($nearestenemy, 'ID') <> 0 AND $WeAreDead = false Then
			Engage()
			CollectObject()
		EndIf
		$lMe = GetAgentByID(-2)
		$coordsX =DllStructGetData($lMe, "X")
		$coordsY = DllStructGetData($lMe, "Y")
		If $oldCoordsX = $coordsX AND $oldCoordsY = $coordsY Then
			$iBlocked += 1
			Move($coordsX, $coordsY, 500)
			RndSlp(350)
			Move($x, $y, $random)
		EndIf
	Until ComputeDistanceEx($coordsX, $coordsY, $x, $y) < 250 OR $iBlocked > 20 OR $WeAreDead
	$TimerToKillDiff = TimerDiff($TimerToKill)
	$Text = StringFormat("min: %03u  sec: %02u ", $TimerToKillDiff/1000/60, Mod($TimerToKillDiff/1000,60))
	FileWriteLine($File, $s & " en ================================== >   " & $Text & @CRLF)
EndFunc

;~ Func AggroMoveToEx($x, $y, $s = "", $z = 1450)
;~ 	local $TimerToKill = TimerInit()
;~ 	CurrentAction("Hunting " & $s)
;~ 	$random = 50
;~ 	$iBlocked = 0

;~ 	If Not $WeAreDead Then Move($x, $y, $random)

;~ 	$lMe = GetAgentByID(-2)
;~ 	$coordsX =DllStructGetData($lMe, "X")
;~ 	$coordsY = DllStructGetData($lMe, "Y")

;~ 	If Not $WeAreDead Then
;~ 		Do
;~ 			rndslp(50)
;~ 			If Not $WeAreDead Then ExitLoop
;~ 			$oldCoordsX = $coordsX
;~ 			$oldCoordsY = $coordsY
;~ 			$nearestenemy = GetNearestEnemyToAgent(-2)
;~ 			$lDistance = GetDistance($nearestenemy, -2)
;~ 			If Not $WeAreDead Then ExitLoop
;~ 			If $lDistance < $z AND DllStructGetData($nearestenemy, 'ID') <> 0 AND Not $WeAreDead Then
;~ 				If Not $WeAreDead Then Fight2()
;~ 				If Not $WeAreDead Then CollectObject()
;~ 			EndIf
;~ 			$lMe = GetAgentByID(-2)
;~ 			$coordsX =DllStructGetData($lMe, "X")
;~ 			$coordsY = DllStructGetData($lMe, "Y")
;~ 			If $oldCoordsX = $coordsX AND $oldCoordsY = $coordsY Then
;~ 				$iBlocked += 1
;~ 				If Not $WeAreDead Then Move($coordsX, $coordsY, 500)
;~ 				If Not $WeAreDead Then RndSlp(350)
;~ 				If Not $WeAreDead Then Move($x, $y, $random)
;~ 			EndIf
;~ 		Until ComputeDistanceEx($coordsX, $coordsY, $x, $y) < 250 OR $iBlocked > 20 OR $WeAreDead
;~ 	EndIf
;~ 	$TimerToKillDiff = TimerDiff($TimerToKill)
;~ 	$Text = StringFormat("min: %03u  sec: %02u ", $TimerToKillDiff/1000/60, Mod($TimerToKillDiff/1000,60))
;~ 	FileWriteLine($File, $s & " en ================================== >   " & $Text & @CRLF)
;~ EndFunc