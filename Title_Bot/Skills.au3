Global $iniFilePath = @ScriptDir & "\skill_requirements.ini"

; Define skill requirements
Global $intSkillEnergy[8] = [1, 15, 5, 5, 10, 15, 10, 5]
Global $intSkillCastTime[8] = [1000, 1250, 1250, 1250, 1250, 1000, 250, 1000]
Global $intSkillAdrenaline[8] = [0, 0, 0, 0, 0, 0, 0, 0]

; Save to INI File
For $i = 1 To 8
    IniWrite($iniFilePath, "Skill" & $i, "Energy", $intSkillEnergy[$i-1])
    IniWrite($iniFilePath, "Skill" & $i, "CastTime", $intSkillCastTime[$i-1])
    IniWrite($iniFilePath, "Skill" & $i, "Adrenaline", $intSkillAdrenaline[$i-1])
Next


Func UseSkillBasedOnRequirements($skillNumber)
    Local $iniFilePath = @ScriptDir & "\skill_requirements.ini"
    Local $energy = IniRead($iniFilePath, "Skill" & $skillNumber, "Energy", "0")
    Local $castTime = IniRead($iniFilePath, "Skill" & $skillNumber, "CastTime", "0")
    Local $adrenaline = IniRead($iniFilePath, "Skill" & $skillNumber, "Adrenaline", "0")

    ; Now use these variables to check conditions and apply the skill
    If (CurrentEnergy() >= $energy) And (CurrentAdrenaline() >= $adrenaline) Then
        ; Assuming you have a function to activate the skill
        ActivateSkill($skillNumber)
        Sleep($castTime + 1000)  ; Adjust sleep as necessary based on the action
    EndIf
EndFunc

Func Fight2($x, $s = "")
    Local $iniFilePath = @ScriptDir & "\skill_requirements.ini"
    Local $skillName = "Skill" & $s  ; Assumes $s is the skill number

    CurrentAction("Fighting")

    Do
        Sleep(250)
        $nearestEnemy = GetNearestEnemyToAgent(-2)
    Until DllStructGetData($nearestEnemy, 'ID') <> 0

    Do
        $useSkill = -1
        $target = GetNearestEnemyToAgent(-2)
        $distance = GetDistance($target, -2)
        If DllStructGetData($target, 'ID') <> 0 And $distance < $x Then
            ChangeTarget($target)
            Sleep(150)
            CallTarget($target)
            Sleep(150)
            Attack($target)
            Sleep(150)
        ElseIf DllStructGetData($target, 'ID') = 0 Or $distance > $x Then
            ExitLoop
        EndIf

        For $i = 1 To 8  ; Assuming 8 skills, adjust as necessary
            $targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
            If $targetHP = 0 Or $distance > $x Then ExitLoop

            $energy = GetEnergy(-2)
            $recharge = DllStructGetData(GetSkillBar(), "Recharge" & $i)
            $adrenaline = DllStructGetData(GetSkillBar(), "Adrenaline" & $i)

            If $recharge = 0 And $energy >= IniRead($iniFilePath, "Skill" & $i, "Energy", "0") _
                And $adrenaline >= IniRead($iniFilePath, "Skill" & $i, "Adrenaline", "0") * 25 - 25 Then
                $useSkill = $i
                PingSleep(250)
                UseSkill($useSkill, $target)
                Sleep(IniRead($iniFilePath, "Skill" & $i, "CastTime", "0") + 1000)
            EndIf
        Next
    Until DllStructGetData($target, 'ID') = 0 Or $distance > $x
    If GetHealth(-2) < 2400 Then UseSkill(7, -2)
    PingSleep(3000)

    CurrentAction("Picking up items")
    If $Bool_PickUp Then PickUpLoot()
    If $Bool_Uselockpicks Then CheckForChest()
EndFunc   ;==>Fight

