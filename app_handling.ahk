﻿#Include WinTitles.ahk



;-------------------------------------------------
;       CapsLock sublime text
CapsLock & s::
runSublimeText(){
    if !WinExist(ahk_sublime) {
      Run "C:\all\Sublime Text 3\sublime_text.exe"
      WinWait % ahk_sublime
    }
    Sleep 499
    WinActivate % ahk_sublime
}



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
    if !WinExist(ahk_telegram) {
        Run "C:\all\Telegram\Telegram.exe"
        Winwait % ahk_telegram
        Sleep 499
        WinActivate % ahk_telegram
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
        w := A_ScreenWidth/3
        h := A_ScreenHeight - th
        x := A_ScreenWidth - w
        y := 0
        WinMove, % ahk_telegram, , x, y, w, h



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
        WinActivate % ahk_telegram
    }
}



; ------------------------------------------------
; Firefox and Chrome: mouse-scroll over the "tab area" to switch tabs forward and backward, instead of clicking/using
; ctrl+tab or ctrl+shift+tab
;
; ; "~"" is  used so that i can scroll in the normal page
; #If WinActive(ahk_firefox) || WinActive(ahk_chrome)
; ~WheelUp::
;     MouseGetPos, , y
;     if (y > -1 && y <= 40) {
;         Send ^+{Tab}
;     }
; Return

; ~WheelDown::
;     MouseGetPos, , y
;     if (y > -1 && y <= 40) {
;         Send ^{Tab}
;     }
; Return
; #If



;-------------------------------------------------
; get taskbar dimensions, assuming bottom position
getTaskbarDimensions(ByRef tw, ByRef th) {
    WinGetPos, x, y, tw, th, ahk_class Shell_TrayWnd
}




;-------------------------------------------------
; Sublime Text: CapsLock & w to toggle word wrap
#If WinActive(ahk_sublime)
CapsLock & w::
    SendInput ^+P
    Sleep 500
    SendInput wwp
    Sleep 500
    SendInput {Enter}
Return
#If


;-------------------------------------------------
; Intellij Idea/goland: CapsLock & w to toggle word wrap
#If WinActive(WinTitles.IntellijIdea) || WinActive(WinTitles.Goland)
CapsLock & w::
    SendInput ^+A
    Sleep 500
    SendInput active editor soft wrap
    Sleep 500
    SendInput {Enter}
    Sleep 500
    SendInput {Esc}
Return
#If


;-------------------------------------------------
; 2018.09.07: no need for this as sublime text is licensed now!
; hide the Sublime Text message for unregistered copy
; #IfWinExist This is an unregistered copy ahk_exe sublime_text.exe
; hideSublimeRegister() {
;     sublime_window := WinExist("This is an unregistered copy " . ahk_sublime)
;     if (sublime_window) {
;         WinActivate
;         SendInput {Esc}
;     }
; }



;-------------------------------------------------
; hide the TeamViewer message for sponsored session
; and also close the TeamViewer window afterwards
hideTeamviewerSponsoredsession() {
    if WinExist(WinTitles.TeamViewerSponsoredSession) {
        SetControlDelay 0
        ControlClick, OK

        ; Looping a few times here, because TeamViewer sometimes shows multiple windows after dismissing the first
       loop, 5
       {
            ; It seems that simply Winclose, WinTitles.TeamViewer doesnt work.
            ; I have to actually search for the window and then WinClose the automatically filled variable.
            ; Weird...
            if WinExist(WinTitles.TeamViewer)
            {
                WinClose
            }
            Sleep, 300
        }

    }
}



;-------------------------------------------------
; use just F4 to close some windows
#If false
    || WinActive(ahk_telegram)
    ; || WinActive(ahk_chrome)
    ; || WinActive(ahk_firefox)
    || WinActive(WinTitles.Vlc)
    || WinActive(WinTitles.ModernPhotos*)
    || WinActive(WinTitles.ModernSkype*)
    || WinActive(WinTitles.TeamViewer)
    || WinActive(WinTitles.CorsairCUE)
    || WinActive(WinTitles.Skype)
    || WinActive(WinTitles.BattleNet)
    || WinActive(WinTitles.ACDSee)
F4:: SendInput !{F4}
#If



; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------


; #If WinActive(ahk_tf2)
; ;-------------------------------------------------
; ; tf2: press reload and autoclick
; CapsLock & R::
;     CallMethodWithTimer("pressR", 500)
;     CallMethodWithTimer("clickLMouse", 50)
;
; Return
;
; ; stop autoclicking (for example if scoped -> stop scope and autoclicking)
; ~RButton::
;     if (WinActive(ahk_tf2)
;         && IsToggleOn("pressR")
;         && IsToggleOn("clickLMouse")) {
;             CallMethodWithTimer("pressR", 1)
;             CallMethodWithTimer("clickLMouse", 1)
;     }
;
; Return
; #If
;
; pressR() {
;      if (WinActive(ahk_tf2)) {
;         SendInput {r}
;     }
; }
;
; clickLMouse(){
;      if (WinActive(ahk_tf2)) {
;         SendInput {LButton}
;     }
; }


CapsLock & v::
    openInMpv() {
        ClipSaved := ClipboardAll   ; Backup Clipboard
        clipboard := ""

        Send ^l
        Sleep 100
        Send ^a
        Sleep 100
        Send ^c
        ClipWait 1

        Tippy("Opening mpv with: " Clipboard)
        Run % "mpvnet.exe " Clipboard

        Clipboard := ClipSaved   ; Restore Clipboard
    }
