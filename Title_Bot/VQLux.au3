Func VQLuxon() ;

	CurrentAction("Taking blessing")
	$deadlock = 0

	if $Bool_cons then
		UseConsets()
	EndIf

GetNearestNPCToCoords(-8394, -9801)

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


CurrentAction("Waiting to get reward")
Sleep(6000)
EndFunc