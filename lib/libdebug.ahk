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
    Tippy("Mouse Pos: " x " x " y, , 19)

    SysGet, virtualScreenWidth, 78
    SysGet, virtualScreenHeight, 79
    Tippy("Screen Size: " virtualScreenWidth " x " virtualScreenHeight,, 18)
}
