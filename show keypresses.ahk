; KeypressOSD.ahk
; The only problem with this script is that it works with AutoHotkey 1, but not with 2.
; Who knows, maybe ill eventually get to fix it, after AutoHotkey 2 gets out of beta

; Of course this isn't mine.
; I have taken the script from here: https://github.com/TaranVH/2nd-keyboard/tree/master/KeyPress-Displayer

; todo:
; 1. make the words stick better together
; 2. make the letters not be all in FUCKING CAPS RAGE!!!!!!!!!



#InstallKeybdHook
#UseHook
#SingleInstance force
#NoEnv

SetBatchLines, -1
ListLines, Off
CoordMode, Mouse, Screen

; Settings
transN        := 100    ; 0=transparent, 255=opaque
ShowSingleKey := True  ; display A-Z, Enter and other keys pressed without modifier (Ctr, Alt, ...)
DisplayTime   := 500  ; time to fade, in milliseconds
DisplayTime2  := 2500

; Create GUI
Gui, +AlwaysOnTop -Caption +Owner +LastFound +E0x20
Gui +ToolWindow         ; hide from alt+tab/windows+tab menu
Gui, Margin, 0, 0
Gui, Color, Black
Gui, Font, cWhite s30 bold, Arial
Gui, Add, Text, vHotkeyText Center y50
WinSet, Transparent, %transN%
Winset, AlwaysOnTop, On
SetTimer, ShowHotkey, 1

; Create hotkey
Loop, 95
    Hotkey, % "~*" Chr(A_Index + 31), Display
Loop, 24 ; F1-F24
    Hotkey, % "~*F" A_Index, Display
Loop, 10 ; Numpad0 - Numpad9
    Hotkey, % "~*Numpad" A_Index - 1, Display
Hotkey, ~*LButton, Display
Hotkey, ~*RButton, Display
Hotkey, ~*MButton, Display
Otherkeys := "NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|Tab|Enter|Esc|BackSpace|Del|Insert|Home|End|PgUp|PgDn|Up|Down|Left|Right|ScrollLock|CapsLock|NumLock|Pause|Space|NumpadDot|NumpadEnter|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|Volume_Mute|Volume_Up|Volume_Down|Browser_Home|AppsKey|PrintScreen|Sleep"
Loop, parse, Otherkeys, |
    Hotkey, % "~*" A_LoopField, Display
return

; Display
;
PreviousKey := ""
Display:
    If (A_ThisHotkey = "")
        Return
    mods   := "Ctrl|Shift|Alt|LWin|RWin"
    prefix := ""
    Loop, Parse, mods, |
        if GetKeyState(A_LoopField)
            prefix .= A_LoopField "+"
    if (!prefix && !ShowSingleKey)
        return

    currentKey := SubStr(A_ThisHotkey, 3)


    needSpace := False
    Loop, parse, Otherkeys, |
    {
        if (A_LoopField = currentKey)
        {
            needSpace := true
            ; ToolTip, 3.%previousKey%.needSpace
        }
    }

    if(prefix = "" and !needSpace)
    {
        key := PreviousKey . currentKey
        ; ToolTip, 1.%PreviousKey%."|".%currentKey%
    }
    else
    {
        key := PreviousKey .  " " . prefix .currentKey
        ; ToolTip, 2.%PreviousKey%."|".%currentKey%
    }
    PreviousKey := key


    if (key = " ")
        key := "Space"
    else if (key = "Numpad0")
        key := "0"
    else if (key = "Numpad1")
        key := "1"
    else if (key = "Numpad2")
        key := "2"
    else if (key = "Numpad3")
        key := "3"
    else if (key = "Numpad4")
        key := "4"
    else if (key = "Numpad5")
        key := "5"
    else if (key = "Numpad6")
       key := "6"
    else if (key = "Numpad7")
       key := "7"
    else if (key = "Numpad8")
       key := "8"
    else if (key = "Numpad9")
        key := "9"
    else if (key = "NumpadDot")
        key := "."
    LastHotkeyPressedTime := A_TickCount
Return

; Show Gui element with the hotkeys, move with mouse and fade into transparency
ShowHotkey:
    prev_X := -999
    prev_Y := -999
    prev_LastHotkeyPressedTime := "999"
    Gui, +LastFound
    Loop {
        Elapsed := A_TickCount - LastHotkeyPressedTime
        Faded := 1 - Elapsed/DisplayTime
        if (prev_LastHotkeyPressedTime != LastHotkeyPressedTime) {
            WinSet, Transparent, % transN
        } else if (Faded > 0.1) {
            WinSet, Transparent, % transN * 1
        }
        MouseGetPos, X, Y
        if (prev_LastHotkeyPressedTime != LastHotkeyPressedTime or (((abs(prev_X - X) > 1 or abs(prev_Y - Y) > 1) or Faded < 0) and PreviousKey != "")) {
            text_w := StrLen(key) * 20 + 50
            if (Faded < 0.1) {
                adjusted_X := 75
                adjusted_Y := A_ScreenHeight - 100
                WinSet, Transparent, % 50
                PreviousKey :=
            } else {
                adjusted_X := 75
                adjusted_Y := A_ScreenHeight - 100
            }
            GuiControl,, HotkeyText, %key%
            GuiControl, Move, HotkeyText, +AlwaysOnTop w%text_w%
            WinSet, Region, 0-0 W%text_w% H50 R10-10
            Gui, Show, NoActivate x%adjusted_X% y%adjusted_Y% w%text_w%
            prev_X := X
            prev_Y := Y
            prev_LastHotkeyPressedTime := LastHotkeyPressedTime
            SetTimer, HideGUI, % -1 * DisplayTime2
        }
        Sleep, 1
    }
Return

HideGUI() {
    Gui, Hide
}
