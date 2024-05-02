

Func VQSSLB();

	CurrentAction("Taking blessing")

	$deadlock = 0

	if $Bool_cons then
		UseConsets()
	EndIf


	;Interact with NPCs to take blessings
    CurrentAction("Taking Blessing")
    GoToNPC(GoNearestNPCToCoords(-704, 15988))
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
	GoToNPC(GoNearestNPCToCoords(-20587, 7280))
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