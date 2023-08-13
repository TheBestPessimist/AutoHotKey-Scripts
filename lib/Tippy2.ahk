#Include _JXON.ahk

class T
{
    static Tooltips := Map()
    static TooltipTimerHwnd := ""

    CurrentText := ""
    LastText := ""
    Duration := ""
    fnOff := ""
    WhichToolTip := ""
    extraOffsetY := ""
    Hwnd := ""
    ToolTipHeight := ""
    YOffset := ""

    __New(
        CurrentText,
        Duration
    ) {
        this.CurrentText := CurrentText
        this.Duration := Duration
    }

    LoopShowTooltips()
    {
        for k,v in T.tooltips
        {
            tooltip( k .  dbg(v), 10, 10, k)
        }
    }

    ShowTooltip()
    {
;        SetTimer(LoopShowTooltips, 10)

       ; TODO: use A_Tick count to set the time after which this tooltip should be off.
       ; in this way i dont have to store start and stop functions for each tooltip
    }


    /*
    Technical: ToString is not needed because i'm using a JSON library to dump everything to string
    */
}



t1 := T("curr 1", 123)
t2 := T("curr 2", 456)

t.tooltips[16] := t1
t.tooltips[10] := t2

;msgbox dbg(T)

t1.CurrentText := "AAAAAAAAAAAAAAAAAA"
;msgbox dbg(T)


dbg(obj)
{
    return JxonEncode(obj, 1)
}

;^j::T.
