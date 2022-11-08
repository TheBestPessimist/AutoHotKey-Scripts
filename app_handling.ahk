﻿#Include WinTitles.ahk
#include lib/clipboard.ahk


; There is no need for a standard ahk auto-execute area anymore because of this method.
; This method is called automatically when the static variable autoExecute is instantiated,
; and since it's a static, it will only be instantiated once!
;
; Idea provided by @nnnik#6686 on the AHK Discord Server: https://discord.gg/s3Fqygv
AppHandlingAutoExecute()
{
    static autoExecute := AppHandlingAutoExecute()

    SetTimer, hideTeamviewerSponsoredSession, 5000

    ; 2018.09.07: no need for this as sublime text is licensed now!
    ; SetTimer, hideSublimeRegister, 1000
}

#If WinActive("ahk_class SDL_app")
j::Space
k::PgUp
#If



;-------------------------------------------------
;       CapsLock sublime text
CapsLock & s::
runSublimeText(){
    if !WinExist(WinTitles.SublimeText) {
      Run "D:\all\all\Sublime Text\sublime_text.exe"
      WinWait % WinTitles.SublimeText
    }
    Sleep 499
    WinActivate % WinTitles.SublimeText
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
#If WinActive(WinTitles.SublimeText)
CapsLock & w::
    SendInput ^+P
    Sleep 500
    SendInput wwp
    Sleep 1500
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
;     sublime_window := WinExist("This is an unregistered copy " . WinTitles.SublimeText)
;     if (sublime_window) {
;         WinActivate
;         SendInput {Esc}
;     }
; }



;-------------------------------------------------
; hide the TeamViewer message for sponsored session
; and also close the TeamViewer window afterwards
hideTeamviewerSponsoredSession() {
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
    || WinActive(WinTitles.Telegram)
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



;-------------------------------------------------
; disable Home/End in AcdSee
#If  WinActive(WinTitles.ACDSee)
Home::Return
End::Return
Ctrl & Home::Home
Ctrl & End::End
#If

; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------
; ------------------------------------------------


; #If WinActive(WinTitles.tf2)
; ;-------------------------------------------------
; ; tf2: press reload and autoclick
; CapsLock & R::
;     ; CallMethodWithTimer("pressR", 500)
;     CallMethodWithTimer("clickLMouse", 50)

; Return

; ; ; stop autoclicking (for example if scoped -> stop scope and autoclicking)
; ; ~RButton::
; ;     if (WinActive(WinTitles.tf2)
; ;         && IsToggleOn("pressR")
; ;         && IsToggleOn("clickLMouse")) {
; ;             CallMethodWithTimer("pressR", 1)
; ;             CallMethodWithTimer("clickLMouse", 1)
; ;     }

; Return
; #If

; ; pressR() {
; ;      if (WinActive(WinTitles.tf2)) {
; ;         SendInput {r}
; ;     }
; ; }

; clickLMouse(){
;      if (WinActive(WinTitles.tf2)) {
;         SendInput {LButton}
;     }
; }


CapsLock & v::
    openInMpv() {
        saveClipboard()

        Send ^l
        Sleep 100
        Send ^a
        Sleep 100
        Send ^c
        ClipWait 1

        Tippy("Opening mpv with: " Clipboard)
        Run % "D:\all\all\mpv.net\mpvnet.exe " Clipboard

       restoreClipboard()
    }



;-----------------------
; Microshitsoft Teams is fucking retarded
;
; Replace "Fancy Paste" with Plain text Copy-Pasta
#If WinActive(WinTitles.MsTeams)
^V::
disableFancyPasteOnText(){
    if DllCall("IsClipboardFormatAvailable", "uint", 1)
    {
        Send ^+v
    }
    else
    {
        Send ^v
    }
}
#If


;-------------------------------------------------
;   Fix Vivaldi Gestures
;
; The problem with Vivaldi is that on "3 finger swipe" left and right touchpad gestures,
;   Vivaldi executes the Browser_Forward and Browser_Back actions both on key up and on key down.
;   Therefore the solution is simple: don't send key down events to Vivaldi

; Browser_Back via 3 finger swipe to right
sc16A::Return
sc16A Up::SendInput !{Left} ; This sends Alt+Left
sc06A::Return
sc06A Up::SendInput !{Left} ; This sends Alt+Left

; Browser_Forward via 3 finger swipe to left
sc069::Return
sc069 Up::SendInput !{Right} ; This sends Alt+Right
