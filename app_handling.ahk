;-------------------------------------------------
;       CapsLock sublime text
CapsLock & s::
    subl := "ahk_exe sublime_text.exe"
    if !WinExist(subl) {
      Run "C:\all\Portable Apps\Sublime Text 3\sublime_text.exe"
      WinWait % subl
    }
    WinActivate % subl
Return



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
    telegram := "ahk_exe telegram.exe"
    if !WinExist(telegram) {
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
        h := A_ScreenHeight - th
        x := A_ScreenWidth - w
        y := 0
        WinMove % telegram, , x, y, w, h,
    }
    else {
        WinActivate % telegram
    }
Return



; ------------------------------------------------
; Firefox and Chrome: mouse-scroll over the "tab area" to switch tabs forward and backward, instead of clicking/using
; ctrl+tab or ctrl+shift+tab
;
; "~"" is  used so that i can scroll in the normal page
#If WinActive("ahk_class MozillaWindowClass") || WinActive("ahk_class Chrome_WidgetWin_1")
~WheelUp::
    MouseGetPos, , y
    if(y <= 40) {
        Send ^+{Tab}
    }
    Return

~WheelDown::
    MouseGetPos, , y
    if(y <= 40) {
        Send ^{Tab}
    }
    Return
#If



;-------------------------------------------------
; get taskbar dimensions, assuming bottom position
getTaskbarDimensions(ByRef tw, ByRef th) {
    WinGetPos x, y, tw, th, ahk_class Shell_TrayWnd,
}




;-------------------------------------------------
; Sublime Text: CapsLock & w to toggle word wrap
#If WinActive("ahk_exe sublime_text.exe")
CapsLock & w::
    SendInput ^+P
    Sleep 10
    SendInput wwp{Enter}
Return
#If


;-------------------------------------------------
; hide the Sublime Text message for unregistered copy
; #IfWinExist This is an unregistered copy ahk_exe sublime_text.exe
hideSublimeRegister() {
    sublime_window := WinExist("This is an unregistered copy ahk_exe sublime_text.exe")
    If sublime_window {
        WinActivate
        SendInput {Esc}
    }
}



