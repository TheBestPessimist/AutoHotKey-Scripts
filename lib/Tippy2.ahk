#Include _JXON.ahk
#SingleInstance


class T
{
    static Tooltips := Map()

    static TheLoopFunc := T.TheLoop.Bind(this)

    CurrentText := -1
    DurationMs := -1
    WhichToolTip := -1
    ToolTipHeight := -1
    Hwnd := -1
    TimeStart := -1
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
        this.WhichTooltip := whichTooltip
        this.TimeStart := A_TickCount
        this.TimeEnd := A_TickCount + DurationMs

        T.Tooltips[WhichTooltip] := this
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

        /*
        Cases
        - tooltip is new and was not shown before ✅
        - tooltip exists and was already shown ✅
        - tooltip exists and was already shown, but has changed text
        - tooltip has expired and must not be shown anymore ✅
        */



        for k,tt in T.Tooltips
        {
            ; tooltip has expired and must be removed
            if(tt.IsExpired())
            {
                T.OnTooltipExpired(k)
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

        T.StopLoopIfNeeded()
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
        T.Tooltips.Delete(whichToolTip)
    }

    static StartLoop()
    {
        SetTimer(T.TheLoopFunc, 10)
    }

    static StopLoopIfNeeded()
    {
        if(T.Tooltips.Count < 1)
            SetTimer(T.TheLoopFunc, 0)
    }

    /*
    Technical: ToString is not needed because i'm using a JSON library to dump everything to string
    */
}




dbg(obj)
{
    return JxonEncode(obj, 1)
}

^j::
{
    Tippy("AAAAAAAAAAAAAAAAAA", 1234, 16)
    Tippy("curr 2", 4567, 10)
}

Tippy(text := "", durationMs := 3333, whichTooltip := 1) {
;    if(whichTooltip == -1)
;    {
;        whichTooltip := _tt.GetUnusedToolTip(text)
;    }

    T(text, durationMs, whichTooltip)
}