Func FightCustomMatch($x, $s = "")
    Local $iniFilePath = @ScriptDir & "\skill_requirements.ini"
    Local $skillName = "Skill" & $s 
    Local $pickupRange = $x * 0.8  

    CurrentAction("Fighting")

    Do
        Sleep(250)
        $nearestEnemy = GetNearestEnemyToAgent(-2)
    Until DllStructGetData($nearestEnemy, 'ID') <> 0

    Do
        $useSkill = -1
        $target = GetNearestEnemyToAgent(-2)
        $distance = GetDistance($target, -2)
        If DllStructGetData($target, 'ID') <> 0 And $distance < $x Then
            ChangeTarget($target)
            Sleep(150)
            CallTarget($target)
            Sleep(150)
            Attack($target)
            Sleep(150)

            ; Check for lootable objects in range and pick them up if within the pickup range
            If $Bool_PickUp Then
                Local $LooteableObjectCount = GetCountInRangeOfAgent(-2, $pickupRange, $NoneUnitType, $TypeLooteable)
                If $LooteableObjectCount > 0 Then
                    Local $LooteableObject = GetClosestInRangeOfAgent(-2, $pickupRange, $NoneUnitType, $TypeLooteable)
                    Local $LooteableObjectDistance = ComputeDistance(DllStructGetData(-2, 'X'), DllStructGetData(-2, 'Y'), DllStructGetData($LooteableObject, 'X'), DllStructGetData($LooteableObject, 'Y'))
                    If $LooteableObjectDistance <= $pickupRange Then
                        PickUpLoot()  
                    EndIf
                EndIf
            EndIf

        ElseIf DllStructGetData($target, 'ID') = 0 Or $distance > $x Then
            ExitLoop
        EndIf

        For $i = 1 To 8
            $targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
            If $targetHP = 0 Or $distance > $x Then ExitLoop

            $energy = GetEnergy(-2)
            $recharge = DllStructGetData(GetSkillBar(), "Recharge" & $i)
            $adrenaline = DllStructGetData(GetSkillBar(), "Adrenaline" & $i)

            If $recharge = 0 And $energy >= IniRead($iniFilePath, "Skill" & $i, "Energy", "0") _
                And $adrenaline >= IniRead($iniFilePath, "Skill" & $i, "Adrenaline", "0") * 25 - 25 Then
                $useSkill = $i
                PingSleep(250)
                UseSkill($useSkill, $target)
                Sleep(IniRead($iniFilePath, "Skill" & $i, "CastTime", "0") + 1000)
            EndIf
        Next
    Until DllStructGetData($target, 'ID') = 0 Or $distance > $x
    If GetHealth(-2) < 2400 Then UseSkill(7, -2)
    PingSleep(3000)

    CurrentAction("Picking up items")
	If $Bool_PickUp Then PickUpLoot()
    If $Bool_Uselockpicks Then CheckForChest()
EndFunc   ;==>Fight

Func FightOriginalCode($x, $s = "")
    Local $iniFilePath = @ScriptDir & "\skill_requirements.ini"
    Local $skillName = "Skill" & $s
    Local $pickupRange = $x * 0.8

    CurrentAction("Fighting")

    Do
        Sleep(250)
        $nearestEnemy = GetNearestEnemyToAgent(-2)
    Until DllStructGetData($nearestEnemy, 'ID') <> 0

    Do
        $useSkill = -1
        $target = GetNearestEnemyToAgent(-2)
        $distance = GetDistance($target, -2)
        If DllStructGetData($target, 'ID') <> 0 And $distance < $x Then
            ChangeTarget($target)
            Sleep(150)
            CallTarget($target)
            Sleep(150)
            Attack($target)
            Sleep(150)

            ; Check for lootable objects in range and pick them up if within the pickup range
            If $Bool_PickUp Then
                Local $LooteableObjectCount = GetCountInRangeOfAgent(-2, $pickupRange, $NoneUnitType, $TypeLooteable)
                If $LooteableObjectCount > 0 Then
                    Local $LooteableObject = GetClosestInRangeOfAgent(-2, $pickupRange, $NoneUnitType, $TypeLooteable)
                    Local $LooteableObjectDistance = ComputeDistance(DllStructGetData(-2, 'X'), DllStructGetData(-2, 'Y'), DllStructGetData($LooteableObject, 'X'), DllStructGetData($LooteableObject, 'Y'))
                    If $LooteableObjectDistance <= $pickupRange Then
                        PickUpLoot()
                    EndIf
                EndIf
            EndIf

        ElseIf DllStructGetData($target, 'ID') = 0 Or $distance > $x Then
            ExitLoop
        EndIf

        For $i = 1 To 8
            $targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
            If $targetHP = 0 Or $distance > $x Then ExitLoop

            $energy = GetEnergy(-2)
            $recharge = DllStructGetData(GetSkillBar(), "Recharge" & $i)
            $adrenaline = DllStructGetData(GetSkillBar(), "Adrenaline" & $i)

            If $recharge = 0 And $energy >= IniRead($iniFilePath, "Skill" & $i, "Energy", "0") _
                And $adrenaline >= IniRead($iniFilePath, "Skill" & $i, "Adrenaline", "0") * 25 - 25 Then
                $useSkill = $i
                PingSleep(250)
                UseSkill($useSkill, $target)
                Sleep(IniRead($iniFilePath, "Skill" & $i, "CastTime", "0") + 1000)
            EndIf
        Next
    Until DllStructGetData($target, 'ID') = 0 Or $distance > $x
    If GetHealth(-2) < 2400 Then UseSkill(7, -2)
    PingSleep(3000)

    CurrentAction("Picking up items")
    If $Bool_PickUp Then PickUpLoot()
    If $Bool_Uselockpicks Then CheckForChest()
