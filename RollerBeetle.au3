#Region About
#cs ----------------------------------------------------------------------------

#################################
#                               #
#       RollerBeetle_Bot	    #
#                               #
#    Author : 	n0futur3        #
#    Update : 	DeeperBlue      #
#              				    #
#         February 2019         #
#                               #
#################################

Changelog V1.0 () by DeeperBlue describing n0futur3's work :
	- GUI window :
		- Character's name input.
		- Start button.
		- Run counter.
		- Racing medals' counter
		- Place counters (1st, 2nd, 3rd, 4th).
	- Outpost recognition.
	- Mission starting based on exact position.
	- Races paths.
	- Runnig functions.
	- Stuck checking function.
	- Medals counting function.

Changelog V1.1 (February the 1st 2019) by DeeperBlue :
	- GUI Update :
		- Reworked GUI
		- Added a Character selector which detects GW Characters logged.
		- Added a Toggle Rendering checkbox.
		- Added a timer displaying time till bot's start.
	- Cleaned RollerBeetle.au3's code by putting regions.
	- Changed the way to handle GUI.
	- Put includes in GW_RollApi.
	- Start mission function allows player to be anywhere in the starting outpost.

Changelog V1.1.1 (January the 02 2019) by maril15
     - just headers and GWA2 updated

Changelog V1.1.2 (June the 28 2019) by Oneshout
    - just headers and GWA2 updated

#TODO :
	- Commenting the code.
	- Using MoveToXYZ insteed of MoveTo

#ce ----------------------------------------------------------------------------
#EndRegion

#Region Includes
#include "GWA2.au3"
#include "GWA2_Headers.au3"
#include "GWA_AddOn.au3"
#include <AutoItConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3> 
#include <GuiButton.au3> 
#include <GUIEdit.au3>

#EndRegion

#Region Declarations
Global $BotRunning = False
Global $BotInitialized = False
; Declare global variables for GUI elements
Global $Gui, $CharInput, $iRefresh, $StartButton, $RenderingBox
Global $cbFriendly, $RunsLabel, $RunsCount, $lblMedals, $MedalCount
Global $lblFirst, $FirstCount, $lblSecond, $SecondCount, $lblThird, $ThirdCount
Global $lblFourth, $FourthCount, $TotTimeLabel, $TotTimeCount, $StatusLabel, $SS_RIGHT, $SB_SCROLLCARET, $SB_LINEUP

Global $stucky1 = 0
Global $stuckx2 = 0
Global $stucky2 = 0

Global $runs = 0
Global $1st = 0
Global $2nd = 0
Global $3rd = 0
Global $4th = 0
Global $medals = 0

Global $TotalSeconds = 0
Global $Seconds = 0
Global $Minutes = 0
Global $Hours = 0

Global $HWND
#EndRegion

#Region GUI
Opt("GUIOnEventMode", True)
Opt("GUICloseOnESC", False)

;$Form1 = GUICreate("Rollerbeetle Bot", 266, 196, 252, 164)
$Gui = GUICreate("Rollerbeetle Bot 1.1.2", 500, 303, -1, -1)

;$cmbCharname = GUICtrlCreateInput("Char name", 30, 34, 201, 25)

	GUICtrlCreateGroup("Select a Character", 10, 5, 170, 43)
	$CharInput = GUICtrlCreateCombo("", 20, 20, 129, 21, $CBS_DROPDOWNLIST)
        GUICtrlSetData(-1, GetLoggedCharNames())
	$iRefresh = GUICtrlCreateButton("", 152, 19, 22.8, 22.8, $BS_ICON)
        GUICtrlSetImage($iRefresh, "shell32.dll", -239, 0)
        GUICtrlSetOnEvent(-1, "RefreshInterface")

;$Button1 = GUICtrlCreateButton("Start/Stop", 55, 120, 153, 49)

$StartButton = GUICtrlCreateButton("Start", 15, 53, 157.8, 21)
	GUICtrlSetOnEvent(-1, "GuiButtonHandler")

$RenderingBox = GUICtrlCreateCheckbox("Disable Rendering", 35, 76, 110, 17)
   GUICtrlSetOnEvent(-1, "ToggleRendering")
   GUICtrlSetState($RenderingBox, $GUI_DISABLE)

GUICtrlCreateGroup("Settings", 10, 95, 170, 40) ;Option
	$cbFriendly = GUICtrlCreateCheckbox("Friendly", 20, 110)

