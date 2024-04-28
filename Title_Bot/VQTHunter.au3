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