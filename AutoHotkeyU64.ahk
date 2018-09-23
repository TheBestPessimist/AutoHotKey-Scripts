#NoEnv
#SingleInstance, force
#MaxHotkeysPerInterval 500
#WinActivateForce
; #InstallKeybdHook
; #InstallMouseHook
; DetectHiddenWindows, on



; AUTOEXECUTE HAS TO BE THE FIRST IMPORTED THING
#Include test_autoExecute.ahk
#include appHandling_autoExecute.ahk
#include lidOff_autoExecute.ahk


; rest of everything
#Include test.ahk
#Include app_handling.ahk
#Include lidOff.ahk



;-------------------------------------------------
;   Handle multiple virtual desktops
CapsLock & D:: SendInput ^#{Right}
CapsLock & A:: SendInput ^#{Left}



;-------------------------------------------------
;       CapsLock media keys
CapsLock & Right::SendInput {Media_Next}
CapsLock & Left::SendInput {Media_Prev}
CapsLock & Up::SendInput {Media_Play_Pause}
CapsLock & Down::SendInput {Media_Play_Pause}



;-------------------------------------------------
;       CapsLock volume
CapsLock & 3::SendInput {Volume_Down 1}
CapsLock & 4::SendInput {Volume_Up 1}



;------------------------------------------------
; caps lock + space => always on top
CapsLock & SPACE::  Winset, Alwaysontop, , A



;------------------------------------------------
; Eve V: alt + menu => ctrl
!AppsKey::Ctrl
AppsKey & Alt::Ctrl


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
~CapsLock & F5::
    SetCapsLockState Off
    Reload
Return