GUICtrlCreateGroup("", 10, 135, 170, 159)
	$RunsLabel = GUICtrlCreateLabel("Runs:", 20, 150, 31, 20)
		$RunsCount = GUICtrlCreateLabel("0", 75, 150, 50, 20, $SS_RIGHT)
	$lblMedals = GUICtrlCreateLabel("Racing Medals: ", 20, 170)
		$MedalCount = GUICtrlCreateLabel("0", 75, 170, 50, 20, $SS_RIGHT)
	$lblFirst = GUICtrlCreateLabel("1st: ", 20, 190)
		$FirstCount = GUICtrlCreateLabel("0", 75, 190, 50, 20, $SS_RIGHT)
	$lblSecond = GUICtrlCreateLabel("2nd: ", 20, 210)
		$SecondCount = GUICtrlCreateLabel("0", 75, 210, 50, 20, $SS_RIGHT)
	$lblThird = GUICtrlCreateLabel("3rd: ", 20, 230)
		$ThirdCount = GUICtrlCreateLabel("0", 75, 230, 50, 20, $SS_RIGHT)
	$lblFourth = GUICtrlCreateLabel("4th: ", 20, 250)
		$FourthCount = GUICtrlCreateLabel("0", 75, 250, 50, 20, $SS_RIGHT)

	$TotTimeLabel = GUICtrlCreateLabel("Total time:", 20, 270, 49, 20)
	$TotTimeCount = GUICtrlCreateLabel("-", 69, 270, 54, 20, $SS_RIGHT)

$StatusLabel = GUICtrlCreateEdit("", 185, 11, 305, 281, BitOR(0x0040, 0x0080, 0x1000, 0x00200000))
    GUICtrlSetFont($StatusLabel, 9, 400, 0, "Arial")
    GUICtrlSetColor($StatusLabel, 65280)
    GUICtrlSetBkColor($StatusLabel, 0)

GUISetOnEvent($GUI_EVENT_CLOSE, "_exit")
GUISetState(@SW_SHOW)


logFile("Version 1.1.2 06/23")
logFile("Ready to start.")
#EndRegion

#Region GUI handeling Functions
	#Region GUI base function
Func GuiButtonHandler() ;Handle the bot's start/pause
    If $BotRunning Then
        logFile("Will pause after this run.")
        GUICtrlSetData($StartButton, "Force Pause")
        GUICtrlSetOnEvent($StartButton, "Resign")
        $BotRunning = False
    ElseIf $BotInitialized Then
        GUICtrlSetData($StartButton, "Pause")
        $BotRunning = True
    Else
        logFile("Initializing...")
        Local $CharName = GUICtrlRead($CharInput)
        If $CharName == "" Then
            If Initialize(ProcessExists("gw.exe"), True, True) = False Then
                MsgBox(0, "Error", "Guild Wars is not running.")
                Exit
            EndIf
        Else
            If Initialize($CharName, True, True) = False Then
                MsgBox(0, "Error", "Could not find a Guild Wars client with a character named '" & $CharName & "'")
                Exit
            EndIf
        EndIf
        $HWND = GetWindowHandle()
        GUICtrlSetState($RenderingBox, $GUI_ENABLE)
        GUICtrlSetState($CharInput, $GUI_DISABLE)
        Local $charname = GetCharname()
        GUICtrlSetData($CharInput, $charname, $charname)
        GUICtrlSetData($StartButton, "Pause")
        WinSetTitle($Gui, "", "Rollerbeetle Bot - " & $charname)
        $BotRunning = True
        $BotInitialized = True
        SetMaxMemory()
   EndIf
EndFunc

Func RefreshInterface() ;Refresh Characters list
    Local $CharName[1]
	Local $lWinList = ProcessList("gw.exe")

    Switch $lWinList[0][0]
		Case 0
            MsgBox(16, "PreFarmer_Bot", "Please open Guild Wars and log into a character before running this program.")
            Exit
        Case Else
            For $i = 1 To $lWinList[0][0]
                MemoryOpen($lWinList[$i][1])
                $lOpenProcess = DllCall($mKernelHandle, 'int', 'OpenProcess', 'int', 0x1F0FFF, 'int', 1, 'int', $lWinList[$i][1])
                $GWHandle = $lOpenProcess[0]
                If $GWHandle Then
                    $CharacterName = ScanForCharname()
                    If IsString($CharacterName) Then
                        ReDim $CharName[UBound($CharName) + 1]
                        $CharName[$i] = $CharacterName
                    EndIf
                EndIf
                $GWHandle = 0
            Next
            GUICtrlSetData($CharInput, _ArrayToString($CharName, "|"), $CharName[1])
    EndSwitch
EndFunc

Func _exit() ;Enable Rendering and close the bot
   If GUICtrlRead($RenderingBox) == $GUI_CHECKED Then
	  EnableRendering()
	  WinSetState($HWND, "", @SW_SHOW)
	  Sleep(500)
   EndIf
   Exit
EndFunc

