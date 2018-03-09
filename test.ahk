
;-------------------------------------------------
; show a mouse tooltip
;
CapsLock & /::
    CallMethodWithTimer("WatchCursor", 100)
Return



;-------------------------------------------------
; setup a timer for calling a method
CallMethodWithTimer(methodName, timer) {
    global allToggles

    toggle := !allToggles[methodName]
    allToggles[methodName] := toggle

    if (toggle) {
        SetTimer %methodName%, % timer
    } else {
        SetTimer %methodName%, Off
        ToolTip
    }
}

IsToggleOn(methodName){
    global allToggles

    return allToggles[methodName]
}


;-------------------------------------------------
; show a tooltip with some data
WatchCursor() {
    MouseGetPos, x, y, id
    WinGetTitle, title, ahk_id %id%
    WinGetClass, class, ahk_id %id%
    ToolTip % "x: " x "`ny: " y "`nahk_id: " id "`nahk_class: " class "`ntitle: " title
    ; ToolTip, % "A_ThisHotkey: " A_ThisHotkey "`n" "A_PriorHotkey: " A_PriorHotkey
}
