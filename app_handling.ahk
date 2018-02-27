#NoEnv
#SingleInstance, force

;-------------------------------------------------
;       Capslock sublime text
CapsLock & s::
    subl := "ahk_exe sublime_text.exe"
    if !WinExist(subl)
    {
      Run "C:\all\Portable Apps\Sublime Text 3\sublime_text.exe"
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
    if !WinExist(telegram)
    {
        Run "C:\all\Portable Apps\Telegram\Telegram.exe"
        Winwait % telegram
        WinActivate % telegram
        ; select the most important chat
        Sleep 90
        SendInput {PgDn}
        Sleep 90
        SendInput {PgUp}
        Sleep 90
        SendInput {PgUp}
        Sleep 90
        SendInput {PgUp}
        Sleep 90
        SendInput {Enter}
        ; move the window to its proper position
        getTaskbarDimensions(tw, th)
        w := A_ScreenWidth/3
        h := A_ScreenHeight - th - 1
        x := A_ScreenWidth - w
        y := 0
        WinMove % telegram, , x, y, w, h,
    }
    else
    {
        WinActivate % telegram
    }
Return


;-------------------------------------------------
; get taskbar dimensions, assuming bottom position
getTaskbarDimensions(ByRef tw, ByRef th) {
    WinGetPos x, y, tw, th, ahk_class Shell_TrayWnd,
}