EndFunc   ;==>Fight

Func Fight($x, $s = "")
    Local $iniFilePath = @ScriptDir & "\skill_requirements.ini"
    Local $pickupRange = $x * 0.05

    CurrentAction("Fighting")

    Do
        Sleep(250)
        $nearestEnemy = GetNearestEnemyToAgent(-2)
    Until DllStructGetData($nearestEnemy, 'ID') <> 0

    Do
        $useSkill = -1
        $target = GetNearestEnemyToAgent(-2)
        $distance = GetDistance($target, -2)
        If DllStructGetData($target, 'ID') <> 0 Then
            If $distance > $x Then
                ; Move closer to the target if out of range using MoveTo function
                CurrentAction("Target is out of range, moving closer.")
                Local $targetX = DllStructGetData($target, 'X')
                Local $targetY = DllStructGetData($target, 'Y')
                MoveTo($targetX, $targetY, 100)  ; Adjust randomization as needed
            EndIf

            ChangeTarget($target)
            Sleep(150)
            CallTarget($target)
            Sleep(150)
            Attack($target)
            Sleep(150)

            ; Check for lootable objects in range and pick them up if within the pickup range
            If $Bool_PickUp Then
                Local $LooteableObjectCount = GetCountInRangeOfAgent(-2, $pickupRange, $NoneUnitType, $TypeLooteable)
                If $LooteableObjectCount > 0 Then
                    Local $LooteableObject = GetClosestInRangeOfAgent(-2, $pickupRange, $NoneUnitType, $TypeLooteable)
                    Local $LooteableObjectDistance = ComputeDistance(DllStructGetData(-2, 'X'), DllStructGetData(-2, 'Y'), DllStructGetData($LooteableObject, 'X'), DllStructGetData($LooteableObject, 'Y'))
                    If $LooteableObjectDistance <= $pickupRange Then
                        PickUpLoot()
                    EndIf
                EndIf
            EndIf
        Else
            ExitLoop
        EndIf

        For $i = 1 To 8
            $targetHP = DllStructGetData(GetCurrentTarget(), 'HP')
            If $targetHP = 0 Or $distance > $x Then ExitLoop

            $energy = GetEnergy(-2)
            $recharge = DllStructGetData(GetSkillBar(), "Recharge" & $i)
            $adrenaline = DllStructGetData(GetSkillBar(), "Adrenaline" & $i)

            If $recharge = 0 And $energy >= IniRead($iniFilePath, "Skill" & $i, "Energy", "0") _
                And $adrenaline >= IniRead($iniFilePath, "Skill" & $i, "Adrenaline", "0") * 25 - 25 Then
                $useSkill = $i
                PingSleep(250)
                UseSkill($useSkill, $target)
                Sleep(IniRead($iniFilePath, "Skill" & $i, "CastTime", "0") + 1000)
            EndIf
        Next
    Until DllStructGetData($target, 'ID') = 0 Or $distance > $x
    If GetHealth(-2) < 2400 Then UseSkill(7, -2)
    PingSleep(3000)

    CurrentAction("Picking up items")
    If $Bool_PickUp Then PickUpLoot()
    If $Bool_Uselockpicks Then CheckForChest()
EndFunc   ;==>Fight
