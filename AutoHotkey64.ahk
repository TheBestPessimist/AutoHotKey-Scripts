#Requires AutoHotkey v2.0

#SingleInstance Force
A_MenuMaskKey := "vkE8"
;#WinActivateForce ; disabled to check if AHK v2 works better than AHK V1
InstallKeybdHook
InstallMouseHook
; these 2 settings are killing the telegram starter, since the telegram process exists,
; just that it is hidden in the tray, instead of taskbar
; DetectHiddenWindows, On
; SetTitleMatchMode, 2

; Change the icon in taskbar
; Ref: https://github.com/TaranVH/2nd-keyboard/blob/master/INFO_and_PROFILES/system32-shell32_dll.png
; TraySetIcon "shell32.dll", 303 ; changes tray icon to a  check mark
; TraySetIcon "shell32.dll", 16 ; change tray icon to a little laptop
; TraySetIcon "shell32.dll", 321 ; change tray icon to a blue star
; TraySetIcon "shell32.dll", 44 ; change tray icon to a yellow star
TraySetIcon("resources/blueStar.ico")

CoordMode("Mouse", "Screen")

; I removed `n and `t from hotstring trigger chars
; https://www.autohotkey.com/docs/v2/Hotstrings.htm#EndChars
#Hotstring EndChars -()[]{}:;'"/\,.?!`s
; Try to make telegram and Feces work better with hotstrings
; 1. Switch all hotstrings from SendInput to SendEvent, otherwise they ignore key delay
; 2. Increase the time between each hotstring hotkey to 5ms
#Hotstring SE K5

;; rest of everything
#Include lib/Tippy.ahk
#Include lib/libdebug.ahk
#Include app_handling.ahk
#Include lib/ReloadScript.ahk
#Include CapsLockToggle.ahk
#Include "Asus Rog Flow X16.ahk"

#Include hotstrings/MarkdownEmoji.ahk
#Include hotstrings/GenericHotstrings.ahk
#Include hotstrings/MarkdownHotstrings.ahk
#Include hotstrings/ResetHotstrings.ahk

#Include *i Private.ahk

#Include lib/_JXON.ahk




;-------------------------------------------------
;   Handle multiple virtual desktops
CapsLock & D::SendInput "^#{Right}"
CapsLock & A::SendInput "^#{Left}"



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
CapsLock & SPACE::WinSetAlwaysOnTop(-1, "A")



;------------------------------------------------
; caps lock + 1 => sleep screen
CapsLock & 1 Up::{
    Sleep 900 ; if you use this with a hotkey, not sleeping will make it so your keyboard input (lifting your fingers from the keyboard after pressing the hotkey) wakes up the monitor immediately
    SendMessage(0x112, 0xF170, 2,, "Program Manager") ; send the monitor into off mode
}


;------------------------------------------------
; Flow Launcher should replaces Windows key, but that is not possible while also keeping AltSnap working
;~LWin & ~LControl:: ; for some reason this ordering of keys interferes with Precision touchpad "3 finger tap = Middle click" 🙄. Why is Microshitsoft sending all modifier keys before middle click? WTF ?!?!?!!?!?
LControl & LWin Up::
{
    ; see https://github.com/seerge/g-helper/issues/512: need this to disable touchpad
    if(A_PriorKey = "F24") ; in my 2 in 1 laptop, when rotating the screen into tabled only mode, GHelper sends the keys LCtrl Down, LWin Down, F24 Down, then up, which activates this hotkey
        return
    if(!ProcessExist(Process.FlowLauncher)) {
        Tippy("It's dead, Jim")
        Run(Paths.FlowLauncher)
        Sleep 2500
    }

    ; if Start menu is open, turn it off
    if(WinActive("ahk_class Windows.UI.Core.CoreWindow")) {
        Send "{Esc}"
        Sleep 500
    }
    Send "#{F10}"
}

;------------------------------------------------
; Launch Voidtools Everything
$#s::Send "#^!+{F12}"

;------------------------------------------------
; Launch the other launcher (Autohotkey-Launcher).
; I must do this dance because this script takes over Win key, and the other one cannot use it
; Technical: I must use LWin Up, because Win + L = lock screen
CapsLock & LWin Up::Send "^!+l"

;------------------------------------------------
; CapsLock + P: Toggle between "Power saver" and "Balanced" powers schemes
;CapsLock & P::TogglePowerScheme()




;------------------------------------------------
; Run Windows Terminal
#t::
{
    Run("C:\Users\TheBestPessimist\AppData\Local\Microsoft\WindowsApps\wt.exe  --title `"Windows FUCKING Terminal :^)`" ")
    windowsFuckingTerminalWindow := "Windows FUCKING Terminal ahk_class CASCADIA_HOSTING_WINDOW_CLASS ahk_exe WindowsTerminal.exe"

    WinWait(windowsFuckingTerminalWindow, , 5)
    WinActivate(windowsFuckingTerminalWindow)
}




;------------------------------------------------
/*
Note in case future me wants to use `LWin Up::` as a hotkey: DO NOT DO IT, IT WILL NEVER WORK
Things which will break:
- Altsnap (win + double click; win + alt + click to resize)
- Middle click
- Win + E and all other win+key shortcuts
- my sanity

workarounds needed because Touchpad Middle click is made up of these keys:
LWin     d
LControl d
LShift   d
F22      d
F22      u
LShift   u
LControl u
LWin     u
MButton  d
MButton  u

Tippy("thisHotkey " thisHotkey "`nA_PriorHotkey " A_PriorHotkey "`nA_PriorKey " A_PriorKey, 20000)

if(A_PriorKey == "F22") {
    Send "{MButton}"
    return
}

if(A_PriorKey != "LWin") {
    return
}
; end of workarounds
*/


; SC2 Eterrnal Wrath of Eres
; 3 = marine stim
; 4 = tank boost armor
; 1 = moi
CapsLock & m:: {
    static toggle := 0
    SetTimer(stim, (toggle := !toggle) ? 400 : 0)
}

stim() {
    Tippy("stim (caps M)", 3000, 5)
    ControlSend("{Blind}{Raw}3tt",, "ahk_exe SC2_x64.exe")
;    ControlSend("{Blind}{Raw}4b",, "ahk_exe SC2_x64.exe")
    ControlSend("{Blind}{Raw}1h",, "ahk_exe SC2_x64.exe")
}
