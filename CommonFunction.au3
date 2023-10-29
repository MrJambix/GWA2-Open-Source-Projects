#include-once

Global $strName = ""
Global $NumberRun = 0
global $boolrun = False
Global $strName = ""
Global $coords[2]
Global $Title, $sGW
Global $Bool_Donate = False, $Bool_IdAndSell = False, $Bool_HM = False, $Bool_Store = False, $Bool_PickUp = False

Global $File = @ScriptDir & "\Trace\Traça du " & @MDAY & "-" & @MON & " a " & @HOUR & "h et " & @MIN & "minutes.txt"



Global $intSkillEnergy[8] = [1, 15, 5, 5, 10, 15, 10, 5]
; Change the next lines to your skill casting times in milliseconds. use ~250 for shouts/stances, ~1000 for attack skills:
Global $intSkillCastTime[8] = [1000, 1250, 1250, 1250, 1250, 1000,  250, 1000]
; Change the next lines to your skill adrenaline count (1 to 8). leave as 0 for skills without adren
Global $intSkillAdrenaline[8] = [0, 0, 0, 0, 0, 0, 0, 0]

Global $totalskills = 7

Opt("GUIOnEventMode", 1)

#Region ### START Koda GUI section ### Form=c:\bot\reputation farming\title package\form1.kxf
global $Form1_1 = GUICreate("Globeul -Title Package updated", 321, 283, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Start = GUICtrlCreateButton("Start", 264, 248, 51, 25)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
GUICtrlCreateGroup("Title", 152, 8, 161, 129)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Radio_Asura = GUICtrlCreateRadio("Asura", 168, 32, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Deldrimor = GUICtrlCreateRadio("Deldrimor", 232, 32, 65, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Vanguard = GUICtrlCreateRadio("Vanguard", 232, 56, 73, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Norn = GUICtrlCreateRadio("Norn", 168, 56, 49, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Kurzick = GUICtrlCreateRadio("Kurzick", 232, 80, 65, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Luxon = GUICtrlCreateRadio("Luxon", 232, 104, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_SS_and_LB = GUICtrlCreateRadio("LB/SS", 168, 80, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_SS = GUICtrlCreateRadio("SS", 168, 104, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateGroup("General Config", 152, 136, 161, 105)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Gui_Id_and_sell = GUICtrlCreateCheckbox("Id and Sell", 168, 184, 75, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Gui_Store_unid = GUICtrlCreateCheckbox("Store Unid", 168, 160, 73, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Gui_HM_enable = GUICtrlCreateCheckbox("HM", 168, 208, 49, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Gui_Donate = GUICtrlCreateCheckbox("Donate", 248, 208, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $gui_cons = GUICtrlCreateCheckbox("Cons", 248, 160, 65, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Gui_PickUp = GUICtrlCreateCheckbox("PickUp", 248, 184, 60, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
;global $txtName = GUICtrlCreateInput($strName, 152, 248, 105, 21)
Global Const $txtName = GUICtrlCreateCombo("", 152, 248, 105, 21, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, GetLoggedCharNames())
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateGroup("Points Status", 8, 8, 137, 161)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Asura", 24, 32, 31, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Deldrimor", 24, 48, 48, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Vanguard", 24, 64, 50, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Norn", 24, 80, 27, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Kurzick", 24, 96, 39, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Luxon", 24, 112, 33, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("LB", 24, 128, 17, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("SS", 24, 144, 18, 17)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_Asura = GUICtrlCreateLabel("0", 96, 32, 40, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x808000)
global $Pt_Deldrimor  = GUICtrlCreateLabel("0", 96, 48, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_Vanguard  = GUICtrlCreateLabel("0", 96, 64, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_Norn  = GUICtrlCreateLabel("0", 96, 80, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_Kurzick  = GUICtrlCreateLabel("0", 96, 96, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_Luxon  = GUICtrlCreateLabel("0", 96, 112, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_LB  = GUICtrlCreateLabel("0", 96, 128, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
global $Pt_SS  = GUICtrlCreateLabel("0", 96, 144, 40, 17, $SS_RIGHT)
GUICtrlSetColor(-1, 0x808000)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Current action :", 40, 192, 79, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $STATUS = GUICtrlCreateLabel("Script Not Started Yet", 16, 208, 124, 17, $SS_CENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $label_stat = GUICtrlCreateLabel("min: 000  sec: 00", 24, 176, 105, 17, $SS_CENTER)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateGroup("Runs", 8, 224, 137, 49)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateLabel("Total Runs", 16, 248, 56, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x008000)
global $gui_status_runs = GUICtrlCreateLabel("0", 96, 248, 10, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x008000)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUISetOnEvent($GUI_EVENT_CLOSE, "gui_eventHandler")
GUICtrlSetState($Gui_Id_and_sell, $GUI_CHECKED)
GUICtrlSetState($Gui_Store_unid, $GUI_CHECKED)
GUICtrlSetState($Gui_HM_enable, $GUI_CHECKED)
GUICtrlSetState($Gui_PickUp, $GUI_CHECKED)
GUICtrlSetState($Radio_Asura, $GUI_CHECKED)
GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

func gui_eventHandler()
	switch (@GUI_CtrlId)
		Case $Radio_Deldrimor
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_Asura
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_Vanguard
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_Norn
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_Kurzick
			GUICtrlSetState($Gui_Donate, $GUI_ENABLE)
			GUICtrlSetState($Gui_Donate, $GUI_CHECKED)
		Case $Radio_Luxon
			GUICtrlSetState($Gui_Donate, $GUI_ENABLE)
			GUICtrlSetState($Gui_Donate, $GUI_CHECKED)
		Case $Radio_SS
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_SS_and_LB
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		case $GUI_EVENT_CLOSE
			exit
		case $Start
			$NumberRun = 0
			$RunSuccess = 0
			$boolrun = True

			GUICtrlSetState($Radio_Asura, $GUI_DISABLE)
			GUICtrlSetState($Radio_Deldrimor, $GUI_DISABLE)
			GUICtrlSetState($Radio_Vanguard, $GUI_DISABLE)
			GUICtrlSetState($Radio_Norn, $GUI_DISABLE)
			GUICtrlSetState($Radio_Kurzick, $GUI_DISABLE)
			GUICtrlSetState($Radio_Luxon, $GUI_DISABLE)
			GUICtrlSetState($Radio_SS_and_LB, $GUI_DISABLE)
			GUICtrlSetState($Radio_SS, $GUI_DISABLE)
			GUICtrlSetState($Gui_Id_and_sell, $GUI_DISABLE)
			GUICtrlSetState($Gui_Store_unid, $GUI_DISABLE)
			GUICtrlSetState($Gui_HM_enable, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Start, $GUI_DISABLE)
			GUICtrlSetState($txtName, $GUI_DISABLE)

			If BitAND(GUICtrlRead($Radio_Asura), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Asura"
			ElseIf BitAND(GUICtrlRead($Radio_Deldrimor), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Deldrimor"
			ElseIf BitAND(GUICtrlRead($Radio_Vanguard), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Vanguard"
			ElseIf BitAND(GUICtrlRead($Radio_Norn), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Norn"
			ElseIf BitAND(GUICtrlRead($Radio_Kurzick), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Kurzick"
			ElseIf BitAND(GUICtrlRead($Radio_Luxon), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Luxon"
			ElseIf BitAND(GUICtrlRead($Radio_SS_and_LB), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "SS and LB"
			ElseIf BitAND(GUICtrlRead($Radio_SS), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "SS"
			EndIf

			$Size = WinGetPos($Form1_1)
			WinMove ( $Form1_1, "", $Size[0], $Size[1], 155, 310, 1)

			If BitAND(GUICtrlRead($Gui_Id_and_sell), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_IdAndSell = True
			If BitAND(GUICtrlRead($Gui_Store_unid), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_Store = True
			If BitAND(GUICtrlRead($Gui_HM_enable), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_HM = True
			If BitAND(GUICtrlRead($Gui_Donate), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_Donate = True
			If BitAND(GUICtrlRead($Gui_PickUp), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_PickUp = True
			If BitAND(GUICtrlRead($gui_cons), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_cons = True

			If GUICtrlRead($txtName) = "" Then
				MsgBox(0, "Error", "Plz enter your name in the input box")
				Exit
			Else
				If Initialize(GUICtrlRead($txtName), "Guild Wars - " & GUICtrlRead($txtName)) = False Then
					MsgBox(0, "Error", "Can't find a Guild Wars client with that character name.")
					Exit
				EndIf
			EndIf
			$sGW = "Guild Wars - " & GUICtrlRead($txtName)
			AdlibRegister("ReduceMemory", 20000)
	endswitch
endfunc

Func ReduceMemory()
	$hWnd = WinGetHandle($sGW)
	If WinExists($hWnd) Then
		$pid = WinGetProcess($hWnd)
		$Pr_Handle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', 0x1f0fff, 'int', False, 'int', $pid)
		DllCall("psapi.dll", 'int', 'EmptyWorkingSet', 'long', $Pr_Handle[0])
		DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $Pr_Handle[0])
	EndIf
EndFunc


Func CurrentAction($MSG)
	GUICtrlSetData($STATUS, $MSG)
	GUICtrlSetData($gui_status_runs, $NumberRun)
	FileWriteLine($File, "Run : " & $NumberRun + 1 & " à : " & @Hour & ":" & @MIN & "." & @Sec & "   " & $MSG & @CRLF)
EndFunc   ;==>CurrentAction

Func SellItemToMerchant()
	If $Bool_Store Then
		CurrentAction("Storing Gold Unid")
		StoreGolds()
		Sleep(1000)
	EndIf
	If $Bool_IdAndSell Then
		CurrentAction("Going to merchant")
		If $Title = "Asura" Then
			$merchant = GetNearestNPCToCoords(18653, 13934)
		ElseIf $Title = "Deldrimor" Then
			$merchant = GetNearestNPCToCoords(-21032,10979)
		ElseIf $Title = "Vanguard" Then
			$merchant = GetNearestNPCToCoords(-19166, 17980)
		ElseIf $Title = "Norn" Then
			$merchant = GetNearestNPCToCoords(1598, -951)
		ElseIf $Title = "Kurzick" Then
			MoveTo(8481, 2005)
			$merchant = GetNearestNPCToCoords(8481, 2005)
		ElseIf $Title = "Luxon" Then
			$merchant = GetNearestNPCToCoords(-4318, 11298)
		ElseIf $Title = "SS and LB" Then
			$merchant = GetNearestNPCToCoords(-1795, -2482)
		ElseIf $Title = "SS" Then
			$merchant = GetNearestNPCToCoords(498, 1297)
		EndIf
		Sleep(1000)
		GoToNPC($merchant)
		Sleep(1000)
		If $Title = "Vanguard" Then
			Sleep(2000)
			Dialog(0x0000007F)
		EndIf
		BuyIDKit()
		Sleep(1000)
		CurrentAction("Ident inventory")
		Ident(1)
		Ident(2)
		Ident(3)
		Ident(4)
		CurrentAction("Sell inventory")
		Sell(1)
		Sell(2)
		Sell(3)
		Sell(4)
	EndIf
EndFunc  ;==>SellItemToMerchant

Func IDENT($bagIndex)
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


Func GetExtraItemInfo($aitem)
	;Use GetRarity() instead... 
    If IsDllStruct($aitem) = 0 Then $aAgent = GetItemByItemID($aitem)
    $lItemExtraPtr = DllStructGetData($aitem, "namestring")

    ;DllCall($mHandle[0], 'int', 'ReadProcessMemory', 'int', $mHandle[1], 'int', $lItemExtraPtr, 'ptr', $lItemExtraStructPtr, 'int', $lItemExtraStructSize, 'int', '')
    Return $lItemExtraStruct
EndFunc   ;==>GetExtraItemInfo

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

Func GoMerchant($id_merchant, $xmerchant, $ymerchant)
	Local $lNearestAgent, $lNearestDistance = 100000000
	Local $lDistance, $lAgentToCompare

	For $i = 1 To GetMaxAgents()
		$lAgentToCompare = GetAgentByID($i)
		If DllStructGetData($lAgentToCompare, 'PlayerNumber') <> $id_merchant then ContinueLoop
		Sleep(150)
		ChangeTarget($lAgentToCompare)
		Sleep(150)
		GoNPC($lAgentToCompare)
		ExitLoop
	Next
	Do
		Sleep(100)
	Until CheckArea($xmerchant, $ymerchant)
	Sleep(2000)
EndFunc

Func StoreGolds()
	GoldIs(1)
	GoldIs(2)
	GoldIs(3)
	GoldIs(4)
EndFunc

Func GoldIs($bagIndex)
	$lBag = GetBag($bagIndex)
	
	For $i = 1 To DllStructGetData($lBag, 'Slots')
		$aItem = GetItemBySlot($bagIndex, $i)
		ConsoleWrite("Checking items: " & $bagIndex & ", " & $i & @CRLF & GetRarity($aItem) & @crlf)
		If DllStructGetData($aItem, 'ID') <> 0 And GetRarity($aItem) = $RARITY_Gold Then
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
					ConsoleWrite("Gold item moved ...."& @CRLF)
					Sleep(Random(450, 550))
				EndIf
		EndIf
	Next
EndFunc   ;==>GoldIs


; This searches for empty slots in your Storage
;Func FindEmptySlot($BagIndex)
;	Local $LItemINFO, $aSlot
;	For $aSlot = 1 To DllStructGetData(GetBAG($BagIndex), "Slots")
;		Sleep(40)
;		$LItemINFO = GetItemBySlot($BagIndex, $aSlot)
;		If DllStructGetData($LItemINFO, "ID") = 0 Then
;			SetExtended($aSlot)
;			ExitLoop
;		EndIf
;	Next
;	Return 0
;EndFunc



Func CheckIfInventoryIsFull()
	If CountSlots() = 0 Then
		return true
	Else
		return false
	EndIf
EndFunc   ;==>CheckIfInventoryIsFull

Func WaitForLoad()
	CurrentAction("Loading zone")
	InitMapLoad()
	$deadlock = 0
	Do
		Sleep(100)
		$deadlock += 100
		$load = GetMapLoading()
		$lMe = GetAgentByID(-2)

	Until $load = 2 And DllStructGetData($lMe, 'X') = 0 And DllStructGetData($lMe, 'Y') = 0 Or $deadlock > 1000

	$deadlock = 0
	Do
		Sleep(100)
		$deadlock += 100

		$deadlock += 100
		$load = GetMapLoading()
		$lMe = GetAgentByID(-2)

	Until $load <> 2 And DllStructGetData($lMe, 'X') <> 0 And DllStructGetData($lMe, 'Y') <> 0 Or $deadlock > 3000
	CurrentAction("Load complete")
	Sleep(1000)
EndFunc   ;==>WaitForLoad

Func CountSlots()
	Local $bag
	Local $temp = 0
	$bag = GetBag(1)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(2)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(3)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	$bag = GetBag(4)
	$temp += DllStructGetData($bag, 'slots') - DllStructGetData($bag, 'ItemsCount')
	Return $temp
EndFunc   ;==>CountSlots


Func AggroMoveToEx($x, $y, $s = "", $z = 1450)
	Local $TimerToKill = TimerInit()
	CurrentAction("Hunting " & $s)
	$random = 50
	$iBlocked = 0

	If $DeadOnTheRun = 0 Then Move($x, $y, $random)

	$lMe = GetAgentByID(-2)
	$coordsX = DllStructGetData($lMe, "X")
	$coordsY = DllStructGetData($lMe, "Y")

	If $DeadOnTheRun = 0 Then
		Do
			If $DeadOnTheRun = 1 Then ExitLoop
			;If $DeadOnTheRun = 0 Then Sleep(250) //////
			$oldCoordsX = $coordsX
			$oldCoordsY = $coordsY
			$nearestenemy = GetNearestEnemyToAgent(-2)
			$lDistance = GetDistance($nearestenemy, -2)
			If $DeadOnTheRun = 1 Then ExitLoop
			If $lDistance < $z And DllStructGetData($nearestenemy, 'ID') <> 0 And $DeadOnTheRun = 0 Then

					FightEx($z, $s = "enemies")

			EndIf
			;If $DeadOnTheRun = 0 Then Sleep(250) /////
			$lMe = GetAgentByID(-2)
			$coordsX = DllStructGetData($lMe, "X")
			$coordsY = DllStructGetData($lMe, "Y")
			If $oldCoordsX = $coordsX And $oldCoordsY = $coordsY Then
				$iBlocked += 1
				If $DeadOnTheRun = 0 Then Move($coordsX, $coordsY, 500)
				If $DeadOnTheRun = 0 Then Sleep(350)
				If $DeadOnTheRun = 0 Then Move($x, $y, $random)
			EndIf
		Until ComputeDistanceEx($coordsX, $coordsY, $x, $y) < 250 Or $iBlocked > 20 Or $DeadOnTheRun = 1
	EndIf
	$TimerToKillDiff = TimerDiff($TimerToKill)
	$TEXT = StringFormat("min: %03u  sec: %02u ", $TimerToKillDiff / 1000 / 60, Mod($TimerToKillDiff / 1000, 60))
	FileWriteLine($File, $s & " en ================================== >   " & $TEXT & @CRLF)
EndFunc   ;==>AggroMoveToEx

Func AggroMoveTo($x, $y, $s = "", $z = 1450)
	CurrentAction("Hunting " & $s)
	$random = 50
	$iBlocked = 0

	Move($x, $y, $random)


	$lMe = GetAgentByID(-2)
	$coordsX = DllStructGetData($lMe, "X")
	$coordsY = DllStructGetData($lMe, "Y")

	Do
		RndSleep(250)
		$oldCoordsX = $coordsX
		$oldCoordsY = $coordsY
		$nearestenemy = GetNearestEnemyToAgent(-2)
		$lDistance = GetDistance($nearestenemy, -2)
		If $lDistance < $z And DllStructGetData($nearestenemy, 'ID') <> 0 Then
			Fight($z, $s)

		EndIf
		RndSleep(250)
		$lMe = GetAgentByID(-2)
		$coordsX = DllStructGetData($lMe, "X")
		$coordsY = DllStructGetData($lMe, "Y")
		If $oldCoordsX = $coordsX And $oldCoordsY = $coordsY Then
			$iBlocked += 1
			Move($coordsX, $coordsY, 500)
			RndSleep(350)
			Move($x, $y, $random)
		EndIf
	Until ComputeDistanceEx($coordsX, $coordsY, $x, $y) < 250 Or $iBlocked > 20
EndFunc   ;==>AggroMoveTo

Func Fight($x, $s = "")
	CurrentAction("Fighting " & $s & "!")
	Do
		Sleep(250)
		$nearestenemy = GetNearestEnemyToAgent(-2)
	Until DllStructGetData($nearestenemy, 'ID') <> 0

	Do
		$useSkill = -1
		$target = GetNearestEnemyToAgent(-2)
		$distance = GetDistance($target, -2)
		If DllStructGetData($target, 'ID') <> 0 And $distance < $x Then
			ChangeTarget($target)
			Sleep(150)
			CallTarget($target)
			Sleep(150)
			Attack($target)
			Sleep(150)
		ElseIf DllStructGetData($target, 'ID') = 0 Or $distance > $x Then
			ExitLoop
		EndIf

		For $i = 0 To $totalskills

			$targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
			If $targetHP = 0 Then ExitLoop

			$distance = GetDistance($target, -2)
			If $distance > $x Then ExitLoop

			$energy = GetEnergy(-2)
			$recharge = DllStructGetData(GetSkillBar(), "Recharge" & $i + 1)
			$adrenaline = DllStructGetData(GetSkillBar(), "Adrenaline" & $i + 1)

			If $recharge = 0 And $energy >= $intSkillEnergy[$i] And $adrenaline >= ($intSkillAdrenaline[$i] * 25 - 25) Then
				$useSkill = $i + 1
				PingSleep(250)
				UseSkill($useSkill, $target)
				Sleep($intSkillCastTime[$i] + 1000)
			EndIf
			If $i = $totalskills Then $i = 0
		Next

	Until DllStructGetData($target, 'ID') = 0 Or $distance > $x
	If GetHealth(-2) < 2400 Then UseSkill(7, -2)
	PingSleep(3000)
	CurrentAction("Picking up items")
	If $Bool_PickUp Then PickUpLoot()
EndFunc   ;==>Fight

;Func PingSleep($msExtra = 0)
;	$ping = GetPing()
;	Sleep($ping + $msExtra)
;EndFunc   ;==>PingSleep

Func FightEx($z, $s = "enemies")
	Local $lastId = 99999, $coordinate[2], $timer
	CurrentAction("Fighting Ex!")

	If $DeadOnTheRun = 0 Then
		Do
			$Me = GetAgentByID(-2)
			$energy = GetEnergy()
			$skillbar = GetSkillbar()
			If $DeadOnTheRun = 0 Then $target = GetNearestEnemyToAgent(-2)
			If Not $target <> 0 Then
				TargetNearestEnemy()
			EndIf
			$distance = GetDistance($target, -2)
			If DllStructGetData($target, 'ID') <> 0 And $distance < $z And $DeadOnTheRun = 0 Then
				If $DeadOnTheRun = 0 Then ChangeTarget($target)
				If $DeadOnTheRun = 0 Then Sleep(150)
				If $DeadOnTheRun = 0 Then CallTarget($target)
				If $DeadOnTheRun = 0 Then Sleep(150)
				If $DeadOnTheRun = 0 Then Attack($target)
				If $DeadOnTheRun = 0 Then Sleep(150)
			ElseIf DllStructGetData($target, 'ID') = 0 Or $distance > $z Or $DeadOnTheRun = 1 Then
				$lastId = DllStructGetData($target, 'Id')
				$coordinate[0] = DllStructGetData($target, 'X')
				$coordinate[1] = DllStructGetData($target, 'Y')
				$timer = TimerInit()
				Do
					Move($coordinate[0], $coordinate[1])
					rndsleep(500)
					$Me = GetAgentByID(-2)
					$distance = ComputeDistance($coordinate[0], $coordinate[1], DllStructGetData($Me, 'X'), DllStructGetData($Me, 'Y'))
				Until $distance < 1100 Or TimerDiff($timer) > 10000
			EndIf
			RndSleep(150)
			$timer = TimerInit()
			Do
				$target = GetCurrentTarget()

				If $DeadOnTheRun = 0 And $target <> 0 Then Attack($target)
				If $DeadOnTheRun = 0 And $target <> 0 Then UseSkillEx(1, -1)
				$targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
				If $targetHP = 0 Then ExitLoop
				If $DeadOnTheRun = 0 And $target <> 0 Then UseSkillEx(2, -1)
				$targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
				If $targetHP = 0 Then ExitLoop
				If $DeadOnTheRun = 0 And $target <> 0 Then UseSkillEx(3, -1)
				$targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
				If $targetHP = 0 Then ExitLoop
				If $DeadOnTheRun = 0 And $target <> 0 Then UseSkillEx(4, -1)
				$targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
				If $targetHP = 0 Then ExitLoop
				If $DeadOnTheRun = 0 And $target <> 0 Then UseSkillEx(5, -1)
				$targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
				If $targetHP = 0 Then ExitLoop
				If $DeadOnTheRun = 0 And $target <> 0 Then UseSkillEx(6, -1)
				$targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
				If $targetHP = 0 Then ExitLoop
				If $DeadOnTheRun = 0 And $target <> 0 Then UseSkillEx(7, -1)
				$targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
				If $targetHP = 0 Then ExitLoop
				If $DeadOnTheRun = 0 And $target <> 0 Then UseSkillEx(8, -1)
				Sleep(200)

				$targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
				If $targetHP = 0 Then ExitLoop
				$target = GetAgentByID(DllStructGetData($target, 'Id'))
				$coordinate[0] = DllStructGetData($target, 'X')
				$coordinate[1] = DllStructGetData($target, 'Y')
				$Me = GetAgentByID(-2)
				$distance = ComputeDistance($coordinate[0], $coordinate[1], DllStructGetData($Me, 'X'), DllStructGetData($Me, 'Y'))
			Until DllStructGetData($target, 'HP') < 0.005 Or $distance > $z Or TimerDiff($timer) > 5000
			$target = GetNearestEnemyToAgent(-2)
			$coordinate[0] = DllStructGetData($target, 'X')
			$coordinate[1] = DllStructGetData($target, 'Y')
			$distance = ComputeDistance(DllStructGetData($target, 'X'), DllStructGetData($target, 'Y'), DllStructGetData(GetAgentByID(-2), 'X'), DllStructGetData(GetAgentByID(-2), 'Y'))
		Until DllStructGetData($target, 'Id') = 0 Or $distance > $z ;; ==
	EndIf

	Sleep(200)
	If getIsDead(-2) Then CurrentAction("Died")
	If CountSlots() = 0 Then
		CurrentAction("Inventory full")
	Else
		CurrentAction("Picking up items")
		If $Bool_PickUp Then PickUpLoot()
	EndIf
EndFunc   ;==>FightEx

;Func GoNearestNPCToCoords($x, $y)
;	Local $guy, $Me
;	Do
;		RndSleep(250)
;		$guy = GetNearestNPCToCoords($x, $y)
;	Until DllStructGetData($guy, 'Id') <> 0
;	ChangeTarget($guy)
;	RndSleep(250)
;	GoNPC($guy)
;	RndSleep(250)
;	Do
;		RndSleep(500)
;		Move(DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y'), 40)
;		RndSleep(500)
;		GoNPC($guy)
;		RndSleep(250)
;		$Me = GetAgentByID(-2)
;	Until ComputeDistance(DllStructGetData($Me, 'X'), DllStructGetData($Me, 'Y'), DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y')) < 250
;	RndSleep(1000)
;EndFunc   ;==>GoNearestNPCToCoords

;Func ComputeDistanceEx($x1, $y1, $x2, $y2)
;	Return Sqrt(($y2 - $y1) ^ 2 + ($x2 - $x1) ^ 2)
;	$dist = Sqrt(($y2 - $y1) ^ 2 + ($x2 - $x1) ^ 2)
;	ConsoleWrite("Distance: " & $dist & @CRLF)
;
;EndFunc   ;==>ComputeDistanceEx

Func PickUpLoot()
	Local $lAgent
	Local $lItem
	Local $lDeadlock
	For $i = 1 To GetMaxAgents()
		If CountSlots() < 1 Then Return ;full inventory dont try to pick up
		If GetIsDead(-2) Then Return
		$lAgent = GetAgentByID($i)
		If DllStructGetData($lAgent, 'Type') <> 0x400 Then ContinueLoop
		$lItem = GetItemByAgentID($i)
		If CanPickUp($lItem) Then
			PickUpItem($lItem)
			$lDeadlock = TimerInit()
			While GetAgentExists($i)
				Sleep(100)
				If GetIsDead(-2) Then Return
				If TimerDiff($lDeadlock) > 10000 Then ExitLoop
			WEnd
		EndIf
	Next
EndFunc   ;==>PickUpLoot

; Checks if should pick up the given item. Returns True or False
Func CanPickUp($aItem)
	Local $lModelID = DllStructGetData(($aItem), 'ModelId')
	Local $t = DllStructGetData($aItem, 'Type')
	Local $aExtraID = DllStructGetData($aItem, 'ExtraId')
	Local $lRarity = GetRarity($aItem)
	Local $Requirement = GetItemReq($aItem)

	If $lModelID > 21785 And $lModelID < 21806 Then Return True ; Elite/Normal Tomes
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
	ElseIf ($t == $TYPE_KEY) Then ; dungeon key
		Return True
	ElseIf($lModelID == $ITEM_ID_Lockpicks) Then
		Return True ; Lockpicks
	ElseIf($lModelID == $ITEM_ID_Glacial_Stones) Then
		Return True ; glacial stones
	ElseIf($lModelID == $Carving) Then
		Return True ; charr carvings
	ElseIf CheckArrayPscon($lModelID) Then ; ==== Pcons ==== or all event items
		Return True
	ElseIf CheckArrayMapPieces($lModelID) Then ; ==== Map Pieces ====
		Return True
	ElseIf ($lRarity == $RARITY_White) And $PickUpAll Then ; White items
		Return False
	Else
		Return False
	EndIf
EndFunc   ;==>CanPickUp

#Region Arrays
;Func CheckArrayPscon($lModelID)
;	For $p = 0 To (UBound($Array_pscon) -1)
;		If ($lModelID == $Array_pscon[$p]) Then Return True
;	Next
;EndFunc

;Func CheckArrayGeneralItems($lModelID)
;	For $p = 0 To (UBound($General_Items_Array) -1)
;		If ($lModelID == $General_Items_Array[$p]) Then Return True
;	Next
;EndFunc

;Func CheckArrayWeaponMods($lModelID)
;	For $p = 0 To (UBound($Weapon_Mod_Array) -1)
;		If ($lModelID == $Weapon_Mod_Array[$p]) Then Return True
;	Next
;EndFunc

;Func CheckArrayTomes($lModelID)
;	For $p = 0 To (UBound($All_Tomes_Array) -1)
;		If ($lModelID == $All_Tomes_Array[$p]) Then Return True
;	Next
;EndFunc

;Func CheckArrayMaterials($lModelID)
;	For $p = 0 To (UBound($All_Materials_Array) -1)
;		If ($lModelID == $All_Materials_Array[$p]) Then Return True
;	Next
;EndFunc

;Func CheckArrayMapPieces($lModelID)
;	For $p = 0 To (UBound($Map_Piece_Array) -1)
;		If ($lModelID == $Map_Piece_Array[$p]) Then Return True
;	Next
;EndFunc
#EndRegion Arrays

;Func CheckArea($AX, $AY)
;	Local $RET = False
;	Local $PX = DllStructGetData(GetAgentByID(-2), "X")
;	Local $PY = DllStructGetData(GetAgentByID(-2), "Y")
;	If ($PX < $AX + 500) And ($PX > $AX - 500) And ($PY < $AY + 500) And ($PY > $AY - 500) Then
;		$RET = True
;	EndIf
;	Return $RET
;EndFunc   ;==>CHECKAREA

Func RndTravel($aMapID) ;Travel to a random region in the outpost
	Local $UseDistricts = 11 ; 7=eu-only, 8=eu+int, 11=all(excluding America)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, us-en, int, asia-ko, asia-ch, asia-ja
	Local $Region[11] = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
	MoveMap($aMapID, $Region[$Random], 0, $Language[$Random])
	WaitMapLoading($aMapID)
EndFunc   ;==>RndTravel