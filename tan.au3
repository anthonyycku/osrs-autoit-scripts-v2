;crafting guild
;birds eye view 20 scrolls
; NPC Indicator plugin: Npcs: Tanner, Highlight_Color: #FFFF00FF

HotKeySet("{Esc}", "_exit")

Global $bankColor = 0x0000ff
Global $bankTextColor = 0xf6951e
Global $stairColor = 0x00ff00
Global $tannerColor = 0xff00ff
Global $potColor = 0xaa9843
Global $activeColor = 0xd4d400
Global $emptyColor = 0x95a82c

Global $timer = TimerInit()
Global $firstTime = True

Global $hide = ''

While 1
   checkPot()
   clickBank()
   upStairs()
   findTanner()
   downStairs()
WEnd

func checkPot()
   if TimerDiff($timer) > 200000 Or (TimerDiff($timer) > 30000 And $firstTime == True) Then
	  $timer = TimerInit()
	  $firstTime = False
	  While 1
		 $bank = PixelSearch(633, 334, 1166, 707, $bankColor)

	  if Not @error Then
		 Sleep(Random(400,700,1))
		 $bank = PixelSearch(633, 334, 1166, 707, $bankColor)

		 if Not @error Then
			$x = Random($bank[0]+20, $bank[0] + 40, 1)
			$y = Random($bank[1]+15, $bank[1]+40, 1)
			MouseClick("left", $x, $y, 1, 2)
			ExitLoop
		 EndIf
	  EndIf
	  WEnd

	  While 1
		 $bankOpen = PixelSearch(572, 40, 620, 61, $bankTextColor, 5)

		 if Not @error Then
			Send("{LSHIFT down}")
			Sleep(Random(150,200,1))
			$x = Random(1421, 1436, 1)
			$y = Random(620, 635, 1)
			MouseClick("left", $x, $y, 1, Random(3,6,1))
			Sleep(Random(150,200,1))
			Send("{LSHIFT up}")

			runPot()
			ExitLoop
		 EndIf
	  WEnd
   EndIf
EndFunc

