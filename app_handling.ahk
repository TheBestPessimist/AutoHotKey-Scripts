#Include WinTitles.ahk
#include lib/clipboard.ahk


#HotIf WinActive("ahk_class SDL_app")
j::Space
k::PgUp
#HotIf



;-------------------------------------------------
;       CapsLock sublime text
CapsLock & s:: {
    Try {
        pid := WinGetPID(WinTitles.SublimeText)
    } Catch {
        pid := 0
    }

    if (!pid) {
        Run("D:\all\all\Sublime Text\sublime_text.exe",, "Max", &pid)
        WinWait("ahk_pid " pid)
    }
    WinActivate("ahk_pid " pid)
}



;-------------------------------------------------
;       CapsLock Telegram
;
; it seems that i cannot open telegram window when it is in task bar, so
; i just chose to reopen it every time. telegram is single instance, so all
; looks good so far :^)
;
; Send is used so that i select the first chat :^)
;
CapsLock & t:: {
    if !WinExist(WinTitles.Telegram) {
        Run("D:\all\all\Telegram\Telegram.exe")
        WinWait(WinTitles.Telegram, , 10)
        Sleep 499
        WinActivate(WinTitles.Telegram)
        ; select the most important chat
        Sleep 499
        Send("{PgDn}")
        Sleep 90
        Send("{PgUp}")
        Sleep 90
        Send("{PgUp}")
        Sleep 90
        Send("{PgUp}")
        Sleep 90
        Send("{Enter}")
        Sleep 499

        ; ; move the window to its proper position
        ; NOTE: THIS DOES NOT WORK. SOMETIMES TELEGRAM JUST WONT FUCKING RESIZE.
        ;                   RUUUUUUDE!
        getTaskbarDimensions(&tw, &th)
        w := A_ScreenWidth/2.5
        h := A_ScreenHeight - th
        x := A_ScreenWidth - w
        y := 0
        WinMove(x, y, w, h, WinTitles.Telegram)
    }
    else {
        WinActivate(WinTitles.Telegram)
    }
}

;-------------------------------------------------
; get taskbar dimensions, assuming bottom position
getTaskbarDimensions(&tw, &th) {
    WinGetPos(,, &tw, &th, "ahk_class Shell_TrayWnd")
}



;-------------------------------------------------
; Sublime Text: CapsLock & w to toggle word wrap
#HotIf WinActive(WinTitles.SublimeText)
CapsLock & w:: {
    Send "^+P"
    Sleep 500
    Send "wwp"
    Sleep 1500
    Send "{Enter}"
}
#HotIf


;-------------------------------------------------
; Intellij Idea: CapsLock & w to toggle word wrap
#HotIf WinActive(WinTitles.IntellijIdea)
CapsLock & w:: {
    Send "^+A"
    Sleep 500
    Send "active editor soft wrap"
    Sleep 500
    Send "{Enter}"
    Sleep 500
    Send "{Esc}"
}
#HotIf



;
; TODO
;;-------------------------------------------------
;; hide the TeamViewer message for sponsored session
;; and also close the TeamViewer window afterwards
;hideTeamviewerSponsoredSession() {
;    if WinExist(WinTitles.TeamViewerSponsoredSession) {
;        SetControlDelay 0
;        ControlClick, OK
;
;        ; Looping a few times here, because TeamViewer sometimes shows multiple windows after dismissing the first
;       loop, 5
;       {
;            ; It seems that simply Winclose, WinTitles.TeamViewer doesnt work.
;            ; I have to actually search for the window and then WinClose the automatically filled variable.
;            ; Weird...
;            if WinExist(WinTitles.TeamViewer)
;            {
;                WinClose
;            }
;            Sleep, 300
;        }
;
;    }
;}



;-------------------------------------------------
; use just F4 to close some windows
#HotIf false
    || WinActive(WinTitles.Telegram)
    ; || WinActive(ahk_chrome)
    ; || WinActive(ahk_firefox)
    || WinActive(WinTitles.Vlc)
    || WinActive(WinTitles.ModernPhotos*)
    || WinActive(WinTitles.ModernMediaPlayer*)
    || WinActive(WinTitles.ModernSkype*)
    || WinActive(WinTitles.ModernDolbyAccess*)
    || WinActive(WinTitles.TeamViewer)
    || WinActive(WinTitles.CorsairCUE)
    || WinActive(WinTitles.Skype)
    || WinActive(WinTitles.BattleNet)
    || WinActive(WinTitles.ACDSee)
    || WinActive(WinTitles.ArmouryCrate)
F4::Send "!{F4}"
#HotIf



;-------------------------------------------------
; disable Home/End in AcdSee
#HotIf WinActive(WinTitles.ACDSee)
Home::Return
End::Return
Ctrl & Home::Home
Ctrl & End::End
#HotIf

