HotKeySet("{Esc}", "_exit")

Global $bankerColor = 0x7a7373
Global $bagColor = 0x764f2b
Global $braceletColor = 0x232020
Global $alchColor = 0xfaf60c

Global $etherX[2] = [649, 677]
Global $etherY[2] = [208, 226]
Global $braceletX[2] = [725, 744]
Global $braceletY[2] = [208, 225]
Global $natureX[2] = [796, 819]
Global $natureY[2] = [208, 229]

Global $bankerX[2] = [1000, 1110]
Global $bankerY[2] = [450, 631]
Global $depositAllX[2] = [895, 923]
Global $depositAllY[2] = [740, 768]
Global $closeX[2] = [964, 980]
Global $closeY[2] = [44, 58]

Global $etherSpotX[2] = [1353, 1377]
Global $etherSpotY[2] = [613, 637]

Global $braceletStartX = 1366
Global $braceletStartY = 629
Global $spaceX = 64
Global $spaceY = 53

Global $spellBookX[2] = [1600, 1621]
Global $spellBookY[2] = [549, 573]
Global $alchX[2] = [1568, 1584]
Global $alchY[2] = [745, 760]
Global $lastSpotX[2] = [1540, 1565]
Global $lastSpotY[2] = [933, 957]

;distance between items = 47px

While 1
   charge()
WEnd

Func findBanker()
   While 1
   $banker = PixelSearch($bankerX[0], $bankerY[0], $bankerX[1], $bankerY[1], $bankerColor, 50)

   if isArray($banker)  Then
	  Sleep(Random(50, 100,1))
	  $x = Random(1043, 1113, 1)
	  $y = Random(477, 586, 1)
	  MouseClick("left", $x, $y, 1, Random(3,6,1))
	  ExitLoop
   EndIf
   WEnd
   Sleep(Random(300,600,1))
EndFunc

Func withdraw()
   While 1
	  PixelSearch($depositAllX[0], $depositAllY[0], $depositAllX[1], $depositAllY[1], $bagColor, 10)

	  if Not @error Then
		 $x = Random($depositAllX[0], $depositAllX[1], 1)
		 $y = Random($depositAllY[0], $depositAllY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))

		 Sleep(Random(100,200,1))
		 $x = Random($etherX[0], $etherX[1], 1)
		 $y = Random($etherY[0], $etherY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))

		 Sleep(Random(100,200,1))
		 Send("{LSHIFT down}")
		 Sleep(Random(100,200,1))
		 $x = Random($braceletX[0], $braceletX[1], 1)
		 $y = Random($braceletY[0], $braceletY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 Sleep(Random(100,200,1))
		 Send("{LSHIFT up}")

		 Sleep(Random(50,100,1))
		 $x = Random($closeX[0], $closeX[1], 1)
		 $y = Random($closeY[0], $closeY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 ExitLoop
	  EndIf
   WEnd
EndFunc

Func getEther()
   findBanker()
   Sleep(Random(300,600,1))

   While 1
	  $foundBag = PixelSearch($depositAllX[0], $depositAllY[0], $depositAllX[1], $depositAllY[1], $bagColor, 10)

	  if Not @error Then
		 Sleep(Random(100,250,1))
		 $x = Random($etherX[0], $etherX[1], 1)
		 $y = Random($etherY[0], $etherY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))

		 Sleep(Random(100,250,1))
		 $x = Random($closeX[0], $closeX[1], 1)
		 $y = Random($closeY[0], $closeY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 ExitLoop
	  EndIf
   WEnd
EndFunc

Func getNature()
   findBanker()
   Sleep(Random(200,350,1))
    While 1
	  $foundNature = PixelSearch($depositAllX[0], $depositAllY[0], $depositAllX[1], $depositAllY[1], $bagColor, 10)

	  if Not @error Then
		 Send("{LSHIFT down}")
		 Sleep(Random(50,100,1))
		 $x = Random($natureX[0], $natureX[1], 1)
		 $y = Random($natureY[0], $natureY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 Sleep(Random(50,100,1))
		 Send("{LSHIFT up}")

		 Sleep(Random(50,100,1))
		 $x = Random($closeX[0], $closeX[1], 1)
		 $y = Random($closeY[0], $closeY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 ExitLoop
	  EndIf
   WEnd

   While 1
	  Sleep(Random(250,500,1))
	  $foundDeposit = PixelSearch($depositAllX[0], $depositAllY[0], $depositAllX[1], $depositAllY[1], $bagColor, 10)

	  if @error Then
		 Sleep(Random(100,200,1))
		 $x = Random($spellBookX[0], $spellBookX[1], 1)
		 $y = Random($spellBookY[0], $spellBookY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))
		 ExitLoop
	  EndIf
   WEnd
EndFunc

Func alch()
   $alchNumber = 27
   While $alchNumber > 0
		 While 1
			$foundAlch = PixelSearch(1564, 753, 1590, 766, $alchColor, 10)
			if Not @error Then
			   ExitLoop
			EndIf
		 WEnd

		 $x = Random($alchX[0], $alchX[1], 1)
		 $y = Random($alchY[0], $alchY[1], 1)
		 MouseClick("left", $x, $y, 1, Random(3,6,1))

		 While 1
			$foundBracelet = PixelSearch($lastSpotX[0], $lastSpotY[0], $lastSpotX[1], $lastSpotY[1], $braceletColor, 1)
			$x = Random($lastSpotX[0], $lastSpotX[1], 1)
			$y = Random($lastSpotY[0], $lastSpotY[1], 1)
			Sleep(Random(50,100,1))
			MouseClick("left", $x, $y, 1, Random(3,6,1))
			Sleep(Random(2600, 3000,1))
			ExitLoop
		 WEnd
		 $alchNumber -= 1
   WEnd
   Sleep(Random(100,200,1))
   $x = Random(1450, 1471, 1)
   $y = Random(548, 570, 1)
   MouseClick("left", $x, $y, 1, Random(3,6,1))
   Sleep(Random(200,400,1))
EndFunc

Func charge()
   findBanker()
   withdraw()

   While 1
	  $foundBag = PixelSearch($depositAllX[0], $depositAllY[0], $depositAllX[1], $depositAllY[1], $bagColor, 10)
	  if @error Then
		 Sleep(Random(250,500,1))
		 ExitLoop
	  EndIf
   WEnd

   For $row = 0 To 6
	  For $column = 0 To 3
		 if $row <> 0 Or $column <> 0 Then
			Sleep(Random(300,400,1))
			$etherClickX = Random($etherSpotX[0], $etherSpotX[1], 1)
			$etherClickY = Random($etherSpotY[0], $etherSpotY[1], 1)
			MouseClick("left", $etherClickX, $etherClickY, 1, Random(4,8,1))

			Sleep(Random(100,300,1))

			$x = Random($braceletStartX - 5 + $column*$spaceX, $braceletStartX + 5 + $column*$spaceX, 1)
			$y = Random($braceletStartY - 5 + $row*$spaceY, $braceletStartY + 5 + $row*$spaceY, 1)
			MouseClick("left", $x, $y, 1, Random(4,8,1))
			Sleep(Random(100, 250,1))
			if $row <> 6 Or $column <> 3 Then
			   getEther()
			EndIf
		 EndIf
	  Next
   Next

   getNature()
   alch()
EndFunc

Func _exit()
	Exit(0)
EndFunc