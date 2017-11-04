/*
			-------------------------------------------------------
								HotShow 1.0
			-------------------------------------------------------

			This program will show any pressed key or combination
			of keys on screen in a very elegant way.

			Perfect for people who creates video tutorials
			and want to show which hotkeys they press during
			a demostration of the software being used.

----[Author]--------------------------------------------------------
This program was created by RaptorX
Thanks to Tidbit and Titan for help in some of the functions
----[Features]------------------------------------------------------
Right now the program is in its basic form.
Features will be added soon, Please read the To Do  list
----[TODO]----------------------------------------------------------
Customization of:
-Background Image
-Transparency settings
-Fade in/Fade out settings
-Window Positioning options
--------------------------------------------------------------------
*/
#SingleInstance Force
#NoEnv
OnExit, Clean

FileInstall, BG-Blue.png, BG-Blue.png, 1

Gui, +owner +AlwaysOnTop +Disabled +Lastfound -Caption
Gui, Color, FFFFFF
Gui, Add, Picture,,BG-Blue.png
WinsetTitle,Background
Winset, transcolor, FFFFFF 0

Gui, 2: +Owner +AlwaysOnTop +Disabled +Lastfound -Caption
Gui, 2: Color, 026D8D
Gui, 2: Font, Bold s15 Arial
Gui, 2: Add, Text, Center CWhite W250 vHotkeys,
WinsetTitle,HotkeyText
Winset, transcolor, 026D8D 0

Gui, Show, Hide
Gui, 2: Show, Hide

Loop, 95
{
	key := Chr(A_Index + 31)
	Hotkey, ~*%key%, Display
}

Display:
If A_ThisHotkey =
	Return

mods = Ctrl,Shift,Alt,LWin,RWin
prefix =

Loop, Parse, mods,`,
{
	GetKeyState, mod, %A_LoopField%
	If mod = D
		prefix = %prefix%%A_LoopField% +
}

StringTrimLeft, key, A_ThisHotkey, 2
if key=%a_Space%
	key=Space
Gosub, Show
Return

Show:
Alpha=0
Duration=150
Imgx=23
Imgy=630

GuiControl, 2: Text, Hotkeys, %prefix% %key%
Gui, Show, x%imgx% y%imgy% NoActivate
imgx-=10
imgy+=15
Gui, 2: Show, x%imgx% y%imgy% NoActivate

Gosub, Fadein
Sleep 2000
Gosub, Fadeout
Gui, Hide
Gui, 2: Hide
Return

Fadein:
Loop, %duration%
{
	Alpha+=255/duration
	Winset, transcolor, FFFFFF %Alpha%, Background
	Winset, transcolor, 026D8D %Alpha%, HotkeyText
}
Return

Fadeout:
Loop, %duration%
{
	Alpha-=255/duration
	Winset, transcolor, FFFFFF %Alpha%, Background
	Winset, transcolor, 026D8D %Alpha%, HotkeyText
}
return

Clean:
FileDelete, BG-Blue.png
ExitApp

~*Esc::Goto, Clean
 
/*
-[Created By]-------------------------------------------------------
						 -RaptorX-

This project can be modified or copied, for personal or commercial
uses provided that you mention the original author.
--------------------------------------------------------------------
