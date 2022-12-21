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



        ; another method of moving telegram to its desired position.
        ; this also bugges sometimes
        ; save initial mouse pos
        ; CoordMode Mouse, Screen
        ; MouseGetPos, initial_x, initial_y

        ; SetDefaultMouseSpeed 40
        ; CoordMode Mouse, Window

        ; ; move mouse to starting position of resize process
        ; MouseMove, 100, 16

        ; SendInput {LButton}
        ; SendInput {LButton}
        ; Sleep 90

        ; MouseMove, 100, 16


        ; ; do a windows right-snap (resize window to half the screen, right side)
        ; SendInput {LButton down}
        ; CoordMode Mouse, Screen         ;; this coordMode trickery has to be done for each movement.
        ; MouseMove, A_ScreenWidth, A_ScreenHeight/2
        ; CoordMode Mouse, Window
        ; SendInput {LButton up}


        ; Sleep 90

        ; ; set the desired window size
        ; MouseMove, -1, 200
        ; SendInput {LButton down}
        ; CoordMode Mouse, Screen
        ; MouseMove, A_ScreenWidth - A_ScreenWidth/3, 200
        ; CoordMode Mouse, Window
        ; SendInput {LButton up}

        ; ; ; de-snap the window, so that the size is remembered.
        ; ; ; windows is retarded and does not remember the size/position for snapped windows.
        ; ; MouseMove, 200, 16
        ; ; SendInput {LButton down}
        ; ; MouseMove, -10, 0,,R
        ; ; SendInput {LButton up}
        ; ; Sleep 90
        ; ; SendInput {LButton down}
        ; ; MouseMove, 10, 0,,R
        ; ; SendInput {LButton up}
        ; ; Sleep 90


        ; ; move the mouse back to the original position
        ; CoordMode Mouse, Screen
        ; MouseMove, initial_x, initial_y
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













CapsLock & v::
    openInMpv() {
        saveClipboard()

        Send {Blind}^l
        Sleep 100
        Send {Blind}^a
        Sleep 100
        Send {Blind}^c
        ClipWait 1

        Tippy("Opening mpv with: " Clipboard)
        Run % "D:\all\all\mpv.net\mpvnet.exe " Clipboard

       restoreClipboard()
    }