Func logFile($msg) ;Print message in the Status console
    GUICtrlSetData($StatusLabel, GUICtrlRead($StatusLabel) & "[" & @HOUR & ":" & @MIN & "]" & " " & $msg & @CRLF)
   _GUICtrlEdit_Scroll($StatusLabel, $SB_SCROLLCARET)
   _GUICtrlEdit_Scroll($StatusLabel, $SB_LINEUP)
EndFunc
	#EndRegion

	#Region GUI Timers
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
	GUICtrlSetData($TotTimeCount, $L_Hour & ":" & $L_Min & ":" & $L_Sec)
EndFunc
	#EndRegion
#EndRegion

#cs
Func EventHandler()
	Select
		Case @GUI_CtrlId = $GUI_EVENT_CLOSE
			Exit
		Case @GUI_CtrlId = $Button1
			If Initialize(GUICtrlRead($cmbCharname), True, True, False) = False Then
				MsgBox(0, "Error", "Can't find a Guild Wars client with that character name.")
				Exit
			EndIf
			GUICtrlSetState($cmbCharname, $GUI_DISABLE)
			$running = Not $running
			If $running Then


				GUICtrlSetData($Button1, "Running, press here to stop")
			Else
				GUICtrlSetData($Button1, "Stopped, press here to run")
			EndIf

	EndSelect
EndFunc
#ce

;If Initialize(WinGetProcess("Guild Wars"), False, False) = False Then MsgBox(0, "Initialize failed", "Initialize failed!")

#Region Loops
While Not $BotRunning
   Sleep(500)
WEnd

AdlibRegister("TimeUpdater", 1000)
While 1
	Sleep(100)

	If Not $BotRunning Then
		AdlibUnRegister("TimeUpdater")
		logFile("Bot is paused.")
		GUICtrlSetState($StartButton, $GUI_ENABLE)
		GUICtrlSetData($StartButton, "Start")
		GUICtrlSetOnEvent($StartButton, "GuiButtonHandler")

	;	ActivateAllGUI()
		While Not $BotRunning
			Sleep(500)
		WEnd
		AdlibRegister("TimeUpdater", 1000)
	EndIf

;	If $running Then
		$medals = CountRacingMedals()
		GUICtrlSetData($MedalCount, $medals)
		CheckOutpost()

		Local $rnd = Random(0, 1)

		;If $rnd < 0.5 Then
			Race()
		;Else
		;	Race2()
		;EndIf
		$runs = $runs + 1
		GUICtrlSetData($RunsCount, $runs)
		logFile("Run completed in " & GetTime() & ".")
		If CountRacingMedals() - $medals = 10 Then
			$1st += 1
			GUICtrlSetData($FirstCount, $1st)
			logFile("Finished 1st.")
		ElseIf CountRacingMedals() - $medals = 7 Then
			$2nd += 1
			GUICtrlSetData($SecondCount, $2nd)
			logFile("Finished 2nd.")
		ElseIf CountRacingMedals() - $medals = 5 Then
			$3rd += 1
			GUICtrlSetData($ThirdCount, $3rd)
			logFile("Finished 3rd.")
		ElseIf CountRacingMedals() - $medals = 3 Then
			$4th += 1
			GUICtrlSetData($FourthCount, $4th)
			logFile("Finished 4th.")
		EndIf
;  	EndIf
Wend
#EndRegion

#Region Job
	#Region Map
Func CheckOutpost() ;Check if player is in the race's outpost, then starts the race.

	If (GetMapID() <> 467) Then
		Do
			TravelTo(467)
			rndslp(500)
			WaitForLoad()
		Until GetMapID() = 467
	ElseIf (GetMapID() == 467) Then
		If (GetAgentExists(-2)) Then
			logFile("Entering Race.")
			EnterChallenge()
            Do
                Sleep(200)
            Until (CheckArea(-6367, -4438, 100) OR CheckArea(-6625,-4435, 100) OR CheckArea(-6151,-4489, 100) OR CheckArea(-5936, -4485, 100) OR CheckArea(-5720, -4483, 100) OR CheckArea(-5495,-4436, 100)) And GetAgentExists(-2)
		Else
			logFile("ERROR : Unable to find player to start race.")
            CheckOutpost()
		EndIf
	EndIf
EndFunc

Func WaitForLoad() ;Waits while the player is loading a map
	InitMapLoad()
	$deadlock = 0
	Do
		Sleep(100)
		$deadlock += 100
		$load = GetMapLoading()
		$lMe = GetAgentByID(-2)

	Until $load = 2 And DllStructGetData($lMe, 'X') = 0 And DllStructGetData($lMe, 'Y') = 0 Or $deadlock > 10000
	$deadlock = 0
	Do
		Sleep(100)
		$deadlock += 100
		$deadlock += 100
		$load = GetMapLoading()
		$lMe = GetAgentByID(-2)

	Until $load <> 2 And DllStructGetData($lMe, 'X') <> 0 And DllStructGetData($lMe, 'Y') <> 0 Or $deadlock > 30000

	rndslp(3000)
