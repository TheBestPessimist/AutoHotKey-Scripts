;-------------------------------------------------
; i use this to capture the keyboard keystrokes (it does not work for FN + sth on SUSV)
; #InstallKeybdHook
; #InstallMouseHook


DetectHiddenWindows, on


CapsLock & t::
{
;    subl = ahk_exe sublime_text.exe
;    IfWinNotExist, %subl%
;    {
;      Run "C:\d3rp\Sublime Text 3\sublime_text.exe"
;      WinWait %subl%
;    }
;    WinShow ahk_exe telegram.exe
;    WinActivate ahk_exe telegram.exe
;    return

telegram = ahk_exe telegram.exe
WinActivate, %telegram%
Return
}


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
    subl = ahk_exe sublime_text.exe
    IfWinNotExist, %subl%
    {
      Run "C:\d3rp\Sublime Text 3\sublime_text.exe"
      WinWait %subl%
    }
    WinActivate %subl%
    Return
}



;-------------------------------------------------
;       Capslock Telegram
;
; it seems that i cannot open telegram window when it is in task bar, so
; i just chose to reopen it every time. telegram is single instance, so all
; looks good so far :^)
CapsLock & t::
{
    Run "C:\d3rp\PortableApps\Telegram\Telegram.exe"
    Winwait ahk_exe telegram.exe
    WinActivate
    Return
}



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