;-----------------------
;  Open an url in MPV
CapsLock & v:: {
    saveClipboard()

    Send "^l"
    Sleep 100
    Send "^a"
    Sleep 100
    Send "^c"
    ClipWait 1

    Tippy("Opening mpv with: " A_Clipboard)
    Run("D:\all\all\mpv.net\mpvnet.exe " A_Clipboard)

   restoreClipboard()
}



;-----------------------
; Microshitsoft Teams is fucking retarded
;
; Replace "Fancy Paste" with Plain text Copy-Pasta
#HotIf WinActive(WinTitles.Feces)
^V:: {
    if DllCall("IsClipboardFormatAvailable", "uint", 1)
        Send "^+v"
    else
        Send "^v"
}
#HotIf


; TODO: add a HOTIF for vivaldi instead of doing this blindly for every app
;-------------------------------------------------
;   Fix Vivaldi Gestures
;
; The problem with Vivaldi is that on "3 finger swipe" left and right touchpad gestures,
;   Vivaldi executes the Browser_Forward and Browser_Back actions both on key up and on key down.
;   Therefore the solution is simple: don't send key down events to Vivaldi

; Browser_Back via 3 finger swipe to right
sc16A::Return
sc16A Up::Send "!{Left}" ; This sends Alt+Left
sc06A::Return
sc06A Up::Send "!{Left}" ; This sends Alt+Left

; Browser_Forward via 3 finger swipe to left
sc069::Return
sc069 Up::Send "!{Right}" ; This sends Alt+Right


/*
For the love of god, i can't understand why they don't allow me to use just my keyboard to play the game.
WTF folks?
*/
#HotIf WinActive(WinTitles.BeatSlayer)
J::Send "{LButton}"
K::Send "{RButton}"
#HotIf


#HotIf WinActive(WinTitles.Obsidian)
; task
::.ttt:: {
    Send("{Home} - [ ] ttt {end}  ➕ " date() " {left 14}")
}

; Ctrl ] - Indent
!]::Tab

; Ctrl [ - Unindent
![::Send "{Shift Down}{Tab}{Shift Up}"

; Link to a local folder or file
::.file:: {
    Send("[title](<file:///paste_link_here>)")
}
#HotIf



/*
Why a KeyDelay for Slack? Because Slack has dogshit slow garbage performance.

If i use normal hotstring replacement for text which has any markup (italic, bold, inline code, etc.), Slack trashes everything ahk types and also losses characters.
Instead, I have to use SendEvent, which respects key delay.

I swear to fucking god, all the JavaScript world is pure fucking garbage.
*/
if(WinActive("ahk_exe slack.exe")) {
    SetKeyDelay 150
}

;------------------------------------------------
; Run Windows Terminal
#t::
{
    Run("wt.exe  --title `"Windows FUCKING Terminal :^)`" ")
    windowsFuckingTerminalWindow := "Windows FUCKING Terminal ahk_class CASCADIA_HOSTING_WINDOW_CLASS ahk_exe WindowsTerminal.exe"

    WinWait(windowsFuckingTerminalWindow, , 5)
    WinActivate(windowsFuckingTerminalWindow)
}


;------------------------------------------------
; Flow Launcher should replaces Windows key, but that is not possible while also keeping AltSnap working
;~LWin & ~LControl:: ; for some reason this ordering of keys interferes with Precision touchpad "3 finger tap = Middle click" 🙄. Why is Microshitsoft sending all modifier keys before middle click? WTF ?!?!?!!?!?
;LControl & LWin Up:: ; this one seems to work, but sometimes it opens FL Flow Launcher without focus, so typing does nothing.
; In the end, using CapsLock is the best decision.
CapsLock & LWin Up::
{
    resetCapsLockState()
    ; see https://github.com/seerge/g-helper/issues/512: need this to disable touchpad
    if(A_PriorKey = "F24") ; in my 2 in 1 laptop, when rotating the screen into tabled only mode, GHelper sends the keys LCtrl Down, LWin Down, F24 Down, then up, which activates this hotkey
        return
    if(!ProcessExist(Process.FlowLauncher)) {
        Tippy("It's dead, Jim")
        Run(Paths.FlowLauncher)
        Sleep 2500
    }

    ; if Start menu is open, turn it off
    if(WinActive("ahk_class Windows.UI.Core.CoreWindow")) {
        Send "{Esc}"
        Sleep 500
    }
    ; F23 was set by editing the FL configuration file manually in `FL/UserData/Settings/Settings.json`
    Send "{F23}"
}

;------------------------------------------------
; Launch Voidtools Everything
$#s::Send "#^!+{F12}"


;$q::Send "1q"
;$w::Send "1w"
;$e::Send "1e"
;$r::Send "1r"
;$g::Send "1g"
