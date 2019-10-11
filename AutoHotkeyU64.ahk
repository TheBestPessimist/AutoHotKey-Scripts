#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force
#MaxHotkeysPerInterval 50
#WinActivateForce
#InstallKeybdHook
#InstallMouseHook
; these 2 settings are killing the telegram starter, since the telegram process exists,
; just that it is hidden in the tray, instead of taskbar
; DetectHiddenWindows, On
; SetTitleMatchMode, 2

#MenuMaskKey vk07

; Change the icon in taskbar
; Ref: https://github.com/TaranVH/2nd-keyboard/blob/master/INFO_and_PROFILES/system32-shell32_dll.png
; Menu, Tray, Icon, shell32.dll, 303 ; changes tray icon to a  check mark
; Menu, Tray, Icon, shell32.dll, 16 ; change tray icon to a little laptop
; Menu, Tray, Icon, shell32.dll, 321 ; change tray icon to a blue star
; Menu, Tray, Icon, shell32.dll, 44 ; change tray icon to a yellow star
Menu, Tray, Icon, resources/blueStar.ico





; AUTOEXECUTE HAS TO BE THE FIRST IMPORTED THING
#include appHandling_autoExecute.ahk
#include lidOff_autoExecute.ahk



; rest of everything
#include <libdebug>
#include MarkdownHotstrings.ahk
#Include app_handling.ahk
#Include lidOff.ahk
#include lib/Tippy.ahk
#include PowerManager.ahk
#include CapsLockToggle.ahk
#include GenericHotstrings.ahk
#include SoundBalance.ahk
#include StarCraft2.ahk
#include lib/ReloadScript.ahk

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





;------------------------------------------------
; Disable faulty multiple "i" key presses
;
; Explanation: my 1st gen many-years-old-spilled-with-tea Corsair K70 RGB a has faulty "i" key.
;   When pressed once, it may register 1, none, or even 3 presses.
;   Kinda annoying, yes.
;
;
; The commented hotkey below is the legacy way which even if works, has the issue that it breaks all hotstrings containing "i"
;           since keyboard "i" is blocked, and ahk sends a "fake i"
; $*i::
;     If (A_TimeSincePriorHotkey < 90 && A_TimeSincePriorHotkey > 1) {
;         Tippy("i doublePress " . A_Now)
;         Return
;     }
;     Send % "{Blind}i"       ; use Blind mode so that Shift and CapsLock work
; Return
;
;
; This is a suggestion from @CloakerSmoker#2459 on the ahk discord: https://discord.gg/eKEX7AG
;
; Bind "i" key to nothing (`~*i::Return`), just so that A_TimeSincePriorHotkey updates and don't block the key on a normal press.
; Otherwise if it was a double press, show the tooltip and block the OS from getting the key press
; By using #if we have the original key presses getting sent, instead of AHK sending them
;       which should fix hotstrings/hotkeys that were messing up

#if (A_TimeSincePriorHotkey < 90 && A_TimeSincePriorHotkey > 1)
*i::
    Tippy("Double press at " A_Now)
Return
#if

~*i::Return

; let's try the same fix for LMB
;       -- later edit, not working properly
;
; #if (A_TimeSincePriorHotkey < 100 && A_TimeSincePriorHotkey > 0)
; *LButton::
;     Tippy("Double press at " A_Now "`nTime since prior hotkey " A_TimeSincePriorHotkey "`n`nThis hotkey " A_ThisHotkey "`nPrior hokey " A_PriorHotkey, , -1)
; Return
; #if
;
; ~*LButton::Return



; ; this version doesn't work either
LButton::
    If (A_TimeSincePriorHotkey < 100 && A_TimeSincePriorHotkey > 0) {
        Tippy("Double press at " A_Now "`nTime since prior hotkey " A_TimeSincePriorHotkey "`n`nThis hotkey " A_ThisHotkey "`nPrior hokey " A_PriorHotkey, , -1)
        Return
    }
    Send {LButton Down}
    Sleep, 10
    KeyWait, LButton
    Send {LButton Up}
Return

