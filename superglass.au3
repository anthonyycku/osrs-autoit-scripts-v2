#include <MsgBoxConstants.au3>

WinActivate("RuneLite")

HotKeySet("{Esc}", "_exit")

Global $bankerColor = 0x7a7373
Global $moltenColor = 0xc76741
Global $spellColor = 0xd9264d
Global $bagColor = 0x764f2b
Global $seaweedColor = 0x03462b
Global $sandColor = 0x847242

Global $reset = False

Global $backpackX[2] = [1332, 1598]
Global $backpackY[2] = [603, 973]

Global $depositAllX[2] = [895, 923]
Global $depositAllY[2] = [740, 768]

Global $seaweedX[2] = [726, 743]
Global $seaweedY[2] = [155, 170]
Global $sandX[2] = [800, 818]
Global $sandY[2] = [158, 174]

Global $closeX[2] = [964, 980]
Global $closeY[2] = [44, 58]

Global $depositX[2] = [1416, 1443]
Global $depositY[2] = [617, 643]

Global $bankerX[2] = [983, 1101]
Global $bankerY[2] = [474, 575]

Global $spellX[2] = [1332,1345]
Global $spellY[2] = [761, 777]

;act human variables
Global $bagX[2] = [1596, 1620]
Global $bagY[2] = [550, 574]

Global $questTabX[2] = [1401, 1425]
Global $questTabY[2] = [550, 577]

Global $summaryX[2] = [1347, 1366]
Global $summaryY[2] = [603, 622]

Global $diariesX[2] = [1484, 1506]
Global $diariesY[2] = [603, 620]
Global $diarySelectionX[2] = [1347, 1559]
Global $diarySelectionY[2] = [676, 961]

Global $diaryPageX[2] = [364, 902]
Global $diaryPageY[2] = [278, 598]
Global $closePageX[2] = [922, 940]
Global $closePageY[2] = [245, 263]


Global $qpX[2] = [1415, 1437]
Global $qpY[2] = [604, 620]
Global $toggleQuestX[2] = [1545, 1558]
Global $toggleQuestY[2] = [633, 648]

Global $skillsTabX[2] = [1348, 1374]
Global $skillsTabY[2] = [549, 575]

While 1
   $roll = Random(1,100,1)
   if $roll <= 2 Then
	  ActHuman()
   ElseIf $roll >= 96 Then
	  Sleep(Random(3000, 10000,1))
   EndIf

   findBanker()
   deposit()
   fetchMats()
   closeBank()
   useSpell()
WEnd

Func findBanker()
   $banker = PixelSearch($bankerX[0], $bankerY[0], $bankerX[1], $bankerY[1], $bankerColor, 50)

   if Not @error Then
	  Sleep(Random(100,200,1))
	  $x = Random(1047, 1099, 1)
	  $y = Random(506, 598, 1)
	  MouseClick("left", $x, $y, 1, Random(3,6,1))
   Else
	  findBanker()
   EndIf

   Sleep(Random(300,600,1))
EndFunc

Func deposit()
   $timer = TimerInit()
   $timeout = 30000
   While 1
	  $foundBag = PixelSearch(895, 742, 925, 766, $bagColor, 10)

	  if Not @error Then
		 $foundSeaweed = PixelSearch($backpackX[0], $backpackY[0], $backpackX[1], $backpackY[1], $seaweedColor, 1)
		 $foundSand = PixelSearch($backpackX[0], $backpackY[0], $backpackX[1], $backpackY[1], $sandColor, 1)

		 if isArray($foundSeaweed) Or isArray($foundSand) Then
			$x = Random($depositAllX[0], $depositAllX[1], 1)
			$y = Random($depositAllY[0], $depositAllY[1], 1)
			MouseClick("left", $x, $y, 1, Random(3,6,1))
			$reset = True
			Sleep(Random(100,200,1))
			ExitLoop
		 Else
			Send("{LSHIFT down}")
			Sleep(Random(100,300,1))

			$roll = Random(1,10,1)
			if $roll <= 7 Then
			   $x = Random(1349, 1378, 1)
			   $y = Random(664, 689, 1)
			Else
			   $x = Random(1413, 1445, 1)
			   $y = Random(612, 636, 1)
			   MouseClick("left", $x, $y, 1, Random(3,6,1))
			   Sleep(Random(100,200,1))
			   Send("{LSHIFT up}")
			   ExitLoop
			EndIf
		 EndIf

	  Else
		 if TimerDiff($timer) > 3000 Then
			findBanker()
			Sleep(Random(1000,1500,1))
		 EndIf
	  EndIf

	  if TimerDiff($timer) > $timeout Then
		 _exit()
	  EndIf
   WEnd
EndFunc

Func fetchMats()
   Sleep(Random(100,300,1))

   if $reset == True Then
	  $reset = False
	  $x = Random(653, 673, 1)
	  $y = Random(153, 174, 1)
	  MouseClick("right", $x, $y, 1, Random(3,6,1))
	  Sleep(Random(300,600,1))
	  $rightX = Random($x-30, $x+30, 1)
	  $rightY = Random($y+167, $y+179, 1)
	  MouseClick("left", $rightX, $rightY, 1, Random(3,6,1))
	  Sleep(Random(50,200,1))
   EndIf

   $x = Random($seaweedX[0], $seaweedX[1], 1)
   $y = Random($seaweedY[0], $seaweedY[1], 1)
   MouseClick("left", $x, $y, 1, Random(2,6,1))
   Sleep(Random(150,180,1))
   MouseClick("left")
   Sleep(Random(150,190,1))
   MouseClick("left")

   Sleep(Random(10,300,1))
   Send("{LSHIFT down}")
   Sleep(Random(100,300,1))
   $x = Random($sandX[0] - 10, $sandX[1] + 10, 1)
   $y = Random($sandY[0] - 10, $sandY[1] + 10, 1)
   MouseClick("left", $x, $y, 1, Random(3,6,1))
   Sleep(Random(100,300,1))
   Send("{LSHIFT up}")
