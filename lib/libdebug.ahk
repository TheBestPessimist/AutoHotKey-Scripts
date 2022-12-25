#include <Tippy>


;------------------------------------------------
; CapsLock + /: Toggle Mouse debugging mode
CapsLock & /:: {
    static toggle := 0
    MouseDebugging()
    SetTimer(MouseDebugging, (toggle := !toggle) ? 500 : 0)
}

MouseDebugging() {
    CoordMode("Mouse", "Screen")
    MouseGetPos(&X, &Y)
    Tippy("Mouse Pos: " x " x " y " (global)", , 19)

    VirtualScreenWidth := SysGet(78)
    VirtualScreenHeight := SysGet(79)
    Tippy("Screen Size: " VirtualScreenWidth " x " VirtualScreenHeight,, 18)

    localPos := GetLocalMonitorMouseCoords()
    Tippy("Mouse Pos: " localPos.x " x " localPos.y " (local)",, 20)

}

GetAllMonitorsDimensions() {
    static monitorCount := 0
    static screens := 0

    newMonitorCount := MonitorGetCount()
    if (monitorCount != newMonitorCount) {
        monitorCount := newMonitorCount

        screens := []
        Loop MonitorCount {
            MonitorGet A_Index, &L, &T, &R, &B
            screens.Push({Top: T, Bottom: B, Left: L, Right: R})
        }
    }
    return screens
}


GetLocalMonitorMouseCoords() {
    monitors := GetAllMonitorsDimensions()

    CoordMode("Mouse", "Screen")
    MouseGetPos(&X, &Y)

    for k, v in monitors {
        if (X >= v.Left && X <= v.Right && Y <= v.Bottom && Y >= v.Top) {
            return {x: X - v.Left, y: Y - v.Top}
        }
    }
}
