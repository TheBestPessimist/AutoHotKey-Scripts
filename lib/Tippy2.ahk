#Include _JXON.ahk
#SingleInstance


/*

# Technical

## Tooltip creation/movement

- tooltip is new and was not shown before
- tooltip exists and is being shown
- tooltip has expired and must not be shown anymore

## ToString:

The function is not needed because i'm using a JSON library to dump everything to string when i need to debug things 🎉

Note regarding AHK class and static access weirdness:
- https://discord.com/channels/115993023636176902/1140576103694602241
- https://www.autohotkey.com/boards/viewtopic.php?f=82&t=120363
*/
class T
{
    static Tooltips := Map()

    static TheLoopFunc := T.TheLoop.Bind(this)

    static defaultOffsetFromCursor := 32

    CurrentText := -1
    DurationMs := -1
    Height := 0
    Hwnd := -1
    TimeEnd := -1

    __New(
        currentText,
        durationMs,
        whichTooltip
    ) {
        this.CurrentText := currentText
        this.DurationMs := durationMs
        this.TimeEnd := A_TickCount + DurationMs

        if(T.Tooltips.Has(whichTooltip))
            T.OnTooltipExpired(whichTooltip)

        T.Tooltips[whichTooltip] := this
        T.StartLoop()
    }

    static TheLoop()
    {
        Critical
        SetWinDelay 0

        CoordMode("Mouse", "Screen")
        CoordMode("ToolTip", "Screen")

        MouseGetPos(&mouseX, &mouseY)

        currentTooltipsHeights := 0

        for k, tt in this.Tooltips
        {
            ; tooltip has expired and must be removed
            if(tt.IsExpired())
            {
                this.OnTooltipExpired(k)
                continue
            }

            x := mouseX
            y := mouseY

            ; offset from cursor
            x += this.defaultOffsetFromCursor
            y += this.defaultOffsetFromCursor

            ; offset from the previous tooltip (tooltip above)
            y +=  currentTooltipsHeights

            ; if tooltip is at right side of screen
;TODO
            if(!tt.IsAlreadyShown())
            {
                Tooltip( k .  dbg(tt) " " currentTooltipsHeights, x, y, k)
                tt.Hwnd := WinExist("ahk_class tooltips_class32 ahk_pid " DllCall("GetCurrentProcessId"))
                WinGetPos(,, &w, &h, "ahk_id " tt.Hwnd)
                tt.Height := h
            }
            else
            {
                ; if a tooltip exists and is being shown then gets deleted in the constructor, this will throw an error. Swallow it
                try {
                    WinMove(x, y,,, tt.Hwnd)
                }
            }
            currentTooltipsHeights += tt.Height

            ; add a little gap from the previous tooltip
            currentTooltipsHeights += 2
        }

        this.StopLoopIfNeeded()
    }

    IsAlreadyShown()
    {
        return (this.Hwnd != -1)
    }

    IsExpired()
    {
        return this.TimeEnd < A_TickCount
    }

    static OnTooltipExpired(whichTooltip)
    {
        ToolTip(,,, whichToolTip)
        this.Tooltips.Delete(whichToolTip)
    }

    static StartLoop()
    {
        SetTimer(this.TheLoopFunc, 10)
    }

    static StopLoopIfNeeded()
    {
        if(this.Tooltips.Count < 1)
            SetTimer(this.TheLoopFunc, 0)
    }

}

;GetMouseCoordinates?????
GetLocalScreenMouseCoordsAndBounds() {
    screens := GetAllScreenCoordinates()

    CoordMode("Mouse", "Screen")
    MouseGetPos(&X, &Y)

    for s in screens {
        if (X >= s.Left && X <= s.Right && Y >= s.Bottom && Y <= s.Top) {
            return {x: X - s.Left, y: Y - s.Top, screenHeight: s.Bottom, screenWidth: s.Right}
        }
    }
}

GetAllScreenCoordinates() {
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





^j::
{
    Tippy("10 " A_Now, 1000000, 10)
    Tippy("16 " A_Now, 1000000, 16)
    Tippy(" 9 " A_Now, 1000000, 9)
}

Tippy(text := "", durationMs := 3333, whichTooltip := 1) {
;    if(whichTooltip == -1)
;    {
;        whichTooltip := _tt.GetUnusedToolTip(text)
;    }

    T(text, durationMs, whichTooltip)
}


^k::
{
MonitorCount := MonitorGetCount()
MonitorPrimary := MonitorGetPrimary()
MsgBox "Monitor Count:`t" MonitorCount "`nPrimary Monitor:`t" MonitorPrimary
Loop MonitorCount
{
    MonitorGet(1, &L, &T, &R, &B)
    MonitorGetWorkArea A_Index, &WL, &WT, &WR, &WB
    MsgBox
    (
        "Monitor:`t#" A_Index "
        Name:`t" MonitorGetName(A_Index) "
        Left:`t" L " (" WL " work)
        Top:`t" T " (" WT " work)
        Right:`t" R " (" WR " work)
        Bottom:`t" B " (" WB " work)"
    )
}
}



class BB
{
    static v := 6

    __New()
    {
        v := 1 ; ❌ assumes local variable, not the static
        this.v := 1 ; ❌ assumes instance variable, not the static
        BB.v := 1 ; ✅
        %this.__Class%.v :=1 ✅
    }

    showV()
    {
        Tooltip(v) ; ❌ Error: Warning: This variable appears to never be assigned a value.
        Tooltip(BB.v) ; ✅ this works
        Tooltip(this.V) ; ✅ this also works! 🎉
    }
}