EndFunc   ;==>WaitForLoad
	#EndRegion

	#Region Race Paths
Func Race()
;Do
 ;MoveTo(-5729.0068359375, -4063.59155273438)
;Until CheckArea(-5729, -4063)
;MoveTo(-5738.43701171875, -3668.1923828125)
;MoveTo(-5745.5234375, -3236.09155273438)
AdlibRegister("Stuck", 3000)
Do
	MoveTo(-5668, -2804)
Until CheckArea(-5668, -2804)
AdlibRegister("RunningBasic", 3000)
AdlibRegister("RunningSpecial", 5000)
MoveTo(-5673.14697265625, -2757.06396484375)
MoveTo(-5516.36865234375, -2280.19775390625)
MoveTo(-5315.2265625, -1811.34558105469)
MoveTo(-5053.7841796875, -1385.13623046875)
MoveTo(-4746.45263671875, -1011.87158203125)
MoveTo(-4426.11474609375, -630.346313476563)
MoveTo(-4107.61376953125, -239.090286254883)
MoveTo(-3797.1259765625, 155.935455322266)
MoveTo(-3623.666015625, 617.51708984375)
MoveTo(-3938.09008789063, 972.233703613281)
MoveTo(-4362.712890625, 1157.03698730469)
MoveTo(-4792.51611328125, 1387.658203125)
MoveTo(-4792.51611328125, 1387.658203125)
MoveTo(-4703.05419921875, 1461.80029296875)
MoveTo(-4957.03076171875, 1949.94714355469)
MoveTo(-5028.56591796875, 2493.89086914063)
MoveTo(-5074.130859375, 3193.3857421875)
MoveTo(-5100.2490234375, 3907.9853515625)
MoveTo(-5081.55078125, 4468.67724609375)
MoveTo(-4931.1396484375, 5006.0146484375)
MoveTo(-4713.84814453125, 5660.2705078125)
MoveTo(-4411.1474609375, 6273.56201171875)
MoveTo(-4041.77758789063, 6826.154296875)
MoveTo(-3687.86572265625, 7241.787109375)
MoveTo(-3467.33154296875, 7914.00537109375)
MoveTo(-3271.09228515625, 8520.173828125)
MoveTo(-3041.04736328125, 9109.2421875)
MoveTo(-2806.72119140625, 9698.7666015625)
MoveTo(-2512.41870117188, 10239.7744140625)
MoveTo(-2008.49182128906, 10579.34375)
MoveTo(-1433.19860839844, 10770.3134765625)
MoveTo(-1053.494140625, 11165.935546875)
MoveTo(-1470.44604492188, 11705.5439453125)
MoveTo(-1589.79382324219, 12318.7919921875)
MoveTo(-1099.47473144531, 12828.2373046875)
MoveTo(-574.090026855469, 13288.037109375)
MoveTo(12.7980651855469, 13645.5)
MoveTo(622.149658203125, 13944.8857421875)
MoveTo(1273.63208007813, 14157.546875)
MoveTo(1637, 14268)
MoveTo(1805.54870605469, 14600.990234375)
MoveTo(1989.046875, 14277.0087890625)
MoveTo(2160.22436523438, 13895.1630859375)
MoveTo(2479.13720703125, 13265.7138671875)
MoveTo(2908.02612304688, 12702.3828125)
MoveTo(3216.54150390625, 12354.8037109375)
MoveTo(3325.77197265625, 11907.18359375)
MoveTo(3279.9375, 11416.166015625)
MoveTo(3254.17700195313, 10945.5390625)
MoveTo(3262.81958007813, 10496.3984375)
MoveTo(3340.27587890625, 10084.498046875)
MoveTo(3481.24291992188, 9717.154296875)
MoveTo(3599.20336914063, 9359.0888671875)
MoveTo(3700.94482421875, 9012.0380859375)
MoveTo(3820.63989257813, 8633.9560546875)
MoveTo(3938.33251953125, 8262.7802734375)
MoveTo(4068.75830078125, 7855.28125)
MoveTo(3967.892578125, 7408.26171875)
MoveTo(3515.6474609375, 7218.08056640625)
MoveTo(3088.00341796875, 7051.79541015625)
MoveTo(2703.75146484375, 6872.7724609375)
MoveTo(2345.61547851563, 6677.353515625)
MoveTo(2027.92504882813, 6458.07373046875)
MoveTo(1762.56274414063, 6179.1826171875)
MoveTo(1710.5869140625, 5811.59521484375)
MoveTo(1749.478515625, 5463.83984375)
MoveTo(1771.69030761719, 5123.66748046875)
MoveTo(1741.11645507813, 4739.955078125)
MoveTo(1620.78466796875, 4388.32275390625)
MoveTo(1417.06030273438, 4131.71533203125)
MoveTo(1048.96875, 3978.89990234375)
MoveTo(650.851623535156, 3869.30615234375)
MoveTo(537.939758300781, 3580.56713867188)
MoveTo(40.1657562255859, 3542.20825195313)
MoveTo(-489.093566894531, 3752.56884765625)
MoveTo(-640.225402832031, 3753.71264648438)
MoveTo(-640.225402832031, 3753.71264648438)
MoveTo(-834.969970703125, 3657.21362304688)
MoveTo(-1097.12084960938, 2996.63793945313)
MoveTo(-1275.85302734375, 2364.57202148438)
MoveTo(-1290.58264160156, 1875.74755859375)
MoveTo(-975.38720703125, 1503.01208496094)
MoveTo(-587.302307128906, 1185.67102050781)
MoveTo(-182.674926757813, 878.83740234375)
MoveTo(235.845916748047, 604.425842285156)
MoveTo(670.890747070313, 353.088073730469)
MoveTo(1051.85131835938, 127.378479003906)
MoveTo(1344.68774414063, -59.3420181274414)
MoveTo(1609.39416503906, -231.560195922852)
MoveTo(1856.71325683594, -95.5749816894531)
MoveTo(2161.50170898438, -36.033821105957)
MoveTo(2509.00463867188, -63.0022621154785)
MoveTo(2840.01611328125, -129.865844726563)
MoveTo(3261.39697265625, -266.361480712891)
MoveTo(3764.32885742188, -430.865112304688)
MoveTo(4257.23388671875, -591.448547363281)
MoveTo(4752.890625, -752.457336425781)
MoveTo(5309.21240234375, -911.053466796875)
MoveTo(5858.654296875, -1047.5234375)
MoveTo(6402.5146484375, -1153.16271972656)
MoveTo(6941.32177734375, -1244.51318359375)
MoveTo(7404.80517578125, -1433.50842285156)
MoveTo(7350.69140625, -1839.09643554688)
MoveTo(7030.20654296875, -2108.61376953125)
MoveTo(6815.83544921875, -2278.35668945313)
MoveTo(6815.83544921875, -2278.35668945313)
MoveTo(6748.55908203125, -2366.61157226563)
MoveTo(6328.45166015625, -2501.04150390625)
MoveTo(5823.482421875, -2552.1845703125)
MoveTo(5634.97900390625, -2939.51928710938)
MoveTo(5675.6728515625, -3427.07592773438)
MoveTo(5758.1494140625, -3998.13598632813)
MoveTo(5889.72314453125, -4707.5224609375)
MoveTo(6218.08544921875, -5233.54541015625)
MoveTo(6681.427734375, -5339.77734375)
MoveTo(7126.94921875, -5343.45263671875)
MoveTo(7556.546875, -5337.80224609375)
MoveTo(7947.3408203125, -5270.9609375)
MoveTo(8229.6171875, -5054.5703125)
MoveTo(8075.7177734375, -4664.0263671875)
MoveTo(7506.99072265625, -4303.58251953125)
MoveTo(7052.81005859375, -4108.4365234375)
MoveTo(6704.859375, -4139.23486328125)
MoveTo(6742.68017578125, -4537.0244140625)
MoveTo(7219.60888671875, -4569.6806640625)
MoveTo(7667.59228515625, -4350.32666015625)
MoveTo(8096.8359375, -4130.49658203125)
MoveTo(8572.78125, -4267.55224609375)
MoveTo(8991.6162109375, -4550.9208984375)
MoveTo(9394.1025390625, -4965.14892578125)
MoveTo(9236.4501953125, -5562.302734375)
MoveTo(8937.546875, -6123.43798828125)
MoveTo(8630.1748046875, -6673.458984375)
MoveTo(8337.0634765625, -7218.55859375)
MoveTo(8070.58984375, -7768.03076171875)
MoveTo(8169.9169921875, -8358.048828125)
MoveTo(8295.5263671875, -8925.74609375)
MoveTo(8415.921875, -9465.9931640625)
MoveTo(8301.6826171875, -9960.962890625)
MoveTo(7797.17822265625, -10331.787109375)
MoveTo(7148.45166015625, -10270.1240234375)
MoveTo(6575.65625, -9985.0068359375)
MoveTo(6034.8837890625, -9642.0908203125)
MoveTo(5485.896484375, -9305.203125)
MoveTo(4930.62841796875, -9044.8154296875)
MoveTo(4398.11572265625, -8803.1474609375)
MoveTo(3887.52758789063, -8565.05078125)
MoveTo(3523.76538085938, -8147.43310546875)
MoveTo(3161.13720703125, -7756.13671875)
MoveTo(2733.26098632813, -7507.34326171875)
MoveTo(2188.072265625, -7264.17529296875)
MoveTo(1565.94262695313, -6926.10498046875)
MoveTo(1091.18505859375, -6571.94482421875)
MoveTo(707.318420410156, -6391.583984375)
MoveTo(223.656188964844, -6205.5625)
MoveTo(-188.808471679688, -5739.4345703125)
MoveTo(-613.730407714844, -5276.01025390625)
MoveTo(-994.133422851563, -4868.31494140625)
MoveTo(-1508.54699707031, -4410.2421875)
AdlibUnRegister("RunningBasic")
AdlibUnRegister("RunningSpecial")
AdlibUnRegister("Stuck")

