#Include _JXON.ahk
#SingleInstance


/*

# Technical

## Tooltip creation/movement

- tooltip is new and was not shown before
- tooltip exists and was already shown
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

    CurrentText := -1
    DurationMs := -1
    ToolTipHeight := -1
    Hwnd := -1
    TimeEnd := -1

    LastText := -1
    extraOffsetY := -1
    YOffset := -1

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
        MouseGetPos(&mouseX, &mouseY)

        x := mouseX
        y := mouseY

        for k,tt in this.Tooltips
        {
            ; tooltip has expired and must be removed
            if(tt.IsExpired())
            {
                this.OnTooltipExpired(k)
                continue
            }

            x := x + 30*k
            y := y + 10*k

            if(!tt.IsAlreadyShown())
            {
                Tooltip( k .  dbg(tt), x, y, k)
                tt.Hwnd := WinExist("ahk_class tooltips_class32 ahk_pid " DllCall("GetCurrentProcessId"))
                WinGetPos(,, &w, &h, "ahk_id " tt.Hwnd)
                tt.ToolTipHeight := h
            }
            else
            {
                WinMove(x, y,,, tt.Hwnd)
            }
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
    Tippy("AAAAAAAAAAAAAAAAAA" , 1234, 16)
    Tippy("curr 2 " A_Now, 4567, 10)
}

Tippy(text := "", durationMs := 3333, whichTooltip := 1) {
;    if(whichTooltip == -1)
;    {
;        whichTooltip := _tt.GetUnusedToolTip(text)
;    }

    T(text, durationMs, whichTooltip)
}
