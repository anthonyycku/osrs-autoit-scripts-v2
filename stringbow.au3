#include <MsgBoxConstants.au3>

WinActivate("RuneLite")

HotKeySet("{Esc}", "_exit")

$left = "LEFT"
$right = "RIGHT"

$unstrungYew = 0xa1890c
$unstrungMage = 0x0b3e39

Global $bagX[2] = [1447, 1477]
Global $bagY[2] = [543, 579]

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

while 1
   _main()
WEnd

Func _main()
   $roll = Random(1,100,1)
   if $roll <= 5 Then
	  ActHuman()
   EndIf

   _takeBreak()
   _findBanker()
   Sleep(_pauseLong())
   _deposit()
   Sleep(_pauseMedium())
   _withdraw()
   Sleep(_pauseVeryShort())
   _closeBank()
   _stringBow()
EndFunc

Func _takeBreak()

   $roll = Random(1,100,1)
   if $roll <= 2 Then
	  Sleep(Random(500, 1000, 1))
	  $whatToDo = Random(1,3,1)

	  if $whatToDo == 1 Then
		 Sleep(Random(5000, 10000, 1))
	  ElseIf $whatToDo == 2 Then
		 $clickX = Random(1348, 1376, 1)
		 $clickY = Random(551, 575, 1)
		 MouseClick("left", $clickX, $clickY, 1, Random(4,10,1))
		 Sleep(Random(5000, 10000, 1))
		 $bagX = Random(1449, 1477, 1)
		 $bagY = Random(547, 574, 1)
		 MouseClick("left", $bagX, $bagY, Random(4,10,1))
	  ElseIf $whatToDo == 3 Then
		 $questX = Random(1402, 1423, 1)
		 $questY = Random(551, 576, 1)
		 MouseClick("left", $questX, $questY, Random(4,10,1))
		 Sleep(Random(2000, 6000, 1))
		 $bagX = Random(1449, 1477, 1)
		 $bagY = Random(547, 574, 1)
		 MouseClick("left", $bagX, $bagY, Random(4,10,1))
	  EndIf
   EndIf
	  Sleep(Random(300,1000,1))
EndFunc

Func _findBanker($currentTime = 0)
   ;$banker = PixelSearch(773, 713, 1280, 1020, 0x181023, 1);Varrock west bank orange banker
   ;$banker = PixelSearch(773, 713, 1280, 1020, 0x2c233b, 10) ;Varrock west bank first banker

   if $currentTime == 0 Then
	$currentTime = TimerInit()
   EndIf

   $banker = PixelSearch(469, 413, 607, 615, 0x74696a, 5) ; GE east side

   if isArray($banker) Then
	  $bankerX = Random($banker[0], $banker[0] + 50, 1)
	  $bankerY = Random($banker[1], $banker[1] + 70, 1)
	  $clickSpeed = Random(3,10,1)

	  MouseClick($left, $bankerX, $bankerY, 1, $clickSpeed)

   Else
	  if TimerDiff($currentTime) >= 60000 Then
		 Exit(0)
	  EndIf

	  _findBanker($currentTime)
   EndIf
EndFunc

Func _deposit($currentTime = 0)
   if $currentTime == 0 Then
	  $currentTime = TimerInit()
   EndIf

   $depositIcon = PixelSearch(889, 740, 924, 771, 0x6f4b29, 5)
   if Not @error Then
	  $depositX = Random(904 - 10, 904 + 10, 1)
	  $depositY = Random(750 - 10, 750 + 10, 1)
	  $clickSpeed = Random(2,8,1)
	  MouseClick($left, $depositX, $depositY, 1, $clickSpeed)
   Else
	  if TimerDiff($currentTime) >= 30000 Then
		 Exit(0)
	  EndIf
	  _deposit($currentTime)
   EndIf
EndFunc