While GetMapLoading() = 1
	Sleep(100)
Wend
;MsgBox(0, "", "done")
Sleep(5000)
EndFunc

Func Race2()

Do
	MoveTo(-5668, -2804)
Until CheckArea(-5668, -2804)
AdlibRegister("RunningBasic", 3000)
AdlibRegister("RunningSpecial", 5000)
MoveTo(-5470.37109375, -2203.48364257813)
MoveTo(-5176.72705078125, -1707.71899414063)
MoveTo(-4818.078125, -1178.47241210938)
MoveTo(-4446.85791015625, -666.470336914063)
MoveTo(-4069.03247070313, -166.326263427734)
MoveTo(-3696.08374023438, 338.075225830078)
MoveTo(-3820.29907226563, 858.65380859375)
MoveTo(-4340.5625, 1162.28247070313)
MoveTo(-4837.845703125, 1610.74304199219)
MoveTo(-5067.40673828125, 2278.16015625)
MoveTo(-5092.75634765625, 2914.9091796875)
MoveTo(-5096.3603515625, 3485.36645507813)
MoveTo(-5081.21044921875, 4048.96435546875)
MoveTo(-5047.30126953125, 4614.58837890625)
MoveTo(-4895.08447265625, 5141.81884765625)
MoveTo(-4695.9052734375, 5740.751953125)
MoveTo(-4360.25341796875, 6345.56396484375)
MoveTo(-3993.60302734375, 6904.83740234375)
MoveTo(-3674.77514648438, 7353.14013671875)
MoveTo(-3548.51684570313, 7859.35693359375)
MoveTo(-3331.2451171875, 8518.8203125)
MoveTo(-3069.6337890625, 9199.556640625)
MoveTo(-2813.75561523438, 9778.984375)
MoveTo(-2467.8310546875, 10274.92578125)
MoveTo(-1952.71826171875, 10624.6083984375)
MoveTo(-1386.36669921875, 10858.3388671875)
MoveTo(-1038.74230957031, 11302.5478515625)
MoveTo(-1466.27111816406, 11651.98046875)
MoveTo(-1658.82275390625, 12174.9541015625)
MoveTo(-1272.26611328125, 12696.359375)
MoveTo(-718.338256835938, 13131.1123046875)
MoveTo(-116.14372253418, 13503.1279296875)
MoveTo(500.882873535156, 13818.8271484375)
MoveTo(1105.06884765625, 14125.4033203125)
MoveTo(1644.18286132813, 14214.7138671875)
MoveTo(2103.45751953125, 13961.4599609375)
MoveTo(2342.95434570313, 13570.37109375)
MoveTo(2557.65502929688, 13212.5556640625)
MoveTo(2791.25756835938, 12898.517578125)
MoveTo(3027.75341796875, 12577.5986328125)
MoveTo(3248.720703125, 12186.369140625)
MoveTo(3285.66772460938, 11731.9052734375)
MoveTo(3269.1875, 11301.904296875)
MoveTo(3255.67602539063, 10893.837890625)
MoveTo(3257.68701171875, 10514.8212890625)
MoveTo(3318.15844726563, 10159.8974609375)
MoveTo(3425.66186523438, 9787.6318359375)
MoveTo(3531.34741210938, 9432.75390625)
MoveTo(3633.03173828125, 9123.716796875)
MoveTo(3744.40356445313, 8793.2919921875)
MoveTo(3870.95629882813, 8424.2724609375)
MoveTo(4038.53173828125, 7880.4794921875)
MoveTo(3688.79296875, 7290.626953125)
MoveTo(3255.9111328125, 7060.05810546875)
MoveTo(2907.0263671875, 6894.6494140625)
MoveTo(2558.32055664063, 6729.3251953125)
MoveTo(2218.19995117188, 6549.25927734375)
MoveTo(1952.49645996094, 6266.04150390625)
MoveTo(1852.86083984375, 5853.29248046875)
MoveTo(1778.19348144531, 5339.9365234375)
MoveTo(1683.49975585938, 4848.998046875)
MoveTo(1592.69006347656, 4361.70654296875)
MoveTo(1318.4169921875, 3983.24438476563)
MoveTo(953.866638183594, 3725.40966796875)
MoveTo(601.05517578125, 3515.27758789063)
MoveTo(132.659881591797, 3464.74169921875)
MoveTo(-301.055053710938, 3716.85595703125)
MoveTo(-730.945678710938, 3570.34838867188)
MoveTo(-773.619262695313, 3472.71337890625)
MoveTo(-773.619262695313, 3472.71337890625)
MoveTo(-927.872924804688, 3257.9052734375)
MoveTo(-1077.94702148438, 2848.94555664063)
MoveTo(-1205.08337402344, 2475.66162109375)
MoveTo(-1275.13806152344, 2083.279296875)
MoveTo(-1132.78967285156, 1651.00952148438)
MoveTo(-756.865173339844, 1321.72277832031)
MoveTo(-310.367370605469, 953.666015625)
MoveTo(189.96728515625, 567.530151367188)
MoveTo(722.825866699219, 221.418365478516)
MoveTo(1201.4033203125, -39.4558486938477)
MoveTo(1603.6494140625, -242.407852172852)
MoveTo(1884.04077148438, -80.4217529296875)
MoveTo(2194.4775390625, -75.6898651123047)
MoveTo(2600.4287109375, -191.267364501953)
MoveTo(3288.4453125, -406.4931640625)
MoveTo(3856.34936523438, -588.831359863281)
MoveTo(4215.4404296875, -697.169311523438)
MoveTo(4569.32177734375, -803.277404785156)
MoveTo(4985.84423828125, -922.239868164063)
MoveTo(5478.0615234375, -1004.97509765625)
MoveTo(5950.3125, -1082.5732421875)
MoveTo(6394.751953125, -1155.6015625)
MoveTo(6820.46728515625, -1225.55297851563)
MoveTo(7211.06005859375, -1290.2880859375)
MoveTo(7417.22119140625, -1520.75024414063)
MoveTo(7397.10009765625, -1825.66467285156)
MoveTo(7093.4345703125, -2072.01489257813)
MoveTo(6700.11962890625, -2352.60034179688)
MoveTo(6239.880859375, -2528.58447265625)
MoveTo(5742.6806640625, -2596.06713867188)
MoveTo(5669.19580078125, -3047.5478515625)
MoveTo(5714.01318359375, -3546.67431640625)
MoveTo(5779.18017578125, -4044.91870117188)
MoveTo(5841.41162109375, -4533.796875)
MoveTo(5993.4208984375, -4976.2587890625)
MoveTo(6331.435546875, -5242.4521484375)
MoveTo(6753.12841796875, -5268.0693359375)
MoveTo(7153.32958984375, -5301.20068359375)
MoveTo(7539.876953125, -5293.70703125)
MoveTo(7914.04931640625, -5261.26025390625)
MoveTo(8220.8388671875, -4810.94580078125)
MoveTo(7625.55712890625, -4451.65234375)
MoveTo(7279.4482421875, -4232.70654296875)
MoveTo(6819.34228515625, -4146.22509765625)
MoveTo(6924.14453125, -4566.46240234375)
MoveTo(7461.30712890625, -4451.3974609375)
MoveTo(7987.02587890625, -4227.154296875)
MoveTo(8535.13671875, -4289.544921875)
MoveTo(9027.2763671875, -4590.79052734375)
MoveTo(9410.2451171875, -4994.1953125)
MoveTo(9455.716796875, -5530.80712890625)
MoveTo(9198.337890625, -5995.6962890625)
MoveTo(8925.1826171875, -6435.1123046875)
MoveTo(8577.580078125, -6934.2841796875)
MoveTo(8167.109375, -7511.43212890625)
MoveTo(8077.12060546875, -8093.400390625)
MoveTo(8212.330078125, -8533.4072265625)
MoveTo(8321.640625, -8954.2099609375)
MoveTo(8391.0205078125, -9354.146484375)
MoveTo(8428.927734375, -9739.3095703125)
MoveTo(8236.2041015625, -10079.7626953125)
MoveTo(7834.35791015625, -10267.51171875)
MoveTo(7312.2255859375, -10271.4033203125)
MoveTo(6766.33544921875, -10140.1220703125)
MoveTo(6239.8466796875, -9905.3193359375)
MoveTo(5755.25439453125, -9614.267578125)
MoveTo(5290.630859375, -9314.9931640625)
MoveTo(4770.28466796875, -9010.724609375)
MoveTo(4117.03515625, -8689.08203125)
MoveTo(3613.03759765625, -8303.5048828125)
MoveTo(3240.74877929688, -7968.04541015625)
MoveTo(2879.02807617188, -7672.64404296875)
MoveTo(2520.33349609375, -7449.59228515625)
MoveTo(2206.638671875, -7277.3505859375)
MoveTo(1937.8115234375, -7105.35107421875)
MoveTo(1411.46850585938, -6722.2099609375)
MoveTo(871.271362304688, -6334.04833984375)
MoveTo(497.658294677734, -6307.0625)
MoveTo(113.552917480469, -6085.138671875)
MoveTo(-315.519409179688, -5631.0283203125)
MoveTo(-715.401306152344, -5148.45458984375)
MoveTo(-1322.26086425781, -4541.7373046875)
MoveTo(-1322.26086425781, -4541.7373046875)
MoveTo(-1322.26086425781, -4541.7373046875)
MoveTo(-1322.26086425781, -4541.7373046875)
MoveTo(-1322.26086425781, -4541.7373046875)
MoveTo(-1322.26086425781, -4541.7373046875)
MoveTo(-1322.26086425781, -4541.7373046875)
MoveTo(-1322.26086425781, -4541.7373046875)
MoveTo(-1322.26086425781, -4541.7373046875)
MoveTo(-1322.26086425781, -4541.7373046875)
Move(-1322.26086425781, -4541.7373046875)

