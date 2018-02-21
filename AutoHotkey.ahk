;-------------------------------------------------
; i use this to capture the keyboard keystrokes (it does not work for FN + sth on SUSV)
; #InstallKeybdHook
; #InstallMouseHook

;-------------------------------------------------
;       mouse lower the volume
; XButton2::
; firstClick = 1
; loop
; {
;     if firstClick = 1   ; so that i have a pause after pressing and holding the key
;     {
;         Send {Volume_Up 1}
;         sleep, 500
;         firstClick = 0
;     }
;     GetKeyState, state, XButton2, P
;     if state = D
;         Send {Volume_Up 1}
;     else
;         return

;     sleep, 120
; }


;-------------------------------------------------
;       mouse increase the volume
; XButton1::
; firstClick = 1
; loop
; {
;     if firstClick = 1   ; so that i have a pause after pressing and holding the key
;     {
;         Send {Volume_Down 1}
;         sleep, 500
;         firstClick = 0
;     }
;     GetKeyState, state, XButton1, P
;     if state = D
;         Send {Volume_Down 1}
;     else
;         return
;     sleep, 120
; }



;-------------------------------------------------
;       shortcut alt+3
;!3::Send {Volume_Down 1}

;-------------------------------------------------
;       shortcut alt+4
;!4::Send {Volume_Up 1}



;-------------------------------------------------
; start Sublime Text. "#" is used to simultate winKey (therefore shortcut = winKey + s)
;!s::run "%A_Desktop%\Sublime Text 3\sublime_text.exe"
;!s::run "E:\portable apps\Sublime Text 3 32 bit\sublime_text -  cracked.exe"


; close Digsby when Esc key is pressed
; #IfWinActive Digsby "Buddy List"
;   WinGetActiveTitle, Title
;   MsgBox, The active window is "%Title%"

;#IfWinActive, Buddy List
;Esc::
; #c::
;{
;   WinClose
;   ; msgbox tibi
;}



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

;-------------------------------------------------
;       Capslock sublime text
CapsLock & s::
{
    IfWinNotExist, ahk_exe sublime_text.exe
    {
      Run "C:\d3rp\Sublime Text 3\sublime_text.exe"
      WinWait ahk_exe sublime_text.exe
    }
    WinActivate ahk_exe sublime_text.exe
    return
}

;------------------------------------------------
; Disable faulty double middle click
; as per here: http://leo.steamr.com/2012/08/fixing-mouse-buttonwheel-from-unintended-double-clicking/
; Explanation: my Madcatz RAT 9 mouse has a faulty middle buttton
; which if pressed once it actually can register 1, none, or even 20 clicks.
; Kinda annoying yea.

; ; This fixes the problem.
; MButton::
;     If (A_TimeSincePriorHotkey < 190 && A_TimeSincePriorHotkey > 1) {
;       ;  MsgBox % A_TimeSincePriorHotkey
;         Return
;     }
;     Send {MButton Down}
;     KeyWait, MButton
;     Send {MButton Up}
; Return


;----------------------------------------------
; caps lock + space => always on top
CapsLock & SPACE::  Winset, Alwaysontop, , A


;----------------------------------------------
; caps lock + 1 => sleep screen
CapsLock & 1::
Sleep 200 ; if you use this with a hotkey, not sleeping will make it so your keyboard input wakes up the monitor immediately
SendMessage 0x112, 0xF170, 2,,Program Manager ; send the monitor into off mode
; unsure why, but sending the second message makes f.lux activate correctly when screen wakes up. otherwise i have to alt-tab for f.lux to work properly
Sleep 2
SendMessage 0x112, 0xF170, 2,,Program Manager
return
