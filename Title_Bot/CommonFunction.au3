#include-once
#include <GuiEdit.au3>
#include <Array.au3>
#include <File.au3>
#include <WinAPI.au3>
#include <EditConstants.au3>

#RequireAdmin
;Define the path to the configuration files
;Global $configFilePath = @ScriptDir & "\skill_requirements.ini"
Global $iniFilePath = @ScriptDir & "\hero_selections.ini"

; Global variable to store GUI handle and inputs array
Global $heroDropdowns[7]
Global $heroNames
Global $selectedIndex = -1
Global $strName = ""
Global $NumberRun = 0
Global $boolrun = False
Global $strName = ""
Global $coords[2]
Global $Title, $sGW
Global $Bool_Donate = False, $Bool_IdAndSell = False, $Bool_HM = False, $Bool_Store = False, $Bool_PickUp = False, $Bool_Uselockpicks = False
Global $g_bRun = False
Global $File = @ScriptDir & "\Trace\Traça du " & @MDAY & "-" & @MON & " a " & @HOUR & "h et " & @MIN & "minutes.txt"
Global Const $NumberOfIdentKits = 1

$loggedCharNames = GetLoggedCharNames()
$charNamesArray = StringSplit($loggedCharNames, "|", 2)

Opt("GUIOnEventMode", 1)

