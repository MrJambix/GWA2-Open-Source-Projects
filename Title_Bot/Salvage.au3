
Func CheckIDAndSalvageKits()	
    CurrentAction("Checking if enough gold for kits")
    If GetGoldCharacter() < 5000 Then
        CurrentAction("Not enough gold, withdrawing...")
        WithdrawGold(5000)
        PingSleep(500)
    EndIf

    CurrentAction("Checking for ID kits in inventory")
    While GetItemQuantityInventory(5899) = 0
        CurrentAction("Buying ID kits...")
        BuySuperiorIdentificationKit2()
        PingSleep(1000)
    WEnd
    
	CurrentAction("Checking for salvage kits in inventory")
    ; Check if no salvage kits are available
    While GetItemQuantityInventory(2991) = 0
        CurrentAction("Buying salvage kits...")
        BuySalvage()
        PingSleep(1000)
    WEnd
EndFunc

Func GetItemQuantityInventory($aItemID)
;	If GetMapLoading() == 2 Then Disconnected()
	Local $lItem = 0
	Local $lQuantity = 0
	For $i = 1 To 4
		For $j = 1 To DllStructGetData(GetBag($i), 'Slots')
			$lItem = GetItemBySlot($i, $j)
			If DllStructGetData($lItem, 'ModelID') == $aItemID Then $lQuantity += DllStructGetData($lItem, 'quantity')
		Next
	Next
	Return $lQuantity
EndFunc ;==>GetItemQuantityInventory

Func CountFreeSlots($aNumberOfBags = 4)
   Local $lSlots

   For $lBag = 1 to $aNumberOfBags
	  $lSlots += DllStructGetData(GetBag($lBag), 'Slots')
	  $lSlots -= DllStructGetData(GetBag($lBag), 'ItemsCount')
   Next
   Return $lSlots
EndFunc ;==> CountFreeSlots

Func BuySuperiorIdentificationKit2($aQuantity = 1)
    Local $currentMapID = GetMapID()
    Local $agent

    ; Determine the nearest agent based on the current map
    Select
        Case $currentMapID = 396
            $agent = GetNearestNPCToCoords(18653, 13934)
        Case $currentMapID = 639
            $agent = GetNearestNPCToCoords(-21032, 10979)
        Case $currentMapID = 640
            $agent = GetNearestNPCToCoords(18653, 13934)
        Case $currentMapID = 645
            $agent = GetNearestNPCToCoords(1598, -951)
        Case $currentMapID = 648
            $agent = GetNearestNPCToCoords(-19166, 17980)
        Case $currentMapID = 545
            $agent = GetNearestNPCToCoords(-1795, -2482)
        Case $currentMapID = 675
            $agent = GetNearestNPCToCoords(7319, -24874)
        Case $currentMapID = 77
            $agent = GetNearestNPCToCoords(8481, 2005)
        Case $currentMapID = 389
            $agent = GetNearestNPCToCoords(-4318, 11298)
        Case Else
            CurrentAction("No valid map ID found")
            Return
    EndSelect

    ; Check if the NPC data is valid
    If Not IsDllStruct($agent) Then
        CurrentAction("No NPC found at the coordinates")
        Return
    EndIf

    ; Moving to NPC
    CurrentAction("Going to NPC")
    GoToNPC($agent)

    ; Check gold availability and adjust if necessary
    If GetGoldCharacter() < 500 And GetGoldCharacter() + GetGoldStorage() >= 500 Then
        WithdrawGold(500 - GetGoldCharacter())
        PingSleep(1000)  ; Wait for transaction to complete
    ElseIf GetGoldCharacter() < 500 Then
        CurrentAction("Out of Gold, cannot buy items")
        $BotRunning = False
        Return
    EndIf

    ; Attempt to buy the identification kits
    BuyItem(6, 1, 500)  ; Buying 1 kit at the price of 500 gold each
EndFunc


Func BuySalvage($aQuantity = 1)
    ; Retrieve the current map ID and determine the nearest agent based on the map
    Local $currentMapID = GetMapID()
    Local $agent
    Select
        Case $currentMapID = 396
            $agent = GetNearestNPCToCoords(18653, 13934)
        Case $currentMapID = 639
            $agent = GetNearestNPCToCoords(-21032, 10979)
        Case $currentMapID = 640
            $agent = GetNearestNPCToCoords(18653, 13934)
        Case $currentMapID = 645
            $agent = GetNearestNPCToCoords(1598, -951)
        Case $currentMapID = 648
            $agent = GetNearestNPCToCoords(-19166, 17980)
        Case $currentMapID = 545
            $agent = GetNearestNPCToCoords(-1795, -2482)
        Case $currentMapID = 675
            $agent = GetNearestNPCToCoords(7319, -24874)
        Case $currentMapID = 77
            $agent = GetNearestNPCToCoords(8481, 2005)
        Case $currentMapID = 389
            $agent = GetNearestNPCToCoords(-4318, 11298)
        Case Else
            CurrentAction("No valid map ID found")
            Return
    EndSelect

    ; Check if the NPC data is valid
    If Not IsDllStruct($agent) Then
        CurrentAction("No NPC found at the coordinates")
        Return
    EndIf

    ; Moving to NPC
    CurrentAction("Going to NPC")
    GoToNPC($agent)

     If Not IsDllStruct($agent) Then
        CurrentAction("No NPC found at the coordinates")
        Return
    EndIf

    CurrentAction("Going to NPC")
    GoToNPC($agent)

    If GetGoldCharacter() < 400 And GetGoldCharacter() + GetGoldStorage() < 100 Then
        CurrentAction("Out of Gold, cannot buy items")
        $BotRunning = False
        Return
    ElseIf GetGoldCharacter() < 100 Then
        WithdrawGold(100 - GetGoldCharacter())
    EndIf

  ;  BuyItem(4, 1, 2000)
   BuyExpertSalvageKit($aQuantity = 1)
