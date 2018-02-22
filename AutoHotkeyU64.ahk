#NoEnv
#SingleInstance, force

#include app_handling.ahk

; #InstallKeybdHook
; #InstallMouseHook
; DetectHiddenWindows, on



;-------------------------------------------------
;   Handle multiple virtual desktops
Capslock & D:: Send ^#{Right}
Capslock & A:: Send ^#{Left}




;-------------------------------------------------
;       Capslock media keys
Capslock & Right::Send {Media_Next}
Capslock & Left::Send {Media_Prev}
Capslock & Up::Send {Media_Play_Pause}
Capslock & Down::Send {Media_Play_Pause}



;-------------------------------------------------
;       Capslock volume
Capslock & 3::Send {Volume_Down 1}
Capslock & 4::Send {Volume_Up 1}



;----------------------------------------------
; caps lock + space => always on top
CapsLock & SPACE::  Winset, Alwaysontop, , A



;----------------------------------------------
; caps lock + 1 => sleep screen
CapsLock & 1::
    Sleep 200 ; if you use this with a hotkey, not sleeping will make it so your keyboard input wakes up the monitor immediately
    SendMessage 0x112, 0xF170, 2,,Program Manager ; send the monitor into off mode
    ; unsure why, but sending the second message makes f.lux activate correctly when screen wakes up. otherwise i have to alt-tab for f.lux to work properly
    Sleep 20
    SendMessage 0x112, 0xF170, 2,,Program Manager
Return
