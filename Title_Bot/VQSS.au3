
Func VQSS();

	CurrentAction("Taking blessing")

	$deadlock = 0

	if $Bool_cons then
		UseConsets()
	EndIf


	GetNearestNPCToCoords(15773, -15302)
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
	If GetAreaVanquished() = False Then AggroMoveTo(4543, -12928, $enemy)

	$enemy = "Second Group"
	If GetAreaVanquished() = False Then AggroMoveTo(2361, -10638, $enemy)

	$enemy = "Third Group"
	If GetAreaVanquished() = False Then AggroMoveTo(1218, -9046, $enemy, 1800)

	$enemy = "4 Group"
	If GetAreaVanquished() = False Then AggroMoveTo(825, -5411, $enemy)

	$enemy = "Monk Boss Group"
	If GetAreaVanquished() = False Then AggroMoveTo(-599, -3110, $enemy, 1600)

	CurrentAction("Moving Other Side")

	MoveTo(1785, -5534)

	MoveTo(3027, -5764)
	MoveTo(6122, -2189)
	MoveTo(9346, -3097)

	$enemy = "First Group"
	If GetAreaVanquished() = False Then AggroMoveTo(10874, -5008, $enemy)

	$enemy = "Second Group"
	If GetAreaVanquished() = False Then AggroMoveTo(10970, -7779, $enemy)

	$enemy = "Third Group"
	If GetAreaVanquished() = False Then AggroMoveTo(14262, -7000, $enemy)

	$enemy = "E Boss Group"
	If GetAreaVanquished() = False Then AggroMoveTo(16338, -6716, $enemy)
EndFunc
