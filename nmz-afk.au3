WinActivate("RuneLite")

HotKeySet("{Esc}", "_exit")

$grassColor = 0x457116
$bottleColor = 0xaa9943
$hpColor = 0x83240f

Global $overloadBagX[2] = [1332, 1577]
Global $overloadBagY[2] = [600, 764]
Global $absorptionBagX[2] = [1342, 1573]
Global $absorptionBagY[2] = [766, 972]

Global $checkHpX[2] = [1289, 1312]
Global $checkHpY[2] = [776, 780]

Global $prayerX[2] = [1376, 1393]
Global $prayerY[2] = [160, 177]

Global $prayerTimer = TimerInit()
Global $potionTimer= TimerInit()
Global $timerCheck = Random(20000,40000,1)
Global $potionCheck = Random(300000, 600000, 1)

Global $overloadEmpty = False

While 1
   checkGrass()

   checkHp()
   checkAbsorbTime()
   checkPrayer()

WEnd

Func checkGrass()
   $foundEnd = PixelSearch(1289, 630, 1311, 641, $hpColor, 3)
   if Not @error Then
	  _exit()
   EndIf
EndFunc

Func checkHp()
   $foundHp = PixelSearch($checkHpX[0], $checkHpY[0], $checkHpX[1], $checkHpY[1], $hpColor, 5)

   if Not @error Then
	  $foundOverload = PixelSearch($overloadBagX[0], $overloadBagY[0], $overloadBagX[1], $overloadBagY[1], $bottleColor, 1)

	  if isArray($foundOverload) Then
		 $x = Random($foundOverload[0]-3, $foundOverload[0]+6, 1)
		 $y = Random($foundOverload[1], $foundOverload[1] + 35, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 Sleep(Random(3000,3500,1))
	  EndIf

   EndIf
EndFunc

Func checkAbsorbTime()

   if TimerDiff($potionTimer) > $potionCheck Then
	  $potionTimer = TimerInit()
	  $potionCheck = Random(300000, 600000, 1)
	  $clicks = Random(2,3,1)

	  While $clicks > 0
		 $foundPotion = PixelSearch($absorptionBagX[0], $absorptionBagY[0], $absorptionBagX[1], $absorptionBagY[1], $bottleColor, 1)

		 if isArray($foundPotion) Then
			$x = Random($foundPotion[0]-3, $foundPotion[0]+7, 1)
			$y = Random($foundPotion[1], $foundPotion[1]+35, 1)
			MouseClick("left", $x, $y, 1, Random(3,6,1))
			Sleep(Random(750,1000,1))
		 EndIf

		 $clicks -= 1
	  WEnd
   EndIf
EndFunc

Func checkPrayer()

   if TimerDiff($prayerTimer) > $timerCheck Then
	  $timerCheck = Random(20000,40000,1)

	  $x = Random($prayerX[0], $prayerX[1], 1)
	  $y = Random($prayerY[0], $prayerY[1], 1)
	  MouseClick("left", $x, $y, 1, Random(3,6,1))
	  Sleep(Random(300,500,1))
	  MouseClick("left", $x, $y, 1, Random(3,6,1))

	  $prayerTimer = TimerInit()
   EndIf
EndFunc

Func _exit()
	Exit(0)
EndFunc