#SingleInstance Force
;#WinActivateForce ; disabled to check if AHK v2 works better than AHK V1
InstallKeybdHook
InstallMouseHook
; these 2 settings are killing the telegram starter, since the telegram process exists,
; just that it is hidden in the tray, instead of taskbar
; DetectHiddenWindows, On
; SetTitleMatchMode, 2

; Change the icon in taskbar
; Ref: https://github.com/TaranVH/2nd-keyboard/blob/master/INFO_and_PROFILES/system32-shell32_dll.png
; Menu, Tray, Icon, shell32.dll, 303 ; changes tray icon to a  check mark
; Menu, Tray, Icon, shell32.dll, 16 ; change tray icon to a little laptop
; Menu, Tray, Icon, shell32.dll, 321 ; change tray icon to a blue star
; Menu, Tray, Icon, shell32.dll, 44 ; change tray icon to a yellow star
;Menu, Tray, Icon, resources/blueStar.ico ; TODO


;; rest of everything
;#include lib/clipboard.ahk
;#Include lib/libdebug.ahk
;#Include app_handling.ahk
;#Include lib/Tippy.ahk
;#Include lib/ReloadScript.ahk
;#Include PowerManager.ahk
;#Include CapsLockToggle.ahk
;#Include SoundBalance.ahk
;; #Include games/StarCraft2.ahk
;#Include FixKeyGhostPresses.ahk
;#Include XmgFusion15.ahk
;
;#Include hotstrings/MarkdownEmoji.ahk
;#Include hotstrings/GenericHotstrings.ahk
;#Include hotstrings/MarkdownHotstrings.ahk
;#Include hotstrings/ResetHotstrings.ahk
;#Include *i Private.ahk

;-------------------------------------------------
;   Handle multiple virtual desktops
CapsLock & D:: SendInput "^#{Right}"
CapsLock & A:: SendInput "^#{Left}"



;-------------------------------------------------
;       CapsLock media keys
CapsLock & Right::SendInput "{Media_Next}"
CapsLock & Left::SendInput "{Media_Prev}"
CapsLock & Up::SendInput "{Media_Play_Pause}"
CapsLock & Down::SendInput "{Media_Play_Pause}"



;-------------------------------------------------
;       CapsLock volume
CapsLock & 3::SendInput "{Volume_Down 1}"
CapsLock & 4::SendInput "{Volume_Up 1}"


;-------------------------------------------------
;       Mouse buttons Volume
XButton1::SendInput "{Volume_Down 1}"
XBUtton2::SendInput "{Volume_Up 1}"


;------------------------------------------------
; caps lock + space => always on top
;CapsLock & SPACE::  Winset, Alwaysontop, , A



;;------------------------------------------------
;; caps lock + 1 => sleep screen
;CapsLock & 1::
;{
;    Sleep 200 ; if you use this with a hotkey, not sleeping will make it so your keyboard input wakes up the monitor immediately
;    SendMessage 0x112, 0xF170, 2,,Program Manager ; send the monitor into off mode
;    ; unsure why, but sending the second message makes f.lux activate correctly when screen wakes up. otherwise i have to alt-tab for f.lux to work properly
;    Sleep 2000
;    SendMessage 0x112, 0xF170, 2,,Program Manager
;    Return
;}
;





;------------------------------------------------
; CapsLock + P: Toggle between "Power saver" and "Balanced" powers schemes
;CapsLock & P::TogglePowerScheme()
