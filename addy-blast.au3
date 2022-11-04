;look east
;scroll 20

;colors
Global $bankColor = 0x0000ff
Global $beltColor = 0xeaff00
Global $dispenserColor = 0x00ff00
Global $potColor = 0xaa9843

Global $coalColor = 0x00ffff
Global $oreColor = 0xff00ff
Global $barColor = 0x3e523e

Global $bankTextColor = 0xff981f

;bank positions
Global $coalBankX[2] = [652, 674]
Global $coalBankY[2] = [532, 551]
Global $oreBankX[2] = [727, 744]
Global $oreBankY[2] = [530, 552]



;bag positions
Global $coalBagX[2] = [1353, 1375]
Global $coalBagY[2] = [617, 634]

Global $bagClickX[2] = [1416, 1438]
Global $bagClickY[2] = [617, 637]

;world location
Global $beltX[2] = [25,185]
Global $beltY[2] = [846, 980]
Global $beltCloseX[2] = [771, 857]
Global $beltCloseY[2] = [424, 504]
Global $bankCloseX[2] = [837, 946]
Global $bankCloseY[2] = [474, 574]
Global $bankFarX[2] = [1427, 1529]
Global $bankFarY[2] = [113, 212]
Global $dispenserX[2] = [1011, 1098]
Global $dispenserY[2] = [603, 684]

Global $barDialogX[2] = [367, 434]
Global $barDialogY[2] = [895, 954]

Global $groundClickX[2] = [1134, 1249]
Global $groundClickY[2] = [109, 201]

;click positions
Global $clickBankCloseX[2] = [878, 911]
Global $clickBankCloseY[2] = [507, 533]
Global $clickBankFarX[2] = [1473, 1492]
Global $clickBankFarY[2] = [142, 164]
Global $beltCloseClickX[2] = [798, 827]
Global $beltCloseClickY[2] = [445, 471]
Global $dispenserClickX[2] = [1039, 1071]
Global $dispenserClickY[2] = [630, 657]

;vars
Global $firstTime = True
Global $round = 1


HotKeySet("{Esc}", "_exit")

While 1
   if $firstTime == True Then
	  firstRun()
	  $firstTime = False
   EndIf

   runAddy()
WEnd

func firstRun()
   	  clickBankClose()
	  getCoal()
	  closeBank()
	  fillCoal()
	  clickBankClose()
	  getCoal()

	  clickBeltFromBank()
	  emptyCoal($coalColor)
	  clickBeltClose($coalColor)
	  clickBankFar($coalColor)

	  getCoal()
	  closeBank()
	  fillCoal()
	  clickBankClose()
	  getOre()

	  clickBeltFromBank()
	  emptyCoal($oreColor)
	  clickBeltClose($coalColor)

	  clickBankFar($coalColor)
   EndFunc

func runAddy()
	  if $round == 1 Then
		 runPot()
		 $round = 4
	  EndIf

	  getCoal()
	  closeBank()
	  fillCoal()
	  clickBankClose()
	  getCoal()

	  clickBeltFromBank()
	  emptyCoal($coalColor)
	  clickBeltClose($coalColor)
	  clickDispenser()
	  clickBankMid()

	  depositBars()
	  getCoal()
	  closeBank()
	  fillCoal()
	  clickBankClose()
	  getOre()

	  clickBeltFromBank()
	  emptyCoal($oreColor)
	  clickBeltClose($coalColor)

	  clickBankFar($coalColor)
	  $round -= 1
EndFunc

func depositBars()
   Send("{LSHIFT down}")
   randomSleep(150,200)
   $x = Random($bagClickX[0], $bagClickX[1], 1)
   $y = Random($bagClickY[0], $bagClickY[1], 1)
   MouseClick("left", $x, $y, 1, Random(3,6,1))
   randomSleep(150,200)
   Send("{LSHIFT up}")
EndFunc