#Region ### START Koda GUI section ### Form=
Global $Form1_1 = GUICreate("Title Farm Bot: Version 3.0 Test Version", 661, 431, -1, -1)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Start = GUICtrlCreateButton("Start", 56, 272, 43, 17, $WS_GROUP)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Stop = GUICtrlCreateButton("Stop", 106, 246, 36, 30, $WS_GROUP)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
GUICtrlSetState($Stop, $GUI_DISABLE)
GUICtrlCreateGroup("Title", 160, 8, 185, 161)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
Global $Radio_Asura = GUICtrlCreateRadio("Asura", 176, 32, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Deldrimor = GUICtrlCreateRadio("Deldrimor", 240, 32, 65, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Vanguard = GUICtrlCreateRadio("Vanguard", 240, 56, 73, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Norn = GUICtrlCreateRadio("Norn", 176, 56, 49, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Kurzick = GUICtrlCreateRadio("Kurzick", 176, 128, 65, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_Luxon = GUICtrlCreateRadio("Luxon", 176, 104, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_SS_and_LB = GUICtrlCreateRadio("LB/SS", 176, 80, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_SS = GUICtrlCreateRadio("SS", 240, 80, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
Global $Radio_TreasureHunter = GUICtrlCreateRadio("Treasure Hunter", 240, 104, 100, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetOnEvent(-1, "gui_eventHandler")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("General Config", 160, 175, 161, 105)

Global $Gui_Id_and_sell = GUICtrlCreateCheckbox("Id and Sell", 176, 216, 75, 17)
GUICtrlSetState(-1, $GUI_CHECKED)

Global $Gui_Store_unid = GUICtrlCreateCheckbox("Store Unid", 176, 192, 73, 17)
GUICtrlSetState(-1, $GUI_CHECKED)

Global $Gui_HM_enable = GUICtrlCreateCheckbox("HM", 176, 240, 49, 17)
GUICtrlSetState(-1, $GUI_CHECKED)

Global $Gui_Donate = GUICtrlCreateCheckbox("Donate", 256, 240, 57, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

Global $gui_cons = GUICtrlCreateCheckbox("Cons", 256, 192, 65, 17)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

Global $Gui_UseLockpicks = GUICtrlCreateCheckbox("Lockpicks", 176, 261, 79, 14)
GUICtrlSetResizing(-1, $GUI_DOCKALL)

Global $Gui_Salvage = GUICtrlCreateCheckbox("Salvage", 256, 262, 79, 17) ; Adjust the width as necessary
GUICtrlSetResizing(-1, $GUI_DOCKALL)

Global $Gui_PickUp = GUICtrlCreateCheckbox("PickUp", 256, 216, 60, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateGroup("", -99, -99, 1, 1)

Global $txtName = GUICtrlCreateCombo("", 8, 248, 89, 25)
GUICtrlSetData(-1, GetLoggedCharNames())
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlCreateGroup("Points Status", 8, 8, 137, 161)
GUICtrlCreateLabel("Asura", 24, 32, 31, 17)
GUICtrlSetColor(-1, 0x0C5440)
GUICtrlCreateLabel("Deldrimor", 24, 48, 48, 17)
GUICtrlSetColor(-1, 0x0C5440)
GUICtrlCreateLabel("Vanguard", 24, 64, 50, 17)
GUICtrlSetColor(-1, 0x0C5440)
GUICtrlCreateLabel("Norn", 24, 80, 27, 17)
GUICtrlSetColor(-1, 0x0C5440)
GUICtrlCreateLabel("Kurzick", 24, 96, 39, 17)
GUICtrlSetColor(-1, 0x0C5440)
GUICtrlCreateLabel("Luxon", 24, 112, 33, 17)
GUICtrlSetColor(-1, 0x0C5440)
GUICtrlCreateLabel("LB", 24, 128, 17, 17)
GUICtrlSetColor(-1, 0x0C5440)
GUICtrlCreateLabel("SS", 24, 144, 18, 17)
GUICtrlSetColor(-1, 0x0C5440)
Global $Pt_Asura = GUICtrlCreateLabel("0", 96, 32, 40, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x0C5440)
Global $Pt_Deldrimor = GUICtrlCreateLabel("0", 96, 48, 40, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x0C5440)
Global $Pt_Vanguard = GUICtrlCreateLabel("0", 96, 64, 40, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x0C5440)
Global $Pt_Norn = GUICtrlCreateLabel("0", 96, 80, 40, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x0C5440)
Global $Pt_Kurzick = GUICtrlCreateLabel("0", 96, 96, 40, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x0C5440)
Global $Pt_Luxon = GUICtrlCreateLabel("0", 96, 112, 40, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x0C5440)
Global $Pt_LB = GUICtrlCreateLabel("0", 96, 128, 40, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x0C5440)
Global $Pt_SS = GUICtrlCreateLabel("0", 96, 144, 40, 17, $SS_RIGHT)
GUICtrlSetResizing(-1, $GUI_DOCKALL)
GUICtrlSetColor(-1, 0x0C5440)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $label_stat = GUICtrlCreateLabel("min: 000  sec: 00", 24, 176, 105, 17, $SS_CENTER)
GUICtrlCreateGroup("Runs", 8, 195, 137, 49)
GUICtrlCreateLabel("Total Runs", 16, 220, 56, 17)
GUICtrlSetColor(-1, 0x001F40)
GUICtrlSetColor(-1, 0x001F40)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $heroCheck = GUICtrlCreateCheckbox("Enable Hero Selection", 176, 281, 79, 14)
GUICtrlSetOnEvent($heroCheck, "ToggleHeroDropdowns")
LoadSelections() ;
Global $heroNames = ["Mercenary Hero 1", "Mercenary Hero 2", "Mercenary Hero 3", "Mercenary Hero 4", "Mercenary Hero 5", "Mercenary Hero 6", "Mercenary Hero 7", "Mercenary Hero 8", "Norgu", "Goren", "Tahlkora", "Master Of Whispers", "Acolyte Jin", "Koss", "Dunkoro", "Acolyte Sousuke", "Melonni", "Zhed Shadowhoof", "General Morgahn", "Margrid The Sly", "Olias", "Razah", "MOX", "Jora", "Pyre Fierceshot", "Livia", "Hayda", "Kahmu", "Gwen", "Xandra", "Vekk", "Ogden"]

Global $longestNameLength = 0

For $name In $heroNames
    If StringLen($name) > $longestNameLength Then $longestNameLength = StringLen($name)
Next

$dropdownWidth = $longestNameLength * 8

Global $heroDropdowns[7]

For $i = 0 To 3
    $heroDropdowns[$i] = GUICtrlCreateCombo("", 10, 300 + ($i * 30), $dropdownWidth, 20, BitOR($CBS_DROPDOWNLIST, $WS_DISABLED))
    For $name In $heroNames
        GUICtrlSetData(-1, $name)
    Next
Next
$rightDropdownX = 180 ; Adjusted from 220 to 180
For $i = 4 To 6
    $heroDropdowns[$i] = GUICtrlCreateCombo("", $rightDropdownX, 300 + (($i - 4) * 30), $dropdownWidth, 20, BitOR($CBS_DROPDOWNLIST, $WS_DISABLED))
    For $name In $heroNames
        GUICtrlSetData(-1, $name)
    Next
Next
Global $btnSave = GUICtrlCreateButton("Save Selection", 192, 398, 100, 30, $WS_GROUP)
GUICtrlSetOnEvent($btnSave, "SaveSelections")
; GUI Elements
Global $btnLoad = GUICtrlCreateButton("Load Selection", 300, 398, 100, 30, $WS_GROUP) 
GUICtrlSetOnEvent($btnLoad, "LoadSelections") 

Global $STATUS = GUICtrlCreateEdit("", 370, 8, 286, 378, $ES_AUTOVSCROLL + $ES_AUTOHSCROLL + $ES_MULTILINE + $WS_VSCROLL)
GUICtrlSetBkColor(-1, 0x000000) ; Black background
GUICtrlSetColor(-1, 0xFFFF00) ; Yellow text


global $gui_status_runs = GUICtrlCreateLabel("0", 96, 220, 30, 17, $SS_RIGHT) ; Increased width to 30
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
		Case $Radio_TreasureHunter
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_SS
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		Case $Radio_SS_and_LB
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_UNCHECKED)
		case $GUI_EVENT_CLOSE
			exit
		Case $Stop
			$g_bRun = False ; 
			CurrentAction("Script will stop after this run ends") ; 
			GUICtrlSetState($Start, $GUI_ENABLE)
			GUICtrlSetState($Stop, $GUI_DISABLE) 
		Case $Start
			$g_bRun = True ; Signal the main functions to start
			GUICtrlSetState($Start, $GUI_DISABLE) ; Disable the start button to prevent re-entrance
			GUICtrlSetState($Stop, $GUI_ENABLE) ; Enable the stop button
			$NumberRun = 0
			$RunSuccess = 0
			$boolrun = True

			GUICtrlSetState($Radio_Asura, $GUI_DISABLE)
			GUICtrlSetState($Radio_Deldrimor, $GUI_DISABLE)
			GUICtrlSetState($Radio_Vanguard, $GUI_DISABLE)
			GUICtrlSetState($Radio_Norn, $GUI_DISABLE)
			GUICtrlSetState($Radio_Kurzick, $GUI_DISABLE)
			GUICtrlSetState($Radio_Luxon, $GUI_DISABLE)
			GUICtrlSetState($Radio_TreasureHunter, $GUI_DISABLE)
			GUICtrlSetState($Radio_SS_and_LB, $GUI_DISABLE)
			GUICtrlSetState($Radio_SS, $GUI_DISABLE)
			GUICtrlSetState($Gui_Id_and_sell, $GUI_DISABLE)
			GUICtrlSetState($Gui_Store_unid, $GUI_DISABLE)
			GUICtrlSetState($gui_cons, $GUI_DISABLE)
			GUICtrlSetState($Gui_UseLockpicks, $GUI_DISABLE)
			GUICtrlSetState($Gui_HM_enable, $GUI_DISABLE)
			GUICtrlSetState($Gui_Donate, $GUI_DISABLE)
			GUICtrlSetState($Gui_PickUp, $GUI_DISABLE)
			GUICtrlSetState($heroCheck, $GUI_DISABLE)
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
			ElseIf BitAND(GUICtrlRead($Radio_TreasureHunter), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "Treasure Hunter"
			ElseIf BitAND(GUICtrlRead($Radio_SS), $GUI_CHECKED) = $GUI_CHECKED Then
				$Title = "SS"
			EndIf

			If BitAND(GUICtrlRead($Gui_Id_and_sell), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_IdAndSell = True
			If BitAND(GUICtrlRead($Gui_Store_unid), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_Store = True
			If BitAND(GUICtrlRead($Gui_HM_enable), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_HM = True
			If BitAND(GUICtrlRead($Gui_Donate), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_Donate = True
			If BitAND(GUICtrlRead($Gui_PickUp), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_PickUp = True
			If BitAND(GUICtrlRead($gui_cons), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_cons = True
			If BitAND(GUICtrlRead($Gui_UseLockpicks), $GUI_CHECKED) = $GUI_CHECKED Then $Bool_Uselockpicks = True

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

Func _ScrollEditToEnd($hEdit)
    Local $iLineCount = _GUICtrlEdit_GetLineCount($hEdit)  ; Get the number of lines in the edit control
    GUICtrlSendMsg($hEdit, $EM_LINESCROLL, 0, $iLineCount)  ; Scroll to the last line
EndFunc


Func SaveSelections()
    For $i = 0 To UBound($heroDropdowns) - 1
        Local $selected = GUICtrlRead($heroDropdowns[$i])
        IniWrite($iniFilePath, "Heroes", "HeroDropdown" & $i, $selected)
    Next
EndFunc

Func LoadSelections()
    If Not FileExists($iniFilePath) Then Return ; Exit if no INI file found

    Local $index = 0
    While 1
        Local $selection = IniRead($iniFilePath, "Heroes", "HeroDropdown" & $index, "")
        If $selection = "" Then ExitLoop ; Break the loop if no more entries

        Local $selectedIndex = _ArraySearch($heroNames, $selection) ; Find the index of the loaded hero name in the array
        If $selectedIndex <> -1 Then
            GUICtrlSetData($heroDropdowns[$index], $selection) ; Set the dropdown to show the loaded hero
        EndIf

        $index += 1
    WEnd
EndFunc

Func ToggleHeroDropdowns()
    Local $isChecked = GUICtrlRead($heroCheck) = $GUI_CHECKED
    For $i = 0 To 6  ; Adjusted for 7 dropdowns
        GUICtrlSetState($heroDropdowns[$i], $isChecked ? $GUI_ENABLE : $GUI_DISABLE)
    Next
EndFunc

Func ToggleHeroesCheckboxes()
    Local $isChecked = GUICtrlRead($AddHeroesCheckbox) = $GUI_CHECKED
    For $i = 0 To UBound($heroCheckboxes) - 1
        GUICtrlSetState($heroCheckboxes[$i], $isChecked ? $GUI_ENABLE : $GUI_DISABLE)
    Next
EndFunc


Func CurrentAction($MSG)
    ; Read the current content of the Edit control
    Local $sCurrentContent = GUICtrlRead($STATUS)

    ; Append the new message to the existing content, adding a newline if not empty
    If $sCurrentContent <> "" Then
        $sCurrentContent &= @CRLF  ; Ensure there's a newline separating messages
    EndIf
    $sCurrentContent &= "Run : " & $NumberRun + 1 & " at: " & @HOUR & ":" & @MIN & "." & @SEC & "   " & $MSG

    ; Update the Edit control with the new content
    GUICtrlSetData($STATUS, $sCurrentContent)

    ; Scroll to the end of the Edit control
    _ScrollEditToEnd($STATUS)

    ; Optionally, update other controls or log to a file as needed
    GUICtrlSetData($gui_status_runs, $NumberRun)  ; Assuming $gui_status_runs needs to be updated similarly
    FileWriteLine($File, $sCurrentContent & @CRLF)  ; Log the message to a file
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
		ElseIf $Title = "Treasure Hunter" Then
			$merchant = GetNearestNPCToCoords(7319, -24874)
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

Func CheckIfInventoryIsFull()
    If CountSlots() < 3 Then
        return true
    Else
        return false
    EndIf
EndFunc   ;==>CheckIfInventoryIsFull

Func Sell($BAGINDEX)
	Local $AITEM
	Local $BAG = GETBAG($BAGINDEX)
	Local $NUMOFSLOTS = DllStructGetData($BAG, "slots")
	For $I = 1 To $NUMOFSLOTS
		$AITEM = GETITEMBYSLOT($BAGINDEX, $I)
		If DllStructGetData($AITEM, "Id") == 0 Then ContinueLoop
		If CanSell($AITEM) Then
			SELLITEM($AITEM)
		EndIf
		Sleep(GetPing()+250)
	Next
EndFunc


Func GetExtraItemInfo($aitem)

    If IsDllStruct($aitem) = 0 Then
        $aitem = GetItemByItemID($aitem)
    EndIf

    $lItemExtraPtr = DllStructGetData($aitem, "namestring")

    Local $lItemExtraStructSize = 256 
    Local $lItemExtraStruct = DllStructCreate("char[" & $lItemExtraStructSize & "]")
    Local $lItemExtraStructPtr = DllStructGetPtr($lItemExtraStruct)
    Local $bytesRead = DllStructCreate("dword")

    DllCall($mHandle[0], 'int', 'ReadProcessMemory', 'handle', $mHandle[1], 'ptr', $lItemExtraPtr, 'ptr', $lItemExtraStructPtr, 'dword', $lItemExtraStructSize, 'ptr', DllStructGetPtr($bytesRead))

    Return DllStructGetData($lItemExtraStruct, 1)
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
		CurrentAction("Checking items: " & $bagIndex & ", " & $i & @CRLF & GetRarity($aItem) & @crlf)
		If DllStructGetData($aItem, 'ID') <> 0 And GetRarity($aItem) = $RARITY_Gold Then
				Do
					For $bag = 8 To 12; Storage panels are form 8 till 16 (I have only standard amount plus aniversary one)
						$slot = FindEmptySlot($bag)
						$slot = @extended
						If $slot <> 0 Then
							CurrentAction("Storing Golds Now")
							$FULL = False
							$nSlot = $slot
							ExitLoop 2; finding first empty $slot in $bag and jump out
						Else
							CurrentAction("Slot Taken_Next")
							$FULL = True; no empty slots :(
						EndIf
						Sleep(100)
					Next
				Until $FULL = True
				If $FULL = False Then
					MoveItem($aItem, $bag, $nSlot)
					CurrentAction("Gold item moved ...."& @CRLF)
					Sleep(Random(150, 250))
				EndIf
		EndIf
	Next
EndFunc   ;==>GoldIs

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

    ; Elite/Normal Tomes
    If $lModelID > 21785 And $lModelID < 21806 Then Return True

    If $lModelID == 2511 Then
        Return GetGoldCharacter() < 100000
    EndIf

    ; Dyes (only white and black)
    If $lModelID == $ITEM_ID_Dyes Then
        Return ($aExtraID == $ITEM_ExtraID_BlackDye) Or ($aExtraID == $ITEM_ExtraID_WhiteDye)
    EndIf

    ; Gold rarity items
    If $lRarity == $RARITY_Gold Then Return True

    ; Dungeon key
    If $t == $TYPE_KEY Then Return True

    ; Lockpicks
    If $lModelID == $ITEM_ID_Lockpicks Then Return True

    ; Glacial Stones (explicitly not picked up)
    If $lModelID == $ITEM_ID_Glacial_Stones Then Return False

    ; Charr carvings
    If $lModelID == $Carving Then Return True

    ; Pcons or all event items
    If CheckArrayPscon($lModelID) Then Return True

    ; Map Pieces (not picked up)
    If CheckArrayMapPieces($lModelID) Then Return False

    ; White items, controlled by a global flag ($PickUpAll)
    If $lRarity == $RARITY_White And $PickUpAll Then Return True

    Return False
EndFunc   ;==>CanPickUp

Func RndTravel($aMapID) ;Travel to a random region in the outpost
	Local $UseDistricts = 11 ; 7=eu-only, 8=eu+int, 11=all(excluding America)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, us-en, int, asia-ko, asia-ch, asia-ja
	Local $Region[11] = [2, 2, 2, 2, 2, 2, 2, -2, 1, 3, 4]
	Local $Language[11] = [0, 2, 3, 4, 5, 9, 10, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
	MoveMap($aMapID, $Region[$Random], 0, $Language[$Random])
	WaitMapLoading($aMapID)
EndFunc   ;==>RndTravel

Func WaitForLoad()
	CurrentAction("Loading zone")
	InitMapLoad()
	$deadlock = 0
	Do
		Sleep(100)
		$deadlock += 100
		$load = GetMapLoading()
		$lMe = GetAgentByID(-2);

	Until $load = 2 And DllStructGetData($lMe, 'X') = 0 And DllStructGetData($lMe, 'Y') = 0 Or $deadlock > 1000
;
	$deadlock = 0
	Do
		Sleep(100)
		$deadlock += 100

		$deadlock += 100
		$load = GetMapLoading()
		$lMe = GetAgentByID(-2)
;
	Until $load <> 2 And DllStructGetData($lMe, 'X') <> 0 And DllStructGetData($lMe, 'Y') <> 0 Or $deadlock > 3000
	CurrentAction("Load complete")
	Sleep(1000)
EndFunc   ;==>WaitForLoad


Func AggroMoveTo($x, $y, $s = "", $z = 1450)
	;CurrentAction("Hunting " & $s)
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
