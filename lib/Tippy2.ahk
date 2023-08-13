#Include _JXON.ahk
#SingleInstance


class T
{
    static Tooltips := Map()

    static ShowTooltipsFunc := T.LoopDisplayTooltips.Bind(this)

    CurrentText := -1
    Duration := -1
    WhichToolTip := -1
    ToolTipHeight := 0

    LastText := -1
    extraOffsetY := -1
    YOffset := -1
    Hwnd := -1

    __New(
        CurrentText,
        Duration,
        WhichTooltip
    ) {
        this.CurrentText := CurrentText
        this.Duration := Duration
        this.WhichTooltip := WhichTooltip
    }

    static LoopDisplayTooltips()
    {
        Critical
        SetWinDelay -1

        CoordMode("Mouse", "Screen")
        MouseGetPos(&mouseX, &mouseY)

        x := mouseX
        y := mouseY

        /*
        Cases
        - tooltip is new and was not shown before
        - tooltip exists and was already shown
        - tooltip exists and was already shown, but has changed text
        - tooltip has expired and must not be shown anymore
        */



        for k,tt in T.tooltips
        {
            x := x + 30*k
            y := y + 10*k

            if(!tt.AlreadyShown())
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
    }

    AlreadyShown()
    {
        return (this.Hwnd != -1)
    }


    static StartLoop()
    {
        SetTimer(T.ShowTooltipsFunc, 1)

       ; TODO: use A_Tick count to set the time after which this tooltip should be off.
       ; in this way i dont have to store start and stop functions for each tooltip
    }

    static StopLoop()
    {
        SetTimer(T.ShowTooltipsFunc, 0)
    }

    /*
    Technical: ToString is not needed because i'm using a JSON library to dump everything to string
    */
}



t1 := T("curr 1", 123, 16)
t2 := T("curr 2", 456, 10)

t.tooltips[16] := t1
t.tooltips[10] := t2
;msgbox dbg(T)

t1.CurrentText := "AAAAAAAAAAAAAAAAAA"
;msgbox dbg(T)


dbg(obj)
{
    return JxonEncode(obj, 1)
}

^j::T.StartLoop()
^k::T.StopLoop()