AdlibUnRegister("RunningBasic")
AdlibUnRegister("RunningSpecial")

While GetMapLoading() = 1
	Sleep(100)
Wend
;MsgBox(0, "", "done")
Sleep(5000)
EndFunc
	#EndRegion

	#Region Side Functions
		#Region Build & Skill Functions
Func RunningBasic()
	If $GUI_CHECKED = GUICtrlRead($cbFriendly) Then
		Local $rnd = Random(1, 2, 1)
		If DllStructGetData(GetSkillbar(), 'Recharge' & $rnd) = 0 Then
			UseSkill($rnd, 0)

		EndIf
	Else
		Local $rnd = Random(1, 3, 1)
		If DllStructGetData(GetSkillbar(), 'Recharge' & $rnd) = 0 Then
			UseSkill($rnd, 0)

		EndIf
	EndIf
EndFunc

Func RunningSpecial()
	If $GUI_CHECKED = GUICtrlRead($cbFriendly) Then
		For $i = 4 to 8
			If $i = 6 OR $i = 8 Then
				If DllStructGetData(GetSkillbar(), 'Recharge' & $i) = 0 Then UseSkill($i, 0)
			EndIf
		Next
	Else
		For $i = 4 to 8
			If $i = 5 Or $i = 7 Or $i = 4 Then
				TargetNearestEnemy()
				If DllStructGetData(GetSkillbar(), 'Recharge' & $i) = 0 Then UseSkill($i, GetAgentByID(-1))
			Else
				If DllStructGetData(GetSkillbar(), 'Recharge' & $i) = 0 Then UseSkill($i, 0)
			EndIf
		Next

	EndIf