func clickDispenser()
   While 1
	  $foundDispenser = PixelSearch($dispenserX[0], $dispenserY[0], $dispenserX[1], $dispenserY[1], $dispenserColor)
	  $ore = PixelSearch($bagClickX[0], $bagClickY[0], $bagClickX[1], $bagClickY[1], $coalColor, 10)

	  if isArray($foundDispenser) And Not isArray($ore) Then
		 randomSleep(100,200)
		 $x = Random($dispenserClickX[0], $dispenserClickX[1], 1)
		 $y = Random($dispenserClickY[0], $dispenserClickY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 ExitLoop
	  EndIf
   WEnd

   While 1
	  $foundBar = PixelSearch($barDialogX[0], $barDialogY[0], $barDialogX[1], $barDialogY[1], $barColor, 5)

	  if Not @error Then
		 randomSleep(150,300)
		 Send("{SPACE}")
		 randomSleep(150, 200)
		 ExitLoop
	  EndIf
   WEnd
EndFunc

func clickBankMid()
   $x = Random($groundClickX[0], $groundClickX[1], 1)
   $y = Random($groundClickY[0], $groundClickY[1], 1)
   MouseClick("left", $x, $y, 1, Random(3,6,1))

   $x = Random(1040, 1306, 1)
   $y = Random(91, 339, 1)
   MouseMove($x, $y, 1)
   randomSleep(2300,3400)

   While 1
	  $foundBank = PixelSearch(883, 459, 1075, 150, $bankColor)

	  if Not @error Then
		 $x = Random($foundBank[0]+10, $foundBank[0]+30, 1)
		 $y = Random($foundBank[1]-30, $foundBank[1]-10, 1)
		 MouseClick("left", $x, $y, 1, 2)
		 ExitLoop
	  EndIf
   WEnd

   While 1
	  $bankOpen = PixelSearch(575, 35, 717, 63, $bankTextColor, 10)

	  if Not @error Then
		 randomSleep(150, 300)
		 ExitLoop
	  EndIf ;end of bank open
   WEnd ;end of bank open loop
EndFunc


func clickBeltFromBank()
   While 1
	  $foundBelt = PixelSearch($beltX[0], $beltY[1], $beltX[1], $beltY[0], $beltColor, 10)

	  if Not @error Then
		 randomSleep(200,400)
		 $x = Random($foundBelt[0]-10, $foundBelt[0] + 20, 1)
		 $y = Random($foundBelt[1]-10, $foundBelt[1]+20, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 randomSleep(4500, 5000)
		 ExitLoop
	  EndIf
   WEnd
EndFunc

func clickBeltClose($currentOreColor)
   While 1
	  $foundBelt = PixelSearch($beltCloseX[0], $beltCloseY[0], $beltCloseX[1], $beltCloseY[1], $beltColor, 10)
	  $ore = PixelSearch($bagClickX[0], $bagClickY[0], $bagClickX[1], $bagClickY[1], $currentOreColor, 10)

	  if isArray($foundBelt) And isArray($ore) Then
		 randomSleep(150,250)
		 $x = Random($beltCloseClickX[0], $beltCloseClickX[1], 1)
		 $y = Random($beltCloseClickY[0], $beltCloseClickY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 ExitLoop
	  EndIf
   WEnd
EndFunc

func clickBankFar($currentOreColor)
   While 1
	  $foundBank = PixelSearch($bankFarX[0], $bankFarY[0], $bankFarX[1], $bankFarY[1], $bankColor, 10)
	  $ore = PixelSearch($bagClickX[0], $bagClickY[0], $bagClickX[1], $bagClickY[1], $currentOreColor, 10)

	  if isArray($foundBank) And Not isArray($ore) Then
		 randomSleep(150,250)
		 $x = Random($clickBankFarX[0], $clickBankFarX[1], 1)
		 $y = Random($clickBankFarY[0], $clickBankFarY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 ExitLoop
	  EndIf
   WEnd
   $timer = TimerInit()

   While 1
	  $bankOpen = PixelSearch(575, 35, 717, 63, $bankTextColor, 10)

	  if Not @error Then
		 randomSleep(150, 300)
		 ExitLoop
	  EndIf

	  if TimerDiff($timer) > 10000 Then
		 $foundBank = PixelSearch($bankCloseX[0], $bankCloseY[0], $bankCloseX[1], $bankCloseY[1], $bankColor)

		 if Not @error Then
			$x = Random($clickBankCloseX[0], $clickBankCloseX[1], 1)
			$y = Random($clickBankCloseY[0], $clickBankCloseY[1], 1)
			MouseClick("left", $x, $y, 1, Random(3,6,1))
		 EndIf
	  EndIf
   WEnd
EndFunc

func clickBankClose()
   While 1
	  $foundBank = PixelSearch($bankCloseX[0], $bankCloseY[0], $bankCloseX[1], $bankCloseY[1], $bankColor)

	  if Not @error Then
		 $x = Random($clickBankCloseX[0], $clickBankCloseX[1], 1)
		 $y = Random($clickBankCloseY[0], $clickBankCloseY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 ExitLoop
	  EndIf ;End of foundBank pixelsearch
   WEnd

   While 1
	  $bankOpen = PixelSearch(575, 35, 717, 63, $bankTextColor, 10)

	  if Not @error Then
		 randomSleep(150, 300)
		 ExitLoop
	  EndIf ;end of bank open
   WEnd ;end of bank open loop
EndFunc

func getOre()
   Send("{LSHIFT down}")
   randomSleep(150, 200)
   $x = Random($oreBankX[0], $oreBankX[1], 1)
   $y = Random($oreBankY[0], $oreBankY[1], 1)
   MouseClick("left", $x, $y, 1, Random(3,6,1))
   randomSleep(150, 200)
   Send("{LSHIFT up}")
EndFunc

func getCoal()
   Send("{LSHIFT down}")
   randomSleep(150, 200)
   $x = Random($coalBankX[0], $coalBankX[1], 1)
   $y = Random($coalBankY[0], $coalBankY[1], 1)
   MouseClick("left", $x, $y, 1, Random(3,6,1))
   randomSleep(150, 200)
   Send("{LSHIFT up}")
EndFunc

func fillCoal()
   While 1
	  $bankOpen = PixelSearch(575, 35, 717, 63, $bankTextColor, 10)

	  if @error Then
		 randomSleep(150, 300)
		 $x = Random($coalBagX[0], $coalBagX[1], 1)
		 $y = Random($coalBagY[0], $coalBagY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 ExitLoop
	  EndIf ;end of bank open
   WEnd
EndFunc

func emptyCoal($currentOreColor)
   While 1
	  $foundCoal = PixelSearch($bagClickX[0], $bagClickY[0], $bagClickX[1], $bagClickY[1], $currentOreColor, 10)

	  if @error Then
		 Send("{LSHIFT down}")
		 randomSleep(150,200)
		 $x = Random($coalBagX[0], $coalBagX[1], 1)
		 $y = Random($coalBagY[0], $coalBagY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 randomSleep(150,200)
		 Send("{LSHIFT up}")
		 randomSleep(200,300)
		 ExitLoop
	  EndIf
   WEnd
EndFunc

func closeBank()
   $x = Random(967, 978, 1)
   $y = Random(46, 58, 1)
   MouseClick("left", $x, $y, 1, Random(3,6,1))
EndFunc

func randomSleep($low, $high)
   Sleep(Random($low, $high, 1))
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; pots
func getPot()
   While 1
	  $foundPot = PixelSearch(868, 573, 890, 590, $potColor)

	  if Not @error Then
		 randomSleep(100,150)
		 $x = Random(871, 888, 1)
		 $y = Random(584, 605, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 randomSleep(100,200)
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
		 randomSleep(100,200)
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
		 randomSleep(100,200)
		 Return
	  Else
		 ExitLoop
	  EndIf
   WEnd

   randomSleep(150,200)
   $x = Random(873, 887, 1)
   $y = Random(432, 446, 1)
   MouseClick("left", $x, $y, 1, Random(3,6,1))
   randomSleep(100,200)
EndFunc

func drinkPot()
   randomSleep(200,300)
   While 1
	  $foundPot = PixelSearch(1408, 605, 1444, 644, 0xe8e00f, 10)
	  $bankOpen = PixelSearch(575, 35, 717, 63, $bankTextColor, 10)

	  if isArray($foundPot) And Not isArray($bankOpen) Then
		 $x = Random(1418, 1437, 1)
		 $y = Random(621, 638, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 randomSleep(500,800)
		 ExitLoop
	  EndIf
   WEnd
   randomSleep(200,300)
   clickBankClose()
   While 1
	  $foundPot = PixelSearch(1408, 605, 1444, 644, 0xe8e00f, 10)

	  if Not @error Then
		 $x = Random(1418, 1437, 1)
		 $y = Random(621, 638, 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 randomSleep(200,300)
	  EndIf

	  ExitLoop
   WEnd
EndFunc

func runPot()
   getPot()
   closeBank()
   drinkPot()
EndFunc

Func _exit()
	Exit(0)
EndFunc