Func _withdraw($currentTime = 0)
      if $currentTime == 0 Then
		 $currentTime = TimerInit()
	  EndIf

	  $string = PixelSearch(506, 158, 530, 174, 0x393324)

	  if isArray($string) Then
		 $stringX = Random($string[0] - 10, $string[0] + 10, 1)
		 $stringY = Random($string[1] - 10, $string[1] + 10, 1)
		 $stringSpeed = Random(3,10,1)
		 $bowSpeed = Random(3, 10, 1)

		 MouseClick($left, $stringX, $stringY, 1, $stringSpeed)
		 Sleep(Random(50,200, 1))

		 $bowX = Random(595 - 10, 595 + 10, 1)
		 $bowY = Random(162 - 10, 162 + 10, 1)

		 MouseClick($left, $bowX, $bowY, 1, $bowSpeed)

	  Else
		 if TimerDiff($currentTime) >= 30000 Then
			Exit(0)
		 EndIf
		 _withdraw($currentTime)
	  EndIf

EndFunc

Func _closeBank($currentTime = 0)
   if $currentTime == 0 Then
	  $currentTime = TimerInit()
   EndIf

   $close = PixelSearch(970, 47, 977, 57, 0x000001, 1)

   if isArray($close) Then
	  $closeX = Random($close[0] - 10, $close[0] + 10, 1)
	  $closeY = Random($close[1] - 10, $close[1] + 10, 1)
	  $clickSpeed = Random(3,10,1)

	  MouseClick($left, $closeX, $closeY, 1, $clickSpeed)

   Else
	  if TimerDiff($currentTime) >= 20000 Then
		 Exit(0)
	  EndIf

	  _closeBank($currentTime)
   EndIf
EndFunc

Func _stringBow($currentTime = 0)
	  if $currentTime == 0 Then
		 $currentTime = TimerInit()
	  EndIf

   Sleep(Random(300, 800,1))
   $firstSlotX = Random(1363 - 10, 1363 + 10, 1)
   $firstSlotY = Random(628 - 10, 628 + 10, 1)
   $clickSpeed = Random(3,10,1)
   MouseClick($left, $firstSlotX, $firstSlotY, 1, $clickSpeed)
   Sleep(Random(50,150,1))

   $unstrung = PixelSearch(1333, 602, 1590, 972, $unstrungMage, 10)

   if isArray($unstrung) Then
	  $unstrungX = Random($unstrung[0], $unstrung[0] + 20, 1)
	  $unstrungY = Random($unstrung[1], $unstrung[1] + 20, 1)
	  $clickSpeed = Random(3,10,1)
	  MouseClick($left, $unstrungX, $unstrungY, 1, $clickSpeed)

	  Sleep(Random(1000, 1500, 1))
	  Send("{SPACE}")
   Else
	  if TimerDiff($currentTime) >= 20000 Then
		 Exit(0)
	  EndIf
	  _stringBow($currentTime)
   EndIf

   $newX = Random(451, 591, 1)
   $newY = Random(435, 618, 1)
   $moveSpeed = Random(3, 15, 1)
   MouseMove($newX, $newY, $moveSpeed)

   $time = 0
   While 1
	  if isArray(PixelSearch(1532, 932, 1567, 964, $unstrungMage, 10)) Then
		 $time += 1
		 Sleep(Random(400,600,1))
		 if ($time == 35) Then
			ExitLoop
		 EndIf
		 ContinueLoop
	  Else
		 ExitLoop
	  EndIf
   WEnd

EndFunc


Func _checkError($errorCount)
   $errorCount += 1
   if ($errorCount == 10) Then
	  _exit()
   EndIf
   return $errorCount
EndFunc

Func _pauseLong()
   return Random(1000, 1500, 1)
EndFunc

Func _pauseMedium()
   return Random(500,1000,1)
EndFunc

Func _pauseShort()
   return Random(50, 500, 1)
EndFunc

Func _pauseVeryShort()
   return Random(50, 100, 1)
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
   $x = Random(1447, 1477, 1)
   $y = Random(543, 579, 1)
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


