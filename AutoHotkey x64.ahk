;-------------------------------------------------
; i use this to capture the keyboard keystrokes (it does not work for FN + sth on SUSV)
;
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
;
; SendInput is used so that i select the first chat :^)
;
CapsLock & t::
{
    telegram = ahk_exe telegram.exe
    IfWinNotExist, %telegram%
    {
        Run "C:\d3rp\PortableApps\Telegram\Telegram.exe"
        Winwait %telegram%
        WinActivate %telegram%
        Sleep 9
        SendInput {PgUp} + {Enter}
    }
    else
    {
        WinActivate
    }
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
Sleep 20
SendMessage 0x112, 0xF170, 2,,Program Manager
return
