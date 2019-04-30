; i call this method
Tippy(text = "", duration := 3333, whichToolTip := 16) {
    TT.Tippy(text, duration, whichToolTip)
}


class TT {
    static CurrentText := []
    static LastText := []
    static Hwnd := []
    static DestroyAtTime := []
    static MultipleToolTipsY := []


    static __TippyOnFn := TT.__TippyOn.Bind(TT)
    static __TippyOffFn := TT.__TippyOff.Bind(TT)

    Tippy(text, duration, whichToolTip) {
        ; sanitize whichToolTip
        whichToolTip := Max(1, Mod(whichToolTip, 20))

        ; init the possibly new timer
        TT.CurrentText[whichToolTip] := text
        TT.DestroyAtTime[whichToolTip] := A_TickCount + duration

        ; call start and stop
        fnOff := this.__TippyOffFn
        SetTimer, % fnOff, % Abs(Min(TT.DestroyAtTime*)-A_TickCount)
        fnOn := this.__TippyOnFn
        SetTimer, % fnOn, 10

        Sleep 2
    }

    __TippyOn() {
        this.__ToolTipFM()
    }

    __TippyOff() {
        copy := TT.CurrentText.Clone()

        For whichToolTip, Text in copy
        {
            if (A_TickCount >= TT.DestroyAtTime[whichToolTip])
            {
                TT.CurrentText[whichToolTip] := ""
            }
        }

        ; no need to waste resources
        if(!TT.CurrentText.Count())
        {
            SetTimer,, Off
        }
    }


    __ToolTipFM() { ; ToolTip which Follows the Mouse
        static defaultxOffset := 16, defaultyOffset := 16
        static virtualScreenWidth, virtualScreenHeight ; http://www.autohotkey.com/forum/post-430240.html#430240

        if (virtualScreenWidth = "" or virtualScreenHeight = "")
        {
            SysGet, virtualScreenWidth, 78
            SysGet, virtualScreenHeight, 79
        }

        copy := TT.CurrentText.Clone()
        For whichToolTip, Text in copy
        {
            ; destroy old
            if(Text = "")
            {
                this.__DestroyWhichTooltip(whichTooltip)
            }

            ; move or recreate tooltip
            WinGetPos,,, w, h, % "ahk_id " . TT.Hwnd[whichToolTip]
            CoordMode, Mouse, Screen
            MouseGetPos, x, y
            x += defaultxOffset
            y += defaultyOffset
            ; stack tooltips vertically
            y += this.__MultipleToolTipsOffsetCalc(TT.MultipleToolTipsY, whichToolTip)


            ; if mouse is bottom right, adjust Tooltip position
            if ((x+w) > virtualScreenWidth)
            {
                AdjustX := 1
            }
            if ((y+h) > virtualScreenHeight)
            {
                AdjustY := 1
            }
            if (AdjustX and AdjustY)
            {
                x := x - defaultxOffset*2 - w
                y := y - defaultyOffset*2 - h
            }
            else if(AdjustX)
            {
                x := virtualScreenWidth - w
            }
            else if(AdjustY)
            {
                y := virtualScreenHeight - h
            }


            ; move tooltip
            if (Text = TT.LastText[whichToolTip])
            {
                DllCall("MoveWindow", A_PtrSize ? "UPTR" : "UInt", TT.Hwnd[whichToolTip], "Int", x, "Int", y, "Int", w, "Int", h, "Int", 0)
            }
            ; recreate tooltip
            else
            {
                ; Perfect solution would be to update tooltip text (TTM_UPDATETIPTEXT), but must be compatible with all versions of AHK_L and AHK Basic.
                ; My Ask For Help link: http://www.autohotkey.com/forum/post-421841.html#421841
                CoordMode, ToolTip, Screen
                ToolTip, % Text, x, y, % whichToolTip
                TT.Hwnd[whichToolTip] := WinExist("ahk_class tooltips_class32 ahk_pid " DllCall("GetCurrentProcessId"))
                TT.LastText[whichToolTip] := Text

                WinGetPos,,, w, h, % "ahk_id " . TT.Hwnd[whichToolTip]
                TT.MultipleToolTipsY[whichToolTip] := h
            }
        }
        ; Winset, AlwaysOnTop, on, % "ahk_id" . TT.Hwnd[whichToolTip]
    }


    __MultipleToolTipsOffsetCalc(arrr, lenn) {
        result := 0
        For i, v in arrr
        {
            if(i >= lenn)
            {
                break
            }
            result += v + 2
        }
        return result
    }

    __DestroyWhichTooltip(whichTooltip)
    {
        ToolTip,,,, % whichToolTip
        this.CurrentText.Delete(whichToolTip)
        this.LastText.Delete(whichToolTip)
        this.Hwnd.Delete(whichToolTip)
        this.DestroyAtTime.Delete(whichToolTip)
        this.MultipleToolTipsY.Delete(whichToolTip)
    }

}


