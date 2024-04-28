
Func VQNorn()
    Local $waypoints[4][2] = [ _
        [-2484.73, 118.55], _
        [-3059.12, -419.00], _
        [-3301.01, -2008.23], _
        [-2034, -4512] _
    ]

    CurrentAction("Taking blessing")
    If $Bool_cons Then
        UseConsets()
    EndIf

    ; Navigate through each waypoint
    For $i = 0 To UBound($waypoints) - 1
        $x = $waypoints[$i][0]
        $y = $waypoints[$i][1]
        CurrentAction("Moving to waypoint: " & $x & ", " & $y & @CRLF)

        MoveTo($x, $y)


        RndSleep(500)
    Next

    GetNearestNPCToCoords(-2034, -4512)
    Dialog(0x00000084)
    RndSleep(1000)

	Do
		$DeadOnTheRun = 0
		$enemy = "Berzerker"
		If GetAreaVanquished() = False Then AggroMoveTo(-5278, -5771, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-5456, -7921, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-8793, -5837, $enemy)

		$enemy = "Vaettir and Berzerker"
		If GetAreaVanquished() = False Then AggroMoveTo(-14092, -9662, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-17260, -7906, $enemy)

		$enemy = "Jotun "
		If GetAreaVanquished() = False Then AggroMoveTo(-21964, -12877, $enemy, 2500)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(-21964, -12877, 1000)

	CurrentAction("Taking blessing")
	GetNearestNPCToCoords(-25272.89, -11968.49)
	RndSleep(1000)

	Do
		$DeadOnTheRun = 0
		MoveTo(-22275, -12462)

		$enemy = "Berzerker"
		If GetAreaVanquished() = False Then AggroMoveTo(-21671, -2163, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-19592, 772, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-13795, -751, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-17012, -5376, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(-17012, -5376, 1000)

	CurrentAction("Taking blessing")
	GetNearestNPCToCoords(-12071, -4274)
	RndSleep(1000)

	Do
		$DeadOnTheRun = 0
		$enemy = "Berzerker"
		If GetAreaVanquished() = False Then AggroMoveTo(-8351, -2633, $enemy)
		MoveTo(-4362, -1610)

		$enemy = "Lake"
		If GetAreaVanquished() = False Then AggroMoveTo(-4316, 4033, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-8809, 5639, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-14916, 2475, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(-14916, 2475, 1000)

	CurrentAction("Taking blessing")
	GetNearestNPCToCoords(-11282, 5466)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		$enemy = "Elemental"
		If GetAreaVanquished() = False Then AggroMoveTo(-16051, 6492, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-16934, 11145, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(-19378, 14555, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(-19378, 14555, 1000)

		CurrentAction("Taking blessing")
		GetNearestNPCToCoords(-22751, 14163)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		If GetAreaVanquished() = False Then AggroMoveTo(-15932, 9386, $enemy)
		MoveTo(-13777, 8097)

		$enemy = "Lake"
		If GetAreaVanquished() = False Then AggroMoveTo(-4729, 15385, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(-4729, 15385, 1000)

	CurrentAction("Taking blessing")
	GetNearestNPCToCoords(-2290, 14879)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		$enemy = "Modnir"
		If GetAreaVanquished() = False Then AggroMoveTo(-1810, 4679, $enemy)

		$enemy = "Boss"
		Moveto(-6911, 5240)
		If GetAreaVanquished() = False Then AggroMoveTo(-15471, 6384, $enemy)
		Moveto(-411, 5874)

		$enemy = "Modniir "
		If GetAreaVanquished() = False Then AggroMoveTo(2859, 3982, $enemy)

		$enemy = "Ice Imp"
		If GetAreaVanquished() = False Then AggroMoveTo(4909, -4259, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(7514, -6587, $enemy)

		$enemy = "Berserker"
		If GetAreaVanquished() = False Then AggroMoveTo(3800, -6182, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(7755, -11467, $enemy)

		$enemy = "Elementals and Griffins"
		If GetAreaVanquished() = False Then AggroMoveTo(15403, -4243, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(21597, -6798, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(21597, -6798, 1000)
	
	CurrentAction("Taking blessing")
	GetNearestNPCToCoords(24522, -6532)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		If GetAreaVanquished() = False Then AggroMoveTo(22883, -4248, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(18606, -1894, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(14969, -4048, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(13599, -7339, $enemy)

		 $enemy = "Ice Imp"
		If GetAreaVanquished() = False Then AggroMoveTo(10056, -4967, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(10147, -1630, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(8963, 4043, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(8963, 4043, 1000)

	CurrentAction("Taking blessing")
	GetNearestNPCToCoords(8963, 4043)
	RndSleep(1000)

	Do
		$DeadOnTheRun = 0
		$enemy = ""
		If GetAreaVanquished() = False Then AggroMoveTo(15576, 7156, $enemy)

		$enemy = "Berserker"
		If GetAreaVanquished() = False Then AggroMoveTo(22838, 7914, $enemy, 2500)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(22838, 7914, 1000)

	CurrentAction("Taking blessing")
	GetNearestNPCToCoords(22961, 12757)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		$enemy = "Modniir and Elemental"
		MoveTo(18067, 8766)
		If GetAreaVanquished() = False Then AggroMoveTo(13311, 11917, $enemy)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(13311, 11917, 1000)

	CurrentAction("Taking blessing")
	GetNearestNPCToCoords(13714, 14520)
	RndSleep(1000)
	
	Do
		$DeadOnTheRun = 0
		$enemy = "Modniir and Elemental"
		If GetAreaVanquished() = False Then AggroMoveTo(11126, 10443, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(5575, 4696, $enemy, 2500)

		 $enemy = "Modniir and Elemental 2"
		If GetAreaVanquished() = False Then AggroMoveTo(-503, 9182, $enemy)
		If GetAreaVanquished() = False Then AggroMoveTo(1582, 15275, $enemy, 2500)
		If GetAreaVanquished() = False Then AggroMoveTo(7857, 10409, $enemy, 2500)
		If  $DeadOnTheRun = 1 then RndSlp(15000)
	Until CheckArea(7857, 10409, 1000)
EndFunc