#NoEnv
#SingleInstance, force
#MaxHotkeysPerInterval 500
#WinActivateForce


; AUTOEXECUTE HAS TO BE THE FIRST IMPORTED THING
#Include autoExecuteArea.ahk

; rest of everything
#Include test.ahk
#Include app_handling.ahk



; #InstallKeybdHook
; #InstallMouseHook
; DetectHiddenWindows, on


;-------------------------------------------------
;   Handle multiple virtual desktops
CapsLock & D:: Send ^#{Right}
CapsLock & A:: Send ^#{Left}



;-------------------------------------------------
;       CapsLock media keys
CapsLock & Right::Send {Media_Next}
CapsLock & Left::Send {Media_Prev}
CapsLock & Up::Send {Media_Play_Pause}
CapsLock & Down::Send {Media_Play_Pause}



;-------------------------------------------------
;       CapsLock volume
CapsLock & 3::Send {Volume_Down 1}
CapsLock & 4::Send {Volume_Up 1}



;------------------------------------------------
; caps lock + space => always on top
CapsLock & SPACE::  Winset, Alwaysontop, , A



;------------------------------------------------
; caps lock + 1 => sleep screen
CapsLock & 1::
    Sleep 200 ; if you use this with a hotkey, not sleeping will make it so your keyboard input wakes up the monitor immediately
    SendMessage 0x112, 0xF170, 2,,Program Manager ; send the monitor into off mode
    ; unsure why, but sending the second message makes f.lux activate correctly when screen wakes up. otherwise i have to alt-tab for f.lux to work properly
    Sleep 20
    SendMessage 0x112, 0xF170, 2,,Program Manager
Return



;-------------------------------------------------
; reload this script
; caps + shift + r
CapsLock & F5::
    SetCapsLockState Off
    Reload
Return
