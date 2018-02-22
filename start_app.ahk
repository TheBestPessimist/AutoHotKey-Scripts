#NoEnv
#SingleInstance, force

;-------------------------------------------------
;       Capslock sublime text
CapsLock & s::
    subl := "ahk_exe sublime_text.exe"
    IfWinNotExist % subl
    {
      Run "C:\d3rp\Sublime Text 3\sublime_text.exe"
      WinWait % subl
    }
    WinActivate % subl
Return



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
    telegram := "ahk_exe telegram.exe"
    IfWinNotExist % telegram
    {
        Run "C:\d3rp\PortableApps\Telegram\Telegram.exe"
        Winwait % telegram
        WinActivate % telegram
        Sleep 9
        SendInput {PgUp} + {Enter}
    }
    else
    {
        WinActivate
    }
Return