func clickBank()
   While 1
	  $bank = PixelSearch(633, 334, 1166, 707, $bankColor)

	  if Not @error Then
		 Sleep(Random(400,700,1))
		 $bank = PixelSearch(633, 334, 1166, 707, $bankColor)

		 if Not @error Then
			$x = Random($bank[0]+20, $bank[0] + 40, 1)
			$y = Random($bank[1]+20, $bank[1]+40, 1)
			MouseClick("left", $x, $y, 1, 2)
			ExitLoop
		 EndIf
	  EndIf
   WEnd

   $timerBank = TimerInit()
   While 1
	  $bankOpen = PixelSearch(572, 38, 620, 61, $bankTextColor, 10)

	  if Not @error Then

		 Send("{LSHIFT down}")
		 Sleep(Random(150,200,1))

		 $x = Random(1421, 1436, 1)
		 $y = Random(620, 635, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))

		 Sleep(Random(50,150,1))

		 findActiveHide()

		 if $hide == 'black' Then
			$x = Random(800, 819, 1)
			$y = Random(427, 443, 1)
		 ElseIf $hide == 'red' Then
			$x = Random(729, 744, 1)
			$y = Random(425, 440, 1)
		 ElseIf $hide == 'blue' Then
			$x = Random(656, 673, 1)
			$y = Random(428, 440, 1)
		 ElseIf $hide == 'green' Then
			$x = Random(585, 597, 1)
			$y = Random(429, 441, 1)
		 EndIf
		 MouseClick("left", $x, $y, 1, Random(3,6,1))

		 Sleep(Random(150,200,1))
		 Send("{LSHIFT up}")

		 Sleep(Random(10,100,1))
		 $x = Random(970, 977, 1)
		 $y = Random(46, 53, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 ExitLoop
	  EndIf

	  if TimerDiff($timerBank) > 5000 Then
		 $timerBank = TimerInit()
		  $bank = PixelSearch(633, 334, 1166, 707, $bankColor)

		 if Not @error Then
			$x = Random($bank[0]+20, $bank[0] + 40, 1)
			$y = Random($bank[1]+20, $bank[1]+40, 1)
			MouseClick("left", $x, $y, 1, 2)
		 EndIf
	  EndIf
   WEnd
EndFunc

func findActiveHide()
   $blackActive = PixelSearch(780,407,816,426, $activeColor, 20)

   if Not @error Then
	  $hide = 'black'
	  Return
   EndIf

   $redActive = PixelSearch(706, 407, 739, 429, $activeColor, 20)

   if Not @error Then
	  $hide = 'red'
	  Return
   EndIf

   $blueActive = PixelSearch(635, 406, 667, 429, 0xfcfc01, 30)

   if Not @error Then
	  $hide = 'blue'
	  Return
   EndIf

   $greenActive = PixelSearch(565, 406, 584, 428, $activeColor, 8)

   if Not @error Then
	  $hide = 'green'
	  Return
   EndIf
EndFunc

func upStairs()
   While 1
	  $stair = PixelSearch(510, 356, 623, 459, $stairColor)

	  if Not @error Then
		 $x = Random($stair[0]+20, $stair[0]+80, 1)
		 $y = Random($stair[1]-30, $stair[1]+40, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 ExitLoop
	  EndIf
   WEnd
EndFunc

func findTanner()


   While 1
	  $tanner = PixelSearch(578, 55, 1079, 626, $tannerColor, 20)

	  if Not @error Then
		 Sleep(Random(200,400,1))
		 $tanner = PixelSearch(578, 55, 1079, 626, $tannerColor, 20)

		 if Not @error Then
			$x = Random($tanner[0], $tanner[0]+2, 1)
			$y = Random($tanner[1]+10, $tanner[1]+20, 1)
			MouseClick("left", $x, $y, 1, 2)
			ExitLoop
		 EndIf
	  EndIf
   WEnd
   $tannerTimer = TimerInit()

   While 1
	  $tannerOpen = PixelSearch(448, 198, 505, 220, $bankTextColor, 10)

	  if Not @error Then
		 if $hide == 'black' Then
			$x = Random(867, 911, 1)
			$y = Random(480, 523, 1)
		 ElseIf $hide == 'red' Then
			$x = Random(706, 735, 1)
			$y = Random(482, 512, 1)
		 ElseIf $hide == 'blue' Then
			$x = Random(538, 567, 1)
			$y = Random(480, 513, 1)
		 ElseIf $hide == 'green' Then
			$x = Random(370, 398, 1)
			$y = Random(482, 516, 1)
	  EndIf
		 MouseClick("right", $x, $y, 1, Random(3,6,1))
		 Sleep(Random(100,200,1))

		 $clickX = Random($x - 40, $x+10, 1)
		 $clickY = Random($y + 100, $y + 108, 1)
		 MouseClick("left", $clickX, $clickY, 1, Random(3,6,1))

		 ExitLoop
	  EndIf

	  if TimerDiff($tannerTimer) > 4000 Then
		 $tannerTimer = TimerInit()

		 $tanner = PixelSearch(169, 35, 1255, 1001, $tannerColor, 20)

		 if Not @error Then
			$x = Random($tanner[0], $tanner[0]+2, 1)
			$y = Random($tanner[1]+10, $tanner[1]+20, 1)
			MouseClick("left", $x, $y, 1, 2)
		 EndIf
	  EndIf
   WEnd

   While 1
	  $tannerOpen = PixelSearch(448, 198, 505, 220, $bankTextColor, 10)

	  if @error Then
		 Sleep(Random(100,200,1))
		 ExitLoop
	  EndIf
   WEnd
EndFunc

func downStairs()
   Sleep(Random(50,150,1))
   While 1
	  $stairs = PixelSearch(201, 388, 1209, 990, $stairColor)

	  if Not @error Then
		 $x = Random($stairs[0]+15, $stairs[0]+35, 1)
		 $y = Random($stairs[1]+20, $stairs[1]+35, 1)
		 MouseClick("left", $x, $y, 1, 2)
		 ExitLoop
	  EndIf
   WEnd

   $timerStairs = TimerInit()

   While 1
	  $foundBank = PixelSearch(1021, 546, 1124, 659, $bankColor, 5)

	  if Not @error Then
		 ExitLoop
	  EndIf

	  if TimerDiff($timerStairs) > 5000 Then
		 $timerStairs = TimerInit()
		  $stairs = PixelSearch(201, 388, 1209, 990, $stairColor)

		 if Not @error Then
			$x = Random($stairs[0]+15, $stairs[0]+35, 1)
			$y = Random($stairs[1]+20, $stairs[1]+35, 1)
			MouseClick("left", $x, $y, 1, 2)
		 EndIf
	  EndIf
   WEnd
EndFunc

;stamina
func getPot()
   While 1
	  $foundPot = PixelSearch(868, 573, 890, 590, $potColor)

	  if Not @error Then
		 randomSleep(100,150)
		 $x = Random(871, 888, 1)
		 $y = Random(584, 605, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 randomSleep(100,150)
		 Return
	  Else
		 ExitLoop
	  EndIf
   WEnd

   While 1
	  $foundPot = PixelSearch(868, 518, 891, 536, $potColor)

	  if Not @error Then
		 randomSleep(100,150)
		 $x = Random(870, 887, 1)
		 $y = Random(536, 553, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 randomSleep(100,150)
		 Return
	  Else
		 ExitLoop
	  EndIf
   WEnd

   While 1
	  $foundPot = PixelSearch(870, 464, 888, 481, $potColor)

	  if Not @error Then
		 randomSleep(100,150)
		 $x = Random(872, 886, 1)
		 $y = Random(484, 497, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 randomSleep(100,150)
		 Return
	  Else
		 ExitLoop
	  EndIf
   WEnd

   randomSleep(150,200)
   $x = Random(873, 887, 1)
   $y = Random(432, 446, 1)
   MouseClick("left", $x, $y, 1, Random(3,6,1))
   randomSleep(100,150)
EndFunc

func drinkPot()
   randomSleep(100,200)
   While 1
	  $foundPot = PixelSearch(1408, 605, 1444, 644, 0xe8e00f, 10)
	  $bankOpen = PixelSearch(575, 35, 717, 63, $bankTextColor, 10)

	  if isArray($foundPot) And Not isArray($bankOpen) Then
		 $x = Random(1418, 1437, 1)
		 $y = Random(621, 638, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 randomSleep(400,700)
		 ExitLoop
	  EndIf
   WEnd
EndFunc

func runPot()
   getPot()
   $x = Random(970, 977, 1)
   $y = Random(46, 53, 1)
   MouseClick("left", $x, $y, 1, Random(3,6,1))
   drinkPot()
EndFunc

func randomSleep($low, $high)
   Sleep(Random($low, $high, 1))
EndFunc

Func _exit()
	Exit(0)
EndFunc