EndFunc

Func closeBank()
   Sleep(Random(100,300,1))
   $x = Random($closeX[0], $closeX[1], 1)
   $y = Random($closeY[0], $closeY[1], 1)
   MouseClick("left", $x, $y, 1, Random(4,8,1))
EndFunc

Func useSpell()
   While 1
	  $spellFound = PixelSearch($spellX[0], $spellY[0], $spellX[1], $spellY[1], $spellColor, 10)

	  if Not @error Then
		 Sleep(Random(200,500,1))
		 $x = Random($spellFound[0]-5, $spellFound[0]+7, 1)
		 $y = Random($spellFound[1], $spellFound[1]+20, 1)
		 MouseClick("left", $x, $y, 1, Random(4,7,1))
		 Sleep(Random(2400,2800,1))
		 ExitLoop
	  EndIf
   WEnd

EndFunc

;act human

Func ActHuman()

   $roll = Random(1,10,1)
   if $roll <= 7 Then
	  gotoQuests()
   Else
	  gotoSkills()
   EndIf

   gotoBag()
EndFunc

Func gotoBag()
   randomSleep(100,300)
   $x = Random(1598, 1625, 1)
   $y = Random(547, 577, 1)
   MouseClick("left", $x, $y, 1, randomMouseSpeed())
   randomSleep(500,1000)
EndFunc

Func gotoSkills()
   randomSleep(200, 800)
   $x = Random($skillsTabX[0], $skillsTabX[1], 1)
   $y = Random($skillsTabY[0], $skillsTabY[1], 1)
   MouseClick("left", $x, $y, 1, randomMouseSpeed())
   randomSleep(2000, 6000)
EndFunc

Func gotoQuests()
   randomSleep(500,1500)
   $x = Random($questTabX[0], $questTabX[1], 1)
   $y = Random($questTabY[0], $questTabY[1], 1)
   MouseClick("left", $x, $y, 1, randomMouseSpeed())

   $roll = Random(0,10, 1)

   if $roll <= 5 Then
	  checkDiary()
   ElseIf $roll <= 7 Then
	  checkQuests()
   Else
	  checkSummary()
   EndIf

   $skillRoll = Random(1,10,1)
   if $skillRoll <= 3 Then
	  gotoSkills()
   EndIf

EndFunc

Func checkQuests()
   randomSleep(500,1000)
   $x = Random($qpX[0], $qpX[1],1)
   $y = Random($qpY[0], $qpY[1],1)
   MouseClick("left", $x, $y, 1, randomMouseSpeed())
   randomSleep(1000, 2000)
   $x = Random($toggleQuestX[0], $toggleQuestX[1], 1)
   $y = Random($toggleQuestY[0], $toggleQuestY[1], 1)
   MouseClick("left", $x, $y, 1, randomMouseSpeed())

   $reclick = Random(0,2,1)
   While $reclick > 0
	  MouseClick("left")
	  randomSleep(700, 1500)
	  $reclick -= 1
   WEnd

   randomSleep(2000,5000)
EndFunc

Func checkDiary()
   randomSleep(500,1000)
   $x = Random($diariesX[0], $diariesX[1], 1)
   $y = Random($diariesY[0], $diariesY[1], 1)
   MouseClick("left", $x, $y, 1, randomMouseSpeed())
   randomSleep(500,700)

   getDiary()
   $diaryRoll = Random(1,10,1)
   if $diaryRoll <= 3 Then
	  getDiary()
   EndIf

   $closeButton = PixelSearch($closePageX[0], $closePageY[0], $closePageX[1], $closePageY[1], 0xe0b77a, 5)
   if Not @error Then
   $x = Random($closePageX[0], $closePageX[1], 1)
   $y = Random($closePageY[0], $closePageY[1], 1)
   MouseClick("left", $x, $y, 1, randomMouseSpeed())
   EndIf
   randomSleep(200,400)
EndFunc

Func getDiary()
   $x = Random($diarySelectionX[0], $diarySelectionX[1], 1)
   $y = Random($diarySelectionY[0], $diarySelectionY[1], 1)
   MouseClick("left", $x, $y, 1, randomMouseSpeed())
   randomSleep(500, 700)

   $x = Random($diaryPageX[0], $diaryPageX[1], 1)
   $y = Random($diaryPageY[0], $diaryPageY[1], 1)
   MouseMove($x, $y, randomMouseSpeed())
   randomSleep(500, 1000)
   MouseWheel("down", Random(5, 10, 1))
   randomSleep(500, 4000)

   $scrollMore = Random(0, 3, 1)
   While $scrollMore > 0
	  $directionRoll = Random(1,2,1)
	  $direction = $directionRoll == 1 ? "down" : "up"
	  MouseWheel($direction, Random(0,10,1))
	  $scrollMore -= 1
	  randomSleep(500,4000)
   WEnd

EndFunc

Func checkSummary()
   randomSleep(200, 500)
   $x = Random($summaryX[0], $summaryX[1], 1)
   $y = Random($summaryY[0], $summaryY[1], 1)
   MouseClick("left", $x, $y, 1, randomMouseSpeed())
   randomSleep(3000, 5000)
EndFunc

Func randomMouseSpeed()
   return Random(5,10,1)
EndFunc

Func randomSleep($start, $end)
   Sleep(Random($start, $end, 1))
EndFunc


Func _exit()
	Exit(0)
EndFunc