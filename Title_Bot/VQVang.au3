Func VQVanguard();

	$DeadOnTheRun = 0
	CurrentAction("Taking Blessing")
	GetNearestNPCToCoords(-14971.00, 11013.00)
	Sleep(1000)
	Dialog(0x84)
	Sleep(1000)

	if $Bool_cons then
		UseConsets()
	EndIf

	CurrentAction("Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(-12373, 12899)
	If GetAreaVanquished() = False Then AggroMoveTo(-9464, 15937, "Charr Group")
	CurrentAction("Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(-9130, 13535)
	CurrentAction("Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(-5532, 11281)
	If GetAreaVanquished() = False Then AggroMoveTo(-3979, 9184, "Mantid Group")
	If GetAreaVanquished() = False Then AggroMoveTo(-355, 9296, "Again mantid Group")
	If GetAreaVanquished() = False Then AggroMoveTo(836, 12171, "Charr Patrol", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(884, 15641, "Charr Group")
	If GetAreaVanquished() = False Then AggroMoveTo(2956, 10496, "Mantid Group")
	If GetAreaVanquished() = False Then AggroMoveTo(5160, 11032, "Moving")
	CurrentAction("Taking Blessing")
	GetNearestNPCToCoords(5816, 11687)
	Sleep(1000)
	CurrentAction("Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(5848, 11086, "Mantid Group", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(7639, 11839, "Charr Patrol")
	If GetAreaVanquished() = False Then AggroMoveTo(6494, 15729, "Charr Patrol")
	If GetAreaVanquished() = False Then AggroMoveTo(5704, 17469, "Charr Group")
	If GetAreaVanquished() = False Then AggroMoveTo(8572, 12365, "Moving Back")
	If GetAreaVanquished() = False Then AggroMoveTo(13960, 13432, "Charr Group")
	If GetAreaVanquished() = False Then AggroMoveTo(15385, 9899, "Going Charr")
	If GetAreaVanquished() = False Then AggroMoveTo(17089, 6922, "Charr Group")
	If GetAreaVanquished() = False Then AggroMoveTo(16363, 3809, "Moving Gain")
	If GetAreaVanquished() = False Then AggroMoveTo(15635, 710, "Charr Group")
	If GetAreaVanquished() = False Then AggroMoveTo(12754, 2740, "Charr Seeker")
	If GetAreaVanquished() = False Then AggroMoveTo(10068, 2580, "Skale")
	If GetAreaVanquished() = False Then AggroMoveTo(7663, 3236, "Charr Seeker")
	If GetAreaVanquished() = False Then AggroMoveTo(6152, 1706, "Charr Seeker")
	If GetAreaVanquished() = False Then AggroMoveTo(5086, -2187, "Charr on the way", 2500)
	If GetAreaVanquished() = False Then AggroMoveTo(3449, -3693, "Charr Patrol", 2000)
	If GetAreaVanquished() = False Then AggroMoveTo(7170, -4037, "Moving")
	CurrentAction("Taking Blessing")
	GetNearestNPCToCoords(8565, -3974)
	Sleep(1000)
	If GetAreaVanquished() = False Then AggroMoveTo(8903, -1801, "Second Skale")
	If GetAreaVanquished() = False Then AggroMoveTo(6790, -6124, "Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(3696, -9324, "Charr Patrol", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(6790, -6124, "Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(8031, -10361, "Charr on the way")
	If GetAreaVanquished() = False Then AggroMoveTo(9282, -12837, "Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(8817, -16314, "Charr Patrol", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(13337, -14025, "Charr Patrol 2", 3000)

	If GetAreaVanquished() = False Then AggroMoveTo(13675, -5513, "Charr Group", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(14760, -2224, "Charr Group", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(13378, -2577, "Charr Group")
	;If GetAreaVanquished() = False Then AggroMoveTo(13675, -5513, "Charr Group")

	;If GetAreaVanquished() = False Then AggroMoveTo(13337, -14025, "Charr Patrol 2")
	;If GetAreaVanquished() = False Then AggroMoveTo(15290, -13688, "Charr Seeker")
	If GetAreaVanquished() = False Then AggroMoveTo(17500, -11685, "Charr Group")
	If GetAreaVanquished() = False Then AggroMoveTo(15290, -13688, "Charr Seeker")
	If GetAreaVanquished() = False Then AggroMoveTo(15932, -14104, "Moving Back")
	If GetAreaVanquished() = False Then AggroMoveTo(14934, -17261, "Moving")

	;If GetAreaVanquished() = False Then AggroMoveTo(17500, -11685, "Charr Group")
	;If GetAreaVanquished() = False Then AggroMoveTo(15932, -14104, "Moving Back")
	;If GetAreaVanquished() = False Then AggroMoveTo(14934, -17261, "Moving")


	CurrentAction("Taking Blessing")
	GetNearestNPCToCoords(14891, -18146)
	Sleep(1000)
	If GetAreaVanquished() = False Then AggroMoveTo(11509, -17586, "Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(6031, -17582, "Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(2846, -17340, "Charr Group")
	If GetAreaVanquished() = False Then AggroMoveTo(-586, -16529, "Charr Seeker")
	If GetAreaVanquished() = False Then AggroMoveTo(-4099, -14897, "Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(-4217, -12620, "Moving")

	CurrentAction("Taking Blessing")
	GetNearestNPCToCoords(-4014, -11504)
	Sleep(1000)
	If GetAreaVanquished() = False Then AggroMoveTo(-8023, -13970, "Charr Seeker")
	If GetAreaVanquished() = False Then AggroMoveTo(-7326, -8852, "Charr Seeker")
	If GetAreaVanquished() = False Then AggroMoveTo(-8023, -13970, "Charr Patrol")

	If GetAreaVanquished() = False Then AggroMoveTo(-9808, -15103, "Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(-10902, -16356, "Skale Place", 2000)
	If GetAreaVanquished() = False Then AggroMoveTo(-11917, -18111, "Skale Place", 2000)
	If GetAreaVanquished() = False Then AggroMoveTo(-13425, -16930, "Skale Boss")
	If GetAreaVanquished() = False Then AggroMoveTo(-15218, -17460, "Skale Group")
	If GetAreaVanquished() = False Then AggroMoveTo(-16084, -14159, "Skale Group")
	If GetAreaVanquished() = False Then AggroMoveTo(-17395, -12851, "Skale Place")
	;charr on field
	If GetAreaVanquished() = False Then AggroMoveTo(-18157, -9785, "Skale On the Way", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(-18222, -6263, "Finish Skale", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(-17239, -1933, "Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(-17509, 202, "Moving")

	CurrentAction("Taking Blessing")
	GetNearestNPCToCoords(-17546, 341)
	Sleep(1000)
	If GetAreaVanquished() = False Then AggroMoveTo(-13853, -2427, "Charr Seeker")
	If GetAreaVanquished() = False Then AggroMoveTo(-9313, -3786, "Charr Seeker")
	If GetAreaVanquished() = False Then AggroMoveTo(-13228, 2083, "Charr Seeker")

	If GetAreaVanquished() = False Then AggroMoveTo(-13622, 5476, "Moving")
	If GetAreaVanquished() = False Then AggroMoveTo(-17705, 3079, "Mantid on the way")
	If GetAreaVanquished() = False Then AggroMoveTo(-16565, 2528, "More Charr")
	If GetAreaVanquished() = False Then AggroMoveTo(-17705, 3079, "Moving")

	If GetAreaVanquished() = False Then AggroMoveTo(-12909, 6403, "Mantid on the way")
	If GetAreaVanquished() = False Then AggroMoveTo(-10699, 5105, "Mantid Group")
	If GetAreaVanquished() = False Then AggroMoveTo(-9016, 6958, "Mantid Group")
	If GetAreaVanquished() = False Then AggroMoveTo(-8889, 9446, "Mantid Group")
	If GetAreaVanquished() = False Then AggroMoveTo(-6869, 4604, "Mantid Monk Boss")
	If GetAreaVanquished() = False Then AggroMoveTo(-8190, 6872, "Mantid")


	If GetAreaVanquished() = False Then AggroMoveTo(-6181, 1837, "Mantid Group")

	If GetAreaVanquished() = False Then AggroMoveTo(-4125, 2789, "Mantid Group")

	If GetAreaVanquished() = False Then AggroMoveTo(-2875, 985, "Moving")

	If GetAreaVanquished() = False Then AggroMoveTo(-769, 2047, "Charr Group")

	If GetAreaVanquished() = False Then AggroMoveTo(1114, 1765, "Mantid and Charr")

	If GetAreaVanquished() = False Then AggroMoveTo(6550, 7549, "Looking for Mantids", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(8246, 8104, "Looking for Mantids", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(6550, 7549, "Looking for Mantids", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(1960, 4969, "Looking for Mantids", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(621, 8056, "Looking for Mantids", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(-4039, 8928, "Looking for Mantids", 3000)
	If GetAreaVanquished() = False Then AggroMoveTo(-3299, 606, "Looking for Mantids", 3000)

	CurrentAction("Taking Blessing")
	GetNearestNPCToCoords(-2646, -452)
	Sleep(1000)


	If GetAreaVanquished() = False Then AggroMoveTo(5219, -5017, "Charr Patrol")
	If GetAreaVanquished() = False Then AggroMoveTo(7289, -9484, "Charr Patrol")
	If GetAreaVanquished() = False Then AggroMoveTo(5219, -7017, "Charr Patrol")
	If GetAreaVanquished() = False Then AggroMoveTo(1342, -9068, "Charr Patrol")

	If GetAreaVanquished() = False Then AggroMoveTo(1606, 22, "Charr Patrol")


	If GetAreaVanquished() = False Then AggroMoveTo(-276, -2566, "Going to Molotov")
	If GetAreaVanquished() = False Then AggroMoveTo(-3337, -4323, "Molotov")
	If GetAreaVanquished() = False Then AggroMoveTo(-4700, -4943, "Molotov")
	If GetAreaVanquished() = False Then AggroMoveTo(-5561, -5483, "Molotov", 10000)


EndFunc
