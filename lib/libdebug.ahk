#include <Tippy>


;------------------------------------------------
; CapsLock + /: Toggle Mouse debugging mode
CapsLock & /::ToggleMouseDebugging()

ToggleMouseDebugging()
{
    static toggle
    MouseDebugging()
    SetTimer MouseDebugging, % (toggle := !toggle) ? 500 : "Off"
}

MouseDebugging() {
    CoordMode, Mouse, Screen
    MouseGetPos, x, y
    Tippy("Mouse Pos: " x " x " y " (global)", , 19)

    SysGet, virtualScreenWidth, 78
    SysGet, virtualScreenHeight, 79
    Tippy("Screen Size: " virtualScreenWidth " x " virtualScreenHeight,, 18)

    localPos := __GetLocalMonitorMouseCoords()
    Tippy("Mouse Pos: " localPos.x " x " localPos.y " (local)",, 20)

}

__GetAllMonitorsDimensions() {
    static monitorCount
    static monitors

    SysGet, newMonitorCount, MonitorCount
    if (monitorCount != newMonitorCount)
    {
        monitorCount := newMonitorCount

        monitors := []
        loop, % MonitorCount
        {
            SysGet, BoundingBox, Monitor, % A_Index
            monitors.Push({"Top": BoundingBoxTop, "Bottom": BoundingBoxBottom, "Left": BoundingBoxLeft, "Right": BoundingBoxRight})
        }
    }
    return monitors
}


__GetLocalMonitorMouseCoords() {
    monitors := __GetAllMonitorsDimensions()

    CoordMode, Mouse, Screen
    MouseGetPos, X, Y

    for k, v in monitors {
        if (X >= v.Left && X <= v.Right && Y <= v.Bottom && Y >= v.Top) {
            return {"x": X - v.Left, "y": Y - v.Top}
        }
    }
}