EndFunc
		#EndRegion

		#Region Player Interactions
Func Stuck()
	$stuckx1 = $stuckx2
	$stucky1 = $stucky2

	$stuckx2 = DllStructGetData(GetAgentByID(-2), 'X')
	$stucky2 = DllStructGetData(GetAgentByID(-2), 'Y')

	If $stuckx1 = $stuckx2 And $stucky1 = $stucky2 Then
		StrafeLeft(1)
		Sleep(200)
		StrafeLeft(0)

		$stuckx2 = DllStructGetData(GetAgentByID(-2), 'X')
		$stucky2 = DllStructGetData(GetAgentByID(-2), 'Y')

		If $stuckx1 = $stuckx2 And $stucky1 = $stucky2 Then
			StrafeRight(1)
			Sleep(200)
			StrafeRight(0)
		EndIf
	EndIf
EndFunc
		#EndRegion

		#Region Count
Func CountRacingMedals()
	$quantity = 0
	For $i = 1 To 4
		For $j = 1 To DllStructGetData(GetBag($i), 'Slots')
			$lItem = GetItemBySlot($i, $j)
			Switch DllStructGetData($lItem, 'ModelID')
				Case 37793
					$quantity += DllStructGetData($lItem, 'Quantity')
				Case Else
					ContinueLoop
			EndSwitch
		Next
	Next
	return $quantity
EndFunc
		#EndRegion
	#EndRegion
#EndRegion