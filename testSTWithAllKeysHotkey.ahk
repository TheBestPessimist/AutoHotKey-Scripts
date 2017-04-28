#InstallKeybdHook
#UseHook
#SingleInstance force
#NoEnv

; Create hotkey
;~ Loop, 95
;~ {
    ;~ a := "~*"Chr(A_Index + 31)
    ;~ Hotkey, a
;~ }
Loop, 12 ; F1-F12
    Hotkey, % "~*F" A_Index
Loop, 10 ; Numpad0 - Numpad9
    Hotkey, % "~*Numpad" A_Index - 1
Hotkey, ~*LButton
Hotkey, ~*RButton
Hotkey, ~*MButton
Otherkeys := "NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|Tab|Enter|Esc|BackSpace|Del|Insert|Home|End|PgUp|PgDn|Up|Down|Left|Right|ScrollLock|CapsLock|NumLock|Pause|Space|NumpadDot|NumpadEnter|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|Volume_Mute|Volume_Up|Volume_Down|Browser_Home|AppsKey|PrintScreen|Sleep"
Loop, parse, Otherkeys, |
    Hotkey, % "~*" A_LoopField
return
