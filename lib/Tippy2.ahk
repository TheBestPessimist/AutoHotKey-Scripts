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

            if(!tt.IsAlreadyShown())
            {
                Tooltip( k .  dbg(tt) " " currentTooltipsHeights, x, y, k)
                tt.Hwnd := WinExist("ahk_class tooltips_class32 ahk_pid " DllCall("GetCurrentProcessId"))
                WinGetPos(,, &w, &h, "ahk_id " tt.Hwnd)
                tt.Height := h
            }
            else
            {
                WinMove(x, y,,, tt.Hwnd)
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




dbg(obj)
{
    return JxonEncode(obj, 1)
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
