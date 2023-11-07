#include <Tippy>
#Include _JXON.ahk

dbg(obj)
{
    return JxonEncode(obj, 1)
}

;------------------------------------------------
; CapsLock + /: Toggle Mouse debugging mode
CapsLock & /:: {
    static toggle := 0
    MouseDebugging()
    Tippy(dbg(GetAllMonitorsDimensions()), 1000000)
    SetTimer(MouseDebugging, (toggle := !toggle) ? 500 : 0)
}

MouseDebugging() {
    MouseGetPos(&X, &Y)
    Tippy("Mouse Pos: " x " x " y " (global)",, 18)

    VirtualScreenWidth := SysGet(78)
    VirtualScreenHeight := SysGet(79)
    Tippy("Screen Size: " VirtualScreenWidth " x " VirtualScreenHeight,, 19)


    m := GetAllMonitorsDimensions()
    Tippy(dbg(m),, 20)
      for k, v in m {
            if (X >= v.Left && X <= v.Right && Y >= v.Bottom && Y <= v.Top) {
                return {x: X - v.Left, y: Y - v.Top}
            }
        }
}

GetMouseCoordinatesInLocalScreen() {
    MouseGetPos(&X, &Y)
    m := GetAllMonitorsDimensions()

      for k, v in m {
            if (X >= v.Left && X <= v.Right && Y >= v.Bottom && Y <= v.Top) {
                return {x: X - v.Left, y: Y - v.Top}
            }
        }
}

class LocalScreenMouseCoords {
    x := ""
    y := ""

}

MouseDebuggingOld() {
    CoordMode("Mouse", "Screen")
    MouseGetPos(&X, &Y)
    Tippy("Mouse Pos: " x " x " y " (global)", , 19)

    VirtualScreenWidth := SysGet(78)
    VirtualScreenHeight := SysGet(79)
    Tippy("Screen Size: " VirtualScreenWidth " x " VirtualScreenHeight,, 18)

    localPos := GetLocalMonitorMouseCoords()
    try {
        Tippy("Mouse Pos: " localPos.x " x " localPos.y " (local)",, 20)
    }
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

            if (L > R) {
                tmp := L
                L := R
                R := tmp
            }

            if (B > T) {
                tmp := B
                B := T
                T := tmp
            }

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
