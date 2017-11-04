#SingleInstance force
#NoEnv
SetBatchLines, -1
ListLines, Off
CoordMode, Mouse, Screen



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Create all the  hotkeys
; add the characters with ascii code 31 -> 126
; add the functional keys F1 -> F12
; add the numpad keys
; add mousebutton clicks
; add a lot of other keys
Loop, 95
    Hotkey, % "~*" Chr(A_Index + 31), GrabLastKeypress
Loop, 12 ; F1-F12
    Hotkey, % "~*F" A_Index, GrabLastKeypress
Loop, 10 ; Numpad0 - Numpad9
    Hotkey, % "~*Numpad" A_Index - 1, GrabLastKeypress
Hotkey, ~*LButton, GrabLastKeypress
Hotkey, ~*RButton, GrabLastKeypress
Hotkey, ~*MButton, GrabLastKeypress
Otherkeys := "NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|Tab|Enter|Esc|BackSpace|Del|Insert|Home|End|PgUp|PgDn|Up|Down|Left|Right|ScrollLock|CapsLock|NumLock|Pause|Space|NumpadDot|NumpadEnter|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|Volume_Mute|Volume_Up|Volume_Down|Browser_Home|AppsKey|PrintScreen|Sleep"
Loop, parse, Otherkeys, |
    Hotkey, % "~*" A_LoopField, GrabLastKeypress
return




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GrabLastKeypress
; Grab the last key pressed, or key-combo (ctrl+shift+alt+h), etc.
PreviousKey := ""   ; !!! not sure this is actually needed anymore
GrabLastKeypress:

    If A_ThisHotkey =       ; if this hotkey is nothing, simply return. Why whould the current hotkey be nothing? Is this maybe a handler for other virtual keypresses?
        Return


    LastHotkeyPressedTime := A_TickCount
Return
