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

$enemy = "Checking for Missing Entity"
If GetAreaVanquished() = False Then AggroMoveToEx(8789, -7285, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(6272, -8739, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(4971, -6945, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(2672, -7902, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-486, -8998, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-3799, -7831, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-7529, -7210, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-5859, -5245, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-7546, -2795, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-11337, -2872, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-9899, 19, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-10592, 3868, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-9465, 7500, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-5926, 6880, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-5214, 4478, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-6669, 647, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(-2506, 1100, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(1281, 1138, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(3825, 5618, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(7169, 7811, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(7649, 6366, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(9529, 8346, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(12450, 7721, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(15512, 6760, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(17033, 3421, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(15498, -316, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(13774, -4433, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(12658, -7181, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(2147, 3452, $enemy, 4000)
If GetAreaVanquished() = False Then AggroMoveToEx(3448, 5167, $enemy, 4000)

CurrentAction("Waiting to get reward")
Sleep(6000)
EndFunc