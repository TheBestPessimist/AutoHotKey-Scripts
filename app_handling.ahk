#Include WinTitles.ahk
#include lib/clipboard.ahk


;-------------------------------------------------
;       CapsLock Telegram
;
; it seems that i cannot open telegram window when it is in task bar, so
; i just chose to reopen it every time. telegram is single instance, so all
; looks good so far :^)
;
; SendInput is used so that i select the first chat :^)
;
CapsLock & t::
startAndResizeTelegram()
{
    if !WinExist(WinTitles.Telegram) {
        Run "D:\all\all\Telegram\Telegram.exe"
        Winwait % WinTitles.Telegram
        Sleep 499
        WinActivate % WinTitles.Telegram
        ; select the most important chat
        Sleep 499
        SendInput {PgDn}
        Sleep 90
        SendInput {PgUp}
        Sleep 90
        SendInput {PgUp}
        Sleep 90
        SendInput {PgUp}
        Sleep 90
        SendInput {Enter}
        Sleep 499

        ; ; move the window to its proper position
        ; NOTE: THIS DOES NOT WORK. SOMETIMES TELEGRAM JUST WONT FUCKING RESIZE.
        ;                   RUUUUUUDE!
        getTaskbarDimensions(tw, th)
        w := A_ScreenWidth/2.5
        h := A_ScreenHeight - th
        x := A_ScreenWidth - w
        y := 0
        WinMove, % WinTitles.Telegram, , x, y, w, h
    }
    else {
        WinActivate % WinTitles.Telegram
    }
}





;-------------------------------------------------
; get taskbar dimensions, assuming bottom position
getTaskbarDimensions(ByRef tw, ByRef th) {
    WinGetPos, x, y, tw, th, ahk_class Shell_TrayWnd
}
