#NoEnv
#SingleInstance, force
#MaxHotkeysPerInterval 200

; ================================================
; show a tooltip with the coordinates of the mouse
; and some more info about the current window
; SetTimer, WatchCursor, 1000
; return

CapsLock & /::
    timer := 20

    global WatchCursorToggle := !WatchCursorToggle
    if(WatchCursorToggle) {
        SetTimer WatchCursor, % timer
    } else {
        SetTimer, WatchCursor, Off
        ToolTip,
    }
Return

WatchCursor()
{
    MouseGetPos, x, y, id
    WinGetTitle, title, ahk_id %id%
    WinGetClass, class, ahk_id %id%
    ; ToolTip, % "x: " x "`ny: " y "`nahk_id: " id "`nahk_class: " class "`ntitle: " title
    ToolTip, % A_ThisHotkey " " A_PriorHotkey
}


