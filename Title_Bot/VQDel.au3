Func VQDeldrimor();

	CurrentAction("Taking blessing")

	$deadlock = 0
	if $Bool_cons then
		UseConsets()
	EndIf


	GetNearestNPCToCoords(-14103, 15457)
	RndSleep(1000)
	Dialog(0x00000084)
	RndSleep(1000)

	Do
		$DeadOnTheRun = 0
		 $enemy = "Snowmen at begining"
		If GetAreaVanquished() = False Then AggroMoveTo(-15988, 10018, $enemy)

		CurrentAction("Avoiding snowball")
		If GetAreaVanquished() = False Then AggroMoveTo(-17986, 6483)
		RndSleep(1000)

		 $enemy = "Snowmen"
		If GetAreaVanquished() = False Then AggroMoveTo(-17574, 2190, $enemy)

		 $enemy = "Cleaning way"
		If GetAreaVanquished() = False Then AggroMoveTo(-15361, 2551, $enemy)

		 $enemy = "Going to shrine"
		If GetAreaVanquished() = False Then AggroMoveTo(-14596, 2612, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-14506, 3963, $enemy)
		If  $DeadOnTheRun = 1 then Sleep(15000)
	Until CheckArea(-14506, 3963, 1000)


	CurrentAction("Taking blessing")
	GetNearestNPCToCoords(-12512, 3919)
	RndSleep(500)

	Do
		$DeadOnTheRun = 0
		 $enemy = "Snowman on the way"
		CurrentAction("Moving away")
		If GetAreaVanquished() = False Then AggroMoveTo(-14556, 4065)
		If GetAreaVanquished() = False Then AggroMoveTo(-14596, 2612)
		CurrentAction("Avoiding Icy")
		If GetAreaVanquished() = False Then AggroMoveTo(-14583, 1896)
		If GetAreaVanquished() = False Then AggroMoveTo(-14262, 974)
		If GetAreaVanquished() = False Then AggroMoveTo(-13759, -552)
		If GetAreaVanquished() = False Then AggroMoveTo(-13306, -1211)
		If GetAreaVanquished() = False Then AggroMoveTo(-12570, -2997)


		 $enemy = "Snowman"
		If GetAreaVanquished() = False Then AggroMoveTo(-13114, -6255, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-14367, -9244, $enemy)
		If  $DeadOnTheRun = 1 then Sleep(15000)
	Until CheckArea(-14367, -9244, 100)

	CurrentAction("Taking blessing")
	GetNearestNPCToCoords(-16025, -10702, 100)
	RndSleep(500)

	Do
		$DeadOnTheRun = 0
		 $enemy = "Ennemy near door"
		If GetAreaVanquished() = False Then AggroMoveTo(-15396, -10850, $enemy)
		Moveto(-13970, -9719)
		Moveto(-13047, -10683)
		 $enemy = "Angry Snowman"
		If GetAreaVanquished() = False Then AggroMoveTo(-10097, -11373, $enemy)
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
		 $enemy = "Snowman"
		If GetAreaVanquished() = False Then AggroMoveTo(-17287, -13895, $enemy)

		 $enemy = "Boss and others"
		If GetAreaVanquished() = False Then AggroMoveTo(-15483, -16565, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-13362, -17430, $enemy)
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