EndFunc

;~ Description: Salvages items from a bag based on rarity.
Func SalvageBag($bagIndex, $aWhites = False, $aBlues = True, $aGolds = True)
    Local $lBag = GetBag($bagIndex)
    Local $lItem, $lRarity, $lType

    For $i = 1 To DllStructGetData($lBag, 'slots')
        ; Ensure we have an expert salvage kit before continuing
        If FindExpertSalvageKit() == 0 Then
            If GetGoldCharacter() < 500 And GetGoldStorage() > 499 Then
                WithdrawGold(2000)
                RndSleep(500)
            EndIf
            Do
                BuySalvage()
                PingSleep(1000)
            Until FindExpertSalvageKit() <> 0

            ; If still no salvage kit, skip this iteration
            If FindExpertSalvageKit() == 0 Then ContinueLoop
        EndIf

        $lItem = GetItemBySlot($bagIndex, $i)
        $lRarity = GetRarity($lItem)

        ; Skip items based on rarity and settings
        If $lRarity = $RARITY_White And $aWhites = False Then ContinueLoop
        If $lRarity = $RARITY_Blue And $aBlues = False Then ContinueLoop
        If $lRarity = $RARITY_Gold And $aGolds = False Then ContinueLoop

        If DllStructGetData($lItem, 'ModelID') == 0 Then ContinueLoop  ; Skip if item has no Model ID

        StartSalvage($lItem)
        PingSleep(1500)

        ; Salvage additional materials based on rarity, skipping specified categories
        SalvageMaterials()
        ControlSend(GetWindowHandle(), "", "", "{Enter}")
        PingSleep(1500)
    Next
EndFunc ; ==> SalvageBag



Func PutMatsIntoChest()
	Local $lItem, $lQuantity, $lModelID
	For $i = 1 To 4
		For $j = 1 To DllStructGetData(GetBag($i), 'slots')
			$lItem = GetItemBySlot($i, $j)
			If DllStructGetData($lItem, 'ID') == 0 Then ContinueLoop
			$lModelID = DllStructGetData($lItem, 'ModelID')
			$lQuantity = DllStructGetData($lItem, 'quantity')
			If ($lModelID == $model_id_iron_ingot And $lQuantity == 250) Then
				MoveItemToChest($lItem)
				ContinueLoop
			EndIf
			If ($lModelID == $model_id_dust And $lQuantity == 250) Then
				MoveItemToChest($lItem)
				ContinueLoop
			EndIf
			If ($lModelID == $model_id_bone And $lQuantity == 250) Then
				MoveItemToChest($lItem)
				ContinueLoop
			EndIf			
			If ($lModelID == $model_id_wood_plank) Then
				SellItem($lItem, $lQuantity)
				PingSleep(500)
				ContinueLoop
			EndIf
			If ($lModelID == $model_id_scale And $lQuantity == 250) Then
				MoveItemToChest($lItem)
				ContinueLoop
			EndIf
			If $lModelID == $model_id_tanned_hide_square Then
				SellItem($lItem, $lQuantity)
				PingSleep(500)
				ContinueLoop
			EndIf
			If $lModelID == $model_id_bolt_of_cloth Then
				SellItem($lItem, $lQuantity)
				PingSleep(500)
				ContinueLoop
			EndIf
			If ($lModelID == $model_id_granite_slab And $lQuantity == 250) Then
				MoveItemToChest($lItem)
				ContinueLoop
			EndIf
			If ($lModelID == $model_id_saurian_bone And $lQuantity == 250) Then
				MoveItemToChest($lItem)
				ContinueLoop
			EndIf
		Next
	Next
EndFunc ;==>PutMatsIntoChest

Func ProcessInventory()        
        Sleep(1000)
        CurrentAction("Ident inventory")
        
        Ident(1)
        Ident(2)
		Ident(3)
		Ident(4)
        
        CurrentAction("Salvaging inventory")
        SalvageBag(1)
		SalvageBag(2)
		SalvageBag(3)
		SalvageBag(4)
		
	PutMatsIntoChest()
EndFunc