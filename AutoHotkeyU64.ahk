#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force
#MaxHotkeysPerInterval 500
#WinActivateForce
; #InstallKeybdHook
; #InstallMouseHook
; DetectHiddenWindows, on


; Change the icon in taskbar
; Ref: https://github.com/TaranVH/2nd-keyboard/blob/master/INFO_and_PROFILES/system32-shell32_dll.png
; Menu, Tray, Icon, shell32.dll, 303 ; changes tray icon to a  check mark
; Menu, Tray, Icon, shell32.dll, 16 ; change tray icon to a little laptop
Menu, Tray, Icon, shell32.dll, 321 ; change tray icon to a blue star
; Menu, Tray, Icon, shell32.dll, 44 ; change tray icon to a yellow star





; AUTOEXECUTE HAS TO BE THE FIRST IMPORTED THING
#Include test_autoExecute.ahk
#include appHandling_autoExecute.ahk
#include lidOff_autoExecute.ahk
#include soundBalance_autoExecute.ahk
#include capsLockToggle_autoExecute.ahk



; rest of everything
#Include app_handling.ahk
#Include lidOff.ahk
#include Tippy.ahk
#include PowerManager.ahk
#include capsLockToggle.ahk




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
; caps lock + 1 => sleep screen
CapsLock & 1::
{
    Sleep 200 ; if you use this with a hotkey, not sleeping will make it so your keyboard input wakes up the monitor immediately
    SendMessage 0x112, 0xF170, 2,,Program Manager ; send the monitor into off mode
    ; unsure why, but sending the second message makes f.lux activate correctly when screen wakes up. otherwise i have to alt-tab for f.lux to work properly
    Sleep 2000
    SendMessage 0x112, 0xF170, 2,,Program Manager
    Return
}



;------------------------------------------------
; Eve V: alt + menu => ctrl
!AppsKey::Ctrl
AppsKey & Alt::Ctrl
AppsKey::Send {AppsKey}




;------------------------------------------------
; CapsLock + P: Toggle between "Power saver" and "Balanced" powers schemes
CapsLock & P::TogglePowerScheme()






;-------------------------------------------------
; reload this script
; caps + shift + r
#If GetKeyState("CapsLock", "P")
F5::Reload
